;Vargas Cruz Jose Manuel
;3.- Obtener sub-cadenas; parte izquierda, derecha y central de:
    ;a) cadena estructurada
    
org 100h  
inicio:
        
        lea dx,msj
        call mostrarCad
        call saltoLinea
            
        mov ah,0Ah
        lea dx,cad
        int 21h 
        
        lea si,cad 
        mov byte ptr [si],50  
        
        xor ax,ax
        inc si 
        cmp [si],1
        je cortar
        jb mostrar
        cmp [si],2
        je cortar2
    
        mov al,[si]
        mov bl,3
        div bl
        
        lea si,cad
        inc si
        inc si
                 
        xor dx,dx
        xor cx,cx
        mov cl,al 
        
        lea di,izq  
        jmp continue
     cortar:  
        lea di,izq 
        lea si,cad
        inc si
        inc si
        
        mov dl,[si]
        mov [di],dl
        jmp mostrar 
     cortar2:  
        lea di,izq 
        lea si,cad
        inc si
        inc si
        lea bp,med
        
        mov dl,[si]
        mov [di],dl
        
        inc si
        mov dl,[si]
        mov [bp],dl  
        jmp mostrar
     
    continue:
        
       ciclo1:
        mov dl,[si]
        mov [di],dl  
        inc si
        inc di
       loop ciclo1
       
       xor bx,bx
       mov bl,al
       mov bh,ah
       add bl,bh
       
       xor cx,cx
       mov cl,bl 
       lea di,med
       xor dx,dx
       ciclo2:
            mov dl,[si]
            mov [di],dl
            inc di
            inc si
       loop ciclo2
       
       xor dx,dx
       xor cx,cx
       mov cl,al
       lea di,der
       
       ciclo3:
            mov dl,[si]
            mov [di],dl
            inc di
            inc si
        loop ciclo3
    call saltoLinea  
 mostrar:
    
    lea dx, izqC
    call mostrarCad
    lea dx, izq
    call mostrarCad
    lea dx, medC
    call mostrarCad 
    lea dx, med
    call mostrarCad
    lea dx,derC
    call mostrarCad     
    lea dx,der       
    call mostrarCad     
        
       
        

fin: int 20h                               

cad db 50 dup ('0')
izq db 25 dup ('$')
med db 25 dup ('$')
der db 25 dup ('$')     

msj db "Ingrese una cadena$"
izqC db 10,13,"Parte Izquierda: $"
medC db 10,13,"Parte Media: $"
derC db 10,13,"Parte Derecha: $"


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
 mostrarCad endp                      ; logica 
                                      ; h o l a -> 4/3=1 c=1 medio= 1+1=2 |iz= h, medio= ol, der=a 
                                      ; h o l a s -> 5/3=1 c=2 medio = 2+1=3
                                      ; h o l a h o l a -> 8/3=2 c=2 medio = 2+2=4