;******************************************************************
;*** TRITON SOFTWARE **** SAGA DARK, FASE DRAGON, GRAFICOS      ***
;******************************************************************   

    ORG		47772

PE_FR1:
        
; [RESOURCE: <Parser:SevenuP Image Parser><Resource:Sprite\Personaje><Data::scAsm:apDEFB:lprrpl:lpo:opl::NAL:doGr:MI:ilSp:soXC:soCL:soYC:soMk:soFN:Dec>]
;-------------------------------------------------------------------------;
; C source file created by TommyGun (Based on output from SevenuP v1.20   ;
; SevenuP  (C) Copyright 2002-2006 by Jaime Tejedor Gomez, aka Metalbrain ;
; TommyGun (C) Copyright 2005-2007 by Tony Thompson, aka Kiwi             ;
;-------------------------------------------------------------------------;
; Name   : Personaje
; Frames : 6
; Size   : 32x56
; Palette: Monochrome
; Masked : No
; RowOrder: Classic
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   1,  64,   0,   0,   5,  64,   0
	DEFB	  0,   6, 192,   0,   0,   5,  96,   0
	DEFB	  0,   7, 240,   0,   0,   3, 168,   0
	DEFB	  0,   1, 252,   0,   0,   1, 252,   0
	DEFB	  0,   1, 228,   0,   0,   1, 252,   0
	DEFB	  0,  15, 248,   0,   0,  31, 224,   0
	DEFB	  0,  63, 240,   0,   0,  63, 240,   0
	DEFB	  0,  57, 240,  28,   0, 121, 240, 224
	DEFB	  0, 121, 135,   0,   0, 124,  56,   0
	DEFB	  0,  61, 192,   0,   0,  62,  12,   0
	DEFB	  0, 222, 238,   0,   0,   0, 198,   0
	DEFB	  0,   5,  64,   0,   0,   2, 160,   0
	DEFB	  0,   1, 240,   0,   0,   2, 248,   0
	DEFB	  0,   3,  56,   0,   0,   3, 188,   0
	DEFB	  0,   3, 156,   0,   0,   7,  28,   0
	DEFB	  0,  10,  28,   0,   0,  29,  36,   0
	DEFB	  0,  31,  24,   0,   0,  31, 188,   0
	DEFB	  0,  15, 190,   0,   0,   7, 191,   0
	DEFB	  0,   0,  63,   0,   0,   0,  31,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0, 160,   0
	DEFB	  0,   2, 160,   0,   0,   3,  96,   0
	DEFB	  0,   2, 176,   0,   0,   3, 248,   0
	DEFB	  0,   1, 212,   0,   0,   0, 254,   0
	DEFB	  0,   0, 254,   0,   0,   0, 242,  32
	DEFB	  0,   0, 254,  32,   0,   7, 252,  64
	DEFB	  0,  15, 112,  64,   0,  31,  28, 128
	DEFB	  0,  31, 216, 128,   0,  60, 221,   0
	DEFB	  0,  59,  61,   0,   0,  59,  22,   0
	DEFB	  0,  28, 114,   0,   0,  15, 132,   0
	DEFB	  0,   7, 228,   0,   0,  10, 184,   0
	DEFB	  0,   5,  88,   0,   0,  11, 192,   0
	DEFB	  0,   7, 160,   0,   0,   7,  28,   0
	DEFB	  0,   3, 224,   0,   0,   3, 224,   0
	DEFB	  0,   5, 240,   0,   0,  14, 240,   0
	DEFB	  0,  31, 112,   0,   0,  28, 224,   0
	DEFB	  0,  61, 192,   0,   0,  58, 128,   0
	DEFB	  0,  59,   0,   0,   0,   7, 128,   0
	DEFB	  0,  15, 192,   0,   0,  15, 224,   0
	DEFB	  0,   7, 224,   0,   0,   3, 192,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,  80,   0
	DEFB	  0,   1,  80,   0,   0,   1, 176,   0
	DEFB	  8,   1,  88,   0,   8,   1, 252,   0
	DEFB	  4,   0, 234,   0,   5, 224, 127,   0
	DEFB	  3, 252, 127,   0,   7, 254, 121,   0
	DEFB	  6, 159, 127,   0,   5,  15, 254,   0
	DEFB	  1,   7, 184,   0,   0, 131, 232,   0
	DEFB	  0, 129, 232,   0,   0,  67, 236,  56
	DEFB	  0,  67, 158,  24,   0,  35, 239,  56
	DEFB	  0,  35, 183, 240,   0,  21, 231, 224
	DEFB	  0,  18, 163, 192,   0,   5,  80,   0
	DEFB	  0,   3, 224,   0,   0,   7, 176,   0
	DEFB	  0,   3, 184,   0,   0,   7,  60,   0
	DEFB	  0, 119, 124,   0,   0, 238, 248,   0
	DEFB	  0, 222, 240,   0,   0,  28,   0,   0
	DEFB	  0,  98,   0,   0,   0, 246,   0,   0
	DEFB	  0, 242,   0,   0,   0, 240,   0,   0
	DEFB	  0, 248,   0,   0,   0, 124,   0,   0
	DEFB	  0, 124,   0,   0,   0,  60,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   7,   0
	DEFB	  0,   0,   6, 128,   0,   6,   7, 128
	DEFB	  0,   8,   3,  64,   0,   9, 227, 192
	DEFB	  0, 195, 217, 160,   1, 227,  93, 196
	DEFB	  1, 227,  61, 164,  25, 115, 158, 228
	DEFB	 33, 115, 143,   9,   1, 187, 128,  49
	DEFB	 13, 185, 128,   2,  29, 157, 128,  12
	DEFB	 30,  77,   0,   0,  15,  22, 128,   0
	DEFB	  3, 133,  64,   0,   0,  11, 160, 112
	DEFB	 24,  12,  80, 216,  62,   3, 176, 168
	DEFB	 63,   3,  29, 168,  63, 131, 233,  28
	DEFB	 57, 195, 218,  92,  56,  97, 236, 221
	DEFB	 57, 153, 253, 140,  24, 231, 219, 140
	DEFB	 28,  57, 171,   0,  28,  30, 119,   1
	DEFB	 28,  15, 255,   2,  30,   7, 255, 140
	DEFB	110,   3, 228, 248,  26,  35, 223, 112
	DEFB	 13, 135, 213, 112,   0,  99, 223,  96
	DEFB	  0,  24, 228, 232,   0,  70,  63, 225
	DEFB	  0, 113, 153, 224,   1, 132,  80, 112
	DEFB	  0,   7,  16,  24,   0,   4,   0,   8
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0, 160,   0,   0,   0, 168,   0
	DEFB	  0,   0, 216,   0,   0,   1, 168,   0
	DEFB	  0,   3, 248,   0,   0,   5, 112,   0
	DEFB	  0,  15, 225, 128,   0,  15, 227, 192
	DEFB	  0,   9, 231, 224,   0,   9, 239, 224
	DEFB	  0,   7, 254,  96,   0, 113, 252,  96
	DEFB	  0, 253, 248, 224,   0, 255, 248, 224
	DEFB	  1, 239, 249,  32,   1, 199, 242, 192
	DEFB	  3, 195, 237, 128,   3, 131, 144,   0
	DEFB	  3, 130, 112,   0,   3,  25, 240,   0
	DEFB	  1, 243, 224,   0,   0, 229,  92,   0
	DEFB	  3,  12, 191,   0,   0,  13,  95, 128
	DEFB	  0,  14, 135, 224,   0,  30,   1, 240
	DEFB	  0,  62,   0, 240,   0, 124,  48, 152
	DEFB	  0, 127,  28,  14,   0,  63, 232, 240
	DEFB	  0,  31, 232, 240,   0,   0,  81, 240
	DEFB	  0,   0, 179, 224,   0,   3, 227, 192
	DEFB	  0,   3, 195, 192,   0,   0,   1, 128
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   5,   0,   0
	DEFB	  0,  21,   0,   0,   0,  27,   0,   0
	DEFB	  0,  21, 128,   0,   0,  31, 192,   0
	DEFB	  4,  30, 160,   0,   4,  14, 160,  24
	DEFB	  2,  15, 240,  96,   2,  15,  81, 128
	DEFB	  1,   6,   2,   0,   1,  14,   0,  64
	DEFB	  0, 158, 122,  12,   0, 190, 253,  48
	DEFB	  0, 127,  13,   0,   0, 253, 229,   0
	DEFB	  0, 254,   6,   0,   1, 239,  64,  48
	DEFB	  1,  27,  66,  12,   1, 174, 192, 130
	DEFB	  1, 175, 128,   0,  64, 215, 192,   0
	DEFB	 16, 234, 160,   0,   4,  19,  96,   0
	DEFB	  1,  42, 176,   0,   0,  21, 120,   0
	DEFB	  0,  78, 184,   0,  33,  39, 220,   0
	DEFB	  4, 131, 172,   0,  16,  65, 212,   0
	DEFB	 66,   0, 244,   0,   0, 128, 212,   0
	DEFB	  8,   1, 232,   0,   1,   3,  28,   0
	DEFB	 32,   7, 160,   0,   0,  25, 112,   0
	DEFB	  0,  62, 120,   0,   0, 124,  60,   0
	DEFB	  0, 126,   0,   0,   0,  63,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
	DEFB	  0,   0,   0,   0,   0,   0,   0,   0
; ]RESOURCE: <Parser:SevenuP Image Parser><Resource:Sprite\Personaje>]        

; ]RESOURCE: <Parser:SevenuP Image Parser><Resource:Sprite>]                  

; ]RESOURCES SECTION                                                         