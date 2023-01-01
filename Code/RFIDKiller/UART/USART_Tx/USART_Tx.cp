#line 1 "C:/Users/SilverCryptor/Desktop/USART_Tx/USART_Tx.c"





void UART_Init(int baudRate)
{
 TRISC=0x80;
 TXSTA=(1<< 5 );
 RCSTA=(1<< 7 ) | (1<< 4 );
 SPBRG = (8000000UL/(long)(64UL*baudRate))-1;
}


void UART_TxChar(char ch)
{
 while(TXIF & 0x10);
 PIR1 = PIR1 & 0xEF;
 TXREG=ch;
}


char UART_RxChar()
{
 while(PIR1 & 0x20);
 PIR1 = PIR1 & 0xDF;
 return(RCREG);
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
 UART_Init(9600);
 delay_ms(5000);

 UART_TxString("Hello World GG!!");
 while(1){}



}
