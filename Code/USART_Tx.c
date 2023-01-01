#define SBIT_TXEN     5
#define SBIT_SPEN     7
#define SBIT_CREN     4


void UART_Init(int baudRate)
{
    TRISC=0x80;            // Configure Rx pin as input and Tx as output
    TXSTA=(1<<SBIT_TXEN);  // Asynchronous mode, 8-bit data & enable transmitter
    RCSTA=(1<<SBIT_SPEN) | (1<<SBIT_CREN);  // Enable Serial Port and 8-bit continuous receive
    SPBRG = (8000000UL/(long)(64UL*baudRate))-1;      // baud rate @20Mhz Clock
}


void UART_TxChar(char ch)
{
    while(TXIF & 0x10);  //Test for TXIF, Wait till the transmitter register becomes empty
    PIR1 = PIR1 & 0xEF;  // Clear transmitter flag
    TXREG=ch;            // load the char to be transmitted into transmit reg
}


char UART_RxChar()
{
    while(PIR1 & 0x20);   // Test for RCIF, Wait till the data is received
    PIR1 = PIR1 & 0xDF;   // Clear receiver flag
    return(RCREG);        // Return the received data to calling function
}

void UART_TxString(char *msg)
{
    char i;
    for(i=0;msg[i]!=0;i++)
    {
        UART_TxChar(msg[i]);
        delay_ms(100);
    }

}
int main()
{
    UART_Init(9600);          //Initialize the UART module with 9600 baud rate
    delay_ms(5000);
    
    UART_TxString("Hello World GG!!");
    while(1){}
    
    
    
}