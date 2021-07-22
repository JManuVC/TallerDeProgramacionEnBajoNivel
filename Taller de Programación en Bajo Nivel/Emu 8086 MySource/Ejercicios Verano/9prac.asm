

org 100h

inicio:   
    lea dx,cad
    call leerCad
    call saltoLinea
    lea dx,subcad
    call leerCad
    call saltoLinea
    
    lea di,cad
    inc di
    mov cl,[di]
    inc di
    ciclo:
    lea si,subcad
    add si,2
    mov bh,0  
       continue: 
        mov bl,[si]
        cmp [di],bl
        jne seguir
        cmp [si+1],0Dh
        je  mostrar
        inc di
        inc si
        inc bh
        jmp continue
       seguir:
        cmp bh,0
        jne sig
        inc di
       sig:
        
    loop ciclo
   noEs:
    lea dx,msj2
    call showCad 
    jmp fin
   mostrar:
    
    lea dx,msj
    call showCad
    
fin: int 20h
cad db 50 dup ('$')
subcad db 50 dup ('$')
msj db 10,13,"Si es subcadena$"
msj2 db 10,13,"No es subcadena$"
proc showCad
    mov ah,9
    int 21h
    ret
    showCad endp 
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
    
    xor dx,0
    ret
saltoLinea endp