;Vargas Cruz Jose Manuel
    ; 4.- Asignar cadenas:
        ;a) estructurada a estructurada

org 100h

 main:   
    lea di,cadena2
    inc di  
    xor cx,cx
    mov cl,[di]
    push cx 
    inc di
    siguiente:
       
        inc di
        loop siguiente
        
        
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
        
        pop bx
        pop cx
        add bl,cl
        lea di,cadena2
        inc di
        mov [di],bl
            
    
 
 fin:int 20h
 
 cadena1 db 7,4,'abcd',0       ;estructurada
 
 cadena2 db 20,7,'1234567',0   ; estructurada
