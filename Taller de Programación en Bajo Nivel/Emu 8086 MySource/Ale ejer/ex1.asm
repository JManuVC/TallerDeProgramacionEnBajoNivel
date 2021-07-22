range macro ini,fin
    local fail
    mov bh,0
    cmp al,ini
    jb  fail
    cmp al,fin
    ja  fail
    mov bh,1
    fail:
endm   

intercale macro var1,var2
    local bucle,fillDi,fillSi,next
    mov si,offset var1
    mov di,offset var2   
    bucle:
        cmp [si],0
        je  fillDi
        print [si]
        inc si
        cmp [di],0
        je  fillSi
        print [di]
        inc di
        jmp bucle
    fillDi:
        print0 di
        jmp next
    fillSi:
        print0 si
    next:
endm

print macro char
    push dx
    push ax
    mov dx,char
    mov ah,2
    int 21h
    pop ax
    pop dx
endm
     
print0 macro pointer
    local bucle,break
    bucle:
        cmp [pointer],0
        je  break
        print [pointer]
        inc pointer
        jmp bucle
    break:
endm

org 100h
inicio:
    mov cx,50
    mov si,offset num
    mov di,offset cap   
    mov bp,offset low
    push si
    mov si,offset weird
    bucle:
        mov ah,1
        int 21h
        cmp al,13
        je  enter1
        range '0','9'
        cmp bh,1
        je  numb
        range 'A','Z'
        cmp bh,1
        je  capt
        range 'a','z'
        cmp bh,1
        je  lowe
        mov [si],al
        inc si
        jmp looop
    numb:
        mov dx,si
        pop si
        mov [si],al
        inc si   
        push si
        mov si,dx
        jmp looop
    capt:
        mov [di],al
        inc di
        jmp looop
    lowe:   
        mov [bp],al
        inc bp
        jmp looop
    looop: 
        loop bucle
    print 13
enter1:
    print 10
    intercale num,cap
    call saltolinea
    intercale low,weird
fin:
    int 20h
             
saltoLinea proc
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    ret                
endp

num db 50 dup(0)
cap db 50 dup(0)
low db 50 dup(0)
weird db db 51 dup(0)