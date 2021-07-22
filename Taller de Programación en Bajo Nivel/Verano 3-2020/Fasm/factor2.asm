INCLUDE 'win32ax.inc' ;

.code
  start:
    xor ecx,ecx       ;es necesario limpiar los registros
    xor eax,eax
    mov cx,5
    mov ax,1
    jcxz fin
    ciclo: mul cx
    loop ciclo
    fin:
    mov [factorial],ax
    invoke  ExitProcess,0

.end start

SECTION '.DATA' DATA readable writeable
 factorial dw ?


