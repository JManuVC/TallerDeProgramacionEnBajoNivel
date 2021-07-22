
;Vargas Cruz Jose Manuel
    ; 4.- Asignar cadenas:
        ;d) ASCIIZ a estructurada

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
        
        xor cx,cx
        
    cicloCopiar:
        cmp [si],0
        je saltar
        mov al,[si]
        mov [di],al
        inc di
        inc si
        inc cl
        jmp cicloCopiar
       saltar: 
        pop bx
        
        add bl,cl
        lea di,cadena2
        inc di
        mov [di],bl
            
    
 
 fin:int 20h
 
 cadena1 db 'abcd',0       ;estructurada
 
 cadena2 db 20,7,'1234567',0   ; estructurada