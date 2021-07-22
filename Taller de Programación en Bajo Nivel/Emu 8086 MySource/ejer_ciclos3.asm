
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

; capturar un num y mostrar solo los resultados de su tabla de suma
; ej: 2 345...
;     4 567...
org 100h
inicio:
    mov ax,0
    mov ah,1
    int 21h
    mov cx,10
ciclo:
    sub cl,


ret
      
;sol
org 100h
inicio:
    mov ah, 1
    int 21h 
    mov dl, al
    mov cx, 5
ciclo:             
    mov ah, 2 
    mov bh, 1
    add dl, bh
    add bh, 1 
    int 21h
    loop ciclo:
fin: int 20h   

;sol
org 100h

inicio:

mov ah,1
int 21h
mov ah,0
mov dl,al
mov dh,al
sub al,30h
mov cx,10


ciclo:
mov dl,dh
mov bx,10
sub bx,cx
add dl,bl
mov ah,2
int 21h
loop ciclo

fin:int 20h



