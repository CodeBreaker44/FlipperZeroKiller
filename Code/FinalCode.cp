#line 1 "C:/Users/SilverCryptor/Desktop/FlipperZeroKiller/Code/FinalCode.c"
#line 1 "c:/users/silvercryptor/desktop/flipperzerokiller/code/rfid_killer_lcd.h"
#line 16 "c:/users/silvercryptor/desktop/flipperzerokiller/code/rfid_killer_lcd.h"
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
#line 37 "c:/users/silvercryptor/desktop/flipperzerokiller/code/rfid_killer_lcd.h"
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
#line 84 "c:/users/silvercryptor/desktop/flipperzerokiller/code/rfid_killer_lcd.h"
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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
int max(int a, int b);
int min(int a, int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 11 "C:/Users/SilverCryptor/Desktop/FlipperZeroKiller/Code/FinalCode.c"
unsigned int door_ctr = 65535;
unsigned char servo_ctr = 0;
unsigned char buzz_toggle = 0;
unsigned int buzz_ctr = 0;
unsigned char loki = 0;
unsigned char recievedBuffer[] = {"00000000000000000000"};
unsigned char random_chall[] = {"00000123456789abcdef"};
unsigned char recieved_chall[] = {"1111"};
unsigned char position = 3;







void interrupt (void){

 buzz_ctr++;
 if (PIR1 & 0x01)
 {
 servo_ctr++;
 if ( servo_ctr >= 0)
 {
 PORTC = PORTC | 0x04;

 }
 if( servo_ctr >= position)
 {
 PORTC = PORTC & 0xFB;
 }
 if( servo_ctr == 40)
 {
 servo_ctr = 0;
 PORTC = PORTC | 0x04;
 }


 }
 if (door_ctr < 65535)
 {
 door_ctr++;
 }
 TMR1H = 0xFF;
 TMR1L = 0x83;

 if(buzz_toggle && buzz_ctr == 250)
 {
 PORTC = PORTC ^ 0x20;
 buzz_ctr = 0;
 }

 if (door_ctr == 10000)
 {
 PORTC = PORTC | 0x04;
 PORTC = PORTC & 0b11001111;
 }

 if (door_ctr == 12000)
 {
 buzz_toggle = 0;
 position = 3;

 PORTC = PORTC | 0x08;
 PORTC = PORTC & 0xEF;
 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt("Door Locked");



 }


 PIR1 = PIR1 & 0xFE;



 if (PIR1 & 0x20)
 {
 recievedBuffer[loki] = RCREG;
 loki++;

 if(loki == 5 && strncmp(recievedBuffer, "hello",5) == 0)
 {
 char d;
 char z;

 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt("Authenticating");
 delay_ms(100);

 for ( d = 0 ; d<4; d++)
 {
 random_chall[d] = rand();
 }
 UART_TxString(4,random_chall);
 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt("Sent");
 UART_RxString(4, recieved_chall);
 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt("Recieved");


 simplehash(random_chall);
 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt("Hashed");
 if( strncmp(recieved_chall, random_chall, 4) == 0 )
 {
 buzz_toggle = 1;
 buzz_ctr = 0;
 position = 1;
 PORTC = PORTC | 0x10;
 PORTC = PORTC & 0xF7;

 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt("Door Unlocked");

 door_ctr = 0;
 loki = 0;
 }




 }

 PIR1 = PIR1 & 0b11011111;
 }
 if(INTCON & 0x02)
 {
 buzz_toggle = 1;
 buzz_ctr = 0;
 position = 1;
 PORTC = PORTC | 0x10;
 PORTC = PORTC & 0xF7;

 Lcd_CmdWriteInt(0x02);
 Lcd_CmdWriteInt(0x28);
 Lcd_CmdWriteInt(0x0E);
 Lcd_CmdWriteInt(0x01);
 Lcd_CmdWriteInt(0x80);
 Lcd_PrintInt("Unlocked by ESP");
 PORTB = PORTB | 0b00000010;

 door_ctr = 0;
 INTCON = INTCON & 0b11111101;

 }

 }

void main()
{
 INTCON = 0xD0;

 T1CON = 0x31;
 TMR1H = 0xFF;
 TMR1L = 0x83;


 UART_Init(9600);
 PIR1 = PIE1 | 0X01;
 buzz_toggle = 0;
 PORTC = PORTC | 0B00001000;
 PORTC = PORTC & 0B11001111;



  TRISD  = 0x00;
 Lcd_CmdWrite(0x02);
 Lcd_CmdWrite(0x28);
 Lcd_CmdWrite(0x0E);
 Lcd_CmdWrite(0x01);
 Lcd_CmdWrite(0x80);
 Lcd_Print("Door Locked");



 while(1){
 }

 }
