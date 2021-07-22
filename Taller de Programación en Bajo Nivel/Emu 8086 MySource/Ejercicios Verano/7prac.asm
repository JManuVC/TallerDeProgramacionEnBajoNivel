

org 100h
   

inicio:                  
     xor bx,bx           
     lea dx,cad          
     call leerCad 
     
     call saltoLinea
     call leerCarac
     mov bh,dl
     call leerCarac
     mov bl,dl
     
     lea di,cad 
     mov [di],50
     inc di
     mov cl,[di]
     inc di
     
     ciclo:
        cmp bh,[di]
        jne seguir
        mov [di],bl
        jmp show
        seguir:
            inc di 
        
     loop ciclo
     show:
        call saltoLinea
        lea si,cad
        inc si
        mov cl,[si]
        inc si
        
        ciclo2:
          mov dl,[si]
          call showCarac
          inc si
        loop ciclo2
        mov [si],24h
        
        
            
     
    
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


