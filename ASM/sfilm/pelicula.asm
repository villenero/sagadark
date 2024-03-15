
; 3 PARTE. LA PELICULA

PELICULA    CALL    CLS
            
; 1 PANTALLA ABUELO
            
            LD      D,%111000   ; =56 TINTA BLANCO, PAPEL NEGRO
            CALL    PONCOLOR
            
            LD      HL,PPANT1
            CALL    VOLQ        ; PANTALLA EN BLANCO Y NEGRO
                       
            CALL    FUEGO_ON    ; Ponemos en marcha el fuego
            CALL    IMPRE6      ; Imprimimos texto
            
            IM      1           ; Paramos IM2                       
            
; PANTALLA 2 CIUDAD 1     

CIUDAD1     CALL    CLS

            LD      D,0
            CALL    PONCOLOR
                    
            LD      DE,PPANT2 ; 58618 longitud 128*16=2048 bytes 
            LD      HL,16384
            LD      B,128
            CALL    MITAD
            
            LD      HL,16384
            LD      BC,4096
            CALL    BYTE
            
            LD      DE,COLOR2 ; 60666 longitud 16*16=256 bytes
            LD      HL,22528
            LD      B,16
            CALL    MITAD
            
            LD      HL,22528
            LD      BC,512
            CALL    ATTR
                   
            LD      HL,NAVES
            CALL    IMPREC  ;   Imprimimos primera nave

            LD      HL,CHARESP; 32341 set caracteres especial
            DEC     H
            LD      (23606),HL

            LD      HL,NAVES2
            CALL    IMPREC  ; imprimimos segunda nave
            
            CALL    POKSET      ; set caracteres original
  
                    
            LD      HL,IM23     ; ANIMACION NAVE IM2
            LD      (65022),HL
            CALL    RAINM2
            
            CALL    IMPRE6
            
            IM      1   ; Paramos IM2
            
; PANTALLA 3 BOMM

BOOM        CALL    CLS

            LD      D,0
            CALL    PONCOLOR
            
            LD      DE,PPANT3; 57464 long 64x16=1024 bytes
            LD      HL,16384
            LD      B,64
            CALL    MITAD
            
            LD      HL,16384
            LD      BC,2048
            CALL    BYTE
            
            LD      DE,COLOR3; 58488 long 64x8=128 bytes
            LD      HL,16384+2048            
            LD      B,8
            CALL    MITAD
                    
            LD      HL,16384+2048
            LD      BC,256
            CALL    ATTR
            
            LD      DE,PPANT2; 58618 utilizamos pantalla2 como buffer            
            LD      HL,16384            
            LD      BC,2048+256
            LDIR  
            
            LD      HL,16384            
            LD      BC,2048+256
BOOM1       LD      A,255
            LD      (HL),A
            INC     HL
            DEC     BC
            LD      A,B
            OR      C
            JR      NZ,BOOM1
            
            CALL    PEQUE   ; ciudad pequeña
            
            CALL    BOMBA    ; SCROOL ARRIBA
            
            LD      HL,PPANT2; utilizamos pantalla2 como buffer
            CALL    VOLQ1
            
            CALL    IMPRE6                            

; PANTALLA 4 MUERTO

MUERTO      CALL    CLS

            LD      D,0
            CALL    PONCOLOR            
            
            LD      HL,PPANT4; 52855 long 4096+512 bytes
            CALL    VOLQ2
            
            CALL    IMPRE6

; PANTALLA 5 BICHOS

BICHOS      CALL    CLS

            LD      D,0
            CALL    PONCOLOR
        
            LD      HL,PPANT5; 35570 long 4096+512 bytes
            CALL    VOLQ2
            
            CALL    IMPRE6

; PANTALLA 6 POBLADO 1

POBLADO1    CALL    CLS

            LD      D,0
            CALL    PONCOLOR
            
            LD      HL,PPANT6; 41332 long 2048+256 bytes
            CALL    VOLQ1
            
            CALL    IMPRE6

; PANTALLA 7 KAMUIR

KAMUIR      CALL    CLS

            LD      D,0
            CALL    PONCOLOR
            
            LD      HL,PPANT7; 48246 long 4096+512 bytes
            CALL    VOLQ2
            
            CALL    IMPRE6
        
; PANTALLA 8 POBLADO 2

POBLADO2    CALL    CLS

            LD      D,0
            CALL    PONCOLOR
            
            LD      DE,PPANT8; 40179 long 64x16=1024 bytes
            LD      HL,16384
            LD      B,64
            CALL    MITAD
            
            LD      HL,16384
            LD      BC,2048
            CALL    BYTE
            
            LD      DE,COLOR8; 41203 long 8x16=128 bytes
            LD      HL,18432
            LD      B,8
            CALL    MITAD
            
            LD      HL,18432
            LD      BC,256
            CALL    ATTR
            
            LD      DE,22528
            LD      HL,18432
            LD      BC,256
            LDIR 
            
            CALL    IMPRE6

; PANTALLA 9 NOOOOOOOOO

PNOO        CALL    CLS

            LD      D,0
            CALL    PONCOLOR
        
            LD      HL,PPANT9
            CALL    VOLQ2
            CALL    IMPRE6

; PANTALLA 10 ABU2

PABUELO2    CALL    CLS
            
            LD      D,%111000        ; =56 TINTA BLANCO, PAPEL NEGRO
            CALL    PONCOLOR
            
            LD      HL,PPANT1
            CALL    VOLQ
            
            CALL    FUEGO_ON    ; Ponemos en marcha el fuego
            CALL    IMPRE6  ; Imprimimos texto
            
            IM      1       ; Paramos IM2
            CALL    IMPRE3  ; Degradado de color
            
; FIN PELICULA

            RET
            

; FUEGO PANTALLA ABUELO IM2

FUEGO       PUSH    HL
            PUSH    AF
            PUSH    DE
            PUSH    BC
            PUSH    IX
            PUSH    IY
            CALL    FUEGO1
            CALL    FUEGO5
            POP     IY
            POP     IX
            POP     BC
            POP     DE
            POP     AF
            POP     HL
            JP      56

FUEGO_ON    LD      HL,FUEGO
            LD      (65022),HL
            CALL    RAINM2  ; Ponemos en marcha IM2
            RET    

FUEGO1      LD      A,(DATFUE1)
            DEC     A
            LD      (DATFUE1),A
            CP      0
            CALL    Z,FUEGO2
            RET     

FUEGO2      LD      A,5
            LD      (DATFUE1),A
            LD      A,(DATFUE2)
            DEC     A
            LD      (DATFUE2),A
            CP      1
            JP      Z,FUEGO4
            JP      FUEGO3
            RET

DATFUE1     DEFB    1
DATFUE2     DEFB    3

FUEGO3      LD      DE,IMGFUEGO  ; 34217
            LD      IX,DATFUE4
            CALL    IMPRE5
            RET

FUEGO4      LD      A,3
            LD      (DATFUE2),A
            LD      HL,PPANT1
            CALL    VOLQ
            RET    
           
DATFUE4     DEFB    4,5     ; FUEGO 4 ALTO X 5 ANCHO
            DEFB    6,14,0

FUEGO5      LD      A,(22548)
            DEC     A
            CP      55
            CALL    Z,FUEGO6
            LD      (22548),A
            LD      (22549),A
            LD      (22580),A
            LD      (22581),A
            RET     

FUEGO6      LD      A,62
            RET  

; BOMBA ATOMICA - REUTILIZAMOS RUTINA SCROOL PIJAMA :)

BOMBA       LD     A,64    ;    POKE DEL SCROLL PIJAMA
            LD     (ARRIB1+1),A
            LD     A,32    ;    POKE DEL SCROLL PIJAMA
            LD     (BLNPIX+1),A
            LD     A,0     ;    POKE DEL SCROLL PIJAMA
            LD     (ARRIB2+1),A
        
PONBYT      LD      HL,16384+2048-32
            LD      DE,PPANT2
            LD      B,8
BBP22       PUSH    BC
            LD      C,8
BBP20       PUSH    DE
            PUSH    HL
            CALL    BUII
            CALL    UP
            LD      B,32
BBP21       LD      A,(DE)
            LD      (HL),A
            INC     HL
            INC     DE
            DJNZ    BBP21
            POP     HL
            POP     DE
            INC     D
            DEC     C
            JR      NZ,BBP20
            POP     BC
            PUSH    HL
            LD      HL,2048-32
            EX      DE,HL
            SBC     HL,DE
            EX      DE,HL
            POP     HL
            DJNZ    BBP22
            RET     

UP          PUSH    BC
            CALL    ARRIBA
            POP     BC
            RET     

INVER       LD      HL,22528    ;   ATTR ?
            LD      B,8
            LD      A,(COLOR)
            LD      E,A
BUCRE1      LD      C,32
UCRE        LD      A,E
            LD      (HL),A
            INC     HL
            DEC     C
            LD      A,C
            CP      0
            JR      NZ,UCRE
            DJNZ    BUCRE1
            RET     

BUII        PUSH    HL
            PUSH    BC
            PUSH    DE
            LD      A,71
            LD      (COLOR),A
            CALL    INVER
            HALT    
            HALT    
            LD      A,120
            LD      (COLOR),A
            CALL    INVER
            POP     DE
            POP     BC
            POP     HL
            RET     
        
                   
; IMPRESION DE LOS TEXTOS DE LA PELICULA SEGUN NUM PANTALLA

DTPANT      DEFB    0   ;   NUM PANTALLA

IMPRE6      LD      A,(DTPANT)
            CP      10
            JR      Z,CONT9
            LD      HL,DTPANT
            INC     (HL)
            ADD     A,A
            LD      D,0
            LD      E,A
            LD      IX,TABLAP
            ADD     IX,DE
            LD      L,(IX+0)
            LD      H,(IX+1)
            CALL    IMP
            RET
CONT9       LD      A,0
            LD      (DTPANT),A
            RET

IMP         LD      A,(HL)
            LD      B,A
            INC     HL
BUT         PUSH    BC
            CALL    IMPREI
            INC     HL
            LD      BC,0
            CALL    7997    ; 1F3D PAUSE-1 rom
            LD      B,8
            LD      C,33    
            PUSH    HL
            CALL    3652    ; E44 CL-LINE rom borra b abajo lineas 
            POP     HL
            POP     BC
            DJNZ    BUT
            RET
                                    
; VOLCADO DE 2/3 DE PANTALLA SIN ATRIBUTOS
VOLQ        LD      DE,16384
            LD      BC,4096
            LDIR 
            RET

; VOLCADO DE 2/3 DE PANTALLA CON ATRIBUTOS

VOLQ2       LD      DE,16384    ; INICIO PANTALLA
            LD      BC,4096     ; PIXELES IMAGEN
            LDIR
            LD      DE,16384+6144   ; INICIO ATRIBUTOS
            LD      BC,512      ; ATRIBUTOS
            LDIR    
            RET

; VOLCADO DE 1/3 DE PANTALLA

VOLQ1       LD      DE,16384    ; INICIO PANTALLA
            LD      BC,2048     ; PIXELES IMAGEN
            LDIR
            LD      DE,16384+6144   ; INICIO ATRIBUTOS
            LD      BC,256      ; ATRIBUTOS
            LDIR    
            RET                 
            
; VOLCADO DE MEDIA PANTALLA
; DE: ORIGEN
; HL: DESTINO
; B: 128,64,16,8

MITAD       PUSH    BC
            LD      B,16
BUUC2       LD      A,(DE)
            LD      (HL),A
            INC     HL 
            INC     DE
            DJNZ    BUUC2
            PUSH    DE
            LD      DE,16
            ADD     HL,DE
            POP     DE
            POP     BC
            DJNZ    MITAD
            RET


; BC: LONGITUD
; HL: COMIENZO

BYTE        PUSH    BC
            LD      A,(HL)
            LD      B,8
BITT        SRL     A
            RL      C
            DJNZ    BITT
            PUSH    HL
            LD      A,L
            XOR     31
            LD      L,A
            LD      (HL),C
            POP     HL
            INC     HL
            POP     BC
            DEC     BC
            LD      A,B
            OR      C
            JR      NZ,BYTE
            RET
   
   
; HL: COMIENZO
; BC: LONGITUD

ATTR        PUSH    BC
            PUSH    HL
            LD      C,(HL)
            LD      A,L
            XOR     31
            LD      L,A
            LD      (HL),C
            POP     HL
            INC     HL
            POP     BC
            DEC     BC
            LD      A,B
            OR      C
            JR      NZ,ATTR
            RET

; PONE UN COLOR A TODA LA PANTALLA
; 34075
PONCOLOR    LD      HL,22528
            LD      BC,512
COLORBUC1   LD      A,D
            LD      (HL),A
            INC     HL
            DEC     BC
            LD      A,C
            OR      B
            JR      NZ,COLORBUC1
            RET     

; IMPRESION TEXTO

IMPREI      LD      A,2
            PUSH    HL
            CALL    $1601
            LD      A,22
            RST     $10
            LD      A,14
            RST     $10
            LD      A,0
            RST     $10
            POP     HL
            LD      B,3
BUU1        PUSH    BC
            PUSH    HL
            LD      A,13
            RST     $10
            LD      A,13
            RST     $10
            POP     HL
            CALL    IMPREE
            POP     BC
            DJNZ    BUU1
            PUSH    HL
            LD      A,1
            CALL    $1601
            LD      A,22
            RST     $10
            LD      A,0
            RST     $10
            LD      A,0
            RST     $10
            POP     HL
            CALL    IMPREE
            RET     

IMPREE      LD      B,32
BUU2        PUSH    BC
            LD      A,(HL)
            CP      255
            RET     Z
            PUSH    HL
            PUSH    AF
            RST     $10
            POP     AF
            CP      32
            JP      Z,BBP98
            LD      HL,10
            LD      DE,5
            CALL    949
            LD      B,3
BUT4        HALT    
            DJNZ    BUT4
BBP98       POP     HL
            POP     BC
            INC     HL
            DJNZ    BUU2
            RET     
        
; ANIMACION DE LA CIUDAD

SNAVE1  LD      HL,16384+32
        LD      B,8
BBPP1   PUSH    BC
        PUSH    HL
        LD      B,2
BBPP2   PUSH    BC
        LD      B,32
BBPP3   RR      (HL)
        INC     HL
        DJNZ    BBPP3
        AND     A
        POP     BC
        DJNZ    BBPP2
        POP     HL
        INC     H
        POP     BC
        DJNZ    BBPP1
        RET     

SNAVE2  LD      HL,16415+256
        LD      B,7
BBP11   PUSH    BC
        PUSH    HL
        LD      B,32
BBP12   RL      (HL)
        DEC     HL
        DJNZ    BBP12
        AND     A
        POP     HL
        POP     BC
        INC     H
        DJNZ    BBP11
        RET     

COCHE1  LD      HL,18609
        LD      B,4
BBP10   RL      (HL)
        DEC     HL
        DJNZ    BBP10
        RET     

COCHE2  LD      HL,18606
        LD      B,4
BBP23   RR      (HL)
        INC     HL
        DJNZ    BBP23
        RET     

IM23    PUSH    IY
        PUSH    IX
        PUSH    DE
        PUSH    BC
        PUSH    HL
        PUSH    AF
        CALL    SNAVE1
        CALL    SNAVE1
        CALL    SNAVE2
EQU2    CALL    COCHE
        POP     AF
        POP     HL
        POP     BC
        POP     DE
        POP     IX
        POP     IY
        JP      $38
        
COCHE   LD      A,(CCOCHE)
        DEC     A
        CP      0
        JR      Z,RENUM
        LD      (CCOCHE),A
        CALL    COCHE1
        RET     
        
CCOCHE  DEFB    1

RENUM   LD      A,90
        LD      (CCOCHE),A
        LD      A,(CCOCH2)
        DEC     A
        CP      0
        JP      Z,RENOM
        LD      (CCOCH2),A
        LD      A,255
        LD      (18609),A
        RET     

RENOM   LD      A,2
        LD      (CCOCH2),A
        LD      DE,COH2
        LD      HL,EQU2
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        LD      HL,18606
        LD      A,255
        LD      (HL),A
        RET     
        
CCOCH2  DEFB    2
CCOCH3  DEFB    1

COH2    LD      A,(CCOCHE)
        DEC     A
        CP      0
        JR      Z,RENIN
        LD      (CCOCHE),A
        CALL    COCHE2
        RET     

RENIN   LD      A,90
        LD      (CCOCHE),A
        LD      A,(CCOCH3)
        DEC     A
        CP      0
        JR      Z,RENUN
        LD      (CCOCHE),A
        LD      HL,18606
        LD      (HL),A
        RET     

RENUN   LD      A,1
        LD      (CCOCH3),A
        LD      DE,COCHE
        LD      HL,EQU2
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        LD      HL,18609
        LD      A,255
        LD      (HL),A
        RET     
                                                          
; TEXTOS DE LA PELICULA

TABLAP      DEFW    PANT1,PANT2,PANT3,PANT4,PANT5
            DEFW    PANT6,PANT7,PANT8,PANT9,PANT10
            
PANT1       DEFB    2
            DEFM    'HIJO MIO... HAN SIDO LARGOS A&OS'
            DEFM    'DE DURO ENTRENAMIENTO, AHORA    '
            DEFM    'ESCUCHA LA HISTORIA QUE VOY A   '
            DEFM    'NARRARTE, LUEGO, DE TI DEPENDERA'
            DEFB    255
            DEFM    'MI FUTURO... Y EL DE LO QUE     '
            DEFM    'QUEDA DE HUMANIDAD.             '
            DEFB    255

PANT2       DEFB    2
            DEFM    'HACE MUCHOS A&OS EN ESTE MALDITO'
            DEFM    'PLANETA EXISTIO UNA GRAN CULTURA'
            DEFM    'NUESTROS ANTEPASADOS VIVIAN EN  '
            DEFM    'GIGANTESCAS CONSTRUCCIONES QUE  '
            DEFB    255
            DEFM    'LLEGABAN AL CIELO, PERO LA      '
            DEFM    'CODICIA DE ESTOS LES CONDUJO A  '
            DEFM    'SU PROPIA EXTINCION.            '
            DEFB    255

PANT3       DEFB    2
            DEFM    'GIGANTESCOS ARBOLES DE FUEGO,   '
            DEFM    'ACABARON CON LA BRILLANTE       '
            DEFM    'CIVILIZACION,LOS GRANDES ARBOLES'
            DEFM    'TRANSFORMARON EN CENIZAS        '
            DEFB    255
            DEFM    'CONSTRUCCIONES, HOMBRES Y       '
            DEFM    'ANIMALES POR IGUAL.             '
            DEFB    255

PANT4       DEFB    2
            DEFM    'SOLO UNOS POCOS SOBREVIVIERON,  '
            DEFM    'AQUELLOS ELEGIDOS EMPRENDIERON  '
            DEFM    'UNA DIFICIL TAREA E INTENTARON  '
            DEFM    'VOLVER A SER COMO ERAN, PERO... '
            DEFB    255
            DEFM    'JAMAS LO CONSIGUIERON.          '
            DEFM    'LAS EPIDEMIAS SE SUCEDIERON Y   '
            DEFM    'DIEZMARON AUN MAS LA YA AZOTADA '
            DEFM    'CIVILIZACION.                   '
            DEFB    255 

PANT5       DEFB    2
            DEFM    'LOS REMOTOS Y OLVIDADOS TIEMPOS '
            DEFM    'DE BRUJOS, DRAGONES Y HECHICEROS'
            DEFM    'REGRESARON. FUE ENTONCES CUANDO '
            DEFM    'APARECIO EL PRIMER -DARK-       '
            DEFB    255
            DEFM    'ESTE NO TARDO EN RECLUTAR Y     '
            DEFM    'ADIESTRAR FUERTES Y MALEVOLOS   '
            DEFM    'SERES.                          '
            DEFB    255

PANT6       DEFB    2
            DEFM    'EL Y SU TROPA SAQUEARON, MATARON'
            DEFM    'Y VIOLARON A LOS INDEFENSOS     '
            DEFM    'HABITANTES DE LOS POBLADOS POR  '
            DEFM    'DONDE PASABAN.                  '
            DEFB    255
            DEFM    'PRIMERO FUERON LAS ALDEAS DE LA '
            DEFM    'COSTA Y DESPUES LAS DEL INTERIOR'
            DEFM    'TODOS ERAN SOMETIDOS BAJO SU    '
            DEFM    'CRUEL Y SANGRIENTA MIRADA.      '
            DEFB    255

PANT7       DEFB    3
            DEFM    'KAMUIR, EL SEGUNDO -DARK-, NO SE'
            DEFM    'HIZO ESPERAR, TRAS LA MUERTE DE '
            DEFM    'SU PADRE SAQUEO NUESTRO POBLADO '
            DEFM    'Y SEGO LA VIDA DE MI FAMILIA.   '
            DEFB    255
            DEFM    'CON FRIA SONRISA LENTAMENTE BAJO'
            DEFM    'SU CABEZA Y ME MIRO, YO PORTABA '
            DEFM    'EN MIS BRAZOS EL LIBRO MISTICO. '
            DEFM    'EL CONTENIDO DE ESE LIBRO LO ERA'
            DEFB    255
            DEFM    'TODO PARA MI. ERA MI PROTECTOR  '
            DEFM    'CONTRA LAS FUERZAS OCULTAS DE   '
            DEFM    'LAS TINIEBLAS. PUDE ESCAPAR DE  '
            DEFM    'AQUEL INFIERNO.                 '
            DEFB    255

PANT8       DEFB    2
            DEFM    'ESTUVE AL BORDE DE LA MUERTE EN '
            DEFM    'VARIAS OCASIONES, PERO PUDE     '
            DEFM    'ALCANZAR UN FOCO DE CIVILIZACION'
            DEFM    'ALEJADO DE LA DESOLACION.       '
            DEFB    255
            DEFM    'PASARON LOS A&OS Y CUANDO TODO  '
            DEFM    'ERA RECORDADO COMO UNA LEJANA   '
            DEFM    'PESADILLA, KAMUIR REGRESO CON   '
            DEFM    'SU ODIO HACIA TODO LO VIVO.     '
            DEFB    255

PANT9       DEFB    1
            DEFM    'POR SEGUNDA VEZ DESTRUYO TODO   '
            DEFM    'AQUELLO POR LO QUE YO HABIA     '
            DEFM    'LUCHADO, MI FAMILIA Y MI LIBRO  '
            DEFM    'DEL CUAL SE APODERO.            '
            DEFB    255

PANT10      DEFB    1
            DEFM    'FUE SOBRE LA TUMBA DE TU MADRE  '
            DEFM    'DONDE YO JURE VENGANZA, Y AHORA '
            DEFM    'TU SERAS EL ENCARGADO DE        '
            DEFM    'LLEVARLA A CABO.                '
            DEFB    255
            
; IMPRESION NAVES CIUDAD 1

NAVES       DEFB    $16,$03,$00,$10,$00,$11,$00,$53,$54,$45,$56,$45
            DEFB    255 

NAVES2      DEFB    $16,$01,$00,$10,$07,$11,$00,$13,$00,$20,$22,$24,$26,$28 
            DEFB    $16,$02,$00,$21,$23,$25,$27,$29,$16,$00,$1D,$2A,$2B,$2C 
            DEFB    255

; IMPRIMIMOS CIUDAD PEQUEÑA 32160

PEQUE       LD      DE,CIUPE    ; 32445 long 3x16x9=432
            LD      IX,TABLI    ; 32181
            CALL    IMPRE5
            LD      DE,CIUPE    ; 32445
            LD      IX,TABLO    ; 32186
            CALL    IMPRE5
            RET

TABLI       DEFB    $03,$10,$08,$00,$00 ;8,0,3,16,0
TABLO       DEFB    $03,$10,$08,$10,$00 ;8,16,3,16,0


CIUPE       DEFB 255,128,255,164,237,164,255,164,56
    		DEFB 164,237,164,255,164,164,237,164,56
    		DEFB 255,164,164,237,164,255,164,173,56
    		DEFB 255,63,190,189,188,187,184,184,56
    		DEFB 184,191,188,190,190,190,190,178,56
    		DEFB 174,146,162,162,162,162,162,190,56
    		DEFB 255,251,123,59,187,81,17,21,56
    		DEFB 49,241,53,117,117,113,249,199,56
    		DEFB 107,213,218,84,202,68,194,124,56
    		DEFB 255,191,191,191,191,95,28,24,56
    		DEFB 88,24,24,24,80,16,16,16,56
    		DEFB 16,33,163,161,160,160,192,192,56
    		DEFB 255,255,255,255,255,255,3,85,56
    		DEFB 41,5,1,244,98,100,2,4,56
    		DEFB 146,152,157,8,1,0,1,0,56
    		DEFB 128,149,139,134,133,139,138,138,56
    		DEFB 138,138,139,133,134,135,133,134,56
    		DEFB 141,90,85,88,83,90,178,170,56
    		DEFB 63,63,190,3,245,10,68,130,56
    		DEFB 4,2,4,249,3,175,70,163,56
    		DEFB 49,184,60,2,255,171,171,171,56
    		DEFB 255,255,31,48,239,216,210,212,56
    		DEFB 208,208,208,239,240,61,24,49,56
    		DEFB 227,5,9,31,48,55,53,53,56
    		DEFB 255,248,248,56,89,168,72,41,56
    		DEFB 72,40,73,152,56,233,136,248,56
	      	DEFB 1,120,72,89,104,72,73,72,56
    		DEFB 255,62,49,46,49,58,61,58,56
    		DEFB 49,46,49,58,61,58,49,46,56
    		DEFB 49,58,61,58,49,46,49,58,56
    		DEFB 255,0,255,16,255,0,85,0,56
	       	DEFB 255,16,255,0,85,0,255,8,56
            DEFB 255,0,85,0,255,4,255,0,56
		    DEFB 240,247,21,239,21,181,119,181,56
    		DEFB 21,239,21,181,119,181,21,239,56
    		DEFB 21,181,119,181,21,239,21,181,56
    		DEFB 15,239,79,239,79,76,237,77,56
    		DEFB 76,237,65,84,253,85,84,253,56
    		DEFB 85,84,253,80,83,250,82,83,56
    		DEFB 248,250,250,248,250,0,42,43,56
    		DEFB 3,34,35,3,42,43,3,34,56
    		DEFB 35,2,43,0,255,73,73,255,56
    		DEFB 3,171,171,3,171,3,171,0,56
    		DEFB 122,125,106,112,103,84,36,87,56
    		DEFB 36,84,39,4,252,39,36,255,56
    		DEFB 254,254,254,254,0,84,106,84,56
    		DEFB 106,84,122,4,242,148,146,244,56
    		DEFB 146,148,242,148,146,244,146,244,56
		

IMGFUEGO    DEFB    0,0,0,0,4,0,0,0,56
            DEFB    1,1,1,3,67,3,3,19,56
            DEFB    3,17,9,9,9,12,20,23,56
            DEFB    19,59,61,127,63,63,31,31,56
            DEFB    0,0,16,16,16,48,96,192,56
            DEFB    192,192,224,224,240,248,252,252,56
            DEFB    254,255,255,255,255,255,255,251,56
            DEFB    249,253,252,252,248,248,240,255,56
            DEFB    0,0,1,1,1,1,1,35,56
            DEFB    3,3,3,3,3,7,15,143,56
            DEFB    255,254,252,252,249,249,249,253,56
            DEFB    252,252,253,123,127,63,63,255,56
            DEFB    64,128,128,128,132,128,132,128,56
            DEFB    128,193,193,193,193,193,193,224,56
            DEFB    224,241,243,231,247,255,255,255,56
            DEFB    255,254,253,254,255,255,255,245,56
            DEFB    0,0,32,32,32,112,112,240,56
            DEFB    224,224,224,224,224,192,224,224,56
            DEFB    224,240,240,240,248,248,248,252,56
            DEFB    252,252,252,252,248,240,224,127,56
            

          
            