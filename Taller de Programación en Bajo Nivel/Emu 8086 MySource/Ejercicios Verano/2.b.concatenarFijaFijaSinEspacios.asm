;Vargas Cruz Jose Manuel
;2.- Concatenar cadenas

    ;b) longitud fija con longitud fija con supresión de espacios en blanco
org 100h



incio:      

    
    lea dx,msj
    call mostrarCad 
    call saltoLinea
    
    lea dx,cade1
    call mostrarCad
    
    xor cx,cx
    mov cx,10
    lea di,cad1 
    mov ah,1
       ciclo:
        
        int 21h
        mov [di],al
        inc di
        loop ciclo 
        call saltoLinea 
        
        lea dx,cade2
        call mostrarCad
                          
    mov cx,10
    lea si,cad2  
    mov ah,1
       ciclo2:
        
        int 21h
        mov [si],al
        inc si
        loop ciclo2  
        
        call saltoLinea 
        lea dx,cade3
        call mostrarCad
        
    
    lea di,cad3
    lea si,cad2
    lea bp,cad1
    xor dx,dx  
    
    
    mov cx,10
    
    ciclo3: 
     
    mov dl,[bp]  
    
    cmp dl,20h
    je saltar1 
    
    mov [di],dl 
    inc di
    saltar1:
        
        inc bp
    
    
    loop ciclo3 
    
    
    mov cx,10
    xor dx,dx
    ciclo4:   
    
    mov dl,[si]  
    
    cmp dl,20h
    je saltar2
    mov [di],dl
    inc di
    saltar2:
    inc si
    
    
    
    loop ciclo4   
    
    mov ah,9
    lea dx,cad3
    
    int 21h
    
         

fin: int 20h   

msj db "Ingrese dos cadenas de longitud fija 10$",10,13
cade1 db "Cadena 1: $"
cade2 db "Cadena 2: $"
cade3 db "Cadena Concatenada: $"

cad1 db 10 dup ('$')
cad2 db 10 dup ('$')

cad3 db 21 dup ('$')    

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