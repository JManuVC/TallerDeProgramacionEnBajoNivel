

org 100h

inicio:
    lea dx,cad
    call leerCad
    
    call saltoLinea
    xor cx,cx
    
    lea di,cad
    inc di
    lea si,iniciales
    xor cx,cx
    mov cl,[di]
    inc di
    
    mov bl,[di] 
    cmp bl,'Z'
    ja rest
    jb cont
   rest: 
    sub bl,20h
   cont:
    mov [si],bl
    inc si
    inc di
    xor bx,bx
    ciclo:
        mov al,[di]
       
        cmp al,20h
        
        jne seguir 
       continue: 
        mov bl,[di+1]
        cmp bl,'Z'
        jb seg
        sub bl,20h       
        seg:
        mov [si],bl
        inc si
        seguir:
        inc di
       
        
    loop ciclo 
        
        mov ah,9
        lea dx,iniciales
        int 21h
    
fin: int 20h

cad 50 dup ('$')
iniciales 50 dup ('$')

proc leerCad 
    mov ah,0Ah
    int 21h
    ret
    leerCad endp

proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
saltoLinea endp