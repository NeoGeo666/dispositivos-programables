; Se tienen 2 SWICHES (RA0 Y RA1) y 8 Leds (RB0 ... RB7), si RA0 esta encendido
; se encienden los leds pares de PORTB, si RA1 esta encendido se encienden los
; leds impares de PORTB
    
    LIST P=18F4550

    #INCLUDE <P18F4550.INC>
    
    ;CONFIG1L dir 300000h 	20
    ;CONFIG	PLLDIV=1	 ; 
    ;CONFIG	CPUDIV=OSC1_PLL2 ;CUANDO SE USA XTAL	
    ;CONFIG	USBDIV=2

    ;CONFIG1H dir 300001h	08
    CONFIG	FOSC=INTOSCIO_EC ;OSCILADOR INTERNO, RA6 COMO PIN, USB USA OSC EC
    CONFIG	FCMEN=OFF        ;DESHABILITDO EL MONITOREO DEL RELOJ
    CONFIG	IESO=OFF

    ;CONFIG2L DIR 300002H	38
    CONFIG	PWRT=ON          ;PWRT HABILITADO
    CONFIG  BOR=OFF		 ;BROWN OUT RESET DESHABILITADO
    CONFIG BORV=3		 ;RESET AL MINIMO VOLTAJE NO UTILZADO EN ESTE CASO
    CONFIG	VREGEN=ON	 ;REULADOR DE USB ENCENDIDO

    ;CONFIG2H DIR 300003H	1E
    CONFIG	WDT=OFF          ;WACH DOG DESHABILITADO
    CONFIG WDTPS=32768      ;TIMER DEL WATCHDOG 

    ;CONFIG3H DIR 300005H	81
    CONFIG	CCP2MX=ON	 ;CCP2 MULTIPLEXADAS CON RC1	
    CONFIG	PBADEN=OFF       ;PUERTO B PINES DEL 0 AL 4 ENTRADAS DIGITALES
    CONFIG  LPT1OSC=OFF	 ;TIMER1 CONFIURADO PARA OPERAR EN BAJA POTENCIA
    CONFIG	MCLRE=ON         ;MASTER CLEAR HABILITADO

    ;CONFIG4L DIR 300006H	81
    CONFIG	STVREN=ON	 ;SI EL STACK SE LLENA CAUSE RESET		
    CONFIG	LVP=OFF		 ;PROGRAMACI�N EN BAJO VOLTAJE APAGADO
    CONFIG	ICPRT=OFF	 ;REGISTRO ICPORT DESHABILITADO
    CONFIG	XINST=OFF	 ;SET DE EXTENCION DE INSTRUCCIONES Y DIRECCIONAMIENTO INDEXADO DESHABILITADO

    ;CONFIG5L DIR 300008H	0F
    CONFIG	CP0=OFF		 ;LOS BLOQUES DEL C�DIGO DE PROGRAMA
    CONFIG	CP1=OFF          ;NO ESTAN PROTEGIDOS
    CONFIG	CP2=OFF		 
    CONFIG	CP3=OFF

    ;CONFIG5H DR 300009H	C0
    CONFIG	CPB=OFF		 ;SECTOR BOOT NO ESTA PROTEGIDO
    CONFIG	CPD=OFF		 ;EEPROM N PROTEGIDA

    ;CONFIG6L DIR 30000AH	0F
    CONFIG	 WRT0=OFF	 ;BLOQUES NO PROTEGIDOS CONTRA ESCRITURA
    CONFIG	 WRT1=OFF
    CONFIG	 WRT2=OFF
    CONFIG	 WRT3=OFF

    ;CONFIG6H DIR 30000BH	E0
    CONFIG	 WRTC=OFF	 ;CONFIGURACION DE REGISTROS NO PROTEGIDO
    CONFIG	 WRTB=OFF	 ;BLOQUE BOOTEBLE NO PROTEGIDO
    CONFIG	 WRTD=OFF	 ;EEPROMDE DATOS NO PROTGIDA

    ;CONFIG7L DIR 30000CH	0F
    CONFIG	 EBTR0=OFF	 ;TABLAS DE LETURA NO PROTEGIDAS
    CONFIG	 EBTR1=OFF
    CONFIG	 EBTR2=OFF
    CONFIG	 EBTR3=OFF

    ;CONFIG7H DIR 30000DH	40
    CONFIG	 EBTRB=OFF	 ;TABLAS NO PROTEGIDAS
    
    #DEFINE	SWICH0	PORTA, RA0, 0
    #DEFINE	SWICH1	PORTA, RA1, 0
    
    #DEFINE	LED0	PORTB, RD0, 0
    #DEFINE	LED1	PORTB, RD1, 0
    #DEFINE	LED2	PORTB, RD2, 0
    #DEFINE	LED3	PORTB, RD3, 0
    #DEFINE	LED4	PORTB, RD4, 0
    #DEFINE	LED5	PORTB, RD5, 0
    #DEFINE	LED6	PORTB, RD6, 0
    #DEFINE	LED7	PORTB, RD7, 0
    	
   
    ORG		.0
    
INICIO
    CLRF    PORTA, 0	; Limpiar PORTA
    CLRF    PORTB, 0	; Limpiar PORTD
    
    SETF    TRISA	; Configura TRISA 0111 1111 (7 Entradas)
    CLRF    TRISB	; Configura TRISD 0000 0000 (8 Salidas)
    
    MOVLW   .15		; Asigna 15 W
    MOVWF   ADCON1, 0	; Asigna 1111 (15 Binario) a ADCON1 para indicar que
			; Todas las entradas son digitales
    
    MOVLW   .7		; Asigna 7 W
    MOVWF   CMCON	; Asigna 111 (7 Binario) a CMCON para indicar que
			; Esta apagado el comparador de voltaje

CHECK0
    BTFSS   SWICH0	; Comprueba el bit 0 de PORTA
    GOTO    OFF0	; Se ejecuta si esta apagado (0)
    GOTO    ON0		; Se ejecuta si esta encendido (1)

ON0
    BSF	    LED0	; Asigna 1 a el bit 0 de PORTB
    BSF	    LED2	; Asigna 1 a el bit 2 de PORTB
    BSF	    LED4	; Asigna 1 a el bit 4 de PORTB
    BSF	    LED6	; Asigna 1 a el bit 6 de PORTB
    GOTO    CHECK1	; Ejecuta el codigo que comprueba el bit 1 de PORTA

OFF0
    BCF	    LED0	; Asigna 0 a el bit 0 de PORTB
    BCF	    LED2	; Asigna 0 a el bit 2 de PORTB
    BCF	    LED4	; Asigna 0 a el bit 4 de PORTB
    BCF	    LED6	; Asigna 0 a el bit 6 de PORTB
    GOTO    CHECK1	; Ejecuta el codigo que comprueba el bit 1 de PORTA

CHECK1
    BTFSS   SWICH1	; Comprueba el bit 1 de PORTA
    GOTO    OFF1	; Se ejecuta si esta apagado (0)
    GOTO    ON1		; Se ejecuta si esta encendido (1)

ON1
    BSF	    LED1	; Asigna 1 a el bit 1 de PORTB
    BSF	    LED3	; Asigna 1 a el bit 3 de PORTB
    BSF	    LED5	; Asigna 1 a el bit 5 de PORTB
    BSF	    LED7	; Asigna 1 a el bit 7 de PORTB
    GOTO    CHECK0	; Ejecuta el codigo que comprueba el bit 0 de PORTA

OFF1
    BCF	    LED1	; Asigna 0 a el bit 1 de PORTB
    BCF	    LED3	; Asigna 0 a el bit 3 de PORTB
    BCF	    LED5	; Asigna 0 a el bit 5 de PORTB
    BCF	    LED7	; Asigna 0 a el bit 7 de PORTB
    GOTO    CHECK0	; Ejecuta el codigo que comprueba el bit 0 de PORTA
    END