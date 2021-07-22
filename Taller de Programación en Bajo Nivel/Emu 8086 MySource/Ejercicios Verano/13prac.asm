

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
         
          cmp al,20h
          je continue
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
         lea si,cad2
         mov bl,[di] 
         cmp bl,'a'
         jnae cont
         sub bl,20h
         cont:
            mov [si],bl 
            inc di
            inc si
      ciclo:
             
             cmp [di],20h
            je conti
            jne saltar
           conti:  
               mov bl,[di]
               mov [si],bl
                     
                inc si
                inc di
                
                mov bl,[di] 
                cmp bl,'a'
                jnae sig
                sub bl,20h
             
             sig:
                mov [si],bl 
                inc si
                inc di
                jmp parar
             saltar:   
                
                mov bl,[di]
                mov [si],bl 
                inc di
                inc si 
              parar:
              
         loop ciclo 
          
         call saltoLinea
         lea dx,cad2
         call showCad
         
fin: int 20h

cad db 201 dup ('$')
cad2 db 201 dup ('$') 
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


