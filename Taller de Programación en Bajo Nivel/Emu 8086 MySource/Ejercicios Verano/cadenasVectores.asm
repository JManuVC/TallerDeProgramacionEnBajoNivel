

org 100h

inicio:
   
    mov ah,7
    int 21h
    cmp al,30h
    jb inicio
    cmp al,39h
    ja inicio
      
    
    
    mov dl,al
    
    mov bl,al
    sub bl,30h
    
    mov ah,2
    int 21h
  otro:  
    mov ah,7
    int 21h
    cmp al,30h
    jb otro
    cmp al,39h
    ja otro
      
    
    
    mov dl,al
    sub al,30h
    mov bh,al
    mov ah,2
    int 21h
    
    xor dx,dx
    
    lea di,impares
    
    xor cx,cx
    mov cl,bl
    
    inc dl
    impar:
        mov [di],dl
        add dl,2
        inc di
        loop impar 
        mov [di],0
    
    xor dx,dx   
    lea si,pares
    
    xor cx,cx
    mov cl,bh
    mov dl,2
    par:
        mov [si],dl
        inc dl
        inc dl
        inc si
        loop par
        mov [si],0    
    
    
    
    
        
fin: int 20h 

pares db 50 dup (0)
impares db 50 dup (0)


