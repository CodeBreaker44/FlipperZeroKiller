#include "RFID_KILLER_LCD.h"

// counters for TMR1
unsigned char door_ctr = 255;
unsigned char buzz_toggle = 0;

void interrupt (void){

     if (PIR1 & 0x01)
    {
        if (door_ctr < 255)
        {
            door_ctr++; //Prevent the timer from overflowing and activating at unexpected time!
        }
        TMR1H = 0x9E;
        TMR1L = 0x58;
        
        if(buzz_toggle)
        {
            PORTC = PORTC ^ 0x10; // keep beeping while door is open
            
        }
        if(door_Ctr == 5)
        {
            PORTC = PORTC & 0x1F; // stop moving the motors
        }
        // time to close the door
        if (door_ctr == 50)
        {
            PORTC = 0x24; // RED ON, GREEN OFF, BUZZER OFF, MOTOR OFF
        }

        if (door_ctr == 60)
        {
            buzz_toggle = 0;
            PORTC = PORTC & 0x1F; // stop moving the motors
            Lcd_CmdWriteInt(0x02);        // Initialize Lcd in 4-bit mode
            Lcd_CmdWriteInt(0x28);        // enable 5x7 mode for chars
            Lcd_CmdWriteInt(0x0E);        // Display OFF, Cursor ON
            Lcd_CmdWriteInt(0x01);        // Clear Display
            Lcd_CmdWriteInt(0x80);        // Move the cursor to beginning of first line
            Lcd_PrintInt("Door Locked");
            asm{sleep};


        }

        PIR1 = PIR1 & 0xFE; // Lower TMR1 INT flag
    }

    if (INTCON & 0X02)
    {
        buzz_toggle = 1;
        PORTC = 0x48; // RED OFF, GREEN ON, BUZZER ON, MOTOR ON
        Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
        Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
        Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
        Lcd_CmdWriteInt(0x01);      // Clear Display
        Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
        Lcd_PrintInt("Door Unlocked");

        door_ctr = 0; // Prepare the door to close after X seconds using TMR1
        INTCON = INTCON & 0xFD; // Lower RB0 INT flag
    }

}

int main()
{

    INTCON  = 0XD0; //GIE = 1, PIE = 1, RB0 INTE = 1
    // Configure TMR1 register to overflow every 0.1s // 1:8 Prescaler with Fosc = 8.0Mhz
    T1CON = 0x31;
    TMR1H = 0x9E;
    TMR1L = 0x58;
    PIE1 = 0x01;
    PIR1 = 0x00;

    // IO pins config
    LcdDataBusDirnReg = 0x00; // TRISD for LCD
    TRISC = 0x00;
    buzz_toggle = 0;
    PORTC = 0x04; // RED ON, GREEN OFF, BUZZER OFF, MOTOR OFF

    Lcd_CmdWrite(0x02);        // Initialize Lcd in 4-bit mode
    Lcd_CmdWrite(0x28);        // enable 5x7 mode for chars
    Lcd_CmdWrite(0x0E);        // Display OFF, Cursor ON
    Lcd_CmdWrite(0x01);        // Clear Display
    Lcd_CmdWrite(0x80);        // Move the cursor to beginning of first line
    Lcd_Print("Door Locked");
    asm{sleep};

    while(1){
    }
}
