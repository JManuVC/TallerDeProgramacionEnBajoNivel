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
	titulo db "Caracteres",0
	    
	pedircadena db "Ingrese una cadena ",0
	noEsP db "No es palindrome",0
	esPa db "Es palindrome",0
		
.data?
	buffer db 50 dup(?)
	

.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr buffer, 50 
	
    lea edi, buffer
	xor edx,edx

	xor ecx,ecx
	recorrer:
		cmp byte ptr[edi],0
		je cont
		inc edi
		inc cl
	jmp recorrer
cont:
	dec edi
	mov al,cl
	mov bl,2
	div bl
	mov cl,al
	lea esi,buffer
	ciclo:		
			mov dl,byte ptr [edi]
			cmp byte ptr[esi],dl
			jne noEs
			inc esi
			dec edi
	      
	loop ciclo
	
	invoke MessageBoxA,NULL,addr esPa,addr titulo,MB_OK
	jmp fin
  noEs:
	invoke MessageBoxA,NULL,addr noEsP,addr titulo,MB_OK
fin:	
	invoke ExitProcess,0
end main
