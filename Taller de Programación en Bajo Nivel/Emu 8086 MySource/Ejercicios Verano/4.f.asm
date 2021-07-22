;Vargas Cruz Jose Manuel
    ; 4.- Asignar cadenas:
        ;f) estructurada a ASCIIZ

org 100h

 main:   
    lea di,cadena2
    ciclo:
        cmp [di],0
        je continue
        inc di
        jmp ciclo
     
     continue:
        
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
 
 cadena1 db 7,4,'abcd',0 ;estructurada
 
 cadena2 db '1234567',0    ; ASCIIZ