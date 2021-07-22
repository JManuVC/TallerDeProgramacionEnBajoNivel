

org 100h

inicio:
  otro: 
    mov ah,7
    int 21h 
    
   
    cmp al,30h
    jb otro
    cmp al,39h
    ja otro
    
    xor cx,cx
    
    mov cl,al
    sub cl,30h
    push cx
    mov ah,2
    mov dl,al
    int 21h
    mov ah,2
    call saltoLinea
    lea dx,cad 
    xor bx,bx
    ciclo:
        mov ah,0Ah
        
        int 21h
          
        mov bl,5
        add dx,bx
        call saltoLinea
        loop ciclo 
        call saltoLinea
     pop cx
     lea di,cad
     inc di
     inc di
     mostrarCajas:
        mov dh,[di] 
        sub dh,30h
        inc di
        mov bh,[di]
        sub bh,30h
        inc di
        mostrarFila:
            cmp dh,0
            je salir   
                push bx
                
                mostrarColumna:
                    cmp bh,0
                    je continuar
                    
                    mov dl,[di]
                    mov ah,2
                    int 21h 
                    dec bh
                    jmp mostrarColumna
               continuar:
               call saltoLinea
               pop bx    
                    
               dec dh
           
            
          
        jmp mostrarFila        
        salir:
        inc di
        inc di 
        inc di
        call saltoLinea
        
     loop mostrarCajas
    
     

fin: int 20h
               
               
cad db 50 dup ('$')
filas db 100 dup ('$') 
proc saltoLinea
    push dx
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    pop dx
    
    ret
saltoLinea endp
proc llenar