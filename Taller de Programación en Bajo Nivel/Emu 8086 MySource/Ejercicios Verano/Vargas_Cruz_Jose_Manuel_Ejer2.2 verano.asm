
org 100h

inicio:     
    mov si,offset pass
    xor cx,cx    
   ciclo:
    mov ah,7
    int 21h
    cmp al, 13
    je show
    cmp al,'0'
    jb error 
    cmp al, 'z'
    ja error
    
    cmp al,'Z'
    jb mayusNum
    cmp al,'a'
    ja mostrar

mayusNum:
     cmp al,3Ah
     jb mostrar
     cmp al,41h
     ja mostrar
     jne error  
    
mostrar:
    
    mov ah,2
    
    mov dl,'*'  
    mov [si],al
    inc si
    int 21h  
    inc cx
    
    jmp ciclo
      
    
error:
    call salto_linea
    mov ah,9
    mov dx,offset msj
    int 21h   
    jmp fin
show:     
    call salto_linea
    mov ah,2
    mov di,offset pass
  ciclo2:
  
    mov dl,[di]
    int 21h
    inc di 
    call salto_linea
    
    loop ciclo2

      

fin: int 20h

msj db "error!$"   
pass db 50 dup ('$')

proc salto_linea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
salto_linea endp