
; RUTINA PIJAMA

PIJAMA  LD      HL,KARLOS
        CALL    JEJE        ; FOTO CARLOS
        LD      HL,ESTEVE
        CALL    JEJE        ; FOTO ESTEVE
        CALL    AMPLI_C     ; C AMPLIADA
        LD      HL,T1       ; CARLOF ...
        CALL    IMPRE4
        LD      HL,TONII    ; FOTO TONI
        CALL    JEJE
        LD      HL,CERO     ; LIMPIAMOS TEXTO
        CALL    IMPREC
        CALL    AMPLI_S     ; S AMPLIADA
        LD      HL,T2       ; STEVE ...
        CALL    IMPRE4
        LD      HL,TRIBIA   ; FOTO TRIBALDO
        CALL    JEJE
        LD      HL,CERO     ; LIMPIAMOS TEXTO
        CALL    IMPREC
        CALL    AMPLI_S     ; S AMPLIADA
        LD      HL,T3       ; SUPER ...
        CALL    IMPRE4
        LD      HL,JAVIER   ; FOTO JAVI => MENOR
        CALL    JEJE
        LD      HL,CERO     ; LIMPIAMOS TEXTO
        CALL    IMPREC
        CALL    AMPLI_I     ; I AMPLIADA
        LD      HL,T4       ; IGOR ...
        CALL    IMPRE4
        LD      B,48
JUJU    PUSH    BC
        CALL    ARRIBA
        POP     BC
        DJNZ    JUJU
        LD      HL,CERO     ; LIMPIAMOS TEXTO
        CALL    IMPREC
        CALL    AMPLI_J     ; E AMPLIADA
        LD      HL,T5       ; TOCA ...
        CALL    IMPRE4
        LD      B,48
JJJJ    PUSH    BC
        CALL    ARRIBA
        POP     BC
        DJNZ    JJJJ
        LD      HL,CERO
        CALL    IMPREC
        LD      B,70
JOJO    PUSH    BC
        CALL    ARRIBA
        POP     BC
        DJNZ    JOJO
        RET     

JEJE    LD      B,3
CARACO  PUSH    BC
        LD      IX,SAGA
        LD      B,4
ETIQUE  PUSH    BC
        LD      C,8
BC1     LD      A,(HL)
        LD      B,8
BC2     RRA     
        RR      D
        RR      E
        SRA     D
        RR      E
        DJNZ    BC2
        LD      (IX+0),D
        LD      (IX+16),E
        LD      (IX+17),E
        LD      (IX+1),D
        INC     HL
        INC     IX
        INC     IX
        DEC     C
        JR      NZ,BC1
        PUSH    BC
        LD      B,16
SEDEE   INC     IX
        DJNZ    SEDEE
        POP     BC
        POP     BC
        DJNZ    ETIQUE
        PUSH    HL
        CALL    TABLE
        PUSH    BC
        LD      B,16
BERE    CALL    ARRIBA
        DJNZ    BERE
        POP     BC
        POP     HL
        POP     BC
        DJNZ    CARACO
        LD      B,2
CARADE  PUSH    BC
        CALL    ARRIBA
        POP     BC
        DJNZ    CARADE
        RET     

TABLE   LD      HL,TABLA
        CALL    IMPREC
        RET     


; 32191
ARRIBA  PUSH    BC
        PUSH    DE
        LD      HL,16384
        LD      DE,16640
ARRIB1  LD      C,192       ; EN LA BOMBA SE POKEA EL VALOR
BLNPIX  LD      B,10        ; EN LA BOMBA SE POKEA EL VALOR
BCOLUM  LD      A,(DE)
        LD      (HL),A
        LD      A,C
        CP      2
        JR      NZ,PROXBY
        XOR     A
        LD      (DE),A
PROXBY  INC     DE
        INC     HL
        DJNZ    BCOLUM
        PUSH    DE
        LD      DE,224
        LD      A,E
ARRIB2  ADD     A,22    ; 224+22 PIJAMA, SOLO 224 EN LA BOMBA
        LD      E,A
        ADD     HL,DE
        EX      (SP),HL
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        DEC     C
        LD      A,C
        AND     7
        JR      Z,SCARDE
        CP      1
        JR      Z,SCAROR
        JR      BLNPIX
        
SCARDE  PUSH    DE
        LD      DE,2048-32
        SBC     HL,DE
        POP     DE
        LD      A,C
        AND     63
        JR      NZ,BLNPIX
STERDE  LD      A,7
        ADD     A,H
        LD      H,A
        JR      BLNPIX
        
SCAROR  PUSH    HL
        EX      DE,HL
        LD      DE,2048-32
        SBC     HL,DE
        EX      DE,HL
        POP     HL
        LD      A,C
        AND     63
        CP      1
        JR      NZ,BLNPIX
STEROR  LD      A,7
        ADD     A,D
        LD      D,A
        LD      A,C
        CP      1
        JR      NZ,BLNPIX
        POP     DE
        POP     BC
        RET     

AMPLI_C CALL    CHARS2
        LD      HL,CCDAT
        CALL    IMPREX2
        CALL    CHARS1
        RET     

AMPLI_S CALL    CHARS2
        LD      HL,CSDAT
        CALL    IMPREX2
        CALL    CHARS1
        RET     

AMPLI_I CALL    CHARS2
        LD      HL,CIDAT
        CALL    IMPREX2
        CALL    CHARS1
        RET     

AMPLI_J CALL    CHARS2
        LD      HL,CJDAT
        CALL    IMPREX2
        CALL    CHARS1
        RET     

; OJO. LOS CARACTERES ESTAN EN LA FUENTE NORMAL 
AMPLI_E LD      HL,CEDAT
        CALL    IMPREX2
        RET 
        
;26791
AMPLI_Y CALL    CHARS2
        LD      HL,CYDAT
        CALL    IMPREX2
        CALL    CHARS1
        RET     

;24770
; ACTIVAMOS SET DE CARACTERES AMPLIADO
CHARS2  LD      HL,CHARX2
        DEC     H
        LD      (23606),HL
        RET   

;24762
; DESACTIVAMOS SET DE CARACTERES AMPLIADO
CHARS1  LD      HL,CHARSET
        DEC     H
        LD      (23606),HL
        RET          

;24861
; IMPRIMIMOS CARACTERES AMPLIADOS
IMPREX2 LD      A,2
        PUSH    HL
        CALL    5633
        POP     HL
BIMPRE  LD      A,(HL)
        CP      255
        RET     Z
        RST     16
        INC     HL
        JR      BIMPRE
        LD      A,0
        LD      (23697),A
        PUSH    BC
        CALL    8927
        POP     BC
        INC     B
        LD      A,12
        LD      (23697),A
        PUSH    BC
        CALL    8927
        POP     BC
        DEC     B
        DEC     B
        LD      A,B
        CP      8
        JR      Z,BIMPRE2
        RET     
BIMPRE2 INC     B
        LD      A,12
        LD      (23697),A
        CALL    8927
        LD      B,133
        RET     

CERO    DEFB    22,9,10 ; POS Y,X
        DEFM    '      '
        DEFB    22,10,10 ; POS Y,X
        DEFM    '                      '
        DEFB    22,12,10 ; POS Y,X
        DEFM    '                      '
        DEFB    255

T1      DEFB    22,10,14 ; POS Y,X
        DEFB    16,6 ; COLOR (6:AMA)
        DEFM    'ARLOF PEREZTROIKO:'
        DEFB    22,12,17 ; POS Y,X
        DEFB    16,7 ; COLOR (7:BLA)
        DEFM    'TOCATECLAS'
        DEFB    255

T2      DEFB    22,10,14 ; POS Y,X
        DEFB    16,6 ; COLOR (6:AMA)
        DEFM    'TEVE  WONDER:'
        DEFB    22,12,15 ; POS Y,X
        DEFB    16,7 ; COLOR (7:BLA)
        DEFM    'TOCATECLAS'
        DEFB    255

T3      DEFB    22,10,14 ; POS Y,X
        DEFB    16,6 ; COLOR (6:AMA)
        DEFM    'UPER AJO DALTONIUS'
        DEFB    22,12,17 ; POS Y,X
        DEFB    16,7 ; COLOR (7:BLA)
        DEFM    'GARABATOS.'
        DEFB    255
        
T4      DEFB    22,10,14 ; POS Y,X
        DEFB    16,6 ; COLOR (6:AMA)
        DEFM    'GOR TRIVALDO:'
        DEFB    22,12,11 ; POS Y,X
        DEFB    16,7 ; COLOR (7:BLA)
        DEFM    'MAPEADOR DE CAMINOS'
        DEFB    255

T5      DEFB    22,10,15 ; POS Y,X
        DEFB    16,6 ; COLOR (6:AMA)
        DEFB    'OSELITO MENOR:'
        DEFB    22,12,13 ; POS Y,X
        DEFB    16,7 ; COLOR (7:BLA)
        DEFM    'TOCAPELOTOSQUIS'
        DEFB    255  

; K AMPLIADA
CCDAT   DEFB    $16,$09,$0C,$11,$01,$13,$01,$10,$05
        DEFB    $24,$26,$13,$00,$16,$0A,$0C,$25,$27
        DEFB    255

; S AMPLIADA
CSDAT   DEFB    $16,$09,$0C,$11,$01,$13,$01,$10,$05
        DEFB    $28,$2A,$13,$00,$16,$0A,$0C,$29,$2B
        DEFB    255      

; I AMPLIADA
CIDAT   DEFB    $16,$09,$0C,$11,$01,$13,$01,$10,$05
        DEFB    $2C,$2E,$13,$00,$16,$0A,$0C,$2D,$2F
        DEFB    255   

; J AMPLIADA
CJDAT   DEFB    $16,$09,$0D,$11,$01,$13,$01,$10,$05
        DEFB    $30,$32,$13,$00,$16,$0A,$0D,$31,$33
        DEFB    255

; Y AMPLIADA
CYDAT   DEFB    $16,$0A,$03,$11,$01,$13,$01,$10,$05
        DEFB    $20,$22,$13,$00,$16,$0B,$03,$21,$23
        DEFB    255
        
; E AMPLIADA
CEDAT   DEFB    $11,$01,$10,$05,$13,$00,$16,$09,$04
        DEFB    $7A,$7C,$13,$01,$16,$0A,$04,$7B,$7D
        DEFB    255
 
START   DEFB    255

TABLA   DEFB    22
        DEFB    20,0,16,0,17,0,93
		DEFB    95,97,99,101,103,105,107,93
		DEFB    95,22,21,0,94,96,98,100
        DEFB    102,104,106,108,94,96,255
        
TONII   DEFB    255,231,195,129,129,195,231,255
        DEFB    0,3,6,13,26,21,11,22,207
		DEFB    181,250,53,254,243,221,63,128
		DEFB    64,160,80,168,88,172,180,255
		DEFB    231,195,129,129,195,231,255,29
		DEFB    15,7,7,3,3,1,1,151
		DEFB    79,179,127,111,119,143,252,84
		DEFB    240,250,244,212,108,191,181,255
		DEFB    231,195,129,129,195,231,255,0
		DEFB    0,0,0,0,0,0,0,243
		DEFB    239,31,125,63,15,23,111,254
		DEFB    253,250,245,250,245,234,213

KARLOS  DEFB    255,231,195,129,129,195,231,255
        DEFB    0,1,6,13,10,13,10,6,63
		DEFB    213,170,85,254,255,143,87,128
		DEFB    112,168,84,170,86,235,245,255
		DEFB    231,195,129,129,195,231,255,3
		DEFB    7,7,15,15,31,13,3,111
		DEFB    159,255,243,239,251,251,247,235
		DEFB    173,139,181,155,182,234,244,255
		DEFB    231,195,129,129,195,231,255,0
		DEFB    3,3,1,1,0,0,0,15
		DEFB    255,255,255,255,255,47,31,236
		DEFB    216,208,232,248,252,255,255
		
ESTEVE  DEFB    255,231,195,129,129,195,231,255
        DEFB    0,0,0,0,0,0,0,0,0
		DEFB    0,0,10,53,106,149,106,0
		DEFB    0,0,0,128,192,160,80,255
		DEFB    231,195,129,129,195,231,255,2
		DEFB    5,5,2,7,7,7,3,120
		DEFB    135,53,88,183,207,255,255,240
		DEFB    112,88,216,248,240,224,192,255
		DEFB    231,195,129,129,195,231,255,0
		DEFB    7,13,26,53,47,53,42,252
		DEFB    1,130,125,131,255,255,255,160
		DEFB    120,236,246,235,245,234,213

JAVIER  DEFB    255,231,195,129,129,195,231,255
        DEFB    0,0,0,1,2,5,7,15,0
		DEFB    30,255,121,135,252,27,252,0
		DEFB    0,128,224,224,112,176,56,255
		DEFB    231,195,129,129,195,231,255,7
		DEFB    8,14,14,15,7,3,3,19
		DEFB    235,221,220,29,227,255,255,204
		DEFB    188,188,120,240,240,224,224,255
		DEFB    231,195,129,129,195,231,255,3
		DEFB    1,1,7,13,58,117,106,192
		DEFB    255,255,255,126,170,85,170,240
		DEFB    200,214,171,85,170,85,170

TRIBIA  DEFB    255,231,195,129,129,195,231,255
        DEFB    16,24,24,22,9,6,5,5,0
		DEFB    0,0,96,18,109,146,4,8
		DEFB    24,24,24,40,208,80,160,255
		DEFB    231,195,129,129,195,231,255,0
		DEFB    3,4,5,3,3,3,7,190
		DEFB    206,167,183,207,255,223,239,192
		DEFB    160,112,240,240,160,192,192,255
		DEFB    231,195,129,129,195,231,255,3
		DEFB    2,2,3,48,85,169,209,31
		DEFB    255,255,0,254,157,250,250,128
		DEFB    128,128,28,234,5,42,85


                              