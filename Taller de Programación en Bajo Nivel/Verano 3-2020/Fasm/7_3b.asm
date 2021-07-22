format PE CONSOLE 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable
  start:


    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke WriteFile, eax,cad,cad.len,hNum,0
    xor        eax, eax

	mov esi,cad
    
	mov al,cad.len
	mov bl,3
	div bl
	xor ecx,ecx
	mov cl,al
	mov esi,cad
		 
	xor dx,dx
	xor ecx,ecx
	mov cl,al
	mov edi,izq

       cicloiz:
	mov dx,[esi]
	mov [edi],dx
	inc esi
	inc edi
       loop cicloiz

       xor ebx,ebx
       mov bl,al
       mov bh,ah
       add bl,bh
       
       xor ecx,ecx
       mov cl,bl

       mov edi,medi
       xor edx,edx
      ciclom:
	    mov dl,[esi]
	    mov [edi],dl
	    inc esi
	    inc edi
	    xor edx,edx
      loop ciclom
       
       xor edx,edx
       xor ecx,ecx
       mov cl,al
       mov edi,der
       
       cicloder:
	    mov dl,byte[esi]
	    mov byte[edi],dl
	    inc edi
	    inc esi
	loop cicloder
    mostrar:
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke WriteFile, eax,pizq,pizq.len,hNum,0
    xor        eax, eax
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke WriteFile, eax,izq,1,hNum,0
    xor        eax, eax
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke WriteFile, eax,pmed,pmed.len,hNum,0
    xor        eax, eax
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke WriteFile, eax,medi,2,hNum,0
    xor        eax, eax
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke WriteFile, eax,pder,pder.len,hNum,0
    xor        eax, eax
    invoke     GetStdHandle, STD_OUTPUT_HANDLE
    invoke WriteFile, eax,der,1,hNum,0
    xor        eax, eax

   invoke    ExitProcess,0


section '.data' data readable writeable
    hNum	 RQ 1
    cad 	 DB "hola",0
    cad.len	 =$-cad     ; Cadena estructurada
    pizq	 DB 10,13,"Parte Izquierda: ",0
    pizq.len	 =$-pizq
    pmed	 DB 10,13,"Parte Media: ",0
    pmed.len	 =$-pmed
    pder	 DB 10,13,"Parte Izquierda: ",0
    pder.len	 =$-pder

    izq 	DB ?
    medi	DB ?
    der 	DB ?




section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL'
  include 'api\kernel32.inc'
