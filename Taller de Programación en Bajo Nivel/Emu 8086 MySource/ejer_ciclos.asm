
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

; capturar un num y mostrar el num de veces que inidica el mismo num
org 100h

inicio:
    mov ah,1
    int 21h
    mov cl,al
    sub cl,30h 
    mov dl,cl
ciclo:
    mov ah,2
    int 21h
    loop ciclo:
fin: int 20h
    

ret    

; otra sol
org 100h

inicio:
    mov ah,1        
    int 21h
    mov cl,al
    sub cl,30h
    mov dl,al
    mov ah,2
ciclo:
    int 21h
    loop ciclo   
fin: int 20h





