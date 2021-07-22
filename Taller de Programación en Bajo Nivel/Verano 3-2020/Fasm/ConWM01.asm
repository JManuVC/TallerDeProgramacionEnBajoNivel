; ----------------------------------------------------------------------------
; -	  TITULO  : Ejemplo de consola W-MASM				     -
; ----- 								 -----
; -	  AUTOR   : Alfonso Víctor Caballero Hurtado			     -
; ----- 								 -----
; -	  VERSION : 1.0 						     -
; ----- 								 -----
; -	  COMENT  : Basado en JEFF HUANG				     -
; ----- 								 -----
; -	 (c) 2010. Abre los Ojos al Ensamblador 			     -
; ----------------------------------------------------------------------------

.386
.MODEL	   flat, stdcall
OPTION	   casemap :none
	  
INCLUDE    windows.inc
INCLUDE    kernel32.inc
INCLUDE    masm32.inc
	  
INCLUDELIB kernel32.lib 
INCLUDELIB masm32.lib 
	  
.DATA
  msg	DB "Hola mundo, en consola windows.", 0
 
.CODE 
start: 
  INVOKE     StdOut, ADDR msg
  INVOKE     ExitProcess, 0
 
END start 
 
