#line 1 "C:/Users/SilverCryptor/Desktop/FlipperZeroKiller/Code/FinalCodeKey.c"
#line 1 "c:/users/silvercryptor/desktop/flipperzerokiller/code/nonce.h"
void xor_a_b(char *a, char *b)
{
 unsigned char i;
 for (i = 0; i < 4; i++)
 {
 a[i] = a[i] ^ b[i];
 }

}

void simplehash(char * msg)
{
 unsigned char i;
 for ( i = 1; i <= 4; i++)
 {
 xor_a_b(msg, msg + (4*i));
 }

}
#line 1 "c:/users/silvercryptor/desktop/flipperzerokiller/code/uart.h"




void UART_Init(int baudRate)
{
 TRISC=0x80;
 PIE1 = PIE1 | 0x01;
 PIE1 = PIE1 | 0b00100000;
 TXSTA=(1<< 5 );
 RCSTA=(1<< 7 ) | (1<< 4 );
 RCSTA = 0x90;
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
 while(!(PIR1 & 0b00100000));
 PIR1 = PIR1 & 0b11011111;
 return(RCREG);
}
#line 44 "c:/users/silvercryptor/desktop/flipperzerokiller/code/uart.h"
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
 INTCON = INTCON & 0b01111111;

 for(i=0;i<length;i++){
 msg[i] = UART_RxChar();
 }
 INTCON = INTCON | 0b10000000;
}
#line 9 "C:/Users/SilverCryptor/Desktop/FlipperZeroKiller/Code/FinalCodeKey.c"
unsigned char key [] = {"0123456789abcdef"};
unsigned char recieved_rand [] = {"00000123456789abcdef"};
unsigned char firstFour [] = {"0000\0"};



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
