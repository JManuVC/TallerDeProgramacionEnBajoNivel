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
   ; stdcall	StdOut, msg
   mov eax,[msg]
   invoke StdIn, eax, 50
    invoke     ExitProcess, 0
    xor        eax, eax
    ret

  proc StdOut uses eax, lpszText
    ;  Propósito: Procedure para salida estándar
    ;  Entrada	: lpszText
    ;  Salida	: Ninguna
    ;  Destruye : Ninguna
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    mov        [hOutPut], eax
    invoke     lstrlenA, [lpszText]
    mov        dword [sl], eax
    invoke     WriteFile, [hOutPut], [lpszText], [sl], bWritten,NULL
    mov        eax, [bWritten]
    ret
  endp

section '.data' data readable writeable
    hOutPut    rd   1
    bWritten   rd   1
    sl	       rd   1
    msg        DB "Hola mundo, en consola windows.", 0
    msg.len    = $-msg

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc' 
