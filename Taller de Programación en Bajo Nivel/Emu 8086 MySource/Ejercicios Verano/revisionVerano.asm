
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

inicio:
    lea di,hola
    lea si,c
    mov cl,10
    xor dx,dx
    ciclo:
        mov bl,[si]
        cmp [di],bl
        jne seguir
            inc dl
        seguir:
        inc di
    loop ciclo
fin: int 20h
hola db "hola mundo$"
c db "a$"



