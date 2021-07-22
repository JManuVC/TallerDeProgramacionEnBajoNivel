
;capturar n numeros, si el num es primo mostrar su tabla de suma, caso contrario 
;mostrar su tabla de resta

org 100h
esPrimo macro pal
   local ciclo
    mov dl,0
    mov cx,pal
    ciclo:
    div cx
    cmp ah,0
    jne inc dl
    loop ciclo
    cmp dl,2
    je bh,2 
    mov al,pal
 endm
    
    
    
endm
inicio:
    mov ah,7
    int 21h
    cmp al,30h
    jb inicio
    cmp al, 39h
    ja inicio
    mov ah,0
    esPrimo
    cmp bh,2
    je call mostrarSuma
    jmp call mostrarResta
    
fin: int 21h
ret
proc mostrarSuma
proc mostrarResta
        





