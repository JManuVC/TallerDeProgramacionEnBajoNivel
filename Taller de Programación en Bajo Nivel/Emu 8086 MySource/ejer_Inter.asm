
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; capturar 2 num. y mostrar la suma de ambos si el primero es par

org 100h

inicio: 
    mov ah,1
    int 21h
    
    mov ch, al
    
    int 21h
    cmp ch,al
    ja sumar
    jmp fin
    sumar:
        sub ch,30h
        sub al,30h
        add ch,al
        add ch,30h
        mov ah,2
        int 21h
fin: int 20h
        

ret  
;sol

org 100h
        mov ah,1
        int 21h
        mov bh,al
        sub bh,30h
        mov ah,1
        int 21h
        sub al,30h
        mov bl,al
        mov ch,2
        mov ax,0
        mov al,bh
        div ch
        cmp ah,0
        je esPar
        jmp fin
    esPar:
        add bh,bl
        mov dl,bh
        add dl,30h
        mov ah,2
        int 21h
fin: int 20h


