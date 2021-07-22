; ----------------------------------------------------------------------------
; -	  TITULO  : Ejemplo de uso de funciones MSVCRT W-MASM		     -
; ----- 								 -----
; -	  AUTOR   : Alfonso Víctor Caballero Hurtado			     -
; ----- 								 -----
; -	  VERSION : 1.0 						     -
; ----- 								 -----
; -	  COMENT  : Basado en ejemplo de Greg Lyon			     -
; ----- 								 -----
; -	 (c) 2010. Abre los Ojos al Ensamblador 			     -
; ----------------------------------------------------------------------------

.386
.MODEL	    flat, STDCALL
OPTION	    casemap :none

include 'win32ax.inc'
INCLUDE     'kernel32.inc'
INCLUDE     'msvcrt.inc'
INCLUDELIB  'kernel32.lib'
INCLUDELIB  'msvcrt.lib'

INCLUDE     C:\masm32\macros\macros.asm

WaitKeyCrt PROTO

.DATA
    newline   BYTE  13, 10, 0

.CODE
  start:
    INVOKE    crt_printf, SADD("Hola mundo, en consola windows, usando funciones MSVCRT.",13,10)
    INVOKE    WaitKeyCrt
    INVOKE    crt__exit, 0

  WaitKeyCrt PROC
    INVOKE    crt_printf, SADD(13,10,"Pulsa una tecla para continuar...")
    INVOKE    crt__getch
    .IF       (EAX == 0) || (EAX == 0E0h)
	INVOKE	  crt__getch
    .ENDIF
    INVOKE    crt_printf, OFFSET newline
    RET
  WaitKeyCrt ENDP

END start 
 
