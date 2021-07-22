;Vargas Cruz Jose Manuel

org 100h
    inicio: 
    
        mov ah,9
        lea dx,msj
        int 21h
        lea dx,cade1
        int 21h 
        
        mov ah,0Ah
        lea dx,cad1
        int 21h
        call saltoLinea
        mov ah,9
        lea dx,cade2
        int 21h
        
        mov ah,0Ah
        lea dx,cad2
        int 21h 
        
        
        
        lea di,cad1
        inc di
        lea si,cad2
        inc si
        
        mov bl,[di]
        cmp [si],bl
        jne mostrarNoiguales
        
        xor cx,cx
        xor bx,bx
        mov cl,[si]
        inc di
        inc si
        comparar:
            mov bl,[di]
            cmp [si],bl
            jne mostrarNoiguales
            inc si
            inc di
            loop comparar 
            
            mov ah,9
            lea dx,iguales
            int 21h
            jmp fin
     mostrarNoiguales:
        mov ah,9
        lea dx,niguales
        int 21h
    
        
        
fin: int 20h
cad1 db 50 dup ('$')
cad2 db 50 dup ('$')
iguales db 10,13,"Son iguales!$" 
niguales db 10,13,"No son iguales!$"
msj db "Ingrese dos cadenas$"
cade1 db 10,13,"Cadena1: $"
cade2 db "Cadena2: $"                          
                         
proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
saltoLinea endp


