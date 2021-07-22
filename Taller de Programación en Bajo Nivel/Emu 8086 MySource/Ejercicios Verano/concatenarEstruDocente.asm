
org 100h
main:
    lea di,cadena3
    mov byte ptr [di],50
    inc di
    
    lea si,cadena1
    inc si
    mov cl,[si]
    push cx
    
  copiar:
    inc si
    inc di
    mov al,[si]
    mov [di],al
    loop copiar
    
    lea si,cadena2
    inc si
    xor cx,cx
    mov cl,[si]
    push cx          
  copiar2:
    inc si
    inc di
    mov al,[si]
    mov [di],al
    loop copiar2
    
    pop ax
    pop dx
    
    add al,dl
    lea di,cadena3
    mov [di+1],al

fin:int 20h      

    cadena1 db 10,3,'abc'
    cadena2 db 20,4,'1234'
    cadena3 db 50 dup ('$')





