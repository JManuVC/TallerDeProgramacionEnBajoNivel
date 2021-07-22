
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; capturar un num y mostrar su tabla de suma
;2
;2+1=3
;
;2+10=12
;12/10 -> 1 como entero en al y el 2 como residuo en ah(no aplica a este programa)


org 100h
inicio: 
    mov ah,7
    int 21h
    
    cmp al,30h
    jb inicio
    cmp al,39h
    ja inicio
    
    mov ah,2
    mov dl,al
    int 21h  
    mov dl,'+'
    int 21h
    mov dl,'1'
    int 21h
    mov dl,'='
    int 21h
    mov dl,'3'
    int 21h 
fin: int 20h


ret




;hace lo mismo pero de otra forma
org 100h
inicio:
    mov ah,7
    int 21h
    cmp al,30h
    jb inicio
    cmp al,39h
    ja inicio
    mov dl,al
    mov ah,2
    mov cx,10 
    mov bh,al
    mov bl,31h
    mov dh,al
    inc dh 
    int 21h  
ciclo:
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    mov dl,bh
    int 21h
    mov dl,'+'
    int 21h
    mov dl,bl
    int 21h 
    mov dl,'='
    int 21h
    mov dl,dh
    int 21h 
    inc bl
    inc dh
    loop ciclo
fin:int 20h