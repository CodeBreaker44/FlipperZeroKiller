#include "RFID_KILLER_LCD.h"
#include "UART.h"
#include "Nonce.h"
#include <stdlib.h>
#include <string.h>
#define SBIT_TXEN     5
#define SBIT_SPEN     7
#define SBIT_CREN     4

// counters for TMR1
unsigned int door_ctr = 65535; // 0 = closed, 40 = open
unsigned char servo_ctr = 0; // 0 = closed, 40 = open
unsigned char buzz_toggle = 0; // 0 = off, 1 = on
unsigned char loki  = 0; // counter for the recieved buffer
unsigned char recievedBuffer[] = {"00000000000000000000"}; // 20 bytes
unsigned char random_chall[] =   {"00000123456789abcdef"}; // 20 bytes
unsigned char recieved_chall[] = {"1111"}; // 4 bytes
unsigned char position = 3;  // 0 = closed, 3 = open
// unsigned char key[] = {"0123456789abcdef"};






void interrupt (void){


    if (PIR1 & 0x01) // Check if the interrupt is caused by TMR1
    {
        servo_ctr++;
        if ( servo_ctr >= 0)
        {
            PORTC  = PORTC | 0x04; // toggle the motor

        }
        if( servo_ctr >= position)
        {
            PORTC = PORTC & 0xFB; // toggle the motor
        }
        if( servo_ctr == 40)
        {
            servo_ctr = 0;
            PORTC = PORTC | 0x04; // toggle the motor
        }


        }
        if (door_ctr < 65535)
        {
            door_ctr++; //Prevent the timer from overflowing and activating at unexpected time!
        }
        TMR1H = 0xFF;
        TMR1L = 0x83;

        if(buzz_toggle)
        {
            PORTC = PORTC ^ 0x20; // keep beeping while door is open

        }
        // time to close the door
        if (door_ctr == 10000)
        {
            PORTC = PORTC | 0x04; // RED ON, GREEN OFF, BUZZER OFF
            PORTC = PORTC & 0b11001111;
        }

        if (door_ctr == 12000)
        {
            buzz_toggle = 0;
            position = 3;
            // PORTC = PORTC & 0xFB; // stop moving the motors
            PORTC = PORTC | 0x08; // RED ON, GREEN OFF, BUZZER OFF
            PORTC = PORTC & 0xEF;
            Lcd_CmdWriteInt(0x02);        // Initialize Lcd in 4-bit mode
            Lcd_CmdWriteInt(0x28);        // enable 5x7 mode for chars
            Lcd_CmdWriteInt(0x0E);        // Display OFF, Cursor ON
            Lcd_CmdWriteInt(0x01);        // Clear Display
            Lcd_CmdWriteInt(0x80);        // Move the cursor to beginning of first line
            Lcd_PrintInt("Door Locked");
            // asm{sleep};


        }


        PIR1 = PIR1 & 0xFE; // Lower TMR1 INT flag



        if (PIR1 & 0x20)  // Check if the interrupt is caused by UART
        {
               recievedBuffer[loki] =  RCREG;
                loki++; // increment the counter

            if(loki == 5 && strncmp(recievedBuffer, "hello",5) == 0)
            {
            char d;
            char z;

                Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
                Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
                Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
                Lcd_CmdWriteInt(0x01);      // Clear Display
                Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
                Lcd_PrintInt("hello");


                for ( d = 0 ; d<4; d++)
                {
                    random_chall[d] = rand(); //TODO: generate random challenge rand()
                }
                UART_TxString(4,random_chall); // send the random challenge
                Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
                Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
                Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
                Lcd_CmdWriteInt(0x01);      // Clear Display
                Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
                Lcd_PrintInt("Sent");
                UART_RxString(4, recieved_chall); // recieve the solved challenge
                Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
                Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
                Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
                Lcd_CmdWriteInt(0x01);      // Clear Display
                Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
                Lcd_PrintInt("Recieved");
                // compare the recieved challenge with the solved challenge

                simplehash(random_chall);  // hash the random challenge with the key
                Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
                Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
                Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
                Lcd_CmdWriteInt(0x01);      // Clear Display
                Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
                Lcd_PrintInt("Hashed");
                if( strncmp(recieved_chall, random_chall, 4) == 0  ) // Compare the recived hash with solved hash
                {
                    buzz_toggle = 1;
                    position = 1;
                    PORTC = PORTC | 0x10; // RED OFF, GREEN ON, BUZZER ON
                    PORTC = PORTC & 0xF7;

                    Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode`
                    Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
                    Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
                    Lcd_CmdWriteInt(0x01);      // Clear Display
                    Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
                    Lcd_PrintInt("Door Unlocked");

                    door_ctr = 0; // Prepare the door to close after X seconds using TMR1
                    loki = 0;
                }




            }

            PIR1 = PIR1 & 0b11011111;   // Clear receiver flag
        }

    }

void main()
{
    INTCON  = 0XC0; // Enable global and peripheral interrupts  // 1100 0000
    // Configure TMR1 register to overflow every 0.1s // 1:8 Prescaler with Fosc = 8.0Mhz
    T1CON = 0x31; // 0011 0001 // 1:8 Prescaler with Fosc = 8.0Mhz // 0x31
    TMR1H = 0xFF;  // 0xFF83 = 0.5ms
    TMR1L = 0x83;  // 0xFF83 = 0.5ms


    UART_Init(9600); // Initialize UART module
    PIR1 = PIE1 | 0X01; // Enable TMR1 interrupt
    buzz_toggle = 0;
    PORTC = PORTC | 0B00001000; // RED ON, GREEN OFF, BUZZER OFF
    PORTC = PORTC & 0B11001111; // RED ON, GREEN OFF, BUZZER OFF


    // Initialize LCD
    LcdDataBusDirnReg = 0x00; // TRISD for LCD
    Lcd_CmdWrite(0x02);        // Initialize Lcd in 4-bit mode
    Lcd_CmdWrite(0x28);        // enable 5x7 mode for chars
    Lcd_CmdWrite(0x0E);        // Display OFF, Cursor ON
    Lcd_CmdWrite(0x01);        // Clear Display
    Lcd_CmdWrite(0x80);        // Move the cursor to beginning of first line
    Lcd_Print("Door Locked");
//    asm{sleep};
    // UART_RxString(20, recievedBuffer); // Receive 20 bytes
    //  Lcd_CmdWrite(0x02);        // Initialize Lcd in 4-bit mode
    // Lcd_CmdWrite(0x28);        // enable 5x7 mode for chars
    // Lcd_CmdWrite(0x0E);        // Display OFF, Cursor ON
    // Lcd_CmdWrite(0x01);        // Clear Display
    // Lcd_CmdWrite(0x80);        // Move the cursor to beginning of first line
    // Lcd_Print("Door UnLocked");
    //     door_ctr = 0; // Prepare the door to close after X seconds using TMR1






    while(1){
    }

    }