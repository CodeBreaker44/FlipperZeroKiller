unsigned char tmr1ctr = 0;




void delaytmr1(unsigned char s){

      tmr1ctr = 0;
      PORTC = 0xFF;
      while(tmr1ctr < s){
      }
      PORTC = 0x00;

}







void interrupt(void){
     tmr1ctr++;
     
     TMR1L = 0xB0;
     TMR1H = 0x3C;
     PIR1 = PIR1 & 0xFE;


}


void main(void){

     TRISD = 0x00;
     TRISC = 0x00;
     PORTC = 0x00;
     PORTD = 0x00;
     INTCON = 0xD0;
     T1CON =0x31;
     PIE1 = 0x01;
     TMR1L = 0xB0;
     TMR1H = 0x3C;
      while(1){
      
      PORTD = 0xFF;
      delaytmr1(25);
      PORTD = 0x00;
      delaytmr1(25);
      
      }


}