; ----------------------------------------------------------------------------
; -	  TITULO  : Ejemplo de messagebox en Windows W-FASM		     -
; ----- 								 -----
; -	  AUTOR   : Alfonso Víctor Caballero Hurtado			     -
; ----- 								 -----
; -	  VERSION : 1.0 						     -
; ----- 								 -----
; -	 (c) 2010. Abre los Ojos al Ensamblador 			     -
; ----------------------------------------------------------------------------

INCLUDE 'win32ax.inc' ; Lo podremos cambiar entre win32ax, win32wx, win64ax y win64wx

.code
  start:
    invoke  MessageBox,NULL,MsgTexto,MsgCabecera,MB_OK
    invoke  ExitProcess,0
.end start

SECTION '.DATA' DATA readable writeable
  MsgCabecera	DB "Primer programa en Windows",0
  MsgTexto	DB "Programa creado con Fasm",0
 
