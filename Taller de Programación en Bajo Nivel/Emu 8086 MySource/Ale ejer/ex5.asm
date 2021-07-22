saveNum macro
    local while
    push ax
    while:
    mov ah,7
    int 21h
    cmp al,'0'
    jb while
    cmp al,'9'
    ja while
    mov ah,2
    mov dl,al
    int 21h
    sub dl,30h
    pop ax
endm

saveNum2dig macro var
    local for,break
    push ax
    push dx
    push cx
    push bx
    mov bl,10
    mov cx,2
    push 0
    for:
        mov ah,7
        int 21h
        cmp al,13
        je break
        cmp al,'0'
        jb for
        cmp al,'9'
        ja for
        mov dl,al
        mov ah,2
        int 21h
        sub dl,30h
        pop ax
        mul bl
        add al,dl
        push ax
        loop for    
    break:
        pop ax
        mov var,al
    pop bx
    pop cx
    pop dx
    pop ax    
endm

saveOp macro var
    local verif,break
    push ax
    push dx
    verif:
    mov ah,7
    int 21h
    cmp al,'+'
    je break
    cmp al,'-'
    je break
    cmp al,'*'
    je break
    cmp al,'/'
    jne verif
    break:
    mov ah,2
    mov dl,al
    mov var,dl
    int 21h
    pop dx
    pop ax
endm


printStr macro var
    push ax
    push dx
    mov ah,9
    mov dx,offset var
    int 21h
    pop dx
    pop ax    
endm

printChar macro char
    push ax
    push dx
    mov dl,char
    mov ah,2
    int 21h
    pop dx
    pop ax
endm

printNum macro reg,base
    local while,break,for,pass
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
        jb  pass
        add dl,7h
        pass:
        int 21h
        loop for    
    pop dx
    pop cx
    pop bx
    pop ax    
endm

org 100h
begin:
    printStr menu
    saveNum
    cmp dl,1
    je  ingNum
    cmp dl,2
    je  ingOp
    cmp dl,3
    je  show
    jmp begin
    ingNum:
    printStr num1
    saveNum2dig n1
    printStr num2
    saveNum2dig n2
    printChar 10
    printChar 13
    jmp begin
    ingOp:
    printStr opMsg
    saveOp op
    printChar 10
    printChar 13
    jmp begin
    show:
    mov dl,op
    cmp dl,0
    je  begin
    mov ax,0
    mov al,n1
    mov bl,n2
    cmp dl,'+'
    je  sum
    cmp dl,'-'
    je  rest
    cmp dl,'*'
    je  por
    div bl
    mov ah,0
    jmp show2
    por:
    mov dx,0
    mul bx
    jmp show2
    sum:
    add al,bl
    jmp show2
    rest:
    cmp al,bl
    jb  show3
    sub al,bl
    show2:
    printStr res
    printNum ax,2
    printStr oct
    printNum ax,8
    printStr deci
    printNum ax,10
    printStr hex
    printNum ax,16
    jmp finish
    show3:
    sub bl,al
    mov bh,0
    printStr res
    printChar '-'
    printNum bx,2
    printStr oct
    printChar '-'
    printNum bx,8
    printStr deci
    printChar '-'
    printNum bx,10
    printStr hex
    printChar '-'
    printNum bx,16
    
finish:
    int 20h
    
menu db '1 Ingreso de numeros',10,13
     db '2 Ingreso de operacion',10,13
     db '3 Mostrar resultado',10,13,24h
num1  db 10,13,'Numero1: $'
num2  db 10,13,'Numero2: $'
opMsg   db 10,13,'Operador: $'
res  db 10,13,'Resultado: ',10,13
     db 'Binario: $'
oct  db 10,13,'Octal: $'
deci db 10,13,'Decimal: $'
hex  db 10,13,'Hexadecimal: $'
n1   db 0
n2   db 0
op   db 0    