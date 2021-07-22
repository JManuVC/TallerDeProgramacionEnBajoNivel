format PE CONSOLE 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable
  start:

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
    invoke WriteFile, eax,cad3,cad3.len,hNum,0
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
    cad1	 DB "murcielago"
    cad1.len	 = $-cad1 ;Cadena de Longitud Fija
    cad2	 DB "bonito"
    cad2.len	 =  $-cad2;Cadena de Longitud Fija
    cad3	 DB ?
    cad3.len = cad1.len+cad2.len


section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc'


