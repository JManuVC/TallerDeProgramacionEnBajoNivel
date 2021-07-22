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
	
		
.data?
	buffer db 50 dup(?)
	cad db 50 dup(?)
.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr buffer, 50 
	
    lea edi, buffer
	xor edx,edx
	lea esi, cad
	ciclo:
		cmp [edi],dx
		je salir
		
			cmp byte ptr[edi],'A'
            jb saltar
            cmp byte ptr[edi],'z'
            ja saltar
            cmp byte ptr[edi],'a'
            jae agregar
            cmp byte ptr[edi],'Z'
            jbe agregar
            jne saltar
           agregar:
		mov bx,[edi]
            mov [esi],bx
            inc esi
           saltar:
           
            inc edi
	      
	jmp ciclo

	salir:
  	
	invoke MessageBoxA,NULL,addr cad,addr titulo,MB_OK
	invoke ExitProcess,0
end main
