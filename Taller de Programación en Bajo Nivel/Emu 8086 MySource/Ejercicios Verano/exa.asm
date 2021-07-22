;Vargas Cruz Jose Manuel
.model tiny
.code

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
    xor cx,cx
    mov cl,[di]
    inc di
   
    mov dl,0
 ciclo:
    
    lea si,subcad
    inc si
    inc si
    
    xor bx,bx
      continue: 
        mov bl,[si]
        
        cmp [di],bl
        
        jne seguir
        cmp [si+1],0Dh
        je  encontro
        jne cont
       encontro:
        inc dl
        jmp seguir
       cont: 
        inc di
        inc si
        inc bh 
        
        jmp continue        ;ababaz
       seguir:              ;vc
        cmp bh,0
        jne sig
        inc di
       sig:
        
    loop ciclo
 
   
    add dl,30h
    mov ah,2
    int 21h
  
    call saltoLinea
    
    lea si, subcad
    inc si 
    xor cx,cx
    mov cl,[si] 
    inc si
    avan:
        inc si
        
       loop avan
       dec si
       
    mov dl,0 
    
    lea di,cad
    inc di
    xor cx,cx
    mov cl,[di]
    inc di
    xor bx,bx
    ulti:
        mov bl,[si]
        cmp [di],bl
        jne seg
        inc bh
        seg:
        inc di
        
     loop ulti
        
        mov ah,2
        mov dl,bh
        add dl,30h
        int 21h
      
    
    
fin: int 20h 

cad db 50 dup ('$')
subcad db 50 dup ('$')
 
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
    
   
    ret
saltoLinea endp
