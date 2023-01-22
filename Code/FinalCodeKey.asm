
_xor_a_b:

;nonce.h,1 :: 		void xor_a_b(char *a, char *b)
;nonce.h,4 :: 		for (i = 0; i < 4; i++)
	CLRF       R2+0
L_xor_a_b0:
	MOVLW      4
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_xor_a_b1
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
	GOTO       L_xor_a_b0
L_xor_a_b1:
;nonce.h,9 :: 		}
L_end_xor_a_b:
	RETURN
; end of _xor_a_b

_simplehash:

;nonce.h,11 :: 		void simplehash(char * msg)
;nonce.h,14 :: 		for ( i = 1; i <= 4; i++)
	MOVLW      1
	MOVWF      simplehash_i_L0+0
L_simplehash3:
	MOVF       simplehash_i_L0+0, 0
	SUBLW      4
	BTFSS      STATUS+0, 0
	GOTO       L_simplehash4
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
	GOTO       L_simplehash3
L_simplehash4:
;nonce.h,19 :: 		}
L_end_simplehash:
	RETURN
; end of _simplehash

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
L__UART_Init26:
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Init27
	RLF        R4+0, 1
	RLF        R4+1, 1
	RLF        R4+2, 1
	RLF        R4+3, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__UART_Init26
L__UART_Init27:
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
L_UART_TxChar7:
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
L_UART_RxChar8:
	BTFSC      PIR1+0, 5
	GOTO       L_UART_RxChar9
	GOTO       L_UART_RxChar8
L_UART_RxChar9:
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
L_UART_TxString10:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_UART_TxString_length+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__UART_TxString31
	MOVF       FARG_UART_TxString_length+0, 0
	SUBWF      UART_TxString_i_L0+0, 0
L__UART_TxString31:
	BTFSC      STATUS+0, 0
	GOTO       L_UART_TxString11
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
L_UART_TxString13:
	DECFSZ     R13+0, 1
	GOTO       L_UART_TxString13
	DECFSZ     R12+0, 1
	GOTO       L_UART_TxString13
	DECFSZ     R11+0, 1
	GOTO       L_UART_TxString13
	NOP
;uart.h,47 :: 		for(i=0;i<length;i++)
	INCF       UART_TxString_i_L0+0, 1
;uart.h,51 :: 		}
	GOTO       L_UART_TxString10
L_UART_TxString11:
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
L_UART_RxString14:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_UART_RxString_length+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__UART_RxString33
	MOVF       FARG_UART_RxString_length+0, 0
	SUBWF      UART_RxString_i_L0+0, 0
L__UART_RxString33:
	BTFSC      STATUS+0, 0
	GOTO       L_UART_RxString15
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
	GOTO       L_UART_RxString14
L_UART_RxString15:
;uart.h,63 :: 		INTCON = INTCON | 0b10000000; // enable global interrupt
	BSF        INTCON+0, 7
;uart.h,64 :: 		}
L_end_UART_RxString:
	RETURN
; end of _UART_RxString

_main:

;FinalCodeKey.c,15 :: 		void main (){
;FinalCodeKey.c,17 :: 		UART_Init(9600);
	MOVLW      128
	MOVWF      FARG_UART_Init_baudRate+0
	MOVLW      37
	MOVWF      FARG_UART_Init_baudRate+1
	CALL       _UART_Init+0
;FinalCodeKey.c,18 :: 		delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
	NOP
;FinalCodeKey.c,19 :: 		UART_TxString(5,"hello");
	MOVLW      5
	MOVWF      FARG_UART_TxString_length+0
	MOVLW      0
	MOVWF      FARG_UART_TxString_length+1
	MOVLW      ?lstr1_FinalCodeKey+0
	MOVWF      FARG_UART_TxString_msg+0
	CALL       _UART_TxString+0
;FinalCodeKey.c,20 :: 		UART_RxString(4, recieved_rand);
	MOVLW      4
	MOVWF      FARG_UART_RxString_length+0
	MOVLW      0
	MOVWF      FARG_UART_RxString_length+1
	MOVLW      _recieved_rand+0
	MOVWF      FARG_UART_RxString_msg+0
	CALL       _UART_RxString+0
;FinalCodeKey.c,22 :: 		simplehash(recieved_rand);
	MOVLW      _recieved_rand+0
	MOVWF      FARG_simplehash_msg+0
	CALL       _simplehash+0
;FinalCodeKey.c,25 :: 		for (i = 0; i < 4; i++)
	CLRF       main_i_L0+0
L_main18:
	MOVLW      4
	SUBWF      main_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main19
;FinalCodeKey.c,27 :: 		firstFour[i] = recieved_rand[i];
	MOVF       main_i_L0+0, 0
	ADDLW      _firstFour+0
	MOVWF      R1+0
	MOVF       main_i_L0+0, 0
	ADDLW      _recieved_rand+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;FinalCodeKey.c,25 :: 		for (i = 0; i < 4; i++)
	INCF       main_i_L0+0, 1
;FinalCodeKey.c,28 :: 		}
	GOTO       L_main18
L_main19:
;FinalCodeKey.c,29 :: 		UART_TxString(4,firstFour);
	MOVLW      4
	MOVWF      FARG_UART_TxString_length+0
	MOVLW      0
	MOVWF      FARG_UART_TxString_length+1
	MOVLW      _firstFour+0
	MOVWF      FARG_UART_TxString_msg+0
	CALL       _UART_TxString+0
;FinalCodeKey.c,32 :: 		while(1);
L_main21:
	GOTO       L_main21
;FinalCodeKey.c,38 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
