
_delay:

;rfid_killer_lcd.h,16 :: 		void delay(unsigned int cnt)
;rfid_killer_lcd.h,19 :: 		for(i=0;i<cnt;i++)
	CLRF       R1+0
	CLRF       R1+1
L_delay0:
	MOVF       FARG_delay_cnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay20
	MOVF       FARG_delay_cnt+0, 0
	SUBWF      R1+0, 0
L__delay20:
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
	GOTO       L__delayInt22
	MOVF       FARG_delayInt_cnt+0, 0
	SUBWF      R1+0, 0
L__delayInt22:
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

;USART_Rx.c,10 :: 		void UART_Init(int baudRate)
;USART_Rx.c,12 :: 		INTCON = 0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;USART_Rx.c,13 :: 		PIE1 = 0b00100000; // enable recieve interrupt
	MOVLW      32
	MOVWF      PIE1+0
;USART_Rx.c,14 :: 		TRISC=0x80;            // Configure Rx pin as input and Tx as output
	MOVLW      128
	MOVWF      TRISC+0
;USART_Rx.c,15 :: 		TXSTA=(1<<SBIT_TXEN);  // Asynchronous mode, 8-bit data & enable transmitter
	MOVLW      32
	MOVWF      TXSTA+0
;USART_Rx.c,16 :: 		RCSTA=(1<<SBIT_SPEN) | (1<<SBIT_CREN);  // Enable Serial Port and 8-bit
	MOVLW      144
	MOVWF      RCSTA+0
;USART_Rx.c,17 :: 		RCSTA = 0x90;
	MOVLW      144
	MOVWF      RCSTA+0
;USART_Rx.c,18 :: 		SPBRG = (8000000UL/(long)(64UL*baudRate))-1;      // baud rate @20Mhz Clock
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
L__UART_Init30:
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Init31
	RLF        R4+0, 1
	RLF        R4+1, 1
	RLF        R4+2, 1
	RLF        R4+3, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__UART_Init30
L__UART_Init31:
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
;USART_Rx.c,19 :: 		}
L_end_UART_Init:
	RETURN
; end of _UART_Init

_UART_TxChar:

;USART_Rx.c,22 :: 		void UART_TxChar(char ch)
;USART_Rx.c,24 :: 		while(TXIF & 0x10);  //Test for TXIF, Wait till the transmitter register becomes empty
L_UART_TxChar13:
;USART_Rx.c,25 :: 		PIR1 = PIR1 & 0xEF;  // Clear transmitter flag
	MOVLW      239
	ANDWF      PIR1+0, 1
;USART_Rx.c,26 :: 		TXREG=ch;            // load the char to be transmitted into transmit reg
	MOVF       FARG_UART_TxChar_ch+0, 0
	MOVWF      TXREG+0
;USART_Rx.c,27 :: 		}
L_end_UART_TxChar:
	RETURN
; end of _UART_TxChar

_UART_RxChar:

;USART_Rx.c,30 :: 		char UART_RxChar()
;USART_Rx.c,32 :: 		while(PIR1 & 0b00100000);   // Test for RCIF, Wait till the data is received
L_UART_RxChar14:
	BTFSS      PIR1+0, 5
	GOTO       L_UART_RxChar15
	GOTO       L_UART_RxChar14
L_UART_RxChar15:
;USART_Rx.c,33 :: 		PIR1 = PIR1 & 0b11011111;   // Clear receiver flag
	MOVLW      223
	ANDWF      PIR1+0, 1
;USART_Rx.c,34 :: 		return(RCREG);        // Return the received data to calling function
	MOVF       RCREG+0, 0
	MOVWF      R0+0
;USART_Rx.c,35 :: 		}
L_end_UART_RxChar:
	RETURN
; end of _UART_RxChar

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;USART_Rx.c,38 :: 		void interrupt()
;USART_Rx.c,41 :: 		ch[i] =  RCREG;
	MOVF       _i+0, 0
	ADDLW      _ch+0
	MOVWF      FSR
	MOVF       RCREG+0, 0
	MOVWF      INDF+0
;USART_Rx.c,42 :: 		i++;
	INCF       _i+0, 1
;USART_Rx.c,43 :: 		PIR1 = PIR1 & 0b11011111;   // Clear receiver flag
	MOVLW      223
	ANDWF      PIR1+0, 1
;USART_Rx.c,44 :: 		LcdDataBusDirnReg = 0x00; // TRISD for LCD
	CLRF       TRISD+0
;USART_Rx.c,45 :: 		Lcd_CmdWriteInt(0x02);        // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,46 :: 		Lcd_CmdWriteInt(0x28);        // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,47 :: 		Lcd_CmdWriteInt(0x0E);        // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,48 :: 		Lcd_CmdWriteInt(0x01);        // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,49 :: 		Lcd_CmdWriteInt(0x80);        // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,51 :: 		if(i == 16)
	MOVF       _i+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
;USART_Rx.c,53 :: 		LcdDataBusDirnReg = 0x00; // TRISD for LCD
	CLRF       TRISD+0
;USART_Rx.c,54 :: 		Lcd_CmdWriteInt(0x02);        // Initialize Lcd in 4-bit mode
	MOVLW      2
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,55 :: 		Lcd_CmdWriteInt(0x28);        // enable 5x7 mode for chars
	MOVLW      40
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,56 :: 		Lcd_CmdWriteInt(0x0E);        // Display OFF, Cursor ON
	MOVLW      14
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,57 :: 		Lcd_CmdWriteInt(0x01);        // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,58 :: 		Lcd_CmdWriteInt(0x80);        // Move the cursor to beginning of first line
	MOVLW      128
	MOVWF      FARG_Lcd_CmdWriteInt_cmd+0
	CALL       _Lcd_CmdWriteInt+0
;USART_Rx.c,59 :: 		Lcd_PrintInt(ch);
	MOVLW      _ch+0
	MOVWF      FARG_Lcd_PrintInt_msg+0
	CALL       _Lcd_PrintInt+0
;USART_Rx.c,60 :: 		i = 0;
	CLRF       _i+0
;USART_Rx.c,61 :: 		}
L_interrupt16:
;USART_Rx.c,63 :: 		}
L_end_interrupt:
L__interrupt35:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;USART_Rx.c,64 :: 		int main()
;USART_Rx.c,66 :: 		TRISE = 0x00;
	CLRF       TRISE+0
;USART_Rx.c,67 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;USART_Rx.c,68 :: 		UART_Init(9600);          //Initialize the UART module with 9600 baud rate
	MOVLW      128
	MOVWF      FARG_UART_Init_baudRate+0
	MOVLW      37
	MOVWF      FARG_UART_Init_baudRate+1
	CALL       _UART_Init+0
;USART_Rx.c,70 :: 		while(1){asm{sleep};}
L_main17:
	SLEEP
	GOTO       L_main17
;USART_Rx.c,71 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
