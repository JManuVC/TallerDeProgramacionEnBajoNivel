printValue macro num
    local bucle1,bucle2,break
    push ax
    push bx
    push cx
    push dx
    mov ax,num
    mov cx,1
    mov bx,10
    bucle1:
        cmp ax,bx
        jb  break
        mov dx,0
        div bx
        push dx
        inc cx
        jmp bucle1
break:
    push ax
    mov ah,2
    bucle2:
        pop dx
        add dx,30h
        int 21h
        loop bucle2
    pop dx
    pop cx
    pop bx
    pop ax    
endm
         
printVarValue macro var,lim
    local bucleP,finPrint
    push ax
    mov si,offset var
    bucleP:
        mov ax,[si]
        cmp ax,lim
        je  finPrint
        printValue ax
        printChar 10
        printChar 13 
        add si,2
        jmp bucleP
    finPrint:
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
                mov cx,50
                mov si,offset par
                mov di,offset npr
                mov bp,offset pri
                bucle:
                    call saveNum
                    cmp dl,1
                    je  enter
                    call isPrime
                    cmp dl,0
                    je  pair1
                    mov [bp],ax
                    add bp,2
                    jmp for1
                pair1:
                    call isImpair
                    cmp dl,1
                    je impair1
                    mov [si],ax
                    add si,2
                    jmp for1
                impair1:
                    mov [di],ax
                    add di,2
                    for1: 
                    loop bucle
                enter:
                    printVarValue pri,1000
                    printVarValue par,1000
                    printVarValue npr,1000
                              
            finish:
                int 20h
                
; num is ax
; cx is lim                 
isPrime proc
    push bx
    push cx
    cmp ax,2
    jb  nonprime
    mov bx,2
    mov cx,ax
    bucle1:
        push ax
        cmp bx,cx
        jnb prime
        mov dx,0
        div bx
        cmp dx,0
        je  nonprime
        mov cx,ax
        inc bx
        pop ax
        jmp bucle1
    prime:
        mov dl,1
        jmp fin
    nonprime:
        mov dl,0
        jmp fin
    fin:
    pop ax    
    pop cx
    pop bx
    ret    
isPrime endp      

;guarda en ax
saveNum proc
    push bx
    push cx
    mov cx,3
    mov bx,10
    mov dx,0
    push dx
    bucle2:
        mov ah,7
        int 21h
        cmp al,13
        je  enter2
        cmp al,'0'
        jb  bucle2
        cmp al,'9'
        ja  bucle2
        mov dl,al
        mov ah,2
        int 21h
        sub dl,30h
        pop ax
        push dx
        mov dx,0
        mul bx
        pop dx
        add ax,dx
        push ax
        loop bucle2
enter2:
    mov dx,0
    printChar 13
    printChar 10
    cmp cx,3
    jne pass
    mov dl,1
    pass:
    pop ax
    pop cx
    pop bx   
    ret
saveNum endp
          
isImpair proc
    push ax
    mov dl,1
    shr ax,1
    jc  impar
    mov dl,0
    impar:
    pop ax           
    ret
isImpair endp              
       
bool proc
    push ax
    push dx
    mov ah,9
    cmp dl,1
    je true
    mov dx,offset f
    jmp done
    true:
    mov dx,offset t
    done:
    int 21h
    pop dx
    pop ax
    ret
bool endp

par dw 50 dup(1000)
npr dw 50 dup(1000)
pri dw 51 dup(1000)
t db 'true',10,13,'$'
f db 'false',10,13,'$'

