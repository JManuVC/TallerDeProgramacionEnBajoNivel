;Vargas Cruz Jose Manuel
    ; 4.- Asignar cadenas:
        ;c) estructurada a longitud fija

org 100h

 main:   
    lea di,cadena2
    lea di,di+7
        
        lea si,cadena1
        inc si
        mov cl,[si]
        push cx
    cicloCopiar:
        inc si
        mov al,[si]
        mov [di],al
        inc di
        loop cicloCopiar
        
      
    
 
 fin:int 20h
 
 cadena1 db 7,4,'abcd',0 ;estructurada
 
 cadena2 db '1234567'    ; longitud fija


