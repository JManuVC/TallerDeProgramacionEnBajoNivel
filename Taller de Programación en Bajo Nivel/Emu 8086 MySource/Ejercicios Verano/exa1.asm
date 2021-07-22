

org 100h

inicio: 
    
    lea dx,menu
    mov ah,9
    int 21h
    lea dx,menu2
    mov ah,9
    int 21h
    call saltoLinea
    mov ah,1
    int 21h
    cmp al,31h
    je continuar
    cmp al,32h
    je fin
    jne inicio
  
  continuar:  
    mov ah,7
    otro:
    int 21h
    cmp al,30h
    jb otro
    cmp al,39h
    ja otro
    
    mov dl,al
    mov bl,al    ; num
    mov ah,2
    int 21h
    call saltoLinea
    xor cx,cx
    mov cl,3
    
  jugar:
    mov ah,9
    lea dx,cad1
    int 21h 
    
    call saltoLinea
      
    mov ah,7
    other:
    int 21h
    cmp al,30h
    jb other
    cmp al,39h
    ja other
    mov dl,al
    mov ah,2
    int 21h
    
    cmp al,bl
    je mostrarGanador
    ja mostrarMenor
    jb mostrarMayor 
    
    
    
    
    mostrarGanador:
        mov ah,9
        lea dx,cad2
        int 21h
        jmp fin
    
     mostrarMenor:
        mov ah,9
        lea dx,menor
        int 21h
        jmp continue
     mostrarMayor:
      mov ah,9
        lea dx,mayor
        int 21h
        jmp continue
     
     continue:
        loop jugar
        
        mov ah,9
        lea dx,cad3
        int 21h 
        
        jmp inicio
    
    
fin:int 20h 
  menu db "1.Jugar$"
  menu2 db 10,13,"2.Salir$"
  
  cad1 db 10,13,"Adivina el numero 1-9$"
  cad2 db 10,13,"You Win!$"
  cad3 db 10,13,"You Loose!$"
  mayor db 10,13,"No es el numero, el numero es mayor$"
  menor db 10,13,"No es el numero, el numero es menor$"

proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
saltoLinea endp



