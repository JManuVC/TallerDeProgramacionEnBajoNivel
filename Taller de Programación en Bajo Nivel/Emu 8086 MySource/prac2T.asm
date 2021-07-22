saveNum macro dig
    local for
    push ax
    push cx
    push dx
    mov cx,dig
    mov bx,10
    mov dx,0
    push dx
    for:
        mov ah,7
        int 21h
        cmp al,'0'
        jb  for
        cmp al,'9'
        ja  for
        mov dl,al
        mov ah,2
        int 21h
        pop ax
        sub dl,30h
        mov dh,0
        push dx
        mov dx,0
        mul bx
        pop dx
        add ax,dx
        push ax
        loop for
    pop bx    
    pop dx
    pop cx
    pop ax
endm
printMsg macro msg
    push ax
    push dx
    mov dx,offset msg
    mov ah,9
    int 21h
    pop dx
    pop ax    
endm

printNum macro reg,base
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



printChar macro char
    push ax
    push dx
    mov ah,2
    mov dl,char
    int 21h
    pop dx
    pop ax
endm

org 100h
begin:
    printMsg msg
    printMsg date
    printMsg form
    printChar 13
    printMsg date
    saveNum 2
    printChar '-'
    mov cx,0
    mov cl,bl
    mov ax,bx
    saveNum 2
    printChar '-'
    mov dx,0
    mov dl,bl
    shl bx,5
    or  ax,bx
    saveNum 4
    push bx
    sub bx,1950
    shl bx,9
    or  ax,bx
    pop bx
    printMsg bin
    printMsg date
    printNum ax,2
    printMsg year
    printNum bx,2
    printMsg month
    printNum dx,2
    printMsg day
    printNum cx,2
    printMsg hex
    printMsg date
    printNum ax,16
    printMsg year
    printNum bx,16
    printMsg month
    printNum dx,16
    printMsg day
    printNum cx,16
    
finish:
    int 20h
    
msg db 'Ingrese la fecha en formato DD-MM-AAAA',10,13,24h
day db 10,13,'Dia: $'
month db 10,13,'Mes: $'
year db 10,13,'A¤o: $'
date db 'Fecha: $'
form db '__-__-____$'
bin db 10,10,13,'Binario:',10,13,'$'
hex db 10,10,13,'Hexadecimal:',10,13,'$'
