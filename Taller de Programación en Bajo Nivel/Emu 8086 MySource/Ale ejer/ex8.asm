saveLet macro 
    push ax
    push bx
    push cx
    push dx
    while:
    mov ah,7
    int 21h
    cmp al,13
    je  break
    cmp al,'a'
    jb while
    cmp al,'z'
    ja while
    mov dl,al
    mov ah,2
    int 21h
    saveCad al
    jmp while
    break:
    pop dx
    pop cx
    pop bx
    pop ax
endm

saveCad macro char
    local while,assign
    mov si,offset let
    mov di,offset cnt
    while:
    cmp [si],0
    je  assign
    cmp [si],char
    je assign
    inc si
    inc di
    jmp while
    assign:
    mov [si],char
    inc [di] 
endm

getNum macro char
    local while,assign
    mov si,offset let
    mov di,offset cnt
    mov dx,0
    while:
    cmp [si],0
    je  val
    cmp [si],char
    je val
    inc si
    inc di
    jmp while
    val:
    mov dl,[di]
endm

print macro
    local while,break
    getNum dl
    mov si,offset let
    while:
    cmp [si],0
    je  break
    printFor [si],dx
    jmp while
    break:
endm

printFor macro let,num
    push ax
    push cx
    push dx
    mov cx,num
    mov ah,2
    for:
    mov dl,let
    int 21h
    mov dl,20h
    int 21h
    loop for
    pop dx
    pop cx
    pop ax
endm 
 
inputLetter macro chat
    local verif
    push ax
    push dx
    verif:
        mov ah,7
        int 21h
        cmp al,'a'
        jb  verif
        cmp al,'z'
        ja verif
        mov dl,al
        mov ah,2
        int 21h
    pop dx
    pop ax
endm    

org 100h

begin:
    saveLet
    inputLetter
    print
finish:
    int 20h

let db 27 dup(0)
cnt db 27 dup(0)