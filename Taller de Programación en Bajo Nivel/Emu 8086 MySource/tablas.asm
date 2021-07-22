
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

mostrarTabla1Dig macro reg,op
    mov cx,1
    cmp op,'+'
    je mostrarSuma
    cmp op,'-'
    
    je mostrarResta
    
    mostrarSuma:
        cmp cx,10
        je break
        mov dl,reg
        mov ah,2
        int 21h
        
        mov dl,'+'
        int 21h
        add cl,30h
        mov dl,cl
        
        int 21h
        sub cl,30h
        mov dl,'='
        int 21h   
        mov al,reg
        
        sub al,30h
        add al,cl
        add al,30h
        mov dl,al
        int 21h 
        inc cx
        call salto_linea
        jmp mostrarSuma
     break:
     mostrarResta: 
        mov cx,0  
        
        mov cl,reg
        sub cl,30h
       cicloR: 
        mov dl,reg
        mov ah,2
        int 21h
        mov dl,'-'
        int 21h 
        add cl,30h
        mov dl,cl
        int 21h
        sub cl,30h
        mov dl,'='
        int 21h
        
        mov al,reg
        sub al,30h
        sub al,cl
        mov dl,al
        add dl,30h
        int 21h   
        call salto_linea
        
        loop cicloR:
        
        
        
         
endm
        
org 100h
inicio:
    mov ah,1
    int 21h   
    push ax
    call salto_linea  
    pop ax      
    mov bl,al
    mov bh,'-'
    mostrarTabla bl,bh
    
fin:int 20h


ret

proc salto_linea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
salto_linea endp


