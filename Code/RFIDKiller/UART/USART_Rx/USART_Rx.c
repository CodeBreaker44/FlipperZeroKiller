#define SBIT_TXEN     5
#define SBIT_SPEN     7
#define SBIT_CREN     4
#include "RFID_KILLER_LCD.h"


unsigned char ch[] = {"0123456789abcdef"};
unsigned char i = 0;

void UART_Init(int baudRate)
{
    INTCON = 0b11000000;
    PIE1 = 0b00100000; // enable recieve interrupt
    TRISC=0x80;            // Configure Rx pin as input and Tx as output
    TXSTA=(1<<SBIT_TXEN);  // Asynchronous mode, 8-bit data & enable transmitter
    RCSTA=(1<<SBIT_SPEN) | (1<<SBIT_CREN);  // Enable Serial Port and 8-bit
    RCSTA = 0x90;
    SPBRG = (8000000UL/(long)(64UL*baudRate))-1;      // baud rate @8Mhz Clock
}


void UART_TxChar(char ch)
{
    while(TXIF & 0x10);  //Test for TXIF, Wait till the transmitter register becomes empty
    PIR1 = PIR1 & 0xEF;  // Clear transmitter flag
    TXREG=ch;            // load the char to be transmitted into transmit reg
}


char UART_RxChar()
{
    while(PIR1 & 0b00100000);   // Test for RCIF, Wait till the data is received
    PIR1 = PIR1 & 0b11011111;   // Clear receiver flag
    return(RCREG);        // Return the received data to calling function
}


void interrupt()
{

     ch[i] =  RCREG;
     i++;
     PIR1 = PIR1 & 0b11011111;   // Clear receiver flag
     LcdDataBusDirnReg = 0x00; // TRISD for LCD
     Lcd_CmdWriteInt(0x02);        // Initialize Lcd in 4-bit mode
     Lcd_CmdWriteInt(0x28);        // enable 5x7 mode for chars
     Lcd_CmdWriteInt(0x0E);        // Display OFF, Cursor ON
     Lcd_CmdWriteInt(0x01);        // Clear Display
     Lcd_CmdWriteInt(0x80);        // Move the cursor to beginning of first line
     //Lcd_DataWriteInt(RCREG);
     if(i == 16)
     {
          LcdDataBusDirnReg = 0x00; // TRISD for LCD
          Lcd_CmdWriteInt(0x02);        // Initialize Lcd in 4-bit mode
          Lcd_CmdWriteInt(0x28);        // enable 5x7 mode for chars
          Lcd_CmdWriteInt(0x0E);        // Display OFF, Cursor ON
          Lcd_CmdWriteInt(0x01);        // Clear Display
          Lcd_CmdWriteInt(0x80);        // Move the cursor to beginning of first line
          Lcd_PrintInt(ch);
          i = 0;
     }

}
int main()
{
    TRISE = 0x00;
    PORTE = 0x00;
    UART_Init(9600);          //Initialize the UART module with 9600 baud rate

    while(1){asm{sleep};}
}