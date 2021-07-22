
org 100h

inicio:
    lea dx,cad1
    call leerCad
    call saltoLinea
    
    lea di,cad1
    inc di
    mov cl,[di]
    inc di 
    lea si,cad2
    ciclo:
        
        cmp [di],'z'       ; solo letras
        ja break
        cmp [di],'A'
        jb break 
        cmp [di],'a'
        jae may
        cmp [di],'Z'
        jb min 
        jne break
        min:
            mov bl,[di]
            add bl,20h
            mov [si],bl
            jmp break
        may:
            mov bl,[di]
            sub bl,20h
            mov [si],bl
        break:
            inc si
            inc di
        
    loop ciclo
    mov ah,9
    lea dx,cad2
    int 21h     
fin: int 20h
cad1 db 50 dup ('$')
cad2 db 50 dup ('$')

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