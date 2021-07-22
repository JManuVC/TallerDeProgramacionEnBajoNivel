;Escribir por pantalla cada caracter de una cadena introducida por teclado.
;Vargas Cruz Jose Manuel
org 100h
inicio:  
      mov ah,0Ah
      lea dx,cad
      int 21h
      
      lea di,cad
      inc di
      xor cx,cx
      mov cl,[di]
      inc di 
      call saltoLinea
      mov ah,2
      
      mostrar:
          cmp [di],'A'
          jb saltar
          cmp [di],'z'
          ja saltar
          cmp [di],'a'
          jae continue
          cmp [di],'Z'
          jb continue
          jne saltar
        continue:
         
          mov dl,[di] 
          int 21h  
          call saltoLinea
         saltar: 
          inc di
          loop mostrar
        
        
fin: int 20h 
cad db 50 dup ('$')

proc saltoLinea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
saltoLinea endp

