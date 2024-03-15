
; 2 PARTE. LA JACA

LAJACA  CALL    SUEL        ; DIBUJAMOS SUELO
        CALL    MONTE       ; DIBUJAMOS MONTAÑAS
        LD      HL,SCROL    ; SCROLL IM2
        LD      (65022),HL
        CALL    RAINM2
        CALL    JACA        ; PRIMER MOVIMIENTO JACA
        CALL    OUTM2       ; PARAMOS SCROLL IM2
        CALL    CLS
        LD      B,100
BDSDS   HALT
        DJNZ    BDSDS       ; PAUSA
        CALL    SUEL        ; DIBUJAMOS SUELO
        CALL    GRUTA       ; DIBUJAMOS CUEVA
        CALL    MONTE       ; DIBUJAMOS MONTANAS
        CALL    MJAC        ; SEGUNDO MOVIMIENTO JACA
        RET

TEXTON  DEFB 22,22,9,0
        DEFM '              '   ; 14 BLANCOS
        DEFB 22,8,0,16,6,19,1
        DEFM ' UNA ESBELTA FIGURA AVANZA POR'
        DEFB 22,10,5
        DEFM 'LA ARIDEZ DEL DESIERTO.'
        DEFB 255
LETRA   DEFW TEXTON

; DIBUJAMOS CUEVA

GRUTA   LD  IX,TREBOL
        LD  DE,GRUTA1
        CALL IMPRE5
        LD  IX,TREBO2
        LD  DE,GRUTA2
        CALL IMPRE5
        RET
        
TREBOL  DEFB 3,1,8,31,0
TREBO2  DEFB 6,3,10,29,0        

TABU23  DEFB 3,16,5,0,45
TABU24  DEFB 3,16,5,16,45
        
; DIBUJAMOS SUELO

SUE     DEFB 6,2,16
SUE1    DEFB 0,4
SUEL    LD  B,16
        LD  A,0
        LD  (SUE1),A
BUSUE   PUSH BC
        LD  IX,SUE
        LD  DE,SUELO
        CALL IMPRE5
        LD  A,(SUE1)
        INC A
        INC A
        LD  (SUE1),A
        POP BC
        DJNZ    BUSUE
        RET

; DIBUJAMOS MONTANAS        

MONTE   LD  IX,TABU23
        LD  DE,CORDIL
        CALL IMPRE5
        LD  IX,TABU24
        LD  DE,CORDIL
        CALL IMPRE5
        RET

; SCROLL DEL SUELO Y LAS MONTANAS. IM2

SCROL   PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        PUSH    IX
        LD      D,4
BC0     LD      HL,22527
        LD      C,64
BC22    LD      B,32
        AND     A
BC3     RL      (HL)
        DEC     HL
        DJNZ    BC3
        JR      NC,NOCA1
        LD      (VAR),HL
        LD      IX,(VAR)
        SET     0,(IX+32)
NOCA1   DEC     C
        JR      NZ,BC22
        DEC     D
        JR      NZ,BC0
SCR2    LD      HL,18431
        LD      C,64
SCRB1   LD      B,32
        AND     A
SCRB2   RL      (HL)
        DEC     HL
        DJNZ    SCRB2
        JR      NC,NOCA2
        LD      (VAR),HL
        LD      IX,(VAR)
        SET     0,(IX+32)
NOCA2   DEC     C
        JR      NZ,SCRB1
        LD      HL,(LETRA)
        LD      A,(HL)
        CP      255
        JR      Z,TEXTAS
        INC     HL
        LD      (LETRA),HL
        CALL    IMPRECS
RADIO   POP     IX
        POP     AF
        POP     BC
        POP     DE
        POP     HL
        JP      $38
        RET     

TEXTAS  LD      HL,TEXTON
        LD      (LETRA),HL
        JR      RADIO

IMPRECS LD      A,2
        PUSH    HL
        CALL    $1601
        POP     HL
UCRESS  LD      A,(HL)
        CP      255
        RET     Z
        INC     HL
        PUSH    HL
        RST     $10
        POP     HL
        RET
           
TABLE2  DEFB    3,4,13
JAC1    DEFB    0,7

; PRIMER MOVIMIENTO DE LA JACA 

JACA    LD      B,29
        LD      A,0
        LD      (JAC1),A
JAC     PUSH    BC
        LD      IX,TABLE2
        LD      DE,JACA1
        CALL    IMPRE5
        LD      DE,JACA2
        HALT    
        CALL    IMPRE5
        HALT    
        LD      DE,JACA3
        CALL    IMPRE5
        LD      HL,10
        LD      DE,5
        PUSH    IX
        CALL    949
        POP     IX
        HALT    
        LD      DE,JACA4
        CALL    IMPRE5
        LD      HL,10
        LD      DE,5
        PUSH    IX
        CALL    949
        POP     IX
        HALT    
        LD      A,(JAC1)
        INC     A
        LD      (JAC1),A
        POP     BC
        DJNZ    JAC
        RET     

; SEGUNDO MOVIMIENTO DE LA JACA 
        
MJAC    LD      B,25
        LD      A,0
        LD      (JAC1),A
JAC2    PUSH    BC
        LD      IX,TABLE2
        LD      DE,JACA1
        CALL    IMPRE5
        HALT    
        HALT    
        HALT    
        HALT    
        LD      DE,JACA2
        CALL    IMPRE5
        HALT    
        HALT    
        HALT    
        HALT    
        HALT    
        LD      DE,JACA3
        CALL    IMPRE5
        LD      HL,10
        LD      DE,5
        PUSH    IX
        CALL    949
        POP     IX
        HALT    
        HALT    
        HALT    
        HALT    
        HALT    
        LD      DE,JACA4
        CALL    IMPRE5
        LD      HL,10
        LD      DE,5
        PUSH    IX
        CALL    949
        POP     IX
        HALT    
        LD      A,(JAC1)
        INC     A
        LD      (JAC1),A
        HALT    
        HALT    
        HALT    
        POP     BC
        DJNZ    JAC2
        RET  

; CARACTERES JACA, ALTO 3 ANCHO 4. 8 BYTES + COLOR (7 BLANCO)
; PRIMERO SE DIBUJAN LAS COLUMNAS. lA PRIMERA ESTA EN BLANCO PARA SCROLL                
JACA1   DEFB 0,0,0,0,0,0,0,0,7  
		DEFB 0,0,0,0,0,0,0,0,7
		DEFB 0,0,0,0,0,0,0,0,7
		DEFB 0,0,0,0,0,0,1,129,7
        DEFB 129,65,65,64,65,65,33,19,7
        DEFB 15,1,0,0,4,15,28,0,7
        DEFB 112,80,120,112,112,160,192,248,7
        DEFB 196,163,95,239,239,238,230,254,7
		DEFB 252,184,30,33,32,224,0,0,7
        DEFB 0,0,0,0,0,224,240,232,7
        DEFB 252,252,164,160,32,16,0,0,7
        DEFB 0,0,0,24,184,112,32,0,7

JACA2   DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
		DEFB 8,8,16,16,32,16,16,16,7
        DEFB 12,3,0,4,27,24,0,0,7
        DEFB 0,28,20,30,28,28,40,112,7
        DEFB 124,115,104,87,59,123,123,121,7
        DEFB 255,255,110,16,160,64,1,1,7
        DEFB 0,0,0,0,0,0,56,60,7
        DEFB 58,63,255,233,232,196,128,128,7
        DEFB 128,0,128,64,64,128,128,192,7
		
JACA3	DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 64,96,32,32,16,16,16,12,7
        DEFB 3,0,0,1,3,3,0,0,7
        DEFB 28,20,30,28,28,40,112,126,7
        DEFB 113,104,87,59,119,119,115,255,7
		DEFB 255,110,20,212,40,64,48,56,7
        DEFB 0,0,0,0,0,56,60,58,7
        DEFB 63,255,233,236,194,128,128,128,7
        DEFB 0,0,0,0,0,0,0,0,7
        
JACA4   DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
		DEFB 128,192,64,64,32,32,32,25,7
        DEFB 7,0,0,24,30,25,24,0,7
        DEFB 56,40,60,56,56,80,224,248,7
        DEFB 230,209,175,119,239,239,231,255,7
        DEFB 254,220,35,32,32,192,0,0,7
        DEFB 0,0,0,0,0,112,120,116,7
        DEFB 126,254,210,208,144,8,0,0,7
        DEFB 0,0,128,96,16,28,12,0,7

SUELO   DEFB 62,244,12,238,85,170,85,170,68
        DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,162,1,76,98,0,73,0,68
        DEFB 247,231,92,243,85,170,85,170,68
		DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,170,85,170,85,170,85,170,68
        DEFB 85,162,1,76,98,0,73,0,68

CORDIL  DEFB 0,8,8,8,20,20,36,50,40
        DEFB 54,106,126,126,126,126,119,235,104
        DEFB 235,201,166,90,127,127,127,255,104
        DEFB 0,0,0,0,0,8,24,20,40
        DEFB 36,106,90,245,255,255,254,253,104
        DEFB 251,247,247,247,111,159,239,255,104
        DEFB 0,8,20,34,90,254,255,223,40
        DEFB 175,175,175,87,71,23,167,235,104
		DEFB 245,254,255,255,255,255,255,255,104
        DEFB 0,0,8,4,8,4,12,156,40
        DEFB 158,190,189,219,219,231,231,231,104
        DEFB 251,61,206,247,248,255,255,255,104
        DEFB 0,0,0,0,0,1,49,73,40
        DEFB 102,210,45,191,255,255,255,255,104
        DEFB 254,254,53,203,55,207,255,255,104
        DEFB 0,0,0,192,64,160,32,208,40
		DEFB 240,248,120,124,140,116,75,100,104
        DEFB 219,255,255,255,255,255,255,255,104
        DEFB 0,0,0,0,0,0,0,0,40
        DEFB 0,1,1,2,4,10,143,143,104
        DEFB 159,111,151,203,252,255,255,255,104
        DEFB 0,0,0,0,0,0,0,0,40
        DEFB 0,1,137,72,88,92,94,238,104
        DEFB 237,227,227,243,251,119,135,255,104
		DEFB 0,0,32,96,64,32,96,80,40
        DEFB 208,168,212,244,252,252,254,254,104
        DEFB 254,254,254,255,255,255,255,255,104
        DEFB 0,0,0,0,0,0,0,0,40
        DEFB 0,0,0,0,4,6,13,18,104
        DEFB 29,30,63,63,191,199,248,255,104
        DEFB 0,0,0,0,0,0,1,3,40
        DEFB 2,4,4,11,10,15,143,79,104
		DEFB 79,223,223,191,191,191,63,255,104
        DEFB 0,0,0,0,0,0,128,64,40
        DEFB 64,64,160,32,160,224,224,208,104
        DEFB 241,241,211,214,246,253,243,239,104
        DEFB 0,8,8,8,20,20,36,50,40
        DEFB 54,106,126,126,126,126,119,235,104
        DEFB 235,201,166,90,127,127,127,255,104
        DEFB 0,0,0,0,0,8,24,20,40
		DEFB 36,106,90,245,255,255,254,253,104
        DEFB 251,247,247,247,111,159,239,255,104
        DEFB 0,8,20,34,90,254,255,223,40
        DEFB 175,175,175,87,71,23,167,235,104
        DEFB 245,254,255,255,255,255,255,255,104
        DEFB 0,0,8,4,8,4,12,156,40
        DEFB 158,190,189,219,219,231,231,231,104
        DEFB 251,61,206,247,248,255,255,255,104
		
GRUTA1  DEFB 7,11,21,11,23,47,47,95,7
        DEFB 79,87,87,47,39,43,117,169,7
        DEFB 85,169,71,63,191,191,127,255,7
GRUTA2  DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,0,0,0,7
        DEFB 0,0,0,0,0,1,1,1,7
        DEFB 3,7,7,7,7,15,15,31,7
        DEFB 63,63,63,63,63,63,127,126,7
		DEFB 127,126,125,254,253,252,254,253,7
        DEFB 7,7,11,20,47,47,95,95,7
        DEFB 191,191,195,60,55,42,53,42,7
        DEFB 85,106,215,175,215,175,95,63,7
        DEFB 253,251,246,232,212,232,216,176,7
        DEFB 80,176,96,161,96,161,96,161,7
        DEFB 96,161,64,209,96,209,32,64,7
        DEFB 255,255,255,127,159,239,255,255,7
		DEFB 255,255,191,95,191,191,95,191,7
        DEFB 127,255,255,255,255,255,255,255,7
        DEFB 127,151,43,23,43,91,181,91,7
        DEFB 181,91,183,107,183,105,181,73,7
        DEFB 180,105,180,105,149,105,213,168,7




