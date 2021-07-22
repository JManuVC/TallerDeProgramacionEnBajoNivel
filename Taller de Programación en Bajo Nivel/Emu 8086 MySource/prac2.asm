
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt


saveDate macro rx, s, x                                               
    
    mov rx,al
    
    push x 
    push dx
    mov dl,rx
    
    mov ah,2
    int 21h
    pop dx
    mov ah,7
    inc s  
    pop x
    
endm    

multDate macro rl,s
     mov dl,al
     
     sub al,30h
     push dx
     
     mul di   
     mov rl,al
     mov ah,2 
     pop dx
     
     int 21h
     
     mov ah,7
     mul di
     inc s       
endm
    
org 100h

inicio:  
    mov dx,offset msg
    mov ah,9
    int 21h
    mov ax,0
    mov si,0
    mov ah,7   
    mov di,10
ciclo:
    cmp si,5
    ja bin
    int 21h
    cmp al,30h
    jb ciclo
    cmp al,39h
    ja ciclo 
    cmp si,0
    je saveDays
    cmp si,1
    je saveDays2
    cmp si,2
    je saveMonth
    cmp si,3
    je saveMonth2
    cmp si,4
    je saveYear  
    cmp si,5
    je saveYear2
    
    saveDays: 
        
         multDate dh,si 
        ;saveDate dl,si,dx 
        
         
        jmp ciclo
    saveDays2: 
        
        saveDate dh,si,dx 
        
        push dx
        mov ah,2
        mov dl,'-'
        int 21h
        mov ah,7
        pop dx 
        
        jmp ciclo
    saveMonth:
        
        saveDate cl,si,cx
          
        jmp ciclo
    saveMonth2: 
        
        saveDate ch,si,cx
        
        push dx
        mov ah,2
        mov dl,'-'
        int 21h
        mov ah,7
        pop dx 
      
        jmp ciclo
    saveYear: 
        
        saveDate bl,si,bx
           
        jmp ciclo
    saveYear2:
        
        saveDate bh,si,bx
        jmp ciclo:   
                  
bin: 
    call salto_linea 
    
    shl bx,9
    shl cx,5
    
    or ax,bx
    or ax,cx
    or ax,dx
    
    mov bx,ax
    mov cx,8
    mov al,bh
    call binario
    mov cx,8
    mov al,bl
    call binario
    
fin: int 20h

ret  

proc binario 
    push ax
    mov ah,2
    ciclo2:
        mov dl,18h
        rol al,1
        rcl dl,1
        push ax
        int 21h
        pop ax
        loop ciclo2  
        pop ax
        ret
binario endp
              
proc salto_linea
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h 
    
    mov dx,0
    ret
salto_linea endp

msg db 'Ingrese la fecha en formato DD-MM-AA: ',10,13,'$' 


