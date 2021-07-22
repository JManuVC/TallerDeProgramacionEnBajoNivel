
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
convertPrintNum macro reg,base   ;convierte un registro a una base dada
    local while,break,for,show
    push ax
    push bx
    push cx
    push dx
    mov ax,reg
    mov bx,base
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
        cmp dl,'9'
        jbe show
        add dl,7h
        show:
        int 21h
        loop for
    pop dx
    pop cx
    pop bx
    pop ax
endm
capturar2 macro reg
    local primer, segundo   
    primer: 
        mov al,0
        mov ah,7
        int 21h
        cmp al,30h
        je primer
        cmp al,39h
        ja primer
        
                
        
        mov reg,al
        
        mov dl,al
        mov ah,2
        
        int 21h
        mov bh,10
                
        mov al,reg
        sub al,30h
        mul bh
        mov reg,al
        
        jmp segundo
    
    segundo:
        mov al,0
        mov ah,7 
        int 21h
        cmp al,30h
        je segundo
        cmp al,39h
        ja segundo
        
        push dx 
       
        mov dl,al
        mov ah,2
        
        int 21h
        pop dx
       
        sub al,30h
        add reg,al
        
        
        
endm
        
    
org 100h
inicio:  
    capturar2 bl
    mov bh,0
    convertPrintNum bx,2
fin:int 20h


ret




