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
	titulo db "Es subcadena?",0    
	pedircadena db "Ingrese una cadena ",0
	esSub db "Si es subcadena",0
	noSub db "No es subcadena",0
		
.data?
	cad db 50 dup(?)
	subcad db 50 dup(?)
.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr cad, 50 
	
	invoke StdOut, addr pedircadena
	invoke StdIn, addr subcad, 50 
	
    lea edi, cad
	xor edx,edx
	lea esi, subcad
	xor ebx,ebx
	mov dx,0
	ciclo:
			cmp byte ptr[esi],dl
			je salir
			mov byte ptr bl,[esi]
            cmp byte ptr [edi],bl
			jne mostrarNo
            inc esi
            inc edi
	jmp ciclo
	salir:
	
	mostrar:
		invoke MessageBoxA,NULL,addr esSub,addr titulo,MB_OK
		
		jmp fin
	mostrarNo:
		invoke MessageBoxA,NULL,addr noSub,addr titulo,MB_OK

  	

	fin: invoke ExitProcess,0
end main
