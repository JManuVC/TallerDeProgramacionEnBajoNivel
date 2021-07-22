;Vargas Cruz Jose Manuel
;2.- Concatenar cadenas
    ;c) estructurada con ASCIIZ

org 100h

inicio:
        lea dx,msj
        call mostrarCad
               
        lea dx,cade1
        call mostrarCad  
        mov ah,0Ah
        lea dx,cad1
        int 21h 
        
        lea si,cad1 
        mov byte ptr [si],50     
        
        call saltoLinea
        lea dx,cade2
        call mostrarCad
        
        lea di,cad2
        
        mov ah,1
        
        ciclo1:
        
        int 21h
        cmp al,13
        je concatenar
        mov [di],al 
        inc di  
        jmp ciclo1  
        
        call saltoLinea  
        
     concatenar:
        
        lea di,cad1
        lea si,cad2
        lea bp,cad3
        xor bx,bx
        xor dx,dx
        
        inc di
        
        mov cx,[di]
        mov ch,0  
        inc di
        
        ciclo2:
            mov dl,[di]
            mov [bp],dl
            inc bp
            inc di
            loop ciclo2
        xor dx,dx
        ciclo3:
            cmp [si],0
            je mostrar
            
            mov dl,[si]
            mov [bp],dl
            inc bp
            inc si
            jmp ciclo3:  
            
            
        mostrar:
            call saltoLinea
            lea dx,cade3
            call mostrarCad
            
            lea dx,cad3
            call mostrarCad
        
        
        
fin: int 20h
cad1 db 50 dup ('0')      ; cadena estructurada
                          
cad2 db 50 dup (0)        ; cadena asciiz -> 'abc',0

cad3 db 50 dup ('$')      ; cadena concatenada

msj db "Ingrese dos cadenas$"
cade1 db 10,13,"Cadena 1: $"
cade2 db "Cadena 2: $"
cade3 db "Cadena Concatenada: $"
                       
proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
saltoLinea endp


proc mostrarCad
    mov ah,9
    int 21h
    
    ret
mostrarCad endp