/* Configure the data bus and Control bus as per the hardware connection
   Dtatus bus is connected to PB4:PB7 and control bus PB0:PB2*/
#define LcdDataBus      PORTD
#define LcdControlBus   PORTD

#define LcdDataBusDirnReg   TRISD

#define LCD_RS     0
#define LCD_RW     1
#define LCD_EN     2



/* local function to generate delay */

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


/* Function to send the command to LCD.
   As it is 4bit mode, a byte of data is sent in two 4-bit nibbles */
void Lcd_CmdWrite(char cmd)
{
    LcdDataBus = (cmd & 0xF0);     //Send higher nibble
    LcdControlBus &= ~(1<<LCD_RS); // Send LOW pulse on RS pin for selecting Command register
    LcdControlBus &= ~(1<<LCD_RW); // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);  // Generate a High-to-low pulse on EN pin
    delay(250);
    LcdControlBus &= ~(1<<LCD_EN);

    delay(500);

    LcdDataBus = ((cmd<<4) & 0xF0); //Send Lower nibble
    LcdControlBus &= ~(1<<LCD_RS);  // Send LOW pulse on RS pin for selecting Command register
    LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
    delay(250);
    LcdControlBus &= ~(1<<LCD_EN);

    delay(500);
}


void Lcd_CmdWriteInt(char cmd)
{
    LcdDataBus = (cmd & 0xF0);     //Send higher nibble
    LcdControlBus &= ~(1<<LCD_RS); // Send LOW pulse on RS pin for selecting Command register
    LcdControlBus &= ~(1<<LCD_RW); // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);  // Generate a High-to-low pulse on EN pin
    delayInt(250);
    LcdControlBus &= ~(1<<LCD_EN);

    delayInt(500);

    LcdDataBus = ((cmd<<4) & 0xF0); //Send Lower nibble
    LcdControlBus &= ~(1<<LCD_RS);  // Send LOW pulse on RS pin for selecting Command register
    LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
    delayInt(250);
    LcdControlBus &= ~(1<<LCD_EN);

    delayInt(500);
}



/* Function to send the Data to LCD.
   As it is 4bit mode, a byte of data is sent in two 4-bit nibbles */
void Lcd_DataWrite(char dat)
{
    LcdDataBus = (dat & 0xF0);      //Send higher nibble
    LcdControlBus |= (1<<LCD_RS);   // Send HIGH pulse on RS pin for selecting data register
    LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
    delay(250);
    LcdControlBus &= ~(1<<LCD_EN);

    delay(500);

    LcdDataBus = ((dat<<4) & 0xF0);  //Send Lower nibble
    LcdControlBus |= (1<<LCD_RS);    // Send HIGH pulse on RS pin for selecting data register
    LcdControlBus &= ~(1<<LCD_RW);   // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);    // Generate a High-to-low pulse on EN pin
    delay(250);
    LcdControlBus &= ~(1<<LCD_EN);

    delay(500);
}


void Lcd_DataWriteInt(char dat)
{
    LcdDataBus = (dat & 0xF0);      //Send higher nibble
    LcdControlBus |= (1<<LCD_RS);   // Send HIGH pulse on RS pin for selecting data register
    LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
    delayInt(250);
    LcdControlBus &= ~(1<<LCD_EN);

    delayInt(500);

    LcdDataBus = ((dat<<4) & 0xF0);  //Send Lower nibble
    LcdControlBus |= (1<<LCD_RS);    // Send HIGH pulse on RS pin for selecting data register
    LcdControlBus &= ~(1<<LCD_RW);   // Send LOW pulse on RW pin for Write operation
    LcdControlBus |= (1<<LCD_EN);    // Generate a High-to-low pulse on EN pin
    delayInt(250);
    LcdControlBus &= ~(1<<LCD_EN);

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
