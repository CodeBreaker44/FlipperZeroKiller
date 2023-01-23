#include "Nonce.h"
#include "UART.h"

#define SBIT_TXEN     5
#define SBIT_SPEN     7
#define SBIT_CREN     4


unsigned char key [] = {"0123456789abcdef"}; // 16 bytes
unsigned char recieved_rand [] = {"00000123456789abcdef"}; // 20 bytes
unsigned char firstFour [] = {"0000\0"}; // 4 bytes



void main (){
    char i;
    TRISB = 0x00;
    PORTB = 0xff;
    UART_Init(9600);
    delay_ms(2000);
    UART_TxString(5,"hello");
    UART_RxString(4, recieved_rand);
    
    simplehash(recieved_rand);
    

    for (i = 0; i < 4; i++)
    {
        firstFour[i] = recieved_rand[i];
    }
    UART_TxString(4,firstFour);
    

    while(1);





}