;Vargas Cruz Jose Manuel
;1.- Leer cadenas estructuradas
org 100h

inicio:
            
        mov ah,0Ah
        lea dx,cad1
        int 21h 
        
        lea si,cad1 
        mov byte ptr [si],50     
        
fin: int 20h
cad1 db 50 dup ('0')      ; cadena estructurada