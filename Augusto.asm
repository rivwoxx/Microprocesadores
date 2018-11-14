#include "p18f4550.inc"

; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = INTOSC_EC      ; Oscillator Selection bits (Internal oscillator, CLKO function on RA6, EC used by USB (INTCKO))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
  CONFIG  BOR = ON              ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = ON              ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)


    #include <MACRO_LCD_MENSAJES_18F4550.inc>
;    #define BOTON  PORTB,0
   
    
    CBLOCK 0x60			;Registros de usuario
    ENDC
    
    
    ORG	    0x00		;Aqui inicia nuestro programa
 
    CONFIGURACION:
	MOVLW	0x60
	MOVWF	OSCCON
	SETF	TRISB
	CLRF	TRISD
	BCF	INTCON2,7		
	CALL    LCD_Inicializa	
	BSF	PORTD,0
;	GOTO INDEX
	
    INDEX:
	MOVLW   .20
	CPFSLT  PORTB	    ;MENOR A 20
	GOTO	STEVEN	  	;NO
	GOTO    STONE 		;SI

    STONE:
	MOVLW	.10
	CPFSGT	PORTB	    ;MAYOR A 10
	GOTO	HARMONY	    ;NO
	GOTO	WILSON	    ;SI
	
;    ROSES:
;	MOVLW	.10
;	CPFSLT	PORTB	    ;MENOR A 10
;	GOTO	HARMONY	    ;NO
;	GOTO	PRESERVE    ;SI
	
    HARMONY:
	MOVLW	.5
	CPFSGT	PORTB	    ;MAYOR A 5
	GOTO	AMASS	    ;NO
	GOTO	PRESERVE	    ;SI
	
	
STEVEN:	
    CALL    LCD_Borra
    CALL    LCD_Linea1
    LCD_Mensaje CALOR	    
    CALL    LCD_Linea2
    MOVF    PORTB,w    
    CALL    IMPRIME
    CALL    Retardo_1s
    GOTO    INDEX

WILSON:
    CALL    LCD_Borra
    CALL    LCD_Linea1
    LCD_Mensaje TEMPLADO	    
    CALL    LCD_Linea2
    MOVF    PORTB,w    
    CALL    IMPRIME
    CALL    Retardo_1s
    GOTO    INDEX

PRESERVE:
    CALL    LCD_Borra
    CALL    LCD_Linea1
    LCD_Mensaje FRIO	    
    CALL    LCD_Linea2
    MOVF    PORTB,w    
    CALL    IMPRIME
    CALL    Retardo_1s
    GOTO    INDEX

AMASS:
    CALL    LCD_Borra
    CALL    LCD_Linea1
    LCD_Mensaje CONGELAMOS	    
    CALL    LCD_Linea2
    MOVF    PORTB,w    
    CALL    IMPRIME
    CALL    Retardo_1s
    GOTO    INDEX
	
    Mensajes:
	ADDWF PCL,F
CONGELAMOS:
    DB "Nos Congelamos",00H
FRIO:
    DB "Hace Frio",00H
TEMPLADO:
    DB "Templado",00H
CALOR:
    DB "Hace calor",00H

INCLUDE <LCD_18F4550.inc>
INCLUDE <RETARDOS.INC>
INCLUDE <BIN_BCD.inc>
INCLUDE <AugustoLibreria.inc>
    END