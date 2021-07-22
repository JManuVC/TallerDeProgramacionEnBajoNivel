; ----------------------------------------------------------------------------
; -	  TITULO  : Ejemplo de uso de funciones MSVCRT W-FASM (no funciona)  -
; ----- 								 -----
; -	  AUTOR   : Alfonso Víctor Caballero Hurtado			     -
; ----- 								 -----
; -	  VERSION : 1.0 						     -
; ----- 								 -----
; -	 (c) 2010. Abre los Ojos al Ensamblador 			     -
; ----------------------------------------------------------------------------

format MS COFF
;entry _main

include 'win32a.inc'	     ; Incluímos definiciones de estructuras y constantes
extrn '_printf'  as _printf

section '.text' code readable executable
_main:
    push      msg
    call      _printf
    add       esp, 4
    xor       eax, eax
    ret

section '.data' data readable writeable
    msg 	DB "Hola mundo, en consola windows, usando funciones MSVRCT.", 0
    msgGetKey	DB "%c%c%c%cPulsa cualquier tecla para salir.",13,10,13,10, 0
 
