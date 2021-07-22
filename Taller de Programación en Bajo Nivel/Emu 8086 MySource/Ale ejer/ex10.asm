saveCantNum macro cant,var
    local for
    push ax
    push bx
    push cx
    push dx
    mov cx,cant
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
        mov bx,var
        inc bx
        mov var,bx
        loop for
    pop dx
    pop cx
    pop bx
    pop ax    
endm

saveNum macro dig,var
    local for,break
    push ax
    push bx
    push cx
    push dx
    mov cx,dig
    for:
        mov ah,7
        int 21h
        cmp al,13
        je  break
        cmp al,'0'
        jb  for
        cmp al,'9'
        ja  for
        mov dl,al
        mov ah,2
        int 21h
        mov bx,var
        inc bx
        mov var,bx
        loop for
    break:
    pop dx
    pop cx
    pop bx
    pop ax
    
endm

saveLet macro cant,varC,varA
    local for,break,pass
    push ax
    push bx
    push cx
    push dx
    mov cx,cant
    for:
        mov ah,7
        int 21h
        cmp al,13
        je  break
        cmp al,' '
        je pass
        cmp al,'A'
        jb  for
        cmp al,'Z'
        ja  for
        mov ah,0
        add varA,ax
        inc varC
        pass:
        mov dl,al
        mov ah,2
        int 21h
        loop for
    break:
    pop dx
    pop cx
    pop bx
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
    mov ah,2
    mov dl,char
    int 21h
    pop dx
    pop ax    
endm

printVal macro num
    local while,break,for
    push ax
    push bx
    push cx
    push dx
    mov ax,num
    mov bx,10
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
        int 21h
        loop for
    pop dx
    pop cx
    pop bx
    pop ax
    
endm

org 100h
begin:
    printStr nit
    saveNum 10,cnt
    printStr nroFact
    saveNum 15,cnt
    printStr nroAut
    saveNum 15,cnt
    printStr nomCli
    saveLet 30,numLet,acum
    printStr fecha
    saveCantNum 2,cnt
    printChar '/'
    saveCantNum 2,cnt
    printChar '/'
    saveCantNum 4,cnt
    printStr cod
    mov ax,acum
    mov bx,numLet
    mov dx,0
    div bx
    printChar al
    mov ax,cnt
    add ax,bx
    printVal ax
finish:
    int 20h
 
nit     db 'NIT: $'
nroFact db 10,13,'Nø Factura: $'
nroAut  db 10,13,'Nø Autorizacion: $'
nomCli  db 10,13,'Nombre: $'
mont    db 10,13,'Monto: $'
fecha   db 10,13,'Fecha: $'
cod     db 10,10,13,'Codigo: $'
cnt     dw 0
numLet  dw 0
acum    dw 0