
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

;REALIZAR UN PROGRAMA QUE CAPTURE LETRAS MAYUS. HASTA PRESIONAR ENTER, MOSTRAR SUS MINISCULAS
org 100h

inicio:  
    mov si,offset aux  
    mov cx,3
    mov ah,7
    int 21h 
    mov bh,0Dh
    cmp al,bh
    je mostrar
      
    cmp al,'A'
    jb inicio
    cmp al,'Z'
    ja inicio 
    jmp guardar
    
    
    
    
guardar: 
   mov si,bx
   mov dl,20h
   add al,dl
   mov [si],al
   inc si
   mov bx,si
   
   jmp inicio
mostrar:
    
    mov ah,2
    mov dl,[si]
    int 21h
    inc si
    loop mostrar 
    
    
    
fin: int 20h

ret
aux db 3 dup(0)



