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
	nombrelen equ $-nombre
.data	
	titulo db "Iniciales",0	
	
	nombre db "jose manuel vargas cruz",0
	
		
.data?
	
	iniciales db 10 dup(?)
	numero db 50 dup(?)

.code
main:
	
	lea edi,nombre
	xor ecx,ecx
	lea esi,iniciales
	mov dl,byte ptr[edi]
	sub dl,20h
	mov byte ptr[esi],dl
	inc edi
	inc esi
	ciclo:
		cmp byte ptr[edi],0
		je salir
        cmp byte ptr[edi],20h
        jne saltar 
        cmp byte ptr[edi-1],20h
        je saltar            
        
        mov dl,byte ptr [edi+1]
		sub dl,20h
		mov [esi],dl
        inc esi
        saltar:
            inc edi
    jmp ciclo
        
            
        
	salir:
	

	invoke MessageBoxA,NULL,addr iniciales,addr titulo,MB_OK
	invoke ExitProcess,0
	
end main


