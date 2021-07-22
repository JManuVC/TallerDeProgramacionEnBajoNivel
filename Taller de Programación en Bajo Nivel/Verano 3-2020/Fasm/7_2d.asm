format PE CONSOLE 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable
  start:

    mov edi,cad1
    mov esi,cad3
    xor ecx,ecx
    inc edi
    mov cl,byte [edi]
    push cx
    inc edi
    stdcall concatenar
    mov edi,cad2
    inc edi
    xor ecx,ecx
    mov cl, byte [edi]
    push cx
    inc edi
    stdcall concatenar
    pop cx
    pop dx
    xor ebx,ebx
    add dx,cx
    mov bx,dx	     ;sumamos las longitudes de las cad estructuradas
    invoke     GetStdHandle, STD_OUTPUT_HANDLE	  ;muestra en consola
    invoke WriteFile, eax,cad3,ebx,hNum,0
    xor        eax, eax

    invoke    ExitProcess,0

proc concatenar 	;concatena edi con esi

     xor bx,bx

     ciclo:
	 mov bx,[edi]
	 mov [esi],bx
	 inc edi
	 inc esi
     loop ciclo

ret
endp
section '.data' data readable writeable
    hNum	RQ 1
    cad1	 DB 20,10,"murcielago"

    cad2	 DB 10,6,"bonito"
    cad3	 DB ?



section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc'


