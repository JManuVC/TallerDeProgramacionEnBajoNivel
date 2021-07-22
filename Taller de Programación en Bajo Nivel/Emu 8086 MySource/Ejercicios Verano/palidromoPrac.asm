

org 100h

inicio:
    xor cx,cx
    call leerNum
    mov cl,dl
    sub cl,30h
    cmp cl,0
    je noHay
    call saltoLinea
    lea di,cad
    xor bx,bx
    push cx
    ciclo:
       mov dh,0
        
        ciclo2:
        cmp dh,4
        jae salir
        call leerNum
        mov [di],dl
        ;mov bl,dl
        ;push bx
        inc di
        inc dh
        jmp ciclo2
       salir: 
       inc di 
       call saltoLinea
    loop ciclo
    pop cx
    mov ch,0
    lea di,cad
    
    
    ciclo3: 
            
         
         mov bl,[di+3]   
         cmp [di],bl
         jne noEs
         inc di
         mov bl,[di+1]   
         cmp [di],bl
         jne noEs
            lea dx,esPa
            call showCad
            jmp seg
         noEs:
         lea dx,noEsPa
         call showCad
         
        seg:
          cmp [di],24h
          jne seguir
          jmp parar
          seguir:
          inc di
          jmp seg  
         parar:
            inc di
        
        loop ciclo3  
        jmp fin
        
     noHay:
     lea dx,no
     call showCad
    
       
fin: int 20h 
cad db 50 dup ('$') 
esPa db 10,13,"Es Palindrome$"
noEsPa db 10,13,"No es Palindrome$" 
no db 10,13,"No hay numeros$"
proc showCad
        mov ah,9
        int 21h
    ret
    showCad endp
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

proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    xor dx,dx
    ret
saltoLinea endp


