
_delay:

;rfid_killer_lcd.h,16 :: 		void delay(unsigned int cnt)
;rfid_killer_lcd.h,19 :: 		for(i=0;i<cnt;i++)
	CLRF       R1+0
	CLRF       R1+1
L_delay0:
	MOVF       FARG_delay_cnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay49
	MOVF       FARG_delay_cnt+0, 0
	SUBWF      R1+0, 0
L__delay49:
	BTFSC      STATUS+0, 0
	GOTO       L_delay1
;rfid_killer_lcd.h,21 :: 		i=i;
;rfid_killer_lcd.h,19 :: 		for(i=0;i<cnt;i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;rfid_killer_lcd.h,22 :: 		}
	GOTO       L_delay0
L_delay1:
;rfid_killer_lcd.h,23 :: 		}
L_end_delay:
	RETURN
; end of _delay

_delayInt:

;rfid_killer_lcd.h,26 :: 		void delayInt(unsigned int cnt)
;rfid_killer_lcd.h,29 :: 		for(i=0;i<cnt;i++){
	CLRF       R1+0
	CLRF       R1+1
L_delayInt3:
	MOVF       FARG_delayInt_cnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delayInt51
	MOVF       FARG_delayInt_cnt+0, 0
	SUBWF      R1+0, 0
L__delayInt51:
	BTFSC      STATUS+0, 0
	GOTO       L_delayInt4
;rfid_killer_lcd.h,30 :: 		i=i;
;rfid_killer_lcd.h,29 :: 		for(i=0;i<cnt;i++){
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;rfid_killer_lcd.h,31 :: 		}
	GOTO       L_delayInt3
L_delayInt4:
;rfid_killer_lcd.h,32 :: 		}
L_end_delayInt:
	RETURN
; end of _delayInt

_Lcd_CmdWrite:

;rfid_killer_lcd.h,37 :: 		void Lcd_CmdWrite(char cmd)
;rfid_killer_lcd.h,39 :: 		LcdDataBus = (cmd & 0xF0);     //Send higher nibble
	MOVLW      240
	ANDWF      FARG_Lcd_CmdWrite_cmd+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,40 :: 		LcdControlBus &= ~(1<<LCD_RS); // Send LOW pulse on RS pin for selecting Command register
	BCF        PORTD+0, 0
;rfid_killer_lcd.h,41 :: 		LcdControlBus &= ~(1<<LCD_RW); // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,42 :: 		LcdControlBus |= (1<<LCD_EN);  // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,43 :: 		delay(250);
	MOVLW      250
	MOVWF      FARG_delay_cnt+0
	CLRF       FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,44 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,46 :: 		delay(500);
	MOVLW      244
	MOVWF      FARG_delay_cnt+0
	MOVLW      1
	MOVWF      FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,48 :: 		LcdDataBus = ((cmd<<4) & 0xF0); //Send Lower nibble
	MOVF       FARG_Lcd_CmdWrite_cmd+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,49 :: 		LcdControlBus &= ~(1<<LCD_RS);  // Send LOW pulse on RS pin for selecting Command register
	BCF        PORTD+0, 0
;rfid_killer_lcd.h,50 :: 		LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,51 :: 		LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,52 :: 		delay(250);
	MOVLW      250
	MOVWF      FARG_delay_cnt+0
	CLRF       FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,53 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,55 :: 		delay(500);
	MOVLW      244
	MOVWF      FARG_delay_cnt+0
	MOVLW      1
	MOVWF      FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,56 :: 		}
L_end_Lcd_CmdWrite:
	RETURN
; end of _Lcd_CmdWrite

_Lcd_CmdWriteInt:

;rfid_killer_lcd.h,59 :: 		void Lcd_CmdWriteInt(char cmd)
;rfid_killer_lcd.h,61 :: 		LcdDataBus = (cmd & 0xF0);     //Send higher nibble
	MOVLW      240
	ANDWF      FARG_Lcd_CmdWriteInt_cmd+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,62 :: 		LcdControlBus &= ~(1<<LCD_RS); // Send LOW pulse on RS pin for selecting Command register
	BCF        PORTD+0, 0
;rfid_killer_lcd.h,63 :: 		LcdControlBus &= ~(1<<LCD_RW); // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,64 :: 		LcdControlBus |= (1<<LCD_EN);  // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,65 :: 		delayInt(250);
	MOVLW      250
	MOVWF      FARG_delayInt_cnt+0
	CLRF       FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,66 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,68 :: 		delayInt(500);
	MOVLW      244
	MOVWF      FARG_delayInt_cnt+0
	MOVLW      1
	MOVWF      FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,70 :: 		LcdDataBus = ((cmd<<4) & 0xF0); //Send Lower nibble
	MOVF       FARG_Lcd_CmdWriteInt_cmd+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,71 :: 		LcdControlBus &= ~(1<<LCD_RS);  // Send LOW pulse on RS pin for selecting Command register
	BCF        PORTD+0, 0
;rfid_killer_lcd.h,72 :: 		LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,73 :: 		LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,74 :: 		delayInt(250);
	MOVLW      250
	MOVWF      FARG_delayInt_cnt+0
	CLRF       FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,75 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,77 :: 		delayInt(500);
	MOVLW      244
	MOVWF      FARG_delayInt_cnt+0
	MOVLW      1
	MOVWF      FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,78 :: 		}
L_end_Lcd_CmdWriteInt:
	RETURN
; end of _Lcd_CmdWriteInt

_Lcd_DataWrite:

;rfid_killer_lcd.h,84 :: 		void Lcd_DataWrite(char dat)
;rfid_killer_lcd.h,86 :: 		LcdDataBus = (dat & 0xF0);      //Send higher nibble
	MOVLW      240
	ANDWF      FARG_Lcd_DataWrite_dat+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,87 :: 		LcdControlBus |= (1<<LCD_RS);   // Send HIGH pulse on RS pin for selecting data register
	BSF        PORTD+0, 0
;rfid_killer_lcd.h,88 :: 		LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,89 :: 		LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,90 :: 		delay(250);
	MOVLW      250
	MOVWF      FARG_delay_cnt+0
	CLRF       FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,91 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,93 :: 		delay(500);
	MOVLW      244
	MOVWF      FARG_delay_cnt+0
	MOVLW      1
	MOVWF      FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,95 :: 		LcdDataBus = ((dat<<4) & 0xF0);  //Send Lower nibble
	MOVF       FARG_Lcd_DataWrite_dat+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,96 :: 		LcdControlBus |= (1<<LCD_RS);    // Send HIGH pulse on RS pin for selecting data register
	BSF        PORTD+0, 0
;rfid_killer_lcd.h,97 :: 		LcdControlBus &= ~(1<<LCD_RW);   // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,98 :: 		LcdControlBus |= (1<<LCD_EN);    // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,99 :: 		delay(250);
	MOVLW      250
	MOVWF      FARG_delay_cnt+0
	CLRF       FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,100 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,102 :: 		delay(500);
	MOVLW      244
	MOVWF      FARG_delay_cnt+0
	MOVLW      1
	MOVWF      FARG_delay_cnt+1
	CALL       _delay+0
;rfid_killer_lcd.h,103 :: 		}
L_end_Lcd_DataWrite:
	RETURN
; end of _Lcd_DataWrite

_Lcd_DataWriteInt:

;rfid_killer_lcd.h,106 :: 		void Lcd_DataWriteInt(char dat)
;rfid_killer_lcd.h,108 :: 		LcdDataBus = (dat & 0xF0);      //Send higher nibble
	MOVLW      240
	ANDWF      FARG_Lcd_DataWriteInt_dat+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,109 :: 		LcdControlBus |= (1<<LCD_RS);   // Send HIGH pulse on RS pin for selecting data register
	BSF        PORTD+0, 0
;rfid_killer_lcd.h,110 :: 		LcdControlBus &= ~(1<<LCD_RW);  // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,111 :: 		LcdControlBus |= (1<<LCD_EN);   // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,112 :: 		delayInt(250);
	MOVLW      250
	MOVWF      FARG_delayInt_cnt+0
	CLRF       FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,113 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,115 :: 		delayInt(500);
	MOVLW      244
	MOVWF      FARG_delayInt_cnt+0
	MOVLW      1
	MOVWF      FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,117 :: 		LcdDataBus = ((dat<<4) & 0xF0);  //Send Lower nibble
	MOVF       FARG_Lcd_DataWriteInt_dat+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      PORTD+0
;rfid_killer_lcd.h,118 :: 		LcdControlBus |= (1<<LCD_RS);    // Send HIGH pulse on RS pin for selecting data register
	BSF        PORTD+0, 0
;rfid_killer_lcd.h,119 :: 		LcdControlBus &= ~(1<<LCD_RW);   // Send LOW pulse on RW pin for Write operation
	BCF        PORTD+0, 1
;rfid_killer_lcd.h,120 :: 		LcdControlBus |= (1<<LCD_EN);    // Generate a High-to-low pulse on EN pin
	BSF        PORTD+0, 2
;rfid_killer_lcd.h,121 :: 		delayInt(250);
	MOVLW      250
	MOVWF      FARG_delayInt_cnt+0
	CLRF       FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,122 :: 		LcdControlBus &= ~(1<<LCD_EN);
	BCF        PORTD+0, 2
;rfid_killer_lcd.h,124 :: 		delayInt(500);
	MOVLW      244
	MOVWF      FARG_delayInt_cnt+0
	MOVLW      1
	MOVWF      FARG_delayInt_cnt+1
	CALL       _delayInt+0
;rfid_killer_lcd.h,125 :: 		}
L_end_Lcd_DataWriteInt:
	RETURN
; end of _Lcd_DataWriteInt

_Lcd_Print:

;rfid_killer_lcd.h,129 :: 		void Lcd_Print(char *msg)
;rfid_killer_lcd.h,132 :: 		for(i=0;msg[i]!=0;i++)
	CLRF       Lcd_Print_i_L0+0
L_Lcd_Print6:
	MOVF       Lcd_Print_i_L0+0, 0
	ADDWF      FARG_Lcd_Print_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_Lcd_Print7
;rfid_killer_lcd.h,134 :: 		Lcd_DataWrite(msg[i]);
	MOVF       Lcd_Print_i_L0+0, 0
	ADDWF      FARG_Lcd_Print_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_DataWrite_dat+0
	CALL       _Lcd_DataWrite+0
;rfid_killer_lcd.h,132 :: 		for(i=0;msg[i]!=0;i++)
	INCF       Lcd_Print_i_L0+0, 1
;rfid_killer_lcd.h,135 :: 		}
	GOTO       L_Lcd_Print6
L_Lcd_Print7:
;rfid_killer_lcd.h,137 :: 		}
L_end_Lcd_Print:
	RETURN
; end of _Lcd_Print

_Lcd_PrintInt:

;rfid_killer_lcd.h,140 :: 		void Lcd_PrintInt(char *msg)
;rfid_killer_lcd.h,143 :: 		for(i=0; msg[i] != 0; i++)
	CLRF       Lcd_PrintInt_i_L0+0
L_Lcd_PrintInt9:
	MOVF       Lcd_PrintInt_i_L0+0, 0
	ADDWF      FARG_Lcd_PrintInt_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_Lcd_PrintInt10
;rfid_killer_lcd.h,145 :: 		Lcd_DataWriteInt(msg[i]);
	MOVF       Lcd_PrintInt_i_L0+0, 0
	ADDWF      FARG_Lcd_PrintInt_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_DataWriteInt_dat+0
	CALL       _Lcd_DataWriteInt+0
;rfid_killer_lcd.h,143 :: 		for(i=0; msg[i] != 0; i++)
	INCF       Lcd_PrintInt_i_L0+0, 1
;rfid_killer_lcd.h,146 :: 		}
	GOTO       L_Lcd_PrintInt9
L_Lcd_PrintInt10:
;rfid_killer_lcd.h,148 :: 		}
L_end_Lcd_PrintInt:
	RETURN
; end of _Lcd_PrintInt

_UART_Init:

;uart.h,5 :: 		void UART_Init(int baudRate)
;uart.h,7 :: 		TRISC=0x80;            // Configure Rx pin as input and Tx as output
	MOVLW      128
	MOVWF      TRISC+0
;uart.h,8 :: 		PIE1 = PIE1 | 0x01;
	BSF        PIE1+0, 0
;uart.h,9 :: 		PIE1 = PIE1 | 0b00100000; // Enable UART interrupt
	BSF        PIE1+0, 5
;uart.h,10 :: 		TXSTA=(1<<SBIT_TXEN);  // Asynchronous mode, 8-bit data & enable transmitter
	MOVLW      32
	MOVWF      TXSTA+0
;uart.h,11 :: 		RCSTA=(1<<SBIT_SPEN) | (1<<SBIT_CREN);  // Enable Serial Port and 8-bit
	MOVLW      144
	MOVWF      RCSTA+0
;uart.h,12 :: 		RCSTA = 0x90;
	MOVLW      144
	MOVWF      RCSTA+0
;uart.h,13 :: 		SPBRG = (8000000UL/(long)(64UL*baudRate))-1;      // baud rate @8Mhz Clock
	MOVLW      6
	MOVWF      R0+0
	MOVF       FARG_UART_Init_baudRate+0, 0
	MOVWF      R4+0
	MOVF       FARG_UART_Init_baudRate+1, 0
	MOVWF      R4+1
	MOVLW      0
	BTFSC      R4+1, 7
	MOVLW      255
	MOVWF      R4+2
	MOVWF      R4+3
	MOVF       R0+0, 0
L__UART_Init59:
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Init60
	RLF        R4+0, 1
	RLF        R4+1, 1
	RLF        R4+2, 1
	RLF        R4+3, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__UART_Init59
L__UART_Init60:
	MOVLW      0
	MOVWF      R0+0
	MOVLW      18
	MOVWF      R0+1
	MOVLW      122
	MOVWF      R0+2
	MOVLW      0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	DECF       R0+0, 0
	MOVWF      SPBRG+0
;uart.h,14 :: 		}
L_end_UART_Init:
	RETURN
; end of _UART_Init

_UART_TxChar:

;uart.h,17 :: 		void UART_TxChar(char ch)
;uart.h,19 :: 		while(TXIF & 0x10);  //Test for TXIF, Wait till the transmitter register becomes empty
L_UART_TxChar13:
;uart.h,20 :: 		PIR1 = PIR1 & 0xEF;  // Clear transmitter flag
	MOVLW      239
	ANDWF      PIR1+0, 1
;uart.h,21 :: 		TXREG=ch;            // load the char to be transmitted into transmit reg
	MOVF       FARG_UART_TxChar_ch+0, 0
	MOVWF      TXREG+0
;uart.h,22 :: 		}
L_end_UART_TxChar:
	RETURN
; end of _UART_TxChar

_UART_RxChar:

;uart.h,25 :: 		char UART_RxChar()
;uart.h,27 :: 		while(!(PIR1 & 0b00100000));  // Wait till the receiver flag becomes 1
L_UART_RxChar14:
	BTFSC      PIR1+0, 5
	GOTO       L_UART_RxChar15
	GOTO       L_UART_RxChar14
L_UART_RxChar15:
;uart.h,28 :: 		PIR1 = PIR1 & 0b11011111;  // Clear receiver flag
	MOVLW      223
	ANDWF      PIR1+0, 1
;uart.h,29 :: 		return(RCREG);        // Return the received data to calling function
	MOVF       RCREG+0, 0
	MOVWF      R0+0
;uart.h,30 :: 		}
L_end_UART_RxChar:
	RETURN
; end of _UART_RxChar

_UART_TxString:

;uart.h,44 :: 		void UART_TxString(int length,char *msg)
;uart.h,47 :: 		for(i=0;i<length;i++)
	CLRF       UART_TxString_i_L0+0
L_UART_TxString16:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_UART_TxString_length+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__UART_TxString64
	MOVF       FARG_UART_TxString_length+0, 0
	SUBWF      UART_TxString_i_L0+0, 0
L__UART_TxString64:
	BTFSC      STATUS+0, 0
	GOTO       L_UART_TxString17
;uart.h,49 :: 		UART_TxChar(msg[i]);
	MOVF       UART_TxString_i_L0+0, 0
	ADDWF      FARG_UART_TxString_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART_TxChar_ch+0
	CALL       _UART_TxChar+0
;uart.h,50 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_UART_TxString19:
	DECFSZ     R13+0, 1
	GOTO       L_UART_TxString19
	DECFSZ     R12+0, 1
	GOTO       L_UART_TxString19
	DECFSZ     R11+0, 1
	GOTO       L_UART_TxString19
	NOP
;uart.h,47 :: 		for(i=0;i<length;i++)
	INCF       UART_TxString_i_L0+0, 1
;uart.h,51 :: 		}
	GOTO       L_UART_TxString16
L_UART_TxString17:
;uart.h,53 :: 		}
L_end_UART_TxString:
	RETURN
; end of _UART_TxString

_UART_RxString:

;uart.h,56 :: 		UART_RxString(int length, char *msg){
;uart.h,58 :: 		INTCON = INTCON & 0b01111111; // disable global interrupt
	MOVLW      127
	ANDWF      INTCON+0, 1
;uart.h,60 :: 		for(i=0;i<length;i++){
	CLRF       UART_RxString_i_L0+0
L_UART_RxString20:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_UART_RxString_length+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__UART_RxString66
	MOVF       FARG_UART_RxString_length+0, 0
	SUBWF      UART_RxString_i_L0+0, 0
L__UART_RxString66:
	BTFSC      STATUS+0, 0
	GOTO       L_UART_RxString21
;uart.h,61 :: 		msg[i] = UART_RxChar();
	MOVF       UART_RxString_i_L0+0, 0
	ADDWF      FARG_UART_RxString_msg+0, 0
	MOVWF      FLOC__UART_RxString+0
	CALL       _UART_RxChar+0
	MOVF       FLOC__UART_RxString+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;uart.h,60 :: 		for(i=0;i<length;i++){
	INCF       UART_RxString_i_L0+0, 1
;uart.h,62 :: 		}
	GOTO       L_UART_RxString20
L_UART_RxString21:
;uart.h,63 :: 		INTCON = INTCON | 0b10000000; // enable global interrupt
	BSF        INTCON+0, 7
;uart.h,64 :: 		}
L_end_UART_RxString:
	RETURN
; end of _UART_RxString

_xor_a_b:

;nonce.h,1 :: 		void xor_a_b(char *a, char *b)
;nonce.h,4 :: 		for (i = 0; i < 4; i++)
	CLRF       R2+0
L_xor_a_b23:
	MOVLW      4
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_xor_a_b24
;nonce.h,6 :: 		a[i] = a[i] ^ b[i];
	MOVF       R2+0, 0
	ADDWF      FARG_xor_a_b_a+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R2+0, 0
	ADDWF      FARG_xor_a_b_b+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORWF      R0+0, 1
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;nonce.h,4 :: 		for (i = 0; i < 4; i++)
	INCF       R2+0, 1
;nonce.h,7 :: 		}
	GOTO       L_xor_a_b23
L_xor_a_b24:
;nonce.h,9 :: 		}
L_end_xor_a_b:
	RETURN
; end of _xor_a_b

_simplehash:

;nonce.h,11 :: 		void simplehash(char * msg)
;nonce.h,14 :: 		for ( i = 1; i <= 4; i++)
	MOVLW      1
	MOVWF      simplehash_i_L0+0
L_simplehash26:
	MOVF       simplehash_i_L0+0, 0
	SUBLW      4
	BTFSS      STATUS+0, 0
	GOTO       L_simplehash27
;nonce.h,16 :: 		xor_a_b(msg, msg + (4*i));
	MOVF       FARG_simplehash_msg+0, 0
	MOVWF      FARG_xor_a_b_a+0
	MOVF       simplehash_i_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDWF      FARG_simplehash_msg+0, 0
	MOVWF      FARG_xor_a_b_b+0
	CALL       _xor_a_b+0
;nonce.h,14 :: 		for ( i = 1; i <= 4; i++)
	INCF       simplehash_i_L0+0, 1
;nonce.h,17 :: 		}
	GOTO       L_simplehash26
L_simplehash27:
;nonce.h,19 :: 		}
L_end_simplehash:
	RETURN
; end of _simplehash

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;FinalCode.c,26 :: 		void interrupt (void){
;FinalCode.c,29 :: 		if (PIR1 & 0x01) // Check if the interrupt is caused by TMR1
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt29
;FinalCode.c,31 :: 		servo_ctr++;
	INCF       _servo_ctr+0, 1
;FinalCode.c,32 :: 		if ( servo_ctr >= 0)
	MOVLW      0
	SUBWF      _servo_ctr+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt30
;FinalCode.c,34 :: 		PORTC  = PORTC | 0x04; // toggle the motor
	BSF        PORTC+0, 2
;FinalCode.c,36 :: 		}
L_interrupt30:
;FinalCode.c,37 :: 		if( servo_ctr >= position)
	MOVF       _position+0, 0
	SUBWF      _servo_ctr+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt31
;FinalCode.c,39 :: 		PORTC = PORTC & 0xFB; // toggle the motor
	MOVLW      251
	ANDWF      PORTC+0, 1
;FinalCode.c,40 :: 		}
L_interrupt31:
;FinalCode.c,41 :: 		if( servo_ctr == 40)
	MOVF       _servo_ctr+0, 0
	XORLW      40
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt32
;FinalCode.c,43 :: 		servo_ctr = 0;
	CLRF       _servo_ctr+0
;FinalCode.c,44 :: 		PORTC = PORTC | 0x04; // toggle the motor
	BSF        PORTC+0, 2
;FinalCode.c,45 :: 		}
L_interrupt32:
;FinalCode.c,48 :: 		}
L_interrupt29:
;FinalCode.c,49 :: 		if (door_ctr < 65535)
	MOVLW      255
	SUBWF      _door_ctr+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt71
	MOVLW      255
	SUBWF      _door_ctr+0, 0
L__interrupt71:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt33
;FinalCode.c,51 :: 		door_ctr++; //Prevent the timer from overflowing and activating at unexpected time!
	INCF       _door_ctr+0, 1
	BTFSC      STATUS+0, 2
	INCF       _door_ctr+1, 1
;FinalCode.c,52 :: 		}
L_interrupt33:
;FinalCode.c,53 :: 		TMR1H = 0xFF;
	MOVLW      255
	MOVWF      TMR1H+0
;FinalCode.c,54 :: 		TMR1L = 0x83;
	MOVLW      131
	MOVWF      TMR1L+0
;FinalCode.c,56 :: 		if(buzz_toggle)
	MOVF       _buzz_toggle+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt34
;FinalCode.c,58 :: 		PORTC = PORTC ^ 0x20; // keep beeping while door is open
	MOVLW      32
	XORWF      PORTC+0, 1
;FinalCode.c,60 :: 		}
L_interrupt34:
;FinalCode.c,62 :: 		if (door_ctr == 10000)
	MOVF       _door_ctr+1, 0
	XORLW      39
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt72
	MOVLW      16
	XORWF      _door_ctr+0, 0
L__interrupt72:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt35
;FinalCode.c,64 :: 		PORTC = PORTC | 0x04; // RED ON, GREEN OFF, BUZZER OFF
	BSF        PORTC+0, 2
;FinalCode.c,65 :: 		PORTC = PORTC & 0b11001111;
	MOVLW      207
	ANDWF      PORTC+0, 1
;FinalCode.c,66 :: 		}
L_interrupt35:
;FinalCode.c,68 :: 		if (door_ctr == 12000)
	MOVF       _door_ctr+1, 0
	XORLW      46
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt73
	MOVLW      224
	XORWF      _door_ctr+0, 0
L__interrupt73:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt36
;FinalCode.c,70 :: 		buzz_toggle = 0;
	CLRF       _buzz_toggle+0
;FinalCode.c,71 :: 		position = 3;
	MOVLW      3
	MOVWF      _position+0
;FinalCode.c,73 :: 		PORTC = PORTC | 0x08; // RED ON, GREEN OFF, BUZZER OFF
	BSF        PORTC+0, 3
;FinalCode.c,74 :: 		PORTC = PORTC & 0xEF;
	MOVLW      239
	ANDWF      PORTC+0, 1
;FinalCode.c,75 :: 		Lcd_CmdWriteInt(0x02);        // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,76 :: 		Lcd_CmdWriteInt(0x28);        // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,77 :: 		Lcd_CmdWriteInt(0x0E);        // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,78 :: 		Lcd_CmdWriteInt(0x01);        // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,79 :: 		Lcd_CmdWriteInt(0x80);        // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,80 :: 		Lcd_PrintInt("Door Locked");
	MOVLW      ?lstr1_FinalCode+0
	MOVWF      FARG_Lcd_PrintInt_msg+0
	CALL       _Lcd_PrintInt+0
;FinalCode.c,84 :: 		}
L_interrupt36:
;FinalCode.c,87 :: 		PIR1 = PIR1 & 0xFE; // Lower TMR1 INT flag
	MOVLW      254
	ANDWF      PIR1+0, 1
;FinalCode.c,91 :: 		if (PIR1 & 0x20)  // Check if the interrupt is caused by UART
	BTFSS      PIR1+0, 5
	GOTO       L_interrupt37
;FinalCode.c,93 :: 		recievedBuffer[loki] =  RCREG;
	MOVF       _loki+0, 0
	ADDLW      _recievedBuffer+0
	MOVWF      FSR
	MOVF       RCREG+0, 0
	MOVWF      INDF+0
;FinalCode.c,94 :: 		loki++; // increment the counter
	INCF       _loki+0, 1
;FinalCode.c,96 :: 		if(loki == 5 && strncmp(recievedBuffer, "hello",5) == 0)
	MOVF       _loki+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt40
	MOVLW      _recievedBuffer+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      ?lstr2_FinalCode+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      5
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt74
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt74:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt40
L__interrupt47:
;FinalCode.c,101 :: 		Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,102 :: 		Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,103 :: 		Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,104 :: 		Lcd_CmdWriteInt(0x01);      // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,105 :: 		Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,106 :: 		Lcd_PrintInt("hello");
	MOVLW      ?lstr3_FinalCode+0
	MOVWF      FARG_Lcd_PrintInt_msg+0
	CALL       _Lcd_PrintInt+0
;FinalCode.c,109 :: 		for ( d = 0 ; d<4; d++)
	CLRF       interrupt_d_L2+0
L_interrupt41:
	MOVLW      4
	SUBWF      interrupt_d_L2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt42
;FinalCode.c,111 :: 		random_chall[d] = rand(); //TODO: generate random challenge rand()
	MOVF       interrupt_d_L2+0, 0
	ADDLW      _random_chall+0
	MOVWF      FLOC__interrupt+0
	CALL       _rand+0
	MOVF       FLOC__interrupt+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;FinalCode.c,109 :: 		for ( d = 0 ; d<4; d++)
	INCF       interrupt_d_L2+0, 1
;FinalCode.c,112 :: 		}
	GOTO       L_interrupt41
L_interrupt42:
;FinalCode.c,113 :: 		UART_TxString(4,random_chall); // send the random challenge
	MOVLW      4
	MOVWF      FARG_UART_TxString_length+0
	MOVLW      0
	MOVWF      FARG_UART_TxString_length+1
	MOVLW      _random_chall+0
	MOVWF      FARG_UART_TxString_msg+0
	CALL       _UART_TxString+0
;FinalCode.c,114 :: 		Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,115 :: 		Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,116 :: 		Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,117 :: 		Lcd_CmdWriteInt(0x01);      // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,118 :: 		Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,119 :: 		Lcd_PrintInt("Sent");
	MOVLW      ?lstr4_FinalCode+0
	MOVWF      FARG_Lcd_PrintInt_msg+0
	CALL       _Lcd_PrintInt+0
;FinalCode.c,120 :: 		UART_RxString(4, recieved_chall); // recieve the solved challenge
	MOVLW      4
	MOVWF      FARG_UART_RxString_length+0
	MOVLW      0
	MOVWF      FARG_UART_RxString_length+1
	MOVLW      _recieved_chall+0
	MOVWF      FARG_UART_RxString_msg+0
	CALL       _UART_RxString+0
;FinalCode.c,121 :: 		Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,122 :: 		Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,123 :: 		Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,124 :: 		Lcd_CmdWriteInt(0x01);      // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,125 :: 		Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,126 :: 		Lcd_PrintInt("Recieved");
	MOVLW      ?lstr5_FinalCode+0
	MOVWF      FARG_Lcd_PrintInt_msg+0
	CALL       _Lcd_PrintInt+0
;FinalCode.c,129 :: 		simplehash(random_chall);  // hash the random challenge with the key
	MOVLW      _random_chall+0
	MOVWF      FARG_simplehash_msg+0
	CALL       _simplehash+0
;FinalCode.c,130 :: 		Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,131 :: 		Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,132 :: 		Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,133 :: 		Lcd_CmdWriteInt(0x01);      // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,134 :: 		Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,135 :: 		Lcd_PrintInt("Hashed");
	MOVLW      ?lstr6_FinalCode+0
	MOVWF      FARG_Lcd_PrintInt_msg+0
	CALL       _Lcd_PrintInt+0
;FinalCode.c,136 :: 		if( strncmp(recieved_chall, random_chall, 4) == 0  ) // Compare the recived hash with solved hash
	MOVLW      _recieved_chall+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      _random_chall+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      4
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt75
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt75:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt44
;FinalCode.c,138 :: 		buzz_toggle = 1;
	MOVLW      1
	MOVWF      _buzz_toggle+0
;FinalCode.c,139 :: 		position = 1;
	MOVLW      1
	MOVWF      _position+0
;FinalCode.c,140 :: 		PORTC = PORTC | 0x10; // RED OFF, GREEN ON, BUZZER ON
	BSF        PORTC+0, 4
;FinalCode.c,141 :: 		PORTC = PORTC & 0xF7;
	MOVLW      247
	ANDWF      PORTC+0, 1
;FinalCode.c,143 :: 		Lcd_CmdWriteInt(0x02);      // Initialize Lcd in 4-bit mode`
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,144 :: 		Lcd_CmdWriteInt(0x28);      // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,145 :: 		Lcd_CmdWriteInt(0x0E);      // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,146 :: 		Lcd_CmdWriteInt(0x01);      // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,147 :: 		Lcd_CmdWriteInt(0x80);      // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;FinalCode.c,148 :: 		Lcd_PrintInt("Door Unlocked");
	MOVLW      ?lstr7_FinalCode+0
	MOVWF      FARG_Lcd_PrintInt_msg+0
	CALL       _Lcd_PrintInt+0
;FinalCode.c,150 :: 		door_ctr = 0; // Prepare the door to close after X seconds using TMR1
	CLRF       _door_ctr+0
	CLRF       _door_ctr+1
;FinalCode.c,151 :: 		loki = 0;
	CLRF       _loki+0
;FinalCode.c,152 :: 		}
L_interrupt44:
;FinalCode.c,157 :: 		}
L_interrupt40:
;FinalCode.c,159 :: 		PIR1 = PIR1 & 0b11011111;   // Clear receiver flag
	MOVLW      223
	ANDWF      PIR1+0, 1
;FinalCode.c,160 :: 		}
L_interrupt37:
;FinalCode.c,162 :: 		}
L_end_interrupt:
L__interrupt70:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;FinalCode.c,164 :: 		void main()
;FinalCode.c,166 :: 		INTCON  = 0XC0; // Enable global and peripheral interrupts  // 1100 0000
	MOVLW      192
	MOVWF      INTCON+0
;FinalCode.c,168 :: 		T1CON = 0x31; // 0011 0001 // 1:8 Prescaler with Fosc = 8.0Mhz // 0x31
	MOVLW      49
	MOVWF      T1CON+0
;FinalCode.c,169 :: 		TMR1H = 0xFF;  // 0xFF83 = 0.5ms
	MOVLW      255
	MOVWF      TMR1H+0
;FinalCode.c,170 :: 		TMR1L = 0x83;  // 0xFF83 = 0.5ms
	MOVLW      131
	MOVWF      TMR1L+0
;FinalCode.c,173 :: 		UART_Init(9600); // Initialize UART module
	MOVLW      128
	MOVWF      FARG_UART_Init_baudRate+0
	MOVLW      37
	MOVWF      FARG_UART_Init_baudRate+1
	CALL       _UART_Init+0
;FinalCode.c,174 :: 		PIR1 = PIE1 | 0X01; // Enable TMR1 interrupt
	MOVLW      1
	IORWF      PIE1+0, 0
	MOVWF      PIR1+0
;FinalCode.c,175 :: 		buzz_toggle = 0;
	CLRF       _buzz_toggle+0
;FinalCode.c,176 :: 		PORTC = PORTC | 0B00001000; // RED ON, GREEN OFF, BUZZER OFF
	BSF        PORTC+0, 3
;FinalCode.c,177 :: 		PORTC = PORTC & 0B11001111; // RED ON, GREEN OFF, BUZZER OFF
	MOVLW      207
	ANDWF      PORTC+0, 1
;FinalCode.c,181 :: 		LcdDataBusDirnReg = 0x00; // TRISD for LCD
	CLRF       TRISD+0
;FinalCode.c,182 :: 		Lcd_CmdWrite(0x02);        // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWrite_cmd+0
	CALL       _Lcd_CmdWrite+0
;FinalCode.c,183 :: 		Lcd_CmdWrite(0x28);        // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWrite_cmd+0
	CALL       _Lcd_CmdWrite+0
;FinalCode.c,184 :: 		Lcd_CmdWrite(0x0E);        // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWrite_cmd+0
	CALL       _Lcd_CmdWrite+0
;FinalCode.c,185 :: 		Lcd_CmdWrite(0x01);        // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWrite_cmd+0
	CALL       _Lcd_CmdWrite+0
;FinalCode.c,186 :: 		Lcd_CmdWrite(0x80);        // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWrite_cmd+0
	CALL       _Lcd_CmdWrite+0
;FinalCode.c,187 :: 		Lcd_Print("Door Locked");
	MOVLW      ?lstr8_FinalCode+0
	MOVWF      FARG_Lcd_Print_msg+0
	CALL       _Lcd_Print+0
;FinalCode.c,203 :: 		while(1){
L_main45:
;FinalCode.c,204 :: 		}
	GOTO       L_main45
;FinalCode.c,206 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
