;Pide una cadena y un carácter por teclado (valida que sea un carácter) y muestra cuantas veces aparece el carácter en la cadena.

org 100h
inicio:
    lea dx,cad
    call leerCad
    call saltoLinea  
    call leerCarac   
    call saltoLinea
    
    lea di,cad
    inc di
    mov cl,[di]
    inc di
    xor bx,bx
    ciclo:
        cmp al,[di]
        jne saltar
        inc bl
       saltar:
        inc di
    loop ciclo
        
        mov dl,bl
        add dl,30h
        call showCarac
        

fin: int 20h
cad db 50 dup ('$')

proc leerCad
    mov ah,0Ah
    int 21h
    ret
    leerCad endp 

proc leerCarac
    mov ah,7
    otro:
          
          int 21h
    
          cmp al,'A'
          jb otro
          cmp al,'z'
          ja otro
          cmp al,'a'
          jae continue
          cmp al,'Z'
          jbe continue
          jne otro
        continue:
          
          mov dl,al 
          call showCarac  
          
          
          
          
    ret
    leerCarac endp   

proc showCarac 
    mov ah,2
    int 21h
    ret
    showCarac endp

proc saltoLinea
    push ax
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    pop ax
    ret
saltoLinea endp

