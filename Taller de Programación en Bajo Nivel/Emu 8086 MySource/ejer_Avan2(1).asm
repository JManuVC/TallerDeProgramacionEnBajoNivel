
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
inicio:
    mov dx,offset ingci
    mov ah,9
    int 21h
    mov si,offset cin  ;ing ci
    mov ah,1  
    mov cx,7
ciclo2:
    int 21h 
    mov [si],al
    inc si
    loop ciclo2
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov dx,offset ingsis   ; mostrar ing sis
    mov ah,9
    int 21h
    mov ah,1
    mov si,offset sisn 
    mov cx,9  ; ing sis
ciclo4:
    int 21h
    mov [si],al
    inc si
    loop ciclo4 
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
   
    mov si,offset cin
    mov di,offset ci
    mov cx,7 
ciclo5:
    mov bl,[si]
    cmp bl,[di]
    jne nuevo 
    inc si
    inc di
    loop ciclo5
    
    mov si, offset sisn
    mov di, offset sis
    mov cx,9
ciclo6:    
    mov bl,[si]
    cmp bl,[di]
    jne nuevo 
    inc si
    inc di
    loop ciclo6
    mov cx,7
    mov ah,9
    mov dx,offset antiguoci
    int 21h
    
    
    jmp fin
 nuevo:
   
    mov ah,9
    mov dx,offset nuevoci
    int 21h
       
    
    
fin: int 20h

ret

ingci db 'ingrese ci:$'

ingsis db 'ingrese codsis:$'

ci db '8767279$'

sis db '201800190$'

cin db '8969299$'

sisn db '201700170$'  

antiguoci db 'antiguo$'

nuevoci db 'nuevo$'




