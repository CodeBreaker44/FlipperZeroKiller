
_UART_Init:

;USART_Tx.c,6 :: 		void UART_Init(int baudRate)
;USART_Tx.c,8 :: 		TRISC=0x80;            // Configure Rx pin as input and Tx as output
	MOVLW      128
	MOVWF      TRISC+0
;USART_Tx.c,9 :: 		TXSTA=(1<<SBIT_TXEN);  // Asynchronous mode, 8-bit data & enable transmitter
	MOVLW      32
	MOVWF      TXSTA+0
;USART_Tx.c,10 :: 		RCSTA=(1<<SBIT_SPEN) | (1<<SBIT_CREN);  // Enable Serial Port and 8-bit continuous receive
	MOVLW      144
	MOVWF      RCSTA+0
;USART_Tx.c,11 :: 		SPBRG = (8000000UL/(long)(64UL*baudRate))-1;      // baud rate @20Mhz Clock
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
L__UART_Init12:
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Init13
	RLF        R4+0, 1
	RLF        R4+1, 1
	RLF        R4+2, 1
	RLF        R4+3, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__UART_Init12
L__UART_Init13:
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
;USART_Tx.c,12 :: 		}
L_end_UART_Init:
	RETURN
; end of _UART_Init

_UART_TxChar:

;USART_Tx.c,15 :: 		void UART_TxChar(char ch)
;USART_Tx.c,17 :: 		while(TXIF & 0x10);  //Test for TXIF, Wait till the transmitter register becomes empty
L_UART_TxChar1:
;USART_Tx.c,18 :: 		PIR1 = PIR1 & 0xEF;  // Clear transmitter flag
	MOVLW      239
	ANDWF      PIR1+0, 1
;USART_Tx.c,19 :: 		TXREG=ch;            // load the char to be transmitted into transmit reg
	MOVF       FARG_UART_TxChar_ch+0, 0
	MOVWF      TXREG+0
;USART_Tx.c,20 :: 		}
L_end_UART_TxChar:
	RETURN
; end of _UART_TxChar

_UART_RxChar:

;USART_Tx.c,23 :: 		char UART_RxChar()
;USART_Tx.c,25 :: 		while(PIR1 & 0x20);   // Test for RCIF, Wait till the data is received
L_UART_RxChar2:
	BTFSS      PIR1+0, 5
	GOTO       L_UART_RxChar3
	GOTO       L_UART_RxChar2
L_UART_RxChar3:
;USART_Tx.c,26 :: 		PIR1 = PIR1 & 0xDF;   // Clear receiver flag
	MOVLW      223
	ANDWF      PIR1+0, 1
;USART_Tx.c,27 :: 		return(RCREG);        // Return the received data to calling function
	MOVF       RCREG+0, 0
	MOVWF      R0+0
;USART_Tx.c,28 :: 		}
L_end_UART_RxChar:
	RETURN
; end of _UART_RxChar

_UART_TxString:

;USART_Tx.c,30 :: 		void UART_TxString(char *msg)
;USART_Tx.c,33 :: 		for(i=0;msg[i]!=0;i++)
	CLRF       UART_TxString_i_L0+0
L_UART_TxString4:
	MOVF       UART_TxString_i_L0+0, 0
	ADDWF      FARG_UART_TxString_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_UART_TxString5
;USART_Tx.c,35 :: 		UART_TxChar(msg[i]);
	MOVF       UART_TxString_i_L0+0, 0
	ADDWF      FARG_UART_TxString_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART_TxChar_ch+0
	CALL       _UART_TxChar+0
;USART_Tx.c,36 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_UART_TxString7:
	DECFSZ     R13+0, 1
	GOTO       L_UART_TxString7
	DECFSZ     R12+0, 1
	GOTO       L_UART_TxString7
	DECFSZ     R11+0, 1
	GOTO       L_UART_TxString7
	NOP
;USART_Tx.c,33 :: 		for(i=0;msg[i]!=0;i++)
	INCF       UART_TxString_i_L0+0, 1
;USART_Tx.c,37 :: 		}
	GOTO       L_UART_TxString4
L_UART_TxString5:
;USART_Tx.c,39 :: 		}
L_end_UART_TxString:
	RETURN
; end of _UART_TxString

_main:

;USART_Tx.c,40 :: 		int main()
;USART_Tx.c,42 :: 		UART_Init(9600);          //Initialize the UART module with 9600 baud rate
	MOVLW      128
	MOVWF      FARG_UART_Init_baudRate+0
	MOVLW      37
	MOVWF      FARG_UART_Init_baudRate+1
	CALL       _UART_Init+0
;USART_Tx.c,43 :: 		delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;USART_Tx.c,45 :: 		UART_TxString("Hello World GG!!");
	MOVLW      ?lstr1_USART_Tx+0
	MOVWF      FARG_UART_TxString_msg+0
	CALL       _UART_TxString+0
;USART_Tx.c,46 :: 		while(1){}
L_main9:
	GOTO       L_main9
;USART_Tx.c,50 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
