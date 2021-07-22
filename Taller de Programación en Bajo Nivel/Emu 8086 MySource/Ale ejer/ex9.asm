printStr macro var
    push ax
    push dx
    mov ah,9
    mov dx,offset var
    int 21h
    pop dx
    pop ax    
endm

saveNum macro
    local while,n1,fin
    push ax
    mov ah,7
    int 21h
    cmp al,'1'
    je n1
    cmp al,'2'
    jne while
    mov dh,2
    jmp fin
    n1:
    mov dh,1
    fin:
    mov dl,al
    mov ah,2
    int 21h
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

saveLetters macro point,exc,lim
    local for,break,empty,fin
    push ax
    push cx
    mov cx,lim
    mov dh,0
    for:
        mov ah,7
        int 21h
        cmp al,exc
        je break
        cmp al,13
        je  empty
        cmp al,'a'
        jb for
        cmp al,'z'
        ja for
        mov ah,2
        mov dl,al
        mov [si],al
        inc si
        int 21h
        loop for
    empty:
        cmp cx,lim
        jne for
        mov dh,1
        jmp fin    
    break:
        mov dl,al
        mov [si],al
        mov ah,2
        int 21h
    fin:    
    pop cx
    pop ax    
endm

jmpF macro tag
    cmp dl,0
    je tag
endm

jmpT macro tag
    cmp dl,1
    je tag
endm

asignCharge macro point,charge
    local n1,n2,n3,n4,n5,n6,n7,n8,n9,fin
    compare admin,charge
    jmpF n1
    mov [point],1
    jmp fin
n1:
    compare anl,charge
    jmpF n2
    mov [point],2
    jmp fin
n2:    
    compare ast,charge
    jmpF n3
    mov [point],3
    jmp fin
n3:    
    compare aux,charge
    jmpF n4
    mov [point],4
    jmp fin
n4:           
    compare caj,charge
    jmpF n5
    mov [point],5
    jmp fin
n5:    
    compare fnc,charge
    jmpF n6
    mov [point],6
    jmp fin
n6:    
    compare grnt,charge
    jmpF n7
    mov [point],7
    jmp fin
n7:    
    compare opd,charge
    jmpF n8
    mov [point],8
    jmp fin
n8:
    compare sup,charge
    jmpF n9
    mov [point],10
    jmp fin
n9:
    mov [point],9
fin:
endm

compare macro var,charge
    local while,break
    push si
    push di
    mov si,offset var
    mov di,offset charge
    mov dl,0
    while:
        mov bh,[si]
        cmp bh,[di]
        jne break:
        inc si
        inc di
        cmp bh,'$'
        jne while
        mov dl,1
    break:
    pop di
    pop si   
endm

sortCharge macro
    
endm

sortName macro
    
endm

printName macro pointer
    local while1,break1
    mov si,pointer
    while1:
        mov al,[si]
        cmp al,'-'
        je  break1
        
        jmp while1
    break1:
        printChar '-'    
endm

;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°

org 100h
begin:
    printStr msg
    call printEnter
    printChar '-'
    printStr grnt
    call printEnter
    printChar '-'
    printStr admin
    call printEnter
    printChar '-'
    printStr sup
    call printEnter
    printChar '-'
    printStr aux
    call printEnter
    printChar '-'
    printStr fnc
    call printEnter
    printChar '-'
    printStr ast
    call printEnter
    printChar '-'
    printStr anl
    call printEnter
    printChar '-'
    printStr caj
    call printEnter
    printChar '-'
    printStr opd
    call printEnter
    printChar '-'
    printStr otro
    call printEnter
    printStr msgEnd
    call printEnter
    mov cx,30
    mov si,offset nombres
    mov di,offset pos
    for:
        printStr input
        mov [di],si
        add di,2
        saveLetters si,'-',15
        cmp dh,1
        je break
        push si
        mov si,offset charge
        saveLetters si,13,15
        pop si 
        asignCharge si,charge
        inc si
        call printEnter
        loop for
    break:
    printStr msgSort
    saveNum
    cmp dh,1
    je  sortN
    sortCharge
    jmp finish
    sortN:
    sortName    
finish:
    int 20h
    
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
printEnter proc
    push ax
    push dx
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    pop dx
    pop ax
    ret
printEnter endp
;²²²²²²²²²²²²²²²²²²²²²DATA²²²²²²²²²²²²²²²²²²²
nombres db 501 dup('$')
charge db 16 dup('$')
pos dw 30 dup(0)
msg db 'Ingrese: nombre-cargo del empleo',10,13,'Los cargos pueden ser:$'
grnt db 'gerente$'
admin db 'administrativo$'
sup db 'supervisor$'
aux db 'auxiliar$'
fnc db 'financiero$'
ast db 'asistente$'
anl db 'analista$'
caj db 'cajero$'
opd db 'operador$'
otro db 'otro$'
msgEnd db 'Si el cargo no existe se asignar  como otro$'
input db 'Empleo: $'
msgSort db'Presione un numero:',10,13,'1 Ordenar por nombre',10,13,'2 Ordenar por cargo',10,13,'$'