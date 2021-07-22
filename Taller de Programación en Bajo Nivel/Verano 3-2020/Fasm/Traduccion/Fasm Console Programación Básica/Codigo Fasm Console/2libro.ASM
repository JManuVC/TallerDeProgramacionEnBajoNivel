format PE CONSOLE 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable
  start:
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke     WriteFile, eax,	msg, msg.len, hNum,0  ;leemos desde consola
    xor        eax, eax

    invoke    ExitProcess,0

section '.data' data readable writeable
    hNum	RQ 1
    msg 	DB "roberto va a casa",0 ;Cadena ASCIIZ termina en cero
    msg.len	= $-msg

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc' 
