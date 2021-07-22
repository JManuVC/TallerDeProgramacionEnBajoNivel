
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
       
      
              
          inc di  
          inc cl
          call showCarac  
          
        jmp otro  
         break:
         
         lea di,cad
         
         ciclo:
         cmp [di],41h
         je contar
         cmp [di],61h
         je contar
         cmp [di],45h
         je contar
         cmp [di],65h
         je contar
         cmp [di],49h
         je contar
         cmp [di],69h
         je contar
         cmp [di],4Fh
         je contar
         cmp [di],6Fh
         je contar
         cmp [di],55h
         je contar
         cmp [di],75h
         je contar 
         jne saltar
         contar:
            inc bl
            
          saltar:
            inc di
            
         loop ciclo 
         call saltoLinea
         mov dl,bl
         add dl,30h
         call showCarac
    

fin:int 20h
cad db 50 dup ('$') 



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
    
    xor dx,dx
    pop ax
    ret
saltoLinea endp



