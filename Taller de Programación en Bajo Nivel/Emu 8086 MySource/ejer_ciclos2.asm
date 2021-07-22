
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; Capturar un num si y solo si es multiplo de 3 y mostrar la mitad de veces que indica el num

org 100h
inicio:
    mov ah,1
    int 21h
    
    mov ah,0
    mov bh,3 
    sub al,30h
    mov dl,al
    div bh
    cmp ah,0
    je mostrar
    jmp fin
mostrar:
    mov bh,2
   ; mov al,dl
    div bh
    mov cl,al
    sub cl,30h
ciclo:
    mov ah,2
    int 21h
    loop ciclo
fin: int 20h
    


ret        

;sol
org 100h

inicio:

mov ah,7
int 21h
sub al,30h
mov bl,al

mov ah,0
mov dl,3
div dl
cmp ah,0
je multiploTRES
jmp inicio

multiploTRES:

mov dl,bl
add dl,30h
mov ah,2
int 21h

mov ax,0
mov al,bl
mov dl,2
div dl
mov cx,0
mov ah,0
mov cx,ax
mov dl,bl
add dl,30h

ciclo:
mov ah,2
int 21h
loop ciclo

fin:int 20h
;sol
org 100h
inicio: 
    mov ah,7
    int 21h 
    sub al,30h 
    mov bl,al
    mov ah,0
    mov bh,3
    div bh
    cmp ah,0
    je mos
    jmp inicio
mos:mov ah,2
    mov dl,bl
    add dl,30h
    int 21h
    mov dl,20h
    int 21h
    mov ax,0
    mov al,bl
    mov cl,2
    div cl
    mov cl,al
    mov ah,2
    mov dl,bl
    add dl,30h
sa1:int 21h
    loop sa1    
fin:int 20h




