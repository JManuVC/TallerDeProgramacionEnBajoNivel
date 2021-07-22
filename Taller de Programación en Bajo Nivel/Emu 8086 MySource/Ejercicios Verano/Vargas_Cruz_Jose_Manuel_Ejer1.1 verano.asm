;Vargas Cruz Jose Manuel


org 100h
inicio:
  mov ah,9
  mov dx,offset nombre
  int 21h          
  
  
  mov ah,1 
  mov si, offset captura
leer:
  int 21h
  cmp al,13
  je mostrar
  mov [si],al 
  inc si
  jmp leer

mostrar:

    mov ah,2
    mov dl,13
    int 21h
    
    mov dl,10
    int 21h
  
  mov ah,9
  mov dx, offset bienv
  int 21h
  
  mov ah,9
  mov dx, offset captura
  int 21h
  
  mov ah,9
  mov dx,offset mensaje
  int 21h   
         
fin: int 20h  


bienv db "Bienvenido $"
nombre db "Nombre: $" 
captura db 50 dup ('$')    

mensaje db " a la materia de",10,13, "Taller de Bajo Nivel$"




