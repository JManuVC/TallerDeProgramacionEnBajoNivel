;Vargas Cruz Jose Manuel
    ; 4.- Asignar cadenas:
        ;e) ASCIIZ a longitud fija

org 100h

 main:   
    lea di,cadena2
    lea di,di+7
        
        lea si,cadena1
        
    cicloCopiar:
        cmp [si],0
        je fin
        
        mov al,[si]
        mov [di],al
        inc di
        inc si
        loop cicloCopiar
        
      
    
 
 fin:int 20h
 
 cadena1 db 'abcd',0 ;ASCIIZ
 
 cadena2 db '1234567'    ; longitud fija