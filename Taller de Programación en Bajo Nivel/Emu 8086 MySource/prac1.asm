
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt


    

org 100h

inicio:
    mov cx,0
    mov ah,1 
    mov si,offset cad1
    mov di,offset cad2 
    
ciclo:
    int 21h
    
    cmp al,13
    je ciclo3  
    mov bl,al
    push bx
    inc cl
    jmp ciclo
    
ciclo3:
    mov ax,0
    mov ax,cx
    push ax
    pop bx
    jmp ciclo2 
    
ciclo2:    
    pop bx
    cmp bl,'A'
    jb mincar
    
    cmp bl,'Z'
    ja addmincar
    cmp bl,40h
    ja numay
    
    cmp bl,39h
    jb numay2
    tag:

    loop ciclo2 
    push ax

    
    pop ax
    mov cx,ax
    
    mov si,offset cad1
    mov di,offset cad2 
    mov ah,2 
     
    
printCads:
    cmp cx,0
    je fin
    call salto_linea  
    cmp [si],0 
    je continue1
    jne printSi
    
           
printSi:
    mov dl,[si]
    int 21h 
    sub cx,1
    jmp continue
continue1:
    mov dl,' '
    int 21h
    jmp continue
continue:
     
    inc si
    cmp [di],0 
    je cont
    jne printDi
cont:
    mov dl,' '
    int 21h
    jmp printCads
printDi:
    
    mov dl,[di]
    int 21h
    inc di
    sub cx,1
    jmp printCads
    
    
     
    
    jmp fin
    
    

mincar:
    
    cmp bl,5Ah
    ja addmincar
    cmp bl,39h
    ja addmincar  
    cmp bl,30h
    jb addmincar
    
    cmp bl,30h
    ja mov numay2
    
numay:
    cmp bl,'Z'
    jb addnumay 
    inc di 
    
numay2:
    cmp bl,30h
    ja addnumay
    inc di
    

addmincar:
    mov [si],bl
    inc si
    jmp tag
addnumay:
    mov [di],bl
    inc di
    jmp tag
           

fin: int 20h  
proc salto_linea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
salto_linea endp

cad1 db 50 dup (0)
cad2 db 50 dup (0)



