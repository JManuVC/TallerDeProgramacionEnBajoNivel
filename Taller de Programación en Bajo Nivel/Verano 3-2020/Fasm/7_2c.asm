format PE CONSOLE 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable
  start:

    mov edi,cad1
    mov esi,cad3
    xor ecx,ecx
    inc edi
    mov cl,byte [edi] ; 2do caract. contiene longitud de la cadena
    push cx
    inc edi
    stdcall concatenar
    mov edi,cad2
    xor ecx,ecx
    xor ebx,ebx
    xor edx,edx
    ciclo2:
	cmp byte[edi],0
	je salir
	 mov bx,[edi]
	 mov [esi],bx
	 inc edi
	 inc esi
	 inc dl
    jmp ciclo2

    salir:
	pop cx
	add dl,cl  ;longitud cadena3= 2da pos de estructurada+log asciiz

    invoke     GetStdHandle, STD_OUTPUT_HANDLE	  ;muestra en consola
    invoke WriteFile, eax,cad3,edx,hNum,0
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
    cad1	 DB 20,10,"murcielago"; Cadena estructurada
    cad2	 DB "bonito",0 ;Cadena ASCIIZ

    cad3	 DB ?


section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc'
