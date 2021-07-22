
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt  


convertPrintNum macro reg,base   ;convierte un registro a una base dada
    local while,break,for,show
    push ax
    push bx
    push cx
    push dx
    mov ax,reg
    mov bx,base
    mov cx,1
    while:
        cmp ax,bx
        jb  break
        mov dx,0
        div bx
        push dx
        inc cx
        jmp while
    break:
    push ax
    mov ah,2
    for:
        pop dx
        add dl,30h
        cmp dl,'9'
        jbe show
        add dl,7h
        show:
        int 21h
        loop for
    pop dx
    pop cx
    pop bx
    pop ax
endm


org 100h
inicio:     
mov al,30
convertPrintNum ax,16

fin:int 20h



ret




