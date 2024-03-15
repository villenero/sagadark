;******************************************************************
;*** TRITON SOFTWARE **** SAGA FILM *******************************
;******************************************************************


; CONSTANTES
SCREEN  EQU 16384       ; Inicio del area de pantalla
PILA    EQU 23999       ; Pila del sistema
INICIO  EQU 24000       ; 24000 Inicio del codigo

VAR     EQU 23728       

; INICIO DEL PROGRMA

        ORG INICIO

        LD  A,0
        OUT (254),A     ; Color del borde
        LD  BC,0        ; esperamos que se pulse una tecla
        CALL 7997       ; 1F3D PAUSE-1 rom
             
MAIN    CALL POKSET     ; Activamos set de caracteres
        CALL CLS        ; Limpiamos pantalla            
        LD HL,TEXTO
        CALL IMPREC     ; Imprimirmos Copyright
        CALL BORDE      ; Efecto sonido y color de borde
        LD HL,DARKT 
        CALL IMPREC     ; Imprime DARK
        CALL RAINM2     ; Pone gotas IM2 en marcha
        LD B,100
        
NUBE    HALT
        DJNZ NUBE
        CALL BO
        CALL TONI
        LD A,0
        LD (23560),A

ESPERA  LD  HL,$5C3B
        RES 5,(HL)
GUSANO  LD  HL,$5C3B
        BIT 5,(HL)
        JR  NZ,CONT8
        LD  A,(DAT9)
        DEC A
        CP  0
        JR  Z,CONT8
        LD  A,(DAT8)
        DEC A
        LD  (DAT8),A
        CP  0
        CALL Z,RALLAS
        HALT
        JR  GUSANO
CONT8   CALL IMPRE3
        LD  B,50
TURURU  HALT
        DJNZ TURURU
        CALL CLS
        CALL OUTM2
        CALL IMPRE3
        CALL CLS
ESTASS  CALL AMPLI_E     ; E AMPLIADA        
        LD  HL,NUBO      
        CALL IMPRE4      ; ESTAS SON LA PERSONAS ...
        LD  B,100
LLUVIA  HALT
        DJNZ LLUVIA
        CALL IMPRE3
        CALL CLS
        CALL PIJAMA      ; SCROLL ARRIBA PIJAMA
YLAHIS  CALL CLS
        CALL AMPLI_Y     ; Y AMPLIADA
        LD  HL,HIST
        CALL IMPRE4      ; Y LA HISTORIA COMIENZA
        LD  B,50
ASASA   HALT
        DJNZ ASASA
        CALL IMPRE3
        CALL CLS
        CALL LAJACA      ; 2 PARTE JACA
        CALL PELICULA    ; 3 PARTE LA PELICULA
        
        JP  FINPELI

HIST    DEFB 22,11,6 ; POS Y,X
        DEFB 16,9 ; COLOR (9:)
        DEFB 17,0
        DEFM 'LA HISTORIA COMIENZA ...'
        DEFB 255
        
NUBO    DEFB 16,7 ; COLOR (7:BLA)
        DEFB 22,10,6 ; POS Y,X
        DEFM 'STAS SON LAS PERSONAS'
        DEFB 22,12,3 ; POS Y,X
        DEFM 'QUE HAN HECHO POSIBLE QUE'
        DEFB 22,14,3 ; POS Y,X
        DEFM 'PUEDAS PASAR UN BUEN RATO'
        DEFB 255
        

; PONE IM2 EN MARCHA

RAINM2  LD A,254
        LD I,A
        IM 2
        RET

; APAGA IM2 GOTAS

OUTM2   IM 1
        RET
                
; COPYRIGHT

TEXTO   DEFB 22,21,0 ; POS Y,X
        DEFB 16,6 ; COLOR (6:AMA)
        DEFB 19,1,17,0
        DEFB 91 ; (C)
        DEFM ' COPYRIGHT 1987 TRITON SOFTWARE'
        DEFB 255

; lOGOTIPO SAGA DARK INICIO

DARKT   DEFB 16,7 ; COLOR (7:BLA)
        DEFB 19,1
        DEFB 22,2,10 ; POS Y,X
        DEFB 92,19,0,93,94
        DEFB 22,3,10 ; POS Y,X
        DEFB 19,1,95,19,0,96,97,19,1
        DEFB 22,4,10 ; POS Y,X
        DEFB 19,1,98,19,0,99,100
        DEFB 22,3,13 ; POS Y,X
        DEFB 101,102,103,107,108,114,115
        DEFB 22,4,13 ; POS Y,X
        DEFB 104,105,106,109,110,116,117
        DEFB 22,2,17 ; POS Y,X
        DEFB 19,1,111,19,0,112,113
        ; SAGA SUPERIOR
        DEFB 16,4 ; COLOR (4:VER)
        DEFB 19,1
        DEFB 22,1,11 ; POS Y,X
        DEFB 118,119,120,121
        DEFB 255

PRESA   DEFM 'PULSE  UNA  TECLA              '
        DEFB 255

; INCLUDES

        INCLUDE libreria.asm    ; Libreria de funciones
        INCLUDE charset.asm     ; tabla de caracteres
        INCLUDE pijama.asm      ; pijama cine   
        INCLUDE jaca.asm        ; la jaca   
        INCLUDE pelicula.asm    ; la pelicula
        INCLUDE final.asm        
        INCLUDE pantallas.asm   ; screens        

FINCODIGO   DEFB    0
        
; INTERRUPCION ENMASCARABLE 2

        ORG 65021
        JP GOTAS
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253        
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253,253,253,253,253,253,253,253
        DEFB 253                                                                                                                                                                                                                                                        
          

; esto tiene que ir aqui detras
; hemos ocupado toda la memoria disponible !!!!

; 33730 2x10 x9 = 180 bytes  

IMGSOL  DEFB 0,0,10,5,0,85,42,0,70
		DEFB 0,0,0,0,0,5,14,221,70
		DEFB 10,5,128,85,42,21,160,85,70
		DEFB 10,1,0,1,170,85,170,117,86
		DEFB 170,69,128,64,168,85,42,5,86
		DEFB 162,85,170,85,170,95,237,116,86
		DEFB 170,85,10,64,10,85,170,85,94
		DEFB 170,65,138,85,170,215,239,189,94
		DEFB 170,81,42,20,160,85,143,95,94
		DEFB 191,63,127,127,127,255,87,255,94
		DEFB 128,85,170,85,170,85,242,249,94
		DEFB 252,253,254,254,254,255,173,215,94
		DEFB 168,85,170,85,170,85,168,85,94
		DEFB 170,85,162,85,170,117,251,215,94
		DEFB 0,64,168,84,168,85,168,81,86
		DEFB 170,85,170,85,170,215,107,182,86
		DEFB 0,0,130,20,168,80,10,85,70
		DEFB 168,80,160,84,170,119,186,215,86
		DEFB 0,0,0,0,0,84,168,0,70
		DEFB 128,0,128,0,128,80,168,85,70
        
TEXTOFIN    DEFB    22,12,2 ; COORD Y, X
            DEFB    19,1,16,5,17,0
            DEFM    'STE ES EL FINAL DE LA HISTORIA'
            DEFB    22,14,5 ; COORD Y,X
            DEFM    'LO DEMAS ES COSA TUYA.'
            DEFB    255
                                          
; FIN DEL CODIGO

FINCODIGO2  DEFB    0

        END INICIO  ; Fin de codigo e inicio de ejecucion del programa
        
        

