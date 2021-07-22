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
	titulo db "Cadena invertida",0	
	pedircadena db "Ingrese una cadena: ",0

		
.data?
	buffer db 50 dup(?)
	carac db 10 dup(?)
	cadena db 50 dup(?)

.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr buffer, 50
	lea edi,buffer
	xor ecx,ecx
	ciclo:
			cmp byte ptr [edi],0
			je continue
            inc edi
			inc cl
    jmp ciclo
    continue:
		lea esi,cadena
		dec edi
		ciclo2:
				mov dl,byte ptr[edi]
				cmp dl,'z'
				ja saltar
				cmp dl,'A'
				jb saltar
				cmp dl,'a'
				jae cont
				cmp dl,'Z'
				jae cont
				jne saltar
				cont:
					mov [esi],dl
					inc esi
				saltar:
					
					dec edi
		loop ciclo2
            
        
	salir:
	
	invoke MessageBoxA,NULL,addr cadena,addr titulo,MB_OK
	invoke ExitProcess,0
	
end main


