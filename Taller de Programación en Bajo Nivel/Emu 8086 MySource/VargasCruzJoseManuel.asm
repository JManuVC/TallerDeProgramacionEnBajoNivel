
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
inicio: 
    mov dx,offset carac
    mov ah,9
    int 21h
    call salto_linea
    mov dx,offset num 
    mov ah,9
    int 21h
    call salto_linea
    mov dx,offset leters
    mov ah,9
    int 21h
    call salto_linea  
   
    mov ah,7
menu:    
    int 21h
    
    cmp al,30h
    jb menu
    cmp al,33h
    ja menu
     
    sub al,30h
    mov bl,al
    
    
    cmp bl,1
    je caracteres
    cmp bl,2
    je numeros
    cmp bl,3
    je letras
    
    call salto_linea
    
numeros:    
    mov dx,offset ingreseN 
    mov ah,9
    int 21h 
    mov ax,0   
    mov ah,1 
    mov cx,0
ciclo:    
    int 21h
    cmp al,13
    je sigueN
    cmp al,30h
    jb ciclo
    cmp al,39h
    ja ciclo
    
    push ax
    inc cx
    jmp ciclo
sigueN: 
    call salto_linea
    mov dx,offset repet
    mov ah,9
    int 21h
    mov ah,1
    int 21h
    mov dl,al
    push dx 
    mov bl,0  
    call salto_linea 
    pop dx
comN:
    cmp cx,0
    je res
    sub cx,1    
    pop ax
    cmp dl,al
    jne comN
    inc bl
    jmp comN
res:   
    mov dx,offset resultado
    mov ah,9
    int 21h  
    
    add bl,30h
    mov dl,bl
    mov ah,2
    int 21h
    jmp fin
 
    
    
    
caracteres:
letras:    
    
fin:int 20h



ret 
proc salto_linea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    ret
salto_linea endp
carac db '1-caracteres$'
num db '2-numeros$'
leters db '3-letras$'  

ingreseN db 'ingrese numeros: $'
repet db 'repeticion: $'

resultado db 'resultado: $'



