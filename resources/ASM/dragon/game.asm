;******************************************************************
;*** TRITON SOFTWARE **** SAGA DARK, FASE DRAGON ******************
;******************************************************************        
        
        INCLUDE PAN-INTRO.ASM
;        INCLUDE 43355.ASM
        INCLUDE GFX-LUNA.ASM
        INCLUDE GFX-PERSONAJE.ASM
        INCLUDE GFX-PUENTE.ASM

        ORG 	40000
        JP      INICIO
        
ENDED:  LD      A,(OK)
        CP      0
        JP      Z,INICIO
        LD      HL,FRASE
        CALL    ESCRIB
        LD      IX,45000
        LD      DE,6192 + 200
        LD      A,255
        SCF 
        CALL    1366   ; RUTINA CARGA ROM AL DESCOMPILAR PONIA l0556
        LD      HL,45000
        LD      DE,16384
        LD      BC,6912
        LDIR    
        JP      45000 + 6912
        
        
FRASE:  DEFB    22,7,11,19,0,18,1,16,2,17,7
        DEFM    "PULSA PLAY"
        DEFB    255
        
MOVI:   CALL    TECLAS
        CALL    TECLA2
MOVE:   LD      A,(VELO)
        LD      C,A
        LD      A,(HOH)
        CP      1
        CALL    Z,TDO
        LD      A,C
        LD      B,0
        LD      HL,FILA
        LD      DE,22545
        CP      0
        JR      Z,VEL1
        LDIR    
VEL1:   LD      B,A
        LD      A,15
        SUB     B
        CP      0
        RET     Z

        LD      C,A
        LD      B,0
        LD      HL,CER
        LDIR    
        RET     

TDO:    LD      C,15
        RET

VELO:   DEFB    0
FILA:   DEFB    %01100000
        DEFB    %01100000
        DEFB    %01100000
        DEFB    %01100000
        DEFB    %01100000
        DEFB    %01100000
        DEFB    %01101000
        DEFB    %01101000
        DEFB    %01101000
        DEFB    %01101000
        DEFB    %01101000
        DEFB    %01110000
        DEFB    %01110000
        DEFB    %01110000
        DEFB    %01110000
CER     DEFB    7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7

TECLA2: LD      A,(BAS)
        CP      0
        JR      Z,UNA
        LD      A,(TEIZ)
        CALL    COMPR
        JP      NZ,MENUS
        LD      A,(TEDE)
        CALL    COMPR
        JP      Z,MENUS
        LD      A,0
        LD      (BAS),A
        JP      MIS
UNA:    LD      A,(TEIZ)
        CALL    COMPR
        JP      Z,MENUS
        LD      A,1
        LD      (BAS),A
        JP      MIS
MIS:    LD      A,(VELO)
        CP      15
        RET     Z

        INC     A
        LD      (VELO),A
        RET     

BAS:    DEFB 0
     
MENUS:  LD      A,(PAES)
        DEC     A
        CP      0
        JP      Z,MENES
        LD      (PAES),A
        RET     

MENES:  LD      A,1
        LD      (PAES),A
        LD      A,(VELO)
        CP      0
        RET     Z
        DEC     A
        LD      (VELO),A
        RET     
        
PAES    DEFB    3

TECLAS: LD      A,(BIS)
        CP      0
        JR      Z,UNO
CERO:   LD      A,(TEDE)
        CALL    COMPR
        JP      NZ,MENOS
        LD      A,0
        LD      (BIS),A
        JP      MAS
UNO:    LD      A,(TEDE)
        CALL    COMPR
        JP      Z,MENOS
        LD      A,1
        LD      (BIS),A
        JP      MAS       ; SALTO A LA SIGUIENTE LINEA ???
MAS:    LD      A,(VELO)
        CP      15
        RET     Z

        INC     A
        LD      (VELO),A
        RET     

MENOS:  LD      A,(PAUS)
        DEC     A
        CP      0
        JR      Z,MENAS
        LD      (PAUS),A
        RET     

MENAS:  LD      A,2
        LD      (PAUS),A
        LD      A,(VELO)
        CP      0
        RET     Z

        DEC     A
        LD      (VELO),A
        RET     

PAUS:   DEFB    2
BIS:    DEFB    0
TEDE:   DEFB    13
TEIZ:   DEFB    14
T_SAL   DEFB    15        
        
COMPR:  LD      DE,TABLA
        LD      L,A
        LD      H,0
        ADD     HL,HL
        ADD     HL,DE
        LD      A,(HL)
        INC     HL
        IN      A,(254)
        AND     (HL)
        RET     

TABLA:  DEFB    247,1,247,2,247,4,247,8,247,16
        DEFB    239,16,239,8,239,4,239,2,239,1
        DEFB    251,1,251,2,251,4,251,8,251,16
        DEFB    223,16,223,8,223,4,223,2,223,1
        DEFB    253,1,253,2,253,4,253,8,253,16
        DEFB    191,16,191,8,191,4,191,2,191,1
        DEFB    254,1,254,2,254,4,254,8,254,16
        DEFB    127,16,127,8,127,4,127,2,127,1
        
SCROLL: LD      A,(VELO)
        CP      0
        RET     Z

        LD      HL,51709
        LD      DE,51965
        LD      C,64
S_BU1:  LD      A,0
        LD      B,4
        EX      DE,HL
S_BU2:  RLD     
        DEC     HL
        DJNZ    S_BU2
        EX      DE,HL
        LD      B,32
S_BU3:  RLD     
        DEC     HL
        DJNZ    S_BU3
        DEC     C
        JR      NZ,S_BU1
        LD      A,(DATO)
        DEC     A
        LD      (DATO),A
        CALL    VOLCA1
        RET     

DATO    DEFB    16
DATO1   DEFB    2,1

VOLCA1  LD      HL,49662
        LD      DE,20480
        EXX     
        LD      B,64
        HALT   
        
VO_B1:  EXX     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        EXX     
        DJNZ    VO_B1
        EXX     
        RET     

VEPO:   LD      A,(DATO1)
        JP      CONT
IMPRE:  LD      A,(DATO)
        CP      8
        JP      Z,VEPO
        CP      0
        RET     NZ

        LD      A,16
        LD      (DATO),A
        LD      A,(DATO1 + 1)
CONT:   ADD     A,A
        LD      IX,GRAF - 2
        LD      B,0
        LD      C,A
        ADD     IX,BC
        LD      L,(IX)
        LD      H,(IX + 1)
        LD      DE,256
        ADD     HL,DE
        LD      DE,51966
        LD      B,64
BEVOL1: PUSH    BC
        LDD     
        LDD     
        LDD     
        LDD     
        POP     BC
        DJNZ    BEVOL1
        RET     

; GRAFICOS DEL PUENTE
; 
GRAF:   DEFW    GR_PUE1 ; 51966 GRAFICO PUENTE 1
        DEFW    GR_PUE1 + 256 ; 52222 GRAFICO PUENTE 2
        DEFW    GR_PUE1 + 512 ; 52478 PUENTE ROTO IZQUIERDA
        DEFW    GR_PUE1 + 768 ; 52734 PUENTE ROTO DERECHA
        DEFW    49117 ; FINAL DEL PUENTE DERECHA

; IMPRIME CARACTERES EN PANTALLA CON SONIDO        
ESCRIB: PUSH    HL
        LD      A,2
        CALL    $1601 ; SELECT PRINT CHANEL ROM -- PONIA l1601
        POP     HL
B_ESC:  LD      A,(HL)
        CP      255
        RET     Z

        RST     $10
        INC     HL
        PUSH    HL
        LD      HL,10 ; DURACION DEL SONIDO
        LD      DE,50 ; TONO DEL SONIDO
        CALL    949 ; RUTINA SONNIDO ROM
        POP     HL
        HALT    
        JR      B_ESC

; PONE ATRIBUTOS DE COLOR EN EL PUENTE Y AGUA       
PCOLOR: LD      HL,23040
        LD      B,64 + 128 ;ATRIBUTOS DEL PUENTE
        LD      A,%00000011 ; COLOR MAGENTA
P1:     LD      (HL),A
        INC     HL
        DJNZ    P1
        LD      B,64 ; AHORA EL AGUA
        LD      A,%00000101 ; COLOR CIAN
P3:     LD      (HL),A
        INC     HL
        DJNZ    P3
        RET     

        ; LIMPIA LA FRASE "CORREO O MUERE!" CON ESPACIOS
TEXT2   DEFB    22
        DEFB    7,9 ; POSICIÓN Y,X DEL TEXTO
        DEFB    32,32,32,32,32,32,32,32,32,32,32,32,32,32
        DEFB    255 ; FIN DE FRASE
        ; FRASE "CORRE O MUERE!"
TEXT1   DEFB    22
        DEFB    7, 9 ; POSICIÓN Y,X DEL TEXTO
        DEFB    16,5,19,1
        DEFB    33,34,35,35,36,32,34,32,37,38,36,35,36,39
        DEFB    255 ; FIN DE FRASE
        
; JUEGO DE CARACTERES "CORRE O MUERE!"        
FONT2   DEFB    0,0,0,0,0,0,0,0 ; ESPACIO
        DEFB    62,125,240,192,192,192,225,126 ; "C"
        DEFB    0,0,60,114,98,98,114,60 ;   "o"
        DEFB    0,0,92,114,96,96,64,64 ;    "r"
        DEFB    0,0,60,98,124,64,96,60 ;    "e"
        DEFB    66,98,118,126,90,66,66,66 ; "m"
        DEFB    0,0,64,98,98,98,114,60 ;    "u"
        DEFB    8,28,24,56,48,0,96,96 ;     "!"      

        
CAMBIO: LD      A,(DATO)
        CP      0
        RET     NZ

        LD      HL,(MAPA)
        LD      A,(HL)
        INC     HL
        LD      (MAPA),HL
        CP      0
        JP      Z,B_CAM
        CP      2
        JP      Z,B_CAM2
        LD      A,2
        LD      (DATO1),A
        LD      A,1
        LD      (DATO1 + 1),A
        RET     

B_CAM2: LD      A,4
        LD      (DATO1),A
        LD      A,3
        LD      (DATO1 + 1),A
        RET     

B_CAM:  LD      A,2
        LD      (OK),A
        DEC     HL
        LD      (MAPA),HL
        RET     

INICIO: LD      HL,33088 ; VOLCADO DE LA PANTALLA DE INTRO
        LD      DE,16384
        LD      BC,6912
        LDIR 
INICI2: LD      A,29
        CALL    COMPR
        JR      NZ,INICI2
        CALL    3435 ; BORRADO DE LA PANTALLA -- DESCOMPILADO l0d6b
        CALL    SELO ; IMPRIME ZONA DE SUELO SIN PUENTES
        CALL    LUNA ; IMPRIME LA LUNA CON NUBES
        LD      A,0
        LD      (FALTA),A
        LD      (OK),A
        LD      (HOH),A
        LD      (FIN),A
        LD      (D_REL),A
        LD      (SALGO),A
        LD      A,5
        LD      (VELO),A
        LD      HL,FONT2 ; POSICION BITMAP DE LAS LETRAS
        DEC     H
        LD      (23606),HL
        LD      HL,TEXT1
        CALL    ESCRIB
        LD      H,60
        LD      L,0
        LD      (23606),HL
        CALL    PCOLOR
        LD      A,2
        LD      (DATO1),A
        LD      A,1
        LD      (DATO1 + 1),A
        LD      A,0
        LD      (DATO),A
        CALL    IMPRE
        LD      B,64
TEB1:   PUSH    BC
        CALL    SCROLL
        CALL    IMPRE
        POP     BC
        DJNZ    TEB1
        LD      HL,TEXT2 ; CARACTERES EB BLANCO PARA BORRAR TEXTO
        CALL    ESCRIB   ; BORRA FRASE DE "CORREO O MUERE!"
        LD      A,0
        LD      (VELO),A
        CALL    IMPRE
PRO2:   LD      HL,MAPO
        LD      (MAPA),HL
TEB2:   CALL    SCROLL
        CALL    ABRIRS
        CALL    FUEGOS
        CALL    VOLTA
        CALL    ANDA
        CALL    SALTOS
        CALL    SALTMO
        CALL    IMPRES
        CALL    CAMBIO
        CALL    IMPRE
        CALL    MOVI
        CALL    RELOJ
        CALL    VDRA
        CALL    VER
        CALL    ESPERA
        CALL    OKS
        LD      A,(FIN)
        CP      1
        JP      Z,ENDED
        JR      TEB2
        
        ; REVISAR ESTAS TABLAS
SALGO:  DEFB    0     
MAPA:   DEFW    0
MAPO:   DEFB    1,1,1,2,1,1,1,1,1,1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,1     
        DEFB    2,1,1,1,1,1,2,1,1,1,2,1,1,1,1,1,1,1,1,2,1,1,1,2,1,1,1
        DEFB    1,2,1,1,1,2,2,1,1,1,2,1,1,2,2,1
        DEFB    1,1,1,2,2,1,1,1,2,1,1,2,2,1
        DEFB    1,1,2,1,1,1,2,1,2,1,2,1,1,2,2,2,2,1
        DEFB    1,1,2,2,2,2,2,2,2,2,1,1
        DEFB    1,1,2,1,0,0,0,0
FIN:    DEFB    0

    
VDRA:   LD      HL,52991 + 64
        LD      A,(D_DRAC)
        AND     A
        RR      A
        LD      B,0
        LD      C,A
        ADD     HL,BC
        LD      DE,16384
        EXX     
        LD      B,128
VDRA1:  EXX     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LD      BC,80 ; DESCOMPILADO l0050
        ADD     HL,BC
        LD      BC,16 ; DESCOMPILADO l0010
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        EXX     
        DJNZ    VDRA1
        EXX     
        CALL    CA
        RET
        
MAAS    DEFB    12
D_DRAC  DEFB    32    

VER     LD      A,(SALGO)
        CP      0
        RET     Z

        LD      A,(VELO)
        sbc     A,7
        JP      C,MASS
        LD      A,(VELO)
        sbc     A,11
        RET     C

        LD      A,(MASS)
        DEC     A
        CP      0
        LD      (MASS),A
        RET     NZ

        LD      A,8
        LD      (MASS),A
        LD      A,(D_DRAC)
        CP      32
        RET     Z

        INC     A
        LD      (D_DRAC),A
        RET     

MASS:   LD      A,(D_DRAC)
        DEC     A
        CP      255
        JP      Z,SIGUE
        LD      (D_DRAC),A
        RET     

SIGUE:  LD      A,0
        LD      (VELO),A
        LD      A,1
        LD      (FBOCA),A
        CALL    BOCA
        CALL    MOVE
        LD      HL,53054
        LD      B,64
        LD      A,0
        LD      (DATCOL),A
SIGUE2: PUSH    BC
        PUSH    HL
        LD      DE,16384
        EXX     
        LD      B,128
        PUSH    HL
        LD      HL,850
        HALT    
SIGUE4: DEC     HL
        LD      A,H
        OR      L
        JR      NZ,SIGUE4
        POP     HL
SIGUE1: EXX     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LD      BC,64 ; DESCOMPILADO l0040
        ADD     HL,BC
        EXX     
        DJNZ    SIGUE1
        EXX     
        CALL    COME
        PUSH    DE
        CALL    CPASO
        LD      A,(DATCOL)
        INC     A
        LD      (DATCOL),A
        POP     DE
        POP     HL
        DEC     HL
        POP     BC
        DJNZ    SIGUE2
        LD      A,32
        LD      (D_DRAC),A
        
TERMI:  LD      B,16
        LD      HL,53006
        LD      A,0
        LD      (DASCOS),A
TEB11:  PUSH    BC
        PUSH    HL
        LD      B,128
        LD      DE,16400
        PUSH    DE
        HALT    
        LD      DE,850
ESPE1:  DEC     DE
        LD      A,D
        OR      E
        JR      NZ,ESPE1
        POP     DE
TEB22:  PUSH    BC
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LD      BC,80 ; DESCOMPILADO l0050
        ADD     HL,BC
        LD      BC,16 ; DESCOMPILADO l0010
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        DJNZ    TEB22
        PUSH    DE
        CALL    CFIN
        LD      A,(DASCOS)
        INC     A
        LD      (DASCOS),A
        POP     DE
        POP     HL
        POP     BC
        DEC     HL
        DJNZ    TEB11
        LD      A,1
        LD      (FIN),A
        CALL    FINAL
        RET     

DATCOL  DEFB    0
DASCOS  DEFB    0
    
RELOJ:  LD      A,(D_REL)
        INC     A
        CP      255
        JP      Z,PONDRA
        LD      (D_REL),A
        RET     

D_REL   DEFB    0
    
PONDRA: LD      A,1
        LD      (SALGO),A
        LD      A,0
        LD      (D_REL),A
        RET     

ESPERA: LD      A,(VELO)
        CP      0
        RET     NZ

        LD      HL,900
        HALT    
ESPE5:  DEC     HL
        LD      A,H
        OR      L
        JR      NZ,ESPE5
        RET     

; IMPRIME GRAFICO DE LUNA Y NUBES
; DIMENSIONES 9 X 4 CARACTERES (9X32 BYTES)
;
LUNA:   LD      DE,GR_LUNA ; POSICIÓN DEL BITMAP
        LD      B,4      
        LD      HL,16439 ; POSICION DE PANTALLA
BLU1:   PUSH    BC
        PUSH    HL
        LD      B,8
LU2:    PUSH    BC
        PUSH    HL
        LD      B,0
        LD      C,9
        EX      DE,HL
        LDIR    
        EX      DE,HL
        POP     HL
        POP     BC
        INC     H
        DJNZ    LU2
        POP     HL
        LD      BC,32 ; DESCOMPILADO l0020
        ADD     HL,BC
        POP     BC
        DJNZ    BLU1
        RET     

OK:     DEFB    0
HOH:    DEFB    0
    
OKS:    LD      A,(OK)
        CP      0
        RET     Z

        LD      A,1
        LD      (HOH),A
        LD      A,15
        LD      (VELO),A
        LD      A,(D_DRAC)
        CP      32
        RET     NZ

        LD      A,5
        LD      (DATO1),A
        LD      A,5
        LD      (DATO1 + 1),A
        LD      A,(FALTA)
        INC     A
        CP      100
        JP      Z,OKS1
        LD      (FALTA),A
        RET     

OKS1:   LD      A,1
        LD      (FIN),A
        LD      A,0
        LD      (FALTA),A
        RET     

FALTA:  DEFB    0
TABLA1: DEFB    7,4 ; ALTO POR ANCHO
FASE:   DEFB    1
; BITMAPS DEL PERSONAJE 224 BYTES CADA FRAME
TABLA2: DEFW    PE_FR1 ;47772 CORRIENDO FRAME 1
        DEFW    PE_FR1 + 224 ;PE_FR2 ;47996 CORRIENDO FRAME 2
        DEFW    PE_FR1 + 448 ;PE_FR3 ;48220 CORRIENDO FRAME 3
        DEFW    PE_FR1 + 672 ;PE_FR4 ;48444 LECHUGAZO CONTRA EL SUELO
        DEFW    PE_FR1 + 896 ;PE_FR5 ;48668 FOTOGRAMA MISTERIOSO ?¿
        DEFW    PE_FR1 + 1120;PE_FR6 ;48892 SE QUEMA EL CULO   1120
COORS:  DEFB    17,10 ; COORDENADAS INICIAL PERSONAJE
        
IMPRES: LD      A,(FASE)
        LD      B,A
        LD      DE,TABLA2 - 2
BIO:    INC     DE
        INC     DE
        DJNZ    BIO
        LD      A,(DE)
        LD      L,A
        INC     DE
        LD      A,(DE)
        LD      H,A
        EX      DE,HL
        LD      HL,(COORS)
        EX      DE,HL
        LD      B,7
BI1:    PUSH    BC
        PUSH    DE
        PUSH    HL
        CALL    DIRE
        EX      DE,HL
        POP     HL
        LD      B,8
BI2:    PUSH    DE
        LD      C,4
BI3:    LD      A,(HL)
        LD      (DE),A
        INC     HL
        INC     DE
        DEC     C
        JR      NZ,BI3
        POP     DE
        INC     D
        DJNZ    BI2
        POP     DE
        INC     D
        POP     BC
        DJNZ    BI1
        RET     

DIRE:   LD      A,D
        SBC     A,16
        JP      NC,ROM
        LD      A,D
        AND     $18
        ADD     A,$40
        LD      H,A
        LD      A,D
        RRCA    
        RRCA    
        RRCA    
        AND     $E0
        ADD     A,E
        LD      L,A
        RET     

ROM:    LD      HL,0 ; DESCOMPILADO l0000
        RET     

SALTO:  DEFB    0
SUBE:   DEFB    7
BAJA:   DEFB    7 
           
ANDA:   LD      A,(VELO)
        CP      0
        RET     Z

        LD      A,(SALTO)
        CP      0
        RET     NZ

        LD      A,(VOL)
        CP      0
        RET     NZ

        LD      A,(FASE)
        CP      4
        CALL    Z,PONO
        LD      A,(FAS)
        CP      1
        JR      Z,BAJ
        LD      A,(FASE)
        INC     A
        CP      4
        CALL    Z,PONO
        LD      (FASE),A
CONT1:  CP      2
        RET     NZ

        RET     ; RET DESPUES DE RET NZ ???

PONO:   LD      A,1
        LD      (FAS),A
        LD      A,2
        RET     

PONA:   LD      A,0
        LD      (FAS),A
        LD      A,2
        RET     

BAJ:    LD      A,(FASE)
        DEC     A
        CP      0
        CALL    Z,PONA
        LD      (FASE),A
        JR      CONT1

FAS:    DEFB    0
     
PUPA:   LD      A,(SALTO)
        CP      1
        RET     Z

        LD      A,1
        LD      (VELO),A
        LD      A,4
        LD      (FASE),A
        LD      A,6
        LD      (VOL),A
        RET     

SALTOS: LD      A,(21265)
        CP      0
        JP      Z,PUPA
        LD      A,(T_SAL)
        CALL    COMPR
        RET     NZ

        LD      A,1
        LD      (SALTO),A
        LD      A,(FASE)
        CP      1
        RET     Z

        CP      2
        RET     Z

        CP      5
        RET     Z

        LD      A,2
        LD      (FASE),A
        RET     

SALTMO: LD      A,(SALTO)
        CP      0
        RET     Z

        LD      A,(SUBE)
        CP      0
        JP      Z,BAJAR
SUBIR:  DEC     A
        LD      (SUBE),A
        LD      A,(COORS + 1)
        DEC     A
        LD      (COORS + 1),A
        RET     

BAJAR:  LD      A,(BAJA)
        DEC     A
        CP      0
        CALL    Z,FINI
        LD      (BAJA),A
        LD      A,(COORS + 1)
        INC     A
        LD      (COORS + 1),A
        RET     

FINI:   LD      A,0
        LD      (SALTO),A
        LD      A,7
        LD      (SUBE),A
        LD      (BAJA),A
        LD      A,2
        LD      (FASE),A
        LD      A,7
        RET     

BOCAS:  DEFW    45468,46044,46620,47196,44892
FBOCA:  DEFB    5
        
BOCA:   LD      A,(FBOCA)
        LD      B,A
        LD      DE,BOCAS - 2
BOCA1:  INC     DE
        INC     DE
        DJNZ    BOCA1
        LD      A,(DE)
        LD      L,A
        INC     DE
        LD      A,(DE)
        LD      H,A
        LD      DE,59206
        LD      B,64
BOCA2:  PUSH    BC
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        LDI     
        EX      DE,HL
        LD      BC,87
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        DJNZ    BOCA2
        CALL    CFB
        RET     

FUEGO:  LD      A,(F1)
        INC     A
        LD      (F1),A
        CP      2
        JP      Z,FUE2
        LD      A,2
        LD      (FBOCA),A
        CALL    BOCA
        RET     

F1      DEFB    0
 
FUE2:   LD      A,0
        LD      (F1),A
        LD      A,3
        LD      (FBOCA),A
        CALL    BOCA
        RET     

FUEGOS: CALL    JIJI
        LD      A,(D_DRAC)
        sbc     A,6
        JP      NC,NOFUE
        LD      A,(FBOCA)
        CP      1
        RET     Z

        CALL    FUEGO
        RET     

NOFUE:  LD      A,(FBOCA)
        CP      1
        RET     Z

        CP      4
        RET     Z

        CP      5
        RET     Z

        LD      A,4
        LD      (FBOCA),A
        CALL    BOCA
        RET     

JIJI:   LD      A,(FBOCA)
        CP      1
        RET     Z

        CP      4
        RET     Z

        CP      5
        RET     Z

        LD      A,(SALTO)
        CP      1
        RET     Z

        LD      A,(FASE)
        CP      4
        RET     Z

        CP      5
        RET     Z

        LD      A,1
        LD      (SALTO),A
        LD      A,6
        LD      (FASE),A
        RET     

COME:   LD      A,(JNO)
        CP      0
        RET     Z

        CALL    LUNA
        LD      A,0
        LD      (JNO),A
        LD      A,10
        LD      (VELO),A
        LD      B,30
COME1:  PUSH    BC
        CALL    SCROLL
        CALL    IMPRE
        CALL    CAMBIO
        POP     BC
        DJNZ    COME1
        RET     

FINAL:  LD      A,5
        LD      (FBOCA),A
        CALL    BOCA
        LD      A,10
        LD      (COORS + 1),A
        LD      A,1
        LD      (JNO),A
        LD      A,0
        LD      (SALTO),A
        LD      A,7
        LD      (BAJA),A
        LD      (SUBE),A
        LD      A,2
        LD      (FASE),A
        RET
        
JNO     DEFB    1    

ABRIRS  LD      A,(D_DRAC)
        sbc     A,8
        RET     C
        CALL    ABRIR
        RET     
        
SENE    DEFB    50
ABRIR   LD      A,(SENE)               
        DEC     A
        LD      (SENE),A
        CP      0
        JP      Z,AB1
        LD      (SENE),A
        CP      25
        RET     NZ

AB2:    LD      A,4
        LD      (FBOCA),A
        CALL    BOCA
        RET     

AB1:    LD      A,50
        LD      (SENE),A
        LD      A,5
        LD      (FBOCA),A
        CALL    BOCA
        RET     

VOL     DEFB    0     
VOLTA   LD      A,(VOL)
        CP      0
        RET     Z

        DEC     A
        LD      (VOL),A
        LD      A,2
        LD      (VELO),A
        LD      A,(FASE)
        INC     A
        LD      (FASE),A
        CP      6
        RET     NZ

        LD      A,4
        LD      (FASE),A
        RET     

SELO:   LD      HL,49117
        LD      DE,49662
        LD      B,64
SELO1:  LD      C,8
SELO2:  PUSH    HL
        PUSH    BC
        LD      BC,4
        LDIR    
        POP     BC
        POP     HL
        DEC     C
        JR      NZ,SELO2
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        DJNZ    SELO1
        RET     

; PART 2 COLORES

CFB:    RET     

CPASO:  LD      DE,22528
        LD      HL,43355 + 63
        LD      A,(DATCOL)
        LD      C,A
        LD      B,0
        AND     A
        sbc     HL,BC
        LD      B,16
CP1:    PUSH    BC
        LD      BC,32 ; DESCOMPILADO l0020
        LDIR    
        LD      BC,64 ; DESCOMPILADO l0040
        ADD     HL,BC
        POP     BC
        DJNZ    CP1
        RET     

CA:     LD      DE,22528
        LD      HL,43355 + 63
        LD      A,(D_DRAC)
        AND     A
        RR      A
        LD      C,A
        LD      B,0
        ADD     HL,BC
        LD      B,16
CA1:    PUSH    BC
        LD      BC,17
        LDIR    
        EX      DE,HL
        LD      BC,15
        ADD     HL,BC
        EX      DE,HL
        LD      BC,79 ; DESCOMPILADO l004f
        ADD     HL,BC
        POP     BC
        DJNZ    CA1
        RET     

CFIN:   LD      DE,22544
        LD      HL,43355 + 16
        LD      A,(DASCOS)
        LD      C,A
        LD      B,0
        AND     A
        SBC     HL,BC
        LD      B,16
CF1:    PUSH    BC
        LD      BC,16 ; DESCOMPILADO l0010
        LDIR    
        LD      BC,16 ; DESCOMPILADO l0010
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        LD      BC,80 ; DESCOMPILADO l0050
        ADD     HL,BC
        POP     BC
        DJNZ    CF1
        RET     
END
; FIN DEL CODIGO