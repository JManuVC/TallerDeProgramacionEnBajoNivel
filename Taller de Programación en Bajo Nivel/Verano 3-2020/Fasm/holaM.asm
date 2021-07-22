; ----------------------------------------------------------------------------
; -	  TITULO  : Ejemplo de consola en Windows W-FASM		     -
; ----- 								 -----
; -	  AUTOR   : Alfonso Víctor Caballero Hurtado			     -
; ----- 								 -----
; -	  VERSION : 1.0 						     -
; ----- 								 -----
; -	 (c) 2010. Abre los Ojos al Ensamblador 			     -
; ----------------------------------------------------------------------------

format PE CONSOLE 4.0
entry start

include 'win32a.inc'	     ; Incluímos definiciones de estructuras y constantes

section '.text' code readable executable
  start:
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke     WriteFile, eax,	msg, msg.len,  hNum,  0
    xor        eax, eax
    ret
    ;invoke    ExitProcess,[msg.wParam]

section '.data' data readable writeable
    hNum	RQ 1
    msg 	DB "Hola mundo", 0
    msg.len	= $-msg

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc' 
