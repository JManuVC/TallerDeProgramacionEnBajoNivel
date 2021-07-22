INCLUDE 'win32ax.inc'

.code
  start:
	MOV esi, X
	xor eax,eax  ; es mas eficiente limpiar con XOR
	xor ecx,ecx
	mov bx,0FFFFh
	P0: CMP [esi],bx
	JZ FIN
	ADD AX,[esi]
	INC CX
	ADD SI,2 ; Otra forma de incrementar SI en 2.
	JMP P0
	FIN: xor edx,edx
	JCXZ NO_HAY
	DIV CX
	NO_HAY:

    invoke  ExitProcess,0
.end start

SECTION '.DATA' DATA readable writeable

  X DW 12,111,223,223,11H,123,22,0FFFFH
