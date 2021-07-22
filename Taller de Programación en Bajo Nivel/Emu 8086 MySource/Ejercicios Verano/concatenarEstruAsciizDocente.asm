.model tiny
.code


org 100h

 main:   
    lea di,cadena2
    siguiente:
        mov al,[di]
        cmp al,0
        je copiar
        inc di
        jmp siguiente
    copiar: 
        lea si,cadena1
        inc si
        mov cl,[si]
    cicloCopiar:
        inc si
        mov al,[si]
        mov [di],al
        inc di
        loop cicloCopiar
        mov [di],0
            
    
 
 fin:int 20h
 
 cadena1 db 7,4,'abcd',0
 
 cadena2 db '1234567',0

