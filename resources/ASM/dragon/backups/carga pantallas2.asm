;******************************************************************
;*** TRITON SOFTWARE **** SAGA DARK, FASE DRAGON ******************
;******************************************************************   
        ORG 40000
        
        INCLUDE PANTALLA-CARGA.ASM    
        
INICIO: ld      hl,PANTA
        ld      de,16384
        ld      bc,6912
        ldir 
        ret

end