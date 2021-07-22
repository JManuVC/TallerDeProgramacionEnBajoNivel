
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
 ;2) 14.10.2020
org 100h

inicio:
    mov cx,10
    mov ah,7
ciclo:    
    int 21h
    cmp al,'a'
    jb inicio
    cmp al,'z'
    ja inicio
    push ax
    loop ciclo
     

ret




