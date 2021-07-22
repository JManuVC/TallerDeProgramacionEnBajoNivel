INCLUDE 'win32ax.inc'

.code
  start:
  xor ecx,ecx
   MOV CX,5
   MOV esi,a
   MOV AX,0
   P0:
	ADD AX,[esi]
	INC SI ; Como son words, hay que incrementar dos veces SI
	INC SI
   LOOP P0
   MOV DX,0 ; Es necesario poner DX en 0 porque la división
   MOV CX,5 ; lo considera parte alta del dividendo.
   DIV CX
   MOV BX,AX

    invoke  ExitProcess,0
.end start

SECTION '.DATA' DATA readable writeable

  a DW 322,721,911,13Ah,10BCh
 

