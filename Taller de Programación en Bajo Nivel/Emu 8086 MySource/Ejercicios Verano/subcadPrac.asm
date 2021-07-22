

org 100h
inicio:
    lea dx,cad
    call leerCad
    call saltoLinea
    call leerNum
    xor cx,cx
    and dl,00fh
    mov cl,dl 
    push cx
    lea di,subcad 
    call saltoLinea
    mov ah,1
    
    ciclo:
      leer:
        int 21h
        
        cmp al,13
        je saltar
        mov [di],al
        inc di
        jmp leer
        
       saltar:
       inc di
       call saltoLinea 
       mov ah,1
        
    loop ciclo
    xor cx,cx
    pop cx
    mov dh,cl
   lea si,subcad
   mov bp,si
   cicl:
   cmp dh,0
   je parar 
    
    lea di,cad
    inc di
    mov cl,[di]
    inc di
    
    ciclo2:
    
    mov si,bp
    mov bh,0  
       continue: 
        mov bl,[si]
        cmp [di],bl
        jne seguir
        cmp [si+1],24h
        je  incre
        inc di
        inc si
        inc bh
        jmp continue
        incre:
            inc dl
       seguir:
        cmp bh,0
        jne sig
        inc di
       sig:
        
    loop ciclo2  
    
    dec dh
     
    add dl,30h
    mov ah,2
    int 21h 
    push dx
    call saltoLinea
    pop dx
    mov dl,0
    avan:
        cmp [si],24h
        je salt
        inc si
    jmp avan
    salt:
        inc si
        mov bp,si  
    jmp cicl
    
    
    parar:
    
    
fin: int 20h

cad db 100 dup ('$')
subcad db 50 dup ('$')
proc leerNum
    mov ah,7
   otro: 
    int 21h
    
    cmp al,'0'
    jb otro
    cmp al,'9'
    ja otro
    
    mov ah,2
    mov dl,al
    int 21h
    ret
    leerNum endp
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