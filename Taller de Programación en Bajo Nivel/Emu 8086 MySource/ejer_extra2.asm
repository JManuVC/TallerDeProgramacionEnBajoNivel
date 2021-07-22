
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
; capturar n caracteres y mostrar los 10 sig, solo si son mayusculas
org 100h

inicio:

ciclo1:
    
    mov ah,7
    int 21h
    
    cmp al,41h
    jb  ciclo1
    
    cmp al,5Ah
    ja  ciclo1
    
    mov cx,0
    mov cx,10 
    mov dl,al

ciclo2:    
    
    mov dh,dl
    
    mov dl,10
    int 21h
    
    mov dl,13
    int 21h
    
    mov ah,2
    mov dl,dh
    int 21h
    
    inc dl
    loop ciclo2
    
fin:int 20h  
