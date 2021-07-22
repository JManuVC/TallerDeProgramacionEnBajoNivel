org 100h  
inicio:
        
        lea dx,msj
        call mostrarCad
        call saltoLinea
        
            
        mov ah,1
        lea di,cad  
        xor cx,cx
      
     capturar:
        
        int 21h
        cmp al,13
        je dividir 
        
        mov [di],al 
        inc di
        inc cx
        jmp capturar 
        
       
     
     dividir:
        cmp cl,1
        je cortar
        jb mostrar
        cmp cl,2
        je cortar2
           
        xor ax,ax
        xor bx,bx
        
        mov al,cl
        mov bl,3
        div bl
               
        xor dx,dx
        lea si,cad
        lea di,izq
        mov cl,al 
        jmp continue
      cortar:  
        lea di,izq 
        lea si,cad
        
        mov dl,[si]
        mov [di],dl
        jmp mostrar
      cortar2:
        lea di,izq 
        lea si,cad
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

cad db 50 dup ('$')             ; cadena longitud fija

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
 mostrarCad endp 
