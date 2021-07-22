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
	titulo db "Cadena reemplazada",0
	
	pedircadena db "Ingrese una cadena: ",0
	pedircarac db "Ingrese una letra: ",0

		
.data?
	buffer db 50 dup(?)
	carac db 10 dup(?)
	carac2 db 10 dup(?)
	numero db 50 dup(?)

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
	leer2:	
	invoke StdOut, addr pedircarac
	invoke StdIn, addr carac2, 10
	lea di,carac2
			cmp byte ptr[edi+1],0
			jne leer2
			cmp byte ptr[edi],'A'
            jb leer2
            cmp byte ptr[edi],'z'
            ja leer2
            cmp byte ptr[edi],'a'
            jae seguir2
            cmp byte ptr[edi],'Z'
            jbe seguir2
            jne leer2	
	
	seguir2:
	lea edi, buffer
	xor edx,edx
	
	xor ecx,ecx
	lea esi,carac
	lea ebp,carac2
	xor bx,bx
	mov bl,byte ptr [esi]
	mov dl,byte ptr [ebp]
	ciclo:
		cmp byte ptr[edi],0
		je salir
		
		cmp byte ptr[edi],bl
		jne saltar
		mov byte ptr[edi],dl
		jmp salir
	    saltar:
		inc edi

	jmp ciclo

	salir:
  	
	invoke MessageBoxA,NULL,addr buffer,addr titulo,MB_OK
	invoke ExitProcess,0
end main
