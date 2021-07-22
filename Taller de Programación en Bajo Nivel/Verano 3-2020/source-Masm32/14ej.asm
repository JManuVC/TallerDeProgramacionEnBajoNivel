.386
.model flat,stdcall
	include c:\masm32\include\kernel32.inc 
	include c:\masm32\include\user32.inc 
	include c:\masm32\include\masm32.inc
	includelib c:\masm32\lib\kernel32.lib 
	includelib c:\masm32\lib\user32.lib   
	includelib c:\masm32\lib\masm32.lib
.const
	NULL equ 0
	MB_OK equ 0
.data	
	titulo db "Palindromes",0
	
	pedircadena db "Ingrese un numero: ",0
	pedircarac db "Ingrese 4 numeros: ",0
		
.data?
	num db 50 dup(?)
	lineas db 50 dup(?)

.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr buffer, 50
	leer:	
	invoke StdOut, addr pedircarac
	invoke StdIn, addr carac, 10
	lea di,carac
			cmp byte ptr[edi+1],0
			jne leer
			cmp byte ptr[edi],'A'
            jb leer
            cmp byte ptr[edi],'z'
            ja leer
            cmp byte ptr[edi],'a'
            jae seguir
            cmp byte ptr[edi],'Z'
            jbe seguir
            jne leer
	seguir:
	lea edi, buffer
	xor dx,dx
	mov dl,0
	xor ecx,ecx
	lea esi,carac
	xor bx,bx
	mov bl,byte ptr [esi]
	
	ciclo:
		cmp byte ptr[edi],dl
		je salir
		
		cmp byte ptr[edi],bl
		jne saltar
		inc ecx
	    saltar:
		inc edi

	jmp ciclo

	salir:
  	invoke dwtoa, ecx, addr numero
	invoke MessageBoxA,NULL,addr numero,addr titulo,MB_OK
	invoke ExitProcess,0
end main
