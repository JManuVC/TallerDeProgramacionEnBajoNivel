
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

;capturar dos num y mostrar sus tablas de suma
org 100h
     mov ah,1
     int 21h
     mov bl,al
     sub bl,30h
     int 21h
     mov bh,al
     
     call salto_linea
     
     mov cl,bl
     call mostrar_tabla
     
     call salto_linea
     
     mov cl,bh
     call mostrar tabla
fin:int 20h
proc salto_linea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    ret
salto_linea endp

proc mostrar_tabla
    mov bl,cl
    mov cx,9
    mov ch,1
    mov ah,2
    mov dl,bl
    int 21h
    mov dl,'+'
    int 21h
    mov dl,ch
    int 21h
    mov 




