format PE CONSOLE 4.0
entry start

;include 'win32a.inc'
include 'win32ax.inc' ; Incluímos definiciones de estructuras y constantes

section '.text' code readable executable
  start:
    mov cx,5
    mov ax,1
    jcxz fin
    ciclo: mul cx
    loop ciclo
    fin:
	 mov [factorial],ax
	; invoke dwtoa, eax,factorial
	;
   ;  add factorial,30h
    ;invoke	GetStdHandle, STD_OUTPUT_HANDLE

    ;invoke	WriteFile, eax,  factorial, fact.len,  hNum,  0
    out 20h,ax ; output word to port 20h
    out dx,al ; output byte to port addressed by dx
     invoke MessageBox,NULL,msg,msg,MB_OK
     invoke ExitProcess,0
    xor        eax, eax
    ret
    ;invoke    ExitProcess,[msg.wParam]
    int 20h
section '.data' data readable writeable
    hNum	RQ 1
    msg 	DB "Hola mundo", 0
    msg.len	= $-msg

    numero dw 5
    factorial dw ?
    fact.len = $-msg

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc' 
