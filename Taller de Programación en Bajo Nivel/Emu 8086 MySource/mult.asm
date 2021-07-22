
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

inicio:
    mov ax,0
    mov al,1
    add al,2
    add al,3
    mov bl,3
    mul bl
    
fin: int 20h


