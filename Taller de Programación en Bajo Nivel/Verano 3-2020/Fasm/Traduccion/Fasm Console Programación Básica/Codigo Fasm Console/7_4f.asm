format PE CONSOLE 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable
  start:

    mov esi,cad2

    xor ecx,ecx
    xor edx,edx
    ciclo1:
    cmp byte[esi],0
    je salir
    inc esi	 ;recorrer al final
    inc dl
    jmp ciclo1
    salir:

    mov edi,cad1
    inc edi
    xor ecx,ecx
    mov cl,byte[edi]
    xor ebx,ebx
    inc edi
    ciclo2:
	mov bx,[edi]
	mov [esi],bx
	inc edi
	inc esi
    loop ciclo2

    mov edi,cad1
    inc edi
    xor ebx,ebx
    mov bl,byte[edi]
    add bl,dl	 ;nueva longitud

     invoke	GetStdHandle, STD_OUTPUT_HANDLE    ;muestra en consola
    invoke WriteFile, eax,cad2,ebx,hNum,0
    xor        eax, eax

    invoke    ExitProcess,0

section '.data' data readable writeable
    hNum	RQ 1
    cad1	DB 20,10,"murcielago" ;estructurada

    cad2	DB "bonito",0	   ;longitud fija




section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc'


