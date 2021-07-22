binario macro pbh
    mov si,offset bin
    local ciclo
        mov al, pbh
    ciclo:
        mov dl,18h
        rol al,1
        rcl dl,1
        push ax
        mov [si],dl
        
        pop ax
        inc si
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
    mov dx,offset bin
    mov ah,9
    int 21h
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

bin db '00000000$'




