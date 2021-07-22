
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
  
  ;Dados 2 num. restarlos si el primero es mayor, caso contrario multiplicarlos
  
org 100h
    mov dh,4
    mov dl,2
    cmp dh,dl
    ja restar
    jmp mult
restar:
    sub dh,dl
    jmp fin
mult:
    mov ax,0
    mov al,dh
    mul dl
fin: int 20h


ret




