
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

inicio: 
      xor cx,cx
      xor bx,bx
     lea di,cad
     
    otro:
           mov ah,7
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
          mov bl,al
          push bx
              
          inc di  
          inc cl
          call showCarac  
          
        
        
        jmp otro  
         break: 
    
     
     lea si,cad
     
     ciclo:
        pop bx
        cmp [si],bl
        jne noEs
        inc si
     loop ciclo 
     
        lea dx,msj
        call showCad
        jmp fin
     noEs:
      lea dx,msj2
      call showCad
        
    
fin:int 20h
cad db 50 dup ('$')
msj db 10,13,"Es palindrome$"
msj2 db 10,13,"No es palindrome$" 

proc showCad
    mov ah,9
    int 21h
    ret
showCad endp

 

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

