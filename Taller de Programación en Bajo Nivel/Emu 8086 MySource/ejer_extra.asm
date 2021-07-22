
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

inicio:
    mov ah,7
    int 21h   
    cmp al,'A'
    jb inicio
    cmp al,'Z'
    ja inicio  
    
    mov dl,al
    mov ah,2
    int 21h   
    
    mov cx,10
ciclo:
    inc dl
    int 21h
    loop ciclo
    
fin: int 20h

ret




