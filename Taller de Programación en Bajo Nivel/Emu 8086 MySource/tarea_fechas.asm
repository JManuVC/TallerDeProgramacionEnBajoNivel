
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

guion macro p
    push p
    mov ah,2
    mov dl,2Dh
    int 21h
    
    mov ah,1
endm
fecha macro
    mov ax,0
    mov ah,1
    int 21h
    sub al,30h 
    mov bh,al
    int 21h
    sub al,30h
    mov bl,al
    guion bx
    
    int 21h
    sub al,30h 
    mov ch,al
    int 21h
    sub al,30h
    mov cl,al
    guion cx
    
    int 21h
    sub al,30h
    mov dh,al
    int 21h
    sub al,30h
    mov dl,al
    push dx
endm  


org 100h

inicio:
   
   fecha
   call salto
   fecha 
   
   mov dx,365
   pop bx
   mov cx,bx
   pop bx
   cmp bx,cx
   ja restar1 bx cx
   jmp restar2 cx bx 
   
restar1:
    sub bx,cx
    mov ax,0
    mov ax,bx
    jmp multiplicar
    
restar2: 
    sub cx,bx
    mov ax,0
    mov ax,cx       
    jmp multiplicar
multiplicar:
    mul dx

    
fin: int 20h
ret

proc salto 
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    mov ah,1
    ret
salto endp

proc fecha
    
    ret
fecha endp



