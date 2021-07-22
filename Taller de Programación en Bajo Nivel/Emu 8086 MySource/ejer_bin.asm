
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
;capturar un num y mostrarlo en binario
binario macro pbh
    local ciclo
        mov al, pbh
    ciclo:
        mov dl,18h
        rol al,1
        rcl dl,1
        push ax
        
        int 21h
        pop ax
        loop ciclo
endm
org 100h

inicio: 
    mov ah,1
    int 21h
    mov bh,al
    sub bh,30h
    call salto
    
    mov cx,8
    binario bh
fin: int 20h
proc salto 
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    ret
salto endp

ret




