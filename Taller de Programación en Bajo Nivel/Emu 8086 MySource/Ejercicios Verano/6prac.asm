

org 100h

inicio:
     
     xor cx,cx
     lea di,cad1
    sig:
     call leerCarac
     cmp al,13
     jne sig
     
     
     
     seguir:
     call saltoLinea 
     lea si,cad2
     dec di
     ciclo:
        mov bl,[di]
        mov [si],bl
        inc si
        dec di
        loop ciclo
        
        mov ah,9
        lea dx,cad2
        int 21h
     
     
     
fin: int 20h 
cad1 db 50 dup ('$')
cad2 db 50 dup ('$')
proc leerCarac
    mov ah,7
    otro:
          
          int 21h
          
          cmp al,13
          je break
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
          mov [di],al    
          inc di  
          inc cl
          call showCarac  
          
        break:  
          
          
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


