;Vargas Cruz Jose Manuel
;2.- Concatenar cadenas
    ;d) estructurada con estructurada


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
        
        lea dx,cad2
        
        mov ah,0Ah
         
        int 21h  
        
        lea si,cad2 
        mov byte ptr [si],50 
        
        call saltoLinea  
        
     
        
        lea di,cad1
        lea si,cad2
        lea bp,cad3
        
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
        inc si
        mov cx,[si]
        mov ch,0
        inc si
        
        ciclo3:
           
            
            mov dl,[si]
            mov [bp],dl
            inc bp
            inc si
            loop ciclo3:  
            
            
        mostrar:
            call saltoLinea
            lea dx,cade3
            call mostrarCad
            
            lea dx,cad3
            call mostrarCad
        
        
        
fin: int 20h
cad1 db 50 dup ('0')      ; cadena estructurada
                          
cad2 db 50 dup ('0')      ; cadena estructurada

cad3 db 50 dup ('$')      ; cadena concatenada   cad3=cad1+cad2

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