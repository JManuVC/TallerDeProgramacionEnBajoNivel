.model tiny
.code
org 100h

leer macro
mov ah,7
int 21h
endm
main:
mov cx,3
mov di,offset numeros
otro:
jcxz salto
leer
cmp al,30h
jb otro
cmp al,39h
ja otro
mov ah,2
mov dl,al
int 21h

mov [di],al
inc di
dec cx
jmp otro
salto:
mov cx,3
dec di
call saltoLinea

ciclo:
mov dl,[di]
call mostrarCaracter
call saltoLinea
dec di
loop ciclo

int 20h ;para terminar un programa en DOS

numeros db 3 dup(0)
saltoLinea:
mov dl,10
call mostrarCaracter
mov dl,13
call mostrarCaracter
ret

mostrarCaracter:
mov ah,2
int 21h
ret

end main