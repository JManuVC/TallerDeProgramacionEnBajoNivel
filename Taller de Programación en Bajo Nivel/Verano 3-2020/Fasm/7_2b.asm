format PE CONSOLE 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable
  start:
    xor edx,edx     ;contamos los caract. que se agregan (no espacios)
    mov edi,cad1
    mov esi,cad3
    xor ecx,ecx
    mov cl,cad1.len
    stdcall concatenar
    mov edi,cad2
    xor ecx,ecx
    mov cl, cad2.len
    stdcall concatenar

    invoke     GetStdHandle, STD_OUTPUT_HANDLE	  ;muestra en consola
    invoke WriteFile, eax,cad3,edx,hNum,0
    xor        eax, eax

    invoke    ExitProcess,0

proc concatenar 	;concatena edi con esi

     xor ebx,ebx


     ciclo:

	 cmp byte[edi],20h   ;comparamos si es espacio
	 je saltar
	 mov bx,[edi]
	 mov [esi],bx
	 inc esi
	 inc edx
	saltar:
	 inc edi
     loop ciclo

ret
endp
section '.data' data readable writeable
    hNum	RQ 1
    cad1	 DB "mur c i el ago neg ro"
    cad1.len	 = $-cad1 ;Cadena de Longitud Fija
    cad2	 DB "b o n i t o"
    cad2.len	 =  $-cad2;Cadena de Longitud Fija
    cad3	 DB ?



section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc'