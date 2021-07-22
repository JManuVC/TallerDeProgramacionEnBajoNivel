
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
       ; capturar 2 num, restar si el 1ro es mayor, sumarlos si el 2do es par
org 100h

inicio:
    mov ax,0
    mov ah,1
    int 21h
    
    mov ch,al
    
    int 21h
    cmp ch,al
    ja restar
    jmp esPar
    
    restar:
        sub ch,30h
        sub al,30h
        
        sub ch,al
        add ch,30h
        jmp fin
    esPar:
        mov ax,0
        mov cl,2
        mov bh,al
        div ch
        cmp ah,0
        je sumar
        jmp fin
    sumar: 
        sub bh,30h
        sub ch,30h
        add bh,ch
        sub bh,30h
        mov dl,bh
        mov ah,2
        int 21h
fin: int 20h  

ret

; otra sol

org 100h
        mov ah,1
        int 21h
        mov bh,al
        sub bh,30h
        mov ah,1
        int 21h
        sub al,30h
        mov bl,al
        cmp bh,bl
        ja resta
        mov ch,2
        mov ax,0
        mov al,bh
        div ch
        cmp ah,0
        je esPar
        jmp fin
        
 resta:
        sub bh,bl
        mov dl,bh
        add dl,30h
        mov ah,2
        int 21h
        jmp fin
        
 esPar:
        add bh,bl
        mov dl,bh
        add dl,30h
      
fin: int 20h 

