;Vargas Cruz Jose Manuel
; 1.-leer cadenas de longitud fija

org 100h
  inicio:
       mov cx,10
       lea di,cadF
       ciclo:
        mov ah,1
        int 21h
        mov [di],al
        inc di
        loop ciclo 
fin: int 20h
        
cadF db 20 dup ('$')

