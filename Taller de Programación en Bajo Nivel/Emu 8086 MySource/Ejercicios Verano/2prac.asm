;Realizar un programa que comprueba si una cadena leída por teclado comienza por una subcadena introducida por teclado.
;Vargas Manuel

org 100h

inicio:  
    lea dx,cad
    call leerCad
    call saltoLinea
    lea dx,subcad
    call leerCad
    
    lea di,cad
    inc di
    lea si,subcad
    inc si
    
    mov bl,[si]
    
    cmp [di],bl
    jb mostrarNosub
    
    
    xor cx,cx
    mov cl,[si] 
    inc di
    inc si
    ciclo:
        mov bl,[si]
        cmp [di],bl
        jne mostrarNosub
        inc si
        inc di
    
        loop ciclo
        
        lea dx,esSub
        call showCad  
        jmp fin
    
    mostrarNosub:
        lea dx,esNsub
        call showCad

fin: int 20h

cad db 50 dup ('$')
subcad db 50 dup ('$')

esSub db 10,13,"Es subcadena$"
esNsub db 10,13,"No es subcadena$"

proc leerCad
    mov ah,0Ah
    int 21h
ret
leerCad endp 

proc showCad
    mov ah,9
    int 21h
ret
showCad endp 

proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
saltoLinea endp