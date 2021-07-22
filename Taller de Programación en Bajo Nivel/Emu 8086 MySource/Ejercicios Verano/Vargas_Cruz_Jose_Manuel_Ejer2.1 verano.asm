
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

inicio:
       mov ah,1
       int 21h 
       
        
       
       mov bl,al
       push bx
       mov ah,2
       mov dl,' '
       int 21h 
       
       mov ah,1
       int 21h 
       
       
        
       mov bl,al
       push bx
      mov ah,2
       mov dl,' '
       int 21h 
       mov ah,1 
       int 21h
       mov bl,al
       push bx 
       
       mov ah,2
    mov dl,13
    int 21h
    
    mov dl,10
    int 21h 
      mov ah,2
    mov dl,13
    int 21h
    
    mov dl,10
    int 21h
       
       mov bx,0
       pop bx
       mov dl,bl
       mov ah,2
       int 21h  
       
        mov ah,2
    mov dl,13
    int 21h
    
    mov dl,10
    int 21h    
    mov ah,2
    mov dl,13
    int 21h
    
    mov dl,10
    int 21h
       
       mov bx,0
       pop bx
       mov dl,bl
       mov ah,2
       int 21h
       
        mov ah,2
    mov dl,13
    int 21h
    
    mov dl,10
    int 21h    
      mov ah,2
    mov dl,13
    int 21h
    
    mov dl,10
    int 21h
       
       mov bx,0
       pop bx
       mov dl,bl
       mov ah,2
       int 21h
            
            
fin: int 20h






