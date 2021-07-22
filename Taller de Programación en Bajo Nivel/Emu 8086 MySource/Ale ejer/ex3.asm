
capture2 macro reg
    push ax
    call capture1
    mov reg,al
    shl reg,4
    call capture1
    or  reg,al
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

sortAsc macro reg1,reg2 
    local fin
    cmp reg1,reg2
    jb  fin
    xchg reg1,reg2
    fin:        
endm

printInBase macro reg,base
    local digits, minor,num,show
    push ax
    push bx
    push cx
    push dx
        mov al,reg
        mov bl,base
        mov ah,0
        mov cx,1
        mov dx,0
        digits:    
            cmp al,bl
            jb  minor
            mov bh,0
            div bl
            mov dl,ah
            mov ah,0
            push dx
            inc cx
            jmp digits
    minor:       
        push ax
        mov ah,2
        show:
            pop dx
            cmp dl,10
            jb  num
            add dl,7
        num:
            add dl,30h
            int 21h
            loop show
    pop dx
    pop cx
    pop bx
    pop ax
endm

printVar macro var
    push ax
    push dx
        mov ah,9
        mov dx,offset var
        int 21h
    pop dx
    pop ax
endm

org 100h
begin:
    mov bh,0
    mov ch,0
    printVar msg 
    capture2 bl
    printChar ' '
    capture2 cl
    printChar ' '
    capture2 dl
    printChar ' '
    ;sortAsc bl,cl
    ;sortAsc bl,dl
    ;sortAsc cl,dl
    cmp bl,cl
    jb  fin1
    xchg bl,cl
fin1:
    cmp bl,dl
    jb  fin2
    xchg bl,dl
fin2:
    cmp cl,dl
    jb  fin3
    xchg cl,dl
fin3:
    push bx
    push cx
    printVar may
    printInBase dl,2
    pop dx
    printVar mid
    printInBase dl,10
    pop dx
    printVar min
    printInBase dl,8
finish:
    int 20h
    
capture1 proc
    push dx
    while1:
    mov ah,7
    int 21h
    cmp al,'0'
    jb  while1
    cmp al,'9'
    jbe pass
    cmp al,'A'
    jb  while1
    cmp al,'F'
    ja  while1
    pass:
    mov dl,al
    mov ah,2
    int 21h
    pop dx
    sub al,30h
    cmp al,10
    jb  endProc
    sub al,7
endProc:         
    ret
capture1 endp    
             
msg db 'Ingrese tres numeros hexadecimales de dos digitos: $'             
may db 10,13,'Mayor: $'
mid db 10,13,'Medio: $'
min db 10,13,'Menor: $'