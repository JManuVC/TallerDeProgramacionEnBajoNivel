
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
 
 ;Dados 2 num. restarlos si el primero es par, caso contrario sumarlos
org 100h

inicio:
    mov dh,5
    mov dl,3 
    mov bh,2
    mov ax,0  
    mov al,dh
    div bh
    
    cmp ah,0
    je restar
    jmp sumar
restar:
    sub dh,dl
    jmp fin
sumar:
    add dh,dl
fin: int 20h

ret




