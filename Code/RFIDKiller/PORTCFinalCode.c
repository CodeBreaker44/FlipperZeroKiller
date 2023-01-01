void delay(unsigned int ms)
{   unsigned int i;
    unsigned int k;
    for (i = 0; i < ms; i++)
    {
        for (k = 0; k < 1000; k++)
        {
        
        }
    }
}

void move_Forward(void){

PORTC = PORTC | 0x40; // set  input 1 firts bit for motor
PORTC = PORTC & 0xDF;
}

void move_BackWard(void){
PORTC = PORTC | 0x20;
PORTC = PORTC & 0xBF;
}

void buzzer(void){
PORTC = PORTC | 0x10;
delay(500);
PORTC = PORTC & 0xEF;
}

void main (){
unsigned char loki;
TRISC = 0x00;
PORTC = 0x00;





while (1){
PORTC = PORTC | 0x0C;
buzzer();
move_Forward();
delay(500);
move_Backward();
delay(500);

}

}
