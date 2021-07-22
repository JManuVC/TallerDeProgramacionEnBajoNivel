

;Vargas Cruz Jose Manuel
    ;5.- Leer una cadena exigiendo 
        ;que sus caracteres solo sean numeros 
        ;y un signo opcional.

org 100h

inicio: 
  other:
    mov ah,7
    int 21h
    cmp al,13
    je fin
    cmp al,2Bh
    je guardar
    cmp al,2Dh
    je guardar
    jmp continue
      
   otro:
    mov ah,7
    int 21h
   continue: 
    cmp al,13
    je fin
    cmp al,39h
    ja otro
    cmp al,30h
    jb otro
   guardar:
    
    mov [di],al
    mov dl,al
    mov ah,2
    int 21h
    jmp otro
   

fin: int 20h

numero db 50 dup (0)


