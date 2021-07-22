

org 100h

inicio:
       
       lea dx,cad
       call leerCad
       xor bx,bx
       
       lea di,cad
       inc di
       cmp [di],0
       je mostrar
       mov cl,[di]
       inc di
       
       ciclo:
        cmp [di],20h
        jne saltar 
        cmp [di-1],20h
        je saltar            
        
        inc bl 
        
        saltar:
            inc di
            loop ciclo
        call saltoLinea 
            
        inc bl
    mostrar:          
        mov ah,2
        mov dl,bl
        add dl,30h
        int 21h   
       
       

fin: int 20h

cad db 100 dup ('$') 
proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
saltoLinea endp 

proc leerCad
    mov ah,0Ah
    int 21h
    ret
    leerCad endp