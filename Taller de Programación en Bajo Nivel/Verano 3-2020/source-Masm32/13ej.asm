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
	titulo db "Nueva cadena",0
	    
	pedircadena db "Ingrese una cadena ",0
	
		
.data?
	cad1 db 50 dup(?)
	cad2 db 50 dup(?)
.code
main:
	invoke StdOut, addr pedircadena
	invoke StdIn, addr cad1, 50  
	  
		lea edi,cad1
         lea esi,cad2
         mov bl,byte ptr[edi] 
         cmp bl,'a'
         jnae cont
         sub bl,20h
         cont:
            mov byte ptr[esi],bl 
            inc edi
            inc esi
      ciclo:
             
            cmp byte ptr[edi],0
			je salir
			cmp byte ptr[edi],20h
            je conti
            jne saltar
           conti:  
               mov bl,byte ptr[edi]
               mov byte ptr[esi],bl
                     
                inc esi
                inc edi
                
                mov bl,byte ptr[edi] 
                cmp bl,'a'
                jnae sig
                sub bl,20h
             
             sig:
                mov byte ptr[esi],bl 
                inc esi
                inc edi
                jmp parar
             saltar:   
                
                mov bl,byte ptr[edi]
                mov byte ptr[esi],bl 
                inc edi
                inc esi 
              parar:
              
         jmp ciclo 
	salir:
  	
	invoke MessageBoxA,NULL,addr cad2,addr titulo,MB_OK
	invoke ExitProcess,0
end main
