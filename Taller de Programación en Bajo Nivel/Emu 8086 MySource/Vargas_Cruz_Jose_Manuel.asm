
;Nombre: Vargas Cruz Jose Manuel
;Cod. Sis: 201800190
;Grupo: 1
;Carrera: Ing. Informatica
;Pregunta: 3

org 100h
    mov ax,0
    mov ah,9
    mov dx, offset nom
    int 21h
    
    mov ah,7
    mov si,offset nomb
      
    
    ingNom:
        
        int 21h
        cmp al,13
        je break
        cmp al, 'z'
        ja ingNom
        cmp al, 'A'
        jb ingNom
        cmp al,'a'
        ja pass
        cmp al,'Z'
        jb pass
        
     pass: 
        mov ah,2
        mov dl,al
        mov [si],al
        int 21h
        mov ah,7
        
        inc si 
        jmp ingNom
     break:
    
     
        
    mov ax,0
    mov ah,9
    mov dx, offset ap
    int 21h  
              
    mov ah,7
    mov si,offset lastName
    ingAp:
        
        int 21h
        cmp al,13
        je break2
        cmp al, 'z'
        ja ingAp
        cmp al, 'A'
        jb ingAp
        cmp al,'a'
        ja pass2
        cmp al,'Z'
        jb pass2
        
     pass2: 
        mov ah,2
        mov dl,al
        mov [si],al
        int 21h
        mov ah,7
        
        inc si 
        jmp ingAp
     break2:
     
     mov ax,0
     mov ah,9
     mov dx,offset tel
     int 21h 
     
     mov cx,7
     mov ah,7
     mov si,offset phone
     ingTel:
        int 21h  
        
        cmp al,30h
        jb ingTel
        cmp al,39h
        ja ingTel
        
        mov dl,al
        mov [si],al
        mov ah,2
        int 21h
        inc si
        mov ah,7
        loop ingTel  
        
     
     mov ax,0
     mov ah,9
     mov dx,offset cel
     int 21h 
     
     mov cx,8
     mov ah,7
     mov si,offset cellp
     ingCel:
        int 21h  
        
        cmp al,30h
        jb ingCel
        cmp al,39h
        ja ingCel
        
        mov dl,al
        mov [si],al
        mov ah,2
        int 21h
        inc si
        mov ah,7
        loop ingCel  
        
        mov ax,0
        mov ah,9
        mov dx,offset dep
        int 21h  
        
        mov ah,7
        mov si,offset city
      ingDep:
            int 21h
        cmp al,13
        je break3
        cmp al, 'z'
        ja ingDep
        cmp al, 'A'
        jb ingDep
        cmp al,'a'
        ja pass3
        cmp al,'Z'
        jb pass3
        
     pass3: 
        mov ah,2
        mov dl,al
        mov [si],al
        int 21h
        mov ah,7
        
        inc si 
        jmp ingDep
     break3:
     
     
        mov ax,0
        mov ah,9
        mov dx,offset correo
        int 21h  
        
        
        mov si,offset mail 
        mov ah,1
        ingMail:
            int 21h
            cmp al,13
            je break4  
            mov [si],al
            inc si
            jmp ingMail
         break4:
         
        mov ax,0
        mov ah,9
        mov dx,offset contrasena
        int 21h 
         
        
        mov si,offset password
        mov ah,7
        ingPass: 
            int 21h
            cmp al,13
            je break5
            mov [si],al
            mov dl,'/'
            mov ah,2
            int 21h
            inc si
            mov ah,7
            jmp ingPass
         break5:
          
         
        mov si,offset phone
        
        cmp [si],32h
        jb error
        cmp [si],34h
        ja error   
         
        jmp sigue: 
        error:  
            mov dx,offset noPe
            mov ah,9
            int 21h
            mov dx,offset regN  
            int 21h
            jmp sigue
        
        sigue: 
            mov si,offset password
            cicloP:
            cmp [si],0
            je breakP
            cmp [si],'A'
            ja min
            jb error2
            min:
                inc si
                cmp [si],'Z'
                jb cicloP
                ja error2
            jmp cicloP
            jmp breakP
            error2:
               mov dx,offset noMay
                mov ah,9
                int 21h
                mov dx,offset regN  
                int 21h 
            breakP:
             
            
fin: int 20h

ret

nom db 'Ingrese Nombres: $'
ap db 10,13,'Ingrese Apellidos: $'
tel db 10,13,'Ingrese Telefono: $'
cel db 10,13,'Ingrese Celular: $'
dep db 10,13,'Ingrese Departamento: $'
correo db 10,13,'Ingrese Correo Electronico: $'
contrasena db 10,13,'Ingrese contrasenia: $'
nomb db 30 dup (0)
lastName db 30 dup (0)
phone db 7 dup (0)
cellp db 8 dup (0)
city db 20 dup (0)
mail db 30 dup (0)
password db 16 dup (0)
  
reg db 10,13,'Registro Realizado$'
regN db 10,13,'Registro No Realizado$'

noPe db 10,13,'Numero NO pertenece a Bolivia$'

noMay db 10,13, 'No contiene mayusculas$'


