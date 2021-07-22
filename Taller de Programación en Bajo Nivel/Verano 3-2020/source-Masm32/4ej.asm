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
	titulo db "Cantidad de palabras",0	
	pedircadena db "Ingrese una cadena: ",0

		
.data?
	buffer db 50 dup(?)
	carac db 10 dup(?)
	numero db 50 dup(?)

.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr buffer, 50
	lea edi,buffer
	xor ecx,ecx
	ciclo:
		cmp byte ptr[edi],0
		je salir
        cmp byte ptr[edi],20h
        jne saltar 
        cmp byte ptr[edi-1],20h
        je saltar            
        
        inc cl
        
        saltar:
            inc di
    jmp ciclo
        
            
        
	salir:
	inc cl
  	invoke dwtoa, ecx, addr numero
	invoke MessageBoxA,NULL,addr numero,addr titulo,MB_OK
	invoke ExitProcess,0
	
end main


