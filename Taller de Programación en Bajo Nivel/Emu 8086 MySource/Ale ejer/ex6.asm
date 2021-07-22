printStr macro var
    push ax
    push dx
    mov ah,9
    mov dx, offset var
    int 21h
    pop dx
    pop ax    
endm

inputLetter macro
    local enter,while,pass
    push ax
    push dx
    while:
        mov ah,7
        int 21h
        cmp al,13
        je  enter
        cmp al,' '
        je  pass
        cmp al,'A'
        jb  while
        cmp al,'['
        jb  pass
        cmp al,'a'
        jb  while
        cmp al,'z'
        ja  while
        pass:
        mov ah,2
        mov dl,al
        int 21h
        jmp while
    enter:
    pop dx
    pop ax    
endm

saveLetters macro var,lim
    local enter,for,pass
    push ax
    push dx
    push cx
    mov si, offset var
    mov cx,lim
    for:
        mov ah,7
        int 21h
        cmp al,13
        je  enter
        cmp al,' '
        je  pass
        cmp al,'a'
        jb  for
        cmp al,'z'
        ja  for
        pass:
        mov ah,2
        mov dl,al
        mov [si],dl
        inc si
        int 21h
        loop for
    enter:
    pop cx
    pop dx
    pop ax
endm

inputNum macro cnt
    local for
    push ax
    push cx
    push dx
    mov cx,cnt
    for:
        mov ah,7
        int 21h
        cmp al,'0'
        jb for
        cmp al,'9'
        ja for
        mov ah,2
        mov dl,al
        int 21h
        loop for
    pop dx
    pop cx
    pop ax
endm

inputNumDl macro
    local verif
    push ax
    push cx
    verif:
        mov ah,7
        int 21h
        cmp al,'0'
        jb verif
        cmp al,'9'
        ja verif
        mov ah,2
        mov dl,al
        int 21h
    pop ax
endm

telfCode macro
    local lp,sc,n4,n5,n6,n8,beni,potosi,chu,nn8,fin
    inputNumDl
    mov dh,0
    cmp dl,2
    je  lp
    cmp dl,3
    je sc
    cmp dl,4
    je n4
    cmp dl,5
    je n5
    cmp dl,6
    je n6
    cmp dl,8
    je n8
    inputNum 6
    jmp fin
    lp: 
        inputNum 6h ;2xx xxxx
        mov dh,1
        jmp fin
    sc:
        inputNum 6h ;3xx xxxx
        mov dh,2
        jmp fin
    n4:
        inputNumDl
        inputNum 5h
        cmp dl,6
        je beni:
            mov dh,3    ;4xx xxxx
            jmp fin     ;cocha
        beni:
            mov dh,4    ;46x xxxx
            jmp fin
    n5:
        inputNumDl
        inputNum 5h
        cmp dl,2     ;52x xxxx
        jne fin
        mov dh,5     ;oruro
        jmp fin
    n6:
        inputNumDl
        inputNum 5h
        cmp dl,2
        je  potosi
        cmp dl,4
        je  chu
        cmp dl,6
        jne fin
            mov dh,6    ;tarija
            jmp fin     ;66x xxxx
        potosi:
            mov dh,7    ;62x xxxx
            jmp fin
        chu:
            mov dh,8    ;64x xxxx
            jmp fin
    n8:
        inputNumDl
        cmp dl,4
        je  next
        inputNum 5h
        jmp fin:
        next:
        inputNumDl
        inputNum 4h
        cmp dl,2        ;842 xxxx
        jne fin
        mov dh,9
    fin:
endm

compare macro var1,var2
    local while,break
    push bx
    mov si,offset var1
    mov di,offset var2
    mov dl,0
    while:
        mov bh,[si]
        mov bl,[si]
        inc si
        inc di
        cmp bh,bl
        jne break
        cmp bh,'$' 
        jne while
        mov dl,1
    break:
    pop bx
endm

ifelse macro tag1,tag2
    cmp dl,1
    je  tag1
    jmp tag2
endm

org 100h
begin:
    printStr nom
    inputLetter
    printStr ape
    inputLetter
    printStr telf
    telfCode
    printStr ciu
    saveLetters city,10
    cmp dh,0
    je fail
    cmp dh,1
    jne next2
        compare city,lp
        ifelse pass,fail
    next2:
    cmp dh,2
    jne next3
        compare city,sc
        ifelse pass,fail
    next3:
    cmp dh,3
    jne next4
        compare city,co
        ifelse pass,fail
    next4:
    cmp dh,4
    jne next5
        compare city,be
        ifelse pass,fail
    next5:
    cmp dh,5
    jne next6
        compare city,oru
        ifelse pass,fail
    next6:
    cmp dh,6
    jne next7
        compare city,ta
        ifelse pass,fail
    next7:
    cmp dh,7
    jne next8
        compare city,po
        ifelse pass,fail
    next8:
    cmp dh,8
    jne next9
        compare city,chu
        ifelse pass,fail
    next9:
        compare city,pa
        ifelse pass,fail
    pass:
        printStr reg 
        jmp finish
    fail:
        printStr nreg    
finish:
    int 20h

city db 11 dup('$')    
nom db 'Nombre: $'
ape db 10,13,'Apellido(s): $'
telf db 10,13,'Telefono: $'
ciu db 10,13,'Ciudad: $'
reg db 10,13,'Registrado$'
nreg db 10,13,'Registro anulado$'
lp db 'la paz$'
sc db 'santa cruz$'
co db 'cochabamba$'
be db 'beni$'
oru db 'oruro$'
ta db 'tarija$'
po db 'potosi$'
chu db 'chuquisica$'
pa db 'pando$'

