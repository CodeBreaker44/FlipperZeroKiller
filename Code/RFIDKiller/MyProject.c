void myDelay(void);
void interrupt(void){
  unsigned char cntr=20;
  while(cntr>0){
  PORTB = ~PORTB;
  myDelay();
  cntr--;
  }
  
 INTCON = INTCON & 0xFD; // CLEAR INTF (bit 1 in INTCON)
}
void main() {
unsigned char i;
TRISC = 0x00; //PORTC Output
TRISB = 0x01; //RB0 Input, RB1-RB7 Output

INTCON = 0x90;// GIE, INTE
PORTB = 0x00;
PORTC =0x01;//First LED ON
myDelay();
while(1){
     for(i=0; i<7; i++){
       PORTC = PORTC <<1;// Shift Contnets of PORTC one time left
       myDelay();
     }
     for(i=0; i<7;i++){
       PORTC = PORTC >> 1;// Sfift right one step
       myDelay();

     }

}
}
void myDelay(void){
  unsigned char j;
  unsigned int k;
  for(j=0;j<50;j++){
   for(k=0; k<2000; k++){
     j=j;
     k=k;
   }
  }
}