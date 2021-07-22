.386
.model flat,stdcall
	include c:\masm32\include\kernel32.inc 
	include c:\masm32\include\user32.inc ;borra prototipos
	include c:\masm32\include\masm32.inc
	includelib c:\masm32\lib\kernel32.lib 
	includelib c:\masm32\lib\user32.lib   
	includelib c:\masm32\lib\masm32.lib
.const
	NULL equ 0
	MB_OK equ 0
.data	
	titulo db "Cantidad de Vocales",0
	
	pedircadena db"ingrese una cadena ",0
	cantidad dw 0
		
.data?
	buffer db 50 dup(?)
	numero db 50 dup(?)

.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr buffer, 50 ;
	lea edi, buffer
	xor dx,dx
	mov dx,0
	xor ecx,ecx
	ciclo:
		cmp [edi],dx
		je salir
		
		cmp byte ptr [edi],'a'
		je contar
		cmp byte ptr [edi],'e'
		je contar
		cmp byte ptr [edi],'i'
		je contar
		cmp byte ptr [edi],'o'
		je contar
		cmp byte ptr [edi],'u'
		je contar
		jne saltar
		contar:
		add ecx,1
	      saltar:
		inc edi

	jmp ciclo

	salir:
		;add cantidad,30h    mi manera xd ??
  	invoke dwtoa, ecx, addr numero
	invoke MessageBoxA,NULL,addr numero,addr titulo,MB_OK
	invoke ExitProcess,0
end main
