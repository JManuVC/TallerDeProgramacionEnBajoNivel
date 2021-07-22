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
	
	lea edi,cad
    ciclo:
	cmp byte ptr [edi],0
	je salir
    lea esi,subcad
    mov bh,0  
       continue: 
        mov bl,byte ptr[esi]
        cmp byte ptr[edi],bl
        jne seguir
        cmp byte ptr[esi+1],0
        je  mostrar
        inc edi
        inc esi
        inc bh
        jmp continue
       seguir:
        cmp bh,0
        jne sig
        inc di
       sig:
        
    jmp ciclo

	salir:
		noEs:
		invoke MessageBoxA,NULL,addr noSub,addr titulo,MB_OK
	jmp fin
  	
	
	mostrar:
		invoke MessageBoxA,NULL,addr esSub,addr titulo,MB_OK
		


	fin: invoke ExitProcess,0
end main
