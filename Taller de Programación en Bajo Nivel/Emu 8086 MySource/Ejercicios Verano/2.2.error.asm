.model tiny
.code
    org 100h
    main:   
         lea di,password ;mov di,offset password(lea load effective address)
        nextCh:
         call leerCaracterSE
         cmp al,0Dh
         jz mCl
         cmp al,'0'
         jb mostrarError
         cmp al,'9'
         jbe guardar
         
         cmp al,'A'
         jb mostrarError
         cmp al,'Z' 
         jbe guardar
         
         
         cmp al,'a'
         jb mostrarError
         cmp al,'z' 
         ja mostrarError
         
guardar:
         mov [di],al
         mov dl,'*'
         call mostrarC
         inc di    
         jmp nextCh  
         
    mCl :                        ; espacio extra
    
         lea si,password        ; falta un salto de linea
    ciclo2:
         mov dl,[si]
         cmp dl,0
         je salir
         call mostrarC
         call saltoLinea
         inc si
         jmp ciclo2
         
mostrarError:
         lea dx,error
         call mostrarString
         
         salir:
    int 20h
         
         password db 50 dup(0)
         error    db 10,13,'Error!$'
         
    saltoLinea:
        mov dl,10
        call mostrarC
        mov dl,13
        call mostrarC
        ret     
    leerCaracterSE:
        mov ah,7
        int 21h
        ret    
    mostrarString: ;dx=direccion de la cadena
        mov ah,9
        int 21h
        ret    
    mostrarC:   ;dl='*'
        mov ah,2
        int 21h
        ret
    end main
    

