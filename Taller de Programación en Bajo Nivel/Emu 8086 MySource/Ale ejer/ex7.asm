
printChar macro char
    push ax
    push dx
    mov ah,2
    mov dl,char
    int 21h
    pop dx
    pop ax
endm

sortAsc macro reg1,reg2
    local break
    xchg reg1,reg2
    break:
endm

acum macro var
    push si
    push ax
    mov si,offset var
    mov ah,0
    add [si],ax
    pop ax 
    pop si    
endm
 
isMinor macro slot1,slot2
    local fin
    push ax
    push bx
    push cx
    mov dl,1
    mov si,slot1
    mov di,slot2
    mov bx,[si]
    mov cx,[di]
    cmp bx,cx
    jb  fin
    mov dl,0
fin:
    pop cx
    pop bx
    pop ax
endm

myDiv16 macro num,divd
    push ax
    push bx
    push dx
    mov bx,divd
    mov ax,num
    mov dx,0
    div bx
    mov num,ax
    pop dx
    pop bx
    pop ax
endm

printVar macro pointer,lim
    local while,break
    push dx
    mov si,pointer
    while:
        mov dl,[si]
        cmp dl,lim
        je  break
        printChar dl
        inc si
        jmp while
    break:    
    pop dx
endm

org 100h
begin:
    mov si,offset num
    mov di,offset let
    mov bp,offset chr
    mov bl,0
    mov bh,0
    mov dh,0
    mov cx,50
    mov ah,1
    for1:
        int 21h
        cmp al,13
        je  enter1
        cmp al,30h
        jb  char1
        cmp al,3Ah
        jb  num1
        cmp al,41h
        jb  char1
        cmp al,5Bh
        jb  let1
        cmp al,61h
        jb  char1
        cmp al,7Bh
        jb  let1
    char1:
        mov [bp],al
        inc bp
        acum chrCnt
        inc bl
        jmp nextfor
    num1:
        mov [si],al
        inc si
        acum numCnt
        inc bh
        jmp nextfor
    let1:
        mov [di],al
        inc di
        acum letCnt
        inc dh
        jmp nextfor
    nextfor:    
        printChar 20h
        loop for1
        printChar 13
enter1:
    printChar 10
    mov ax,0
    mov al,dh
    push ax
    mov al,bh
    push ax
    mov al,bl
    ;prom
    mov si,offset chrCnt
    myDiv16 [si],ax
    mov bx,si
    mov si,offset numCnt
    pop ax
    myDiv16 [si],ax
    mov cx,si
    mov si,offset letCnt
    pop ax
    myDiv16 [si],ax
    mov ax,si
    ;sort
    isMinor ax,bx
    cmp dl,1
    je  jump1
    xchg ax,bx
jump1:
    isMinor ax,cx
    cmp dl,1
    je  jump2
    xchg ax,cx
jump2:
    isMinor bx,cx
    cmp dl,1
    je  jump3
    xchg bx,cx
jump3:
    push ax
    push bx
    push cx
    mov cx,3
    for2:
        pop ax
        add ax,2
        printVar ax,0
        loop for2
    
finish:
    int 20h
    
numCnt dw 0
num db 50 dup (0)
letCnt dw 0
let db 50 dup (0)
chrCnt dw 0
chr db 51 dup (0)