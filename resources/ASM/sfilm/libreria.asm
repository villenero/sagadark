
; RUTINA DE IMPRESION RST#10

IMPREC  LD A,2
        PUSH HL
        CALL $1601      ; Open Channel
        POP HL
IMPROC  LD A,(HL)
        CP 255
        RET Z
        RST $10         ; PRINT
        INC HL
        JR IMPROC

; INCREMENTO COLOR

IMPRE2  LD  B,8
CA1     LD  A,255
        LD (COLOR),A
BU13    LD  A,(COLOR)
CA2     INC A
        LD (COLOR),A
        PUSH BC
        CALL CLS2;65296
        LD B,10
BU16    HALT
        DJNZ BU16
        POP BC
        DJNZ BU13
        RET

; DECREMENTO COLOR

IMPRE3  LD  A,8
        LD  (CA1+1),A
        LD  A,$3D
        LD  (CA2),A
        CALL IMPRE2
        LD  A,255
        LD  (CA1+1),A
        LD  A,$3C
        LD  (CA2),A
        RET
        
; RUTINA DE IMPRESION RST#10 CON SONIDO

IMPRE4  LD A,2
        PUSH HL
        CALL $1601      ; Open Channel
        POP HL
UCLE    LD A,(HL)
        CP 255
        RET Z
        INC HL
        PUSH HL
        RST $10         ; PRINT
        LD HL,1
        LD DE,10
        CALL 949        ; BBEPER
        LD B,3
BUC     HALT
        DJNZ BUC
        POP HL
        JR UCLE


; 27007 RUTINA IMPRESION 5
IMPRE5  LD      B,(IX+2)
        LD      C,(IX+3)
        LD      A,(IX+1)
FILA    PUSH    AF
        LD      A,(IX+0)
COLUM   PUSH    AF
PANTHL  LD      H,$40
        LD      A,B
        AND     24
        ADD     A,H
        LD      H,A
        LD      A,B
        AND     7
        RRCA    
        RRCA    
        RRCA    
        ADD     A,C
        LD      L,A
        PUSH    BC
        LD      B,8
CARACT  LD      A,(DE)
        LD      (HL),A
        INC     DE
        INC     H
        DJNZ    CARACT
        POP     BC
ATTH    LD      A,B
        SRA     A
        SRA     A
        SRA     A
        ADD     A,$58
        LD      H,A
        LD      A,(DE)
        AND     63
        LD      A,(DE)
        JR      NZ,NCHANG
SCHANG  AND     192
        OR      (IX+4)
NCHANG  INC     DE
        LD      (HL),A
        POP     AF
        INC     B
        DEC     A
        JR      NZ,COLUM
        POP     AF
        LD      B,(IX+2)
        INC     C
        DEC     A
        JR      NZ,FILA
        RET     

; RUTINA QUE PONE EN FUNCIONAMIENTO EL SET DE CARACTERES

POKSET  LD HL,CHARSET
        LD A,L
        LD (23606),A
        LD A,H
        DEC A
        LD (23607),A
        RET

; RUTINA CLS DE PANTALLA

CLS     LD A,%01000111
        LD (23624),A    ; BORDCR color parte inferior pantalla y borde
        LD A,%01000111
        LD (23693),A    ; ATTR-P COLORES     
        CALL $0D6B      ; Llamamos a la rutina CLS de la Rom
        RET

; RUTINA DE CAMBIO DE PAPER E INK SIN CLS

CLS2    LD A,0
        OUT(254),A      ; Color del borde
SINCLS  LD HL,22528
        LD B,24
        LD A,(COLOR)
        LD E,A
BU1     LD C,32
BUCLE   LD A,E
        LD (HL),A
        INC HL
        DEC C
        LD A,C
        CP 0
        JR NZ,BUCLE
        DJNZ BU1
        RET
        
COLOR   DEFB 70

; EFECTO COLOR DEL BORDER Y SONIDO

BORDE   LD HL,120
        LD DE,12
        LD B,170
BUC_0   PUSH BC
        PUSH DE
        PUSH HL
        CALL 949        ; BEEPER ROM
        LD A,2
        OUT (254),A     ; control de altavoz y color del borde
        POP HL
        POP DE
        POP BC
        HALT
        INC HL
        INC HL
        INC HL
        DJNZ BUC_0
        LD A,0
        OUT (254),A     ; control de altavoz y color del borde
        RET
        
; SCROLL LATERAL BAJO

SCROLL  LD C,8
AA1     LD B,8
        LD HL,20671
BU      PUSH BC
        PUSH HL
        LD B,32
BU2     LD A,(HL)
        RLA
        LD (HL),A
        DEC HL
        DJNZ BU2
        POP HL
        INC H
        POP BC
        AND A
        DJNZ BU
        DEC C
        LD A,C
        CP 0
        JR NZ,AA1
        RET
BO      LD B,32
BECLE   PUSH BC
        CALL SCROLL
        POP BC
        DJNZ BECLE
        RET
PRESS   DEFB 22,21,31,16,0

; SCROLL "PULSE UNA TECLA"

TONI    LD A,0
        LD (23697),A
        LD C,24
        LD DE,PRESA
ADIOS   LD HL,PRESS
        LD B,5
HOLA    LD A,(HL)
        RST $10
        INC HL
        DJNZ HOLA
        LD A,(DE)
        RST $10
        INC DE
        PUSH BC
        PUSH HL
        PUSH DE
        CALL SCROLL
        POP DE
        POP HL
        POP BC
        DEC C
        LD A,C
        CP 0
        RET Z
        JR ADIOS        

; RUTINA GOTAS
BUC_1   ld      a,0
        ld      (23697),a
        push    bc
        call    8927
        pop     bc
        inc     b
        ld      a,12
        ld      (23697),a
        push    bc
        call    8927
        pop     bc
        dec     b
        dec     b
        ld      a,b
        cp      8
        jr      z,RESS
        ret     

RESS    inc     b
        ld      a,12
        ld      (23697),a
        call    8927
        ld      b,133
        ret     

M1      ld      a,(DAT1)
        ld      b,a
        ld      a,(CONT1)
        inc     a
        cp      50
        jr      z,C1
        ld      (CONT1),a
        ret     

C1      ld      c,132
        call    BUC_1
        ld      a,b
        ld      (DAT1),a
        ret     

M2      ld      a,b
        ld      a,(DAT4)
        ld      b,a
        ld      a,(CONT2)
        inc     a
        cp      90
        jr      z,C2
        ld      (CONT2),a
        ret     

C2      ld      c,98
        call    BUC_1
        ld      a,b
        ld      (DAT4),a
        ret     

M3      ld      a,(DAT3)
        ld      b,a
        ld      c,133
        call    BUC_1
        ld      a,b
        ld      (DAT3),a
        ret     

M4      ld      a,(DAT2)
        ld      b,a
        ld      a,(CONT4)
        inc     a
        cp      75
        jr      z,C4
        ld      (CONT4),a
        ret     

C4      ld      c,132
        call    BUC_1
        ld      a,b
        ld      (DAT2),a
        ret     

M5      ld      a,(DAT5)
        ld      b,a
        ld      c,148
        call    BUC_1
        ld      a,b
        ld      (DAT5),a
        ret
             
M7      ld      a,(DAT6)
        ld      b,a
        ld      c,89
        call    BUC_1
        ld      a,b
        ld      (DAT6),a
        ret     

GOTAS   push    af
        push    hl
        push    de
        push    bc
        call    M1
        call    M1
        call    M1
        call    M2
        call    M2
        call    M2
        call    M3
        call    M3
        call    M4
        call    M4
        call    M4
        call    M4
        call    M5
        call    M5
        call    M5
        call    M5
        call    M5
        call    M5
        call    M7
        call    M7
        call    M7
        call    M7
        ld      a,0
        ld      (23697),a
        pop     bc
        pop     de
        pop     hl
        pop     af
        jp      56

DAT1    DEFB 130
DAT2    DEFB 130
DAT3    DEFB 130
DAT4    DEFB 130
DAT5    DEFB 130
DAT6    DEFB 130
CONT1   DEFB 0
CONT2   DEFB 0
CONT4   DEFB 0

; RUTINA PAUSE 0

PAUSE0  LD  HL,23611
        RES 5,(HL)
        LD  BC,0
        CALL 7997
        RET

; RUTINA BORRADO DE DARK LINEA A LINEA

RALLAS  LD  A,20
        LD  (DAT8),A
        LD  A,(DAT9)
        DEC A
        CP  0
        CALL NZ,RALLOS
        RET
RALLOS  LD  (DAT9),A
        LD  A,(DAT10)
        DEC A
        LD  (DAT10),A
        LD  B,A
        LD  C,80
        CALL 8874
        LD  B,10
BU44    LD  A,0
        LD  (HL),A
        INC HL
        DJNZ BU44
        RET
        
DAT8    DEFB 20
DAT9    DEFB 33
DAT10   DEFB 168


