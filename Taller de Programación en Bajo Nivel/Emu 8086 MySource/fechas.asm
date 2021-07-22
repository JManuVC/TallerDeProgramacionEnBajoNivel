
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

inicio:
    mov ax,0
    mov bx,60 ;aa
    mov cx,12 ;mm
    mov dx,31 ;dd
    
    shl bx,9
    shl cx,5
    
    or ax,bx
    or ax,cx
    or ax,dx
    
    mov bx,ax
    mov cx,8 
    mov al,bh
    call binario
    mov cx,8
    mov al,bl
    call binario
fin: int 20h

ret         

proc binario
        mov ah,2
        ciclo:
            mov dl,18h
            rol al,1
            rcl dl,1
            push ax
            int 21h
            pop ax
            loop ciclo
            ret
binario endp




