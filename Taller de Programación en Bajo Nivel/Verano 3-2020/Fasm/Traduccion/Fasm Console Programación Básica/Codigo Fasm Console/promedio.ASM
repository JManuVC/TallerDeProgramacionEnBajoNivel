INCLUDE 'win32ax.inc'

.code
  start:
    xor ecx,ecx
    MOV cl,5 ; CX es el contador
    mov esi, a ; SI apuntara al área a con los bytes a promediar
    MOV al,0 ; El resultado quedara en AL
    P0: add ax,[esi]
    inc esi ; Avance al siguiente byte
    loop P0
    mov ah,0 ; Debe ponerse en 0 porque la división
	     ; considera AH como parte alta del dividendo
    mov dl,5 ; Se debe usar un registro por que la división
    div dl; no acepta un operando inmediato.

     mov byte[num],al	    ;El resultado esta en AL
			    ; se usa byte para la conversion
    invoke  ExitProcess,0
.end start

SECTION '.DATA' DATA readable writeable
  num dw ?
  a DB 3,7,9,1Ah,0BCh
 

