#line 1 "C:/Users/SilverCryptor/Desktop/USART_Rx/USART_Rx.c"
#line 1 "c:/users/silvercryptor/desktop/usart_rx/rfid_killer_lcd.h"
#line 16 "c:/users/silvercryptor/desktop/usart_rx/rfid_killer_lcd.h"
void delay(unsigned int cnt)
{
 unsigned int i;
 for(i=0;i<cnt;i++)
 {
 i=i;
 }
}


void delayInt(unsigned int cnt)
{
 unsigned int i;
 for(i=0;i<cnt;i++){
 i=i;
 }
}
#line 37 "c:/users/silvercryptor/desktop/usart_rx/rfid_killer_lcd.h"
void Lcd_CmdWrite(char cmd)
{
  PORTD  = (cmd & 0xF0);
  PORTD  &= ~(1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delay(250);
  PORTD  &= ~(1<< 2 );

 delay(500);

  PORTD  = ((cmd<<4) & 0xF0);
  PORTD  &= ~(1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delay(250);
  PORTD  &= ~(1<< 2 );

 delay(500);
}


void Lcd_CmdWriteInt(char cmd)
{
  PORTD  = (cmd & 0xF0);
  PORTD  &= ~(1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delayInt(250);
  PORTD  &= ~(1<< 2 );

 delayInt(500);

  PORTD  = ((cmd<<4) & 0xF0);
  PORTD  &= ~(1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delayInt(250);
  PORTD  &= ~(1<< 2 );

 delayInt(500);
}
#line 84 "c:/users/silvercryptor/desktop/usart_rx/rfid_killer_lcd.h"
void Lcd_DataWrite(char dat)
{
  PORTD  = (dat & 0xF0);
  PORTD  |= (1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delay(250);
  PORTD  &= ~(1<< 2 );

 delay(500);

  PORTD  = ((dat<<4) & 0xF0);
  PORTD  |= (1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delay(250);
  PORTD  &= ~(1<< 2 );

 delay(500);
}


void Lcd_DataWriteInt(char dat)
{
  PORTD  = (dat & 0xF0);
  PORTD  |= (1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delayInt(250);
  PORTD  &= ~(1<< 2 );

 delayInt(500);

  PORTD  = ((dat<<4) & 0xF0);
  PORTD  |= (1<< 0 );
  PORTD  &= ~(1<< 1 );
  PORTD  |= (1<< 2 );
 delayInt(250);
  PORTD  &= ~(1<< 2 );

 delayInt(500);
}



void Lcd_Print(char *msg)
{
 char i;
 for(i=0;msg[i]!=0;i++)
 {
 Lcd_DataWrite(msg[i]);
 }

}


void Lcd_PrintInt(char *msg)
{
 char i;
 for(i=0; msg[i] != 0; i++)
 {
 Lcd_DataWriteInt(msg[i]);
 }

}
#line 7 "C:/Users/SilverCryptor/Desktop/USART_Rx/USART_Rx.c"
unsigned char ch[] = {"0123456789abcdef"};
unsigned char i = 0;

void UART_Init(int baudRate)
{
 INTCON = 0b11000000;
 PIE1 = 0b00100000;
 TRISC=0x80;
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
 while(PIR1 & 0b00100000);
 PIR1 = PIR1 & 0b11011111;
 return(RCREG);
}


void interrupt()
{

 ch[i] = RCREG;
 i++;
 PIR1 = PIR1 & 0b11011111;
  TRISD  = 0x00;
 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);

 if(i == 16)
 {
  TRISD  = 0x00;
 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt(ch);
 i = 0;
 }

}
int main()
{
 TRISE = 0x00;
 PORTE = 0x00;
 UART_Init(9600);

 while(1){asm{sleep};}
}
