#define SBIT_TXEN     5
#define SBIT_SPEN     7
#define SBIT_CREN     4

void UART_Init(int baudRate)
{
    TRISC=0x80;            // Configure Rx pin as input and Tx as output
    PIE1 = PIE1 | 0x01; 
    PIE1 = PIE1 | 0b00100000; // Enable UART interrupt
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
    while(!(PIR1 & 0b00100000));  // Wait till the receiver flag becomes 1
    PIR1 = PIR1 & 0b11011111;  // Clear receiver flag
    return(RCREG);        // Return the received data to calling function
}


// void UART_TxString(char *msg)
// {
//     char i;
//     for(i=0;msg[i]!=0;i++)
//     {
//         UART_TxChar(msg[i]);
//         delay_ms(100);
//     }

// }

void UART_TxString(int length,char *msg)
{
    char i;
    for(i=0;i<length;i++)
    {
        UART_TxChar(msg[i]);
        delay_ms(100);
    }

}


UART_RxString(int length, char *msg){
    char i;
    INTCON = INTCON & 0b01111111; // disable global interrupt 

    for(i=0;i<length;i++){
        msg[i] = UART_RxChar();
    }
    INTCON = INTCON | 0b10000000; // enable global interrupt
}