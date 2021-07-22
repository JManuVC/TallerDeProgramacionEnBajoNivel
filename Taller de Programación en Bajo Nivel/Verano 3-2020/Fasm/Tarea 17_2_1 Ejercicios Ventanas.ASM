

format PE GUI 4.0
entry start

include 'win32a.inc'	; Incluímos definiciones de estructuras y constantes
;WinMain proto dword,dword,dword,dword

cdXPos	      EQU  100	       ; Constante double X-Posición de la ventana(esq sup izqda)
cdYPos	      EQU  100	       ; Constante double Y-Posición de la ventana(esq sup izqda)
cdXSize       EQU  500	       ; Constante double X-tamaño de la ventana
cdYSize       EQU  600	       ; Constante double Y-tamaño de la ventana
cdColFondo    EQU  COLOR_WINDOW + 1  ; Color de fondo de la ventana: gris de un botón de comando
cdVIcono      EQU  IDI_APPLICATION ; Icono de la ventana, véase Resource.H
cdVCursor     EQU  IDC_ARROW   ; Cursor para la ventana
; Tipo de ventana (Barra de cabecera)
;cdVBarTipo  EQU  WS_EX_TOOLWINDOW		      ; Tipo de barra de Cabecera: delgado, sin icono, sin reflejo en barra de tareas
cdVBarTipo    EQU  NULL 			      ; Normal, con icono
cdVBtnTipo    EQU  WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU  ; Normal sólo con botón cerrar
cdID_MSG      EQU  500
cdID_SALIR    EQU  501

section '.text' code readable executable
  start:
    invoke    GetModuleHandle,0
    mov       [wc.hInstance],eax
    invoke    GetCommandLine
    mov       [CommandLine], EAX
    stdcall   WinMain, [wc.hInstance], NULL, [CommandLine], SW_SHOWDEFAULT
    invoke    ExitProcess,[msg.wParam]

proc WinMain uses ebx esi edi, hInst, hPrevInst, CmdLine, CmdShow
    ;  Propósito: Inicializamos la ventana principal de la aplicación y captura errores, si los hubiere
    ;  Entrada	: hInst, hPrevInst, CmdLine, CmdShow
    ;  Salida	: Ninguna
    ;  Destruye : Ninguna
    invoke    LoadIcon,0,cdVIcono
    mov       [wc.hIcon],eax
    invoke    LoadCursor,0,cdVCursor
    mov       [wc.hCursor],eax
    invoke    RegisterClass,wc
    test      eax,eax
    jz	      error

    invoke    CreateWindowEx,cdVBarTipo,NombreClase,MsgCabecera,\
	      cdVBtnTipo,cdXPos, cdYPos, cdXSize, cdYSize,\
	      NULL,NULL,[wc.hInstance],NULL
    test      eax,eax
    jz	      error

    msg_loop:
      invoke	GetMessage,msg,NULL,0,0
      cmp	eax,1
      jb	end_loop
      jne	msg_loop
      invoke	TranslateMessage,msg
      invoke	DispatchMessage,msg
    jmp       msg_loop

  error:
    invoke    MessageBox,NULL,MsgError,NULL,MB_ICONERROR+MB_OK

  end_loop:
    MOV       EAX, [msg.wParam]
    ret
endp

proc WndProc uses ebx esi edi, hWnd,wmsg,wparam,lparam
    ;  Propósito: Procesa los mensajes provenientes de las ventanas
    ;  Entrada	: hwnd,wmsg,wparam,lparam
    ;  Salida	: Ninguna
    ;  Destruye : Ninguna
    ;  Si usáramos WM_PAINT, al menos aquí habría que redireccionar a wmDefault para que funcione
    
    mov       eax, [wmsg]
    cmp       eax, WM_DESTROY
    jz	      wmDestroy
    cmp       eax, WM_COMMAND
    jz	      wmCommand
    cmp       eax, WM_CREATE
    jz	      wmCreate

    wmDefault:
	invoke	 DefWindowProcA, [hWnd], [wmsg], [wparam], [lparam]
	jmp	 wmFin
    wmCreate:
	invoke CreateWindowEx,NULL,boton,cboton1,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	420,520,40,23,[hWnd],23,[wc.hInstance],NULL

	invoke CreateWindowEx,NULL, edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,30,130,25,[hWnd],24,[wc.hInstance],NULL
	mov [hedit1],eax
	invoke CreateWindowEx,NULL, edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	180,30,130,25,[hWnd],25,[wc.hInstance],NULL
	mov [hedit2],eax
	invoke CreateWindowEx,NULL,boton,cboton2,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,30,120,25,[hWnd],26,[wc.hInstance],NULL				;longitudes
		
		 invoke CreateWindowEx,NULL,edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,80,130,25,[hWnd],27,[wc.hInstance],NULL
	mov [hedit3],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	180,80,130,25,[hWnd],28,[wc.hInstance],NULL
	mov [hedit4],eax
	invoke CreateWindowEx,NULL, boton,comparar,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,80,130,25,[hWnd],29,[wc.hInstance],NULL
		
		 invoke CreateWindowEx,NULL,edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,130,130,25,[hWnd],30,[wc.hInstance],NULL
	mov [hedit5],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	180,130,100,25,[hWnd],31,[wc.hInstance],NULL
	mov [hedit6],eax
		  invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_NUMBER	or ES_CENTER or WS_BORDER,\
	300,130,45,25,[hWnd],32,[wc.hInstance],NULL
	mov [hedit7],eax
	invoke CreateWindowEx,NULL,  boton, asignar,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	350,130,80,25,[hWnd],33,[wc.hInstance],NULL
		
		 invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,180,130,25,[hWnd],34,[wc.hInstance],NULL
	mov [hedit8],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	180,180,130,25,[hWnd],35,[wc.hInstance],NULL
	mov [hedit9],eax
	invoke CreateWindowEx,NULL,  boton, concatenar,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,180,80,25,[hWnd],36,[wc.hInstance],NULL
		
		invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or ES_LOWERCASE	or WS_BORDER,\
	40,230,130,25,[hWnd],37,[wc.hInstance],NULL
	mov [hedit10],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY	or WS_BORDER,\
	180,230,130,25,[hWnd],38,[wc.hInstance],NULL
	mov [hedit11],eax
	invoke CreateWindowEx,NULL,  boton, convMay,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,230,130,25,[hWnd],39,[wc.hInstance],NULL
		
		invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,280,130,25,[hWnd],40,[wc.hInstance],NULL
	mov [hedit12],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY	or WS_BORDER,\
	180,280,130,25,[hWnd],41,[wc.hInstance],NULL
	mov [hedit13],eax
	invoke CreateWindowEx,NULL,  boton, supr,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,280,130,25,[hWnd],42,[wc.hInstance],NULL
		
		invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,330,130,25,[hWnd],43,[wc.hInstance],NULL
	mov [hedit14],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	180,330,130,25,[hWnd],44,[wc.hInstance],NULL
	mov [hedit15],eax
	invoke CreateWindowEx,NULL,  boton, subcad,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,330,150,25,[hWnd],45,[wc.hInstance],NULL
		
		invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,380,130,25,[hWnd],46,[wc.hInstance],NULL
	mov [hedit16],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	180,380,130,25,[hWnd],47,[wc.hInstance],NULL
	mov [hedit17],eax
	invoke CreateWindowEx,NULL,  boton, caracter,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,380,150,25,[hWnd],48,[wc.hInstance],NULL
		
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
	40,430,130,25,[hWnd],49,[wc.hInstance],NULL
	mov [hedit18],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY or WS_BORDER,\
	180,430,130,25,[hWnd],50,[wc.hInstance],NULL
	mov [hedit19],eax
	invoke CreateWindowEx,NULL,  boton, invertir,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,430,150,25,[hWnd],51,[wc.hInstance],NULL
		
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or ES_LOWERCASE or WS_BORDER,\
	40,480,130,25,[hWnd],52,[wc.hInstance],NULL
	mov [hedit20],eax
	invoke CreateWindowEx,NULL,  edit,NULL,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY or WS_BORDER,\
	180,480,130,25,[hWnd],53,[wc.hInstance],NULL
	mov [hedit21],eax
	invoke CreateWindowEx,NULL,  boton, intercalar,\
	WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
	320,480,150,25,[hWnd],54,[wc.hInstance],NULL


	jmp	 wmFin
    wmCommand:

	cmp [wparam],23
	je btn_Salir
	cmp [wparam],26
	je longitudes
	cmp [wparam],29
	je compararB
	cmp [wparam],36
	je concatenarB
	cmp [wparam],33
	je asignarB
	cmp [wparam],39
	je convMayB
	cmp [wparam],42
	je suprB
	cmp [wparam],45
	je subcadB
	cmp [wparam],48
	je caracB
	cmp [wparam],51
	je invertirB
	cmp [wparam],54
	je intercalarMayMinB
	jmp	 wmDefault
	    btn_Salir:
		jmp	 wmDestroy
		jmp	 wmFin
	    longitudes:
		invoke SendMessage,[hedit1],WM_GETTEXT,50,buffer1
		invoke SendMessage,[hedit2],WM_GETTEXT,50,buffer2

			mov esi,buffer1
	
			stdcall contarCad
		       ; invoke dwtoa,ecx,buffer3

			invoke	  wsprintf, buffer3, strFormat, ecx

			mov esi,buffer2
			stdcall contarCad

			invoke	  wsprintf, buffer4, strFormat, ecx
			;invoke dwtoa,ecx,buffer4
			invoke MessageBox,[hWnd],buffer3,tcad1,0

			invoke MessageBox,[hWnd],buffer4, tcad2,0
			 invoke SendMessage,[hedit1],WM_SETTEXT,0,0
			invoke SendMessage,[hedit2],WM_SETTEXT,0,0

			jmp	 wmFin
	    compararB:
			invoke SendMessage,[hedit3],WM_GETTEXT,50,cad1
			invoke SendMessage,[hedit4],WM_GETTEXT,50,cad2
			mov esi,cad1
			stdcall contarCad
			xor edx,edx
			mov dx,cx
			mov esi,cad2
			stdcall contarCad
			cmp cx,dx
			ja segMayor
			jb priMayor
			
			mov edi,cad1
			mov esi,cad2
			cicloC:
				cmp byte[edi],0
				je salirC
				mov dl,byte [edi]
				cmp byte  [esi],dl
				jne mostrarNoSon
				inc edi
				inc esi
			jmp cicloC
			salirC:
			sonMisma:
			invoke MessageBox,[hWnd],sonIguales,comparar,0
			jmp terminar
			mostrarNoSon:
			invoke MessageBox,[hWnd],noSonIguales,comparar,0
			jmp terminar
			segMayor:
			invoke MessageBox,[hWnd],segmayor,comparar,0
			jmp terminar
			priMayor:
			invoke MessageBox,[hWnd],primayor,comparar,0
			jmp terminar
	
			
			terminar:
			invoke SendMessage,[hedit3],WM_SETTEXT,0,0
			invoke SendMessage,[hedit4],WM_SETTEXT,0,0

			jmp	 wmFin
	   concatenarB:
				invoke SendMessage,[hedit8],WM_GETTEXT,50,cad3
				invoke SendMessage,[hedit9],WM_GETTEXT,50,cad4
				
				mov edi,cad3
				mov esi,cad5
				
			
				cicloCo:
					cmp byte[edi],0
					je salirCo
					mov dl,byte [edi]
					mov byte [esi],dl
					inc edi
					inc esi
				jmp cicloCo
				salirCo:
				mov edi,cad4
				
				cicloCo2:
					cmp byte [edi],0
					je salirCoc
					mov dl,byte [edi]
					mov byte[esi],dl
					inc edi
					inc esi
				jmp cicloCo2
				
				salirCoc:
					invoke MessageBox,[hWnd],cad5,concatenar,0
					invoke SendMessage,[hedit8],WM_SETTEXT,0,0
					invoke SendMessage,[hedit9],WM_SETTEXT,0,0
					mov edi,cad5
					stdcall limpiarCad

			jmp	 wmFin
	     asignarB:
				invoke SendMessage,[hedit5],WM_GETTEXT,50, cad6
				invoke SendMessage,[hedit6],WM_GETTEXT,50,cad7
				invoke SendMessage,[hedit7],WM_GETTEXT,50,cad8
				mov edx, cad8 ; our string
				atoi:
				xor eax, eax ; zero a "result so far"
				.top:
				movzx ecx, byte [edx] ; get a character
				inc edx ; ready for next one
				cmp ecx, '0' ; valid?
				jb .done
				cmp ecx, '9'
				ja .done
				sub ecx, '0' ; "convert" character to number
				imul eax, 10 ; multiply "result so far" by ten
				add eax, ecx ; add in current digit
				jmp .top ; until done
				.done:
			       ; invoke atodw,addr cad8
				mov [number],ax
				mov edi,cad6
				mov ebx,cad9
				
				xor ecx,ecx
				mov cx,[number]
				avanzar:
						mov dl,byte [edi]
						mov byte [ebx],dl
						inc edi
						inc ebx
				loop avanzar
				mov esi,cad7
				insertar:
					cmp byte [esi],0
					je contI
					mov dl,byte [esi]
					mov byte  [ebx],dl
					inc esi
					inc ebx
				jmp insertar
				contI:
				insertar2:
					cmp byte  [edi],0
					je salirI
					mov dl,byte  [edi]
					mov byte  [ebx],dl
					inc edi
					inc ebx
				jmp insertar2
				salirI:
				invoke MessageBox,[hWnd],cad9,nueva,0
				invoke SendMessage,[hedit5],WM_SETTEXT,0,0
				invoke SendMessage,[hedit6],WM_SETTEXT,0,0
				invoke SendMessage,[hedit7],WM_SETTEXT,0,0
			jmp	 wmFin
	     convMayB:
				mov edi,cad10
				stdcall limpiarCad
				mov edi,cad11
				stdcall limpiarCad,cad11
				invoke SendMessage,[hedit10],WM_GETTEXT,50,cad10
				
				mov edi,cad10
				mov esi,cad11
				cicloMay:
								mov dl,byte [edi]
								cmp dl,0
								je salirM
								cmp dl,'z'
								ja saltarMay
								cmp dl,'A'
								jb saltarMay
								cmp dl,'a'
								jae contMay
								cmp dl,'Z'
								jae contMay
								jne saltarMay
								contMay:
									sub dl,20h
									mov byte [esi],dl
									inc esi
								saltarMay:
									inc edi
				jmp cicloMay
				salirM:
					
					invoke SendMessage,[hedit10],WM_SETTEXT,0,0
					invoke SendMessage,[hedit11],WM_SETTEXT,0,0
					invoke SendMessage,[hedit11],WM_SETTEXT,0,cad11
					mov edi,cad11
					stdcall limpiarCad
		   jmp	    wmFin
	       suprB:
			invoke SendMessage,[hedit12],WM_GETTEXT,50,cad12
				
				mov edi,cad12
				mov esi,cad13
				borrar:
					cmp byte [edi],0
					je salirB
					mov dl,byte [edi]
					cmp dl,20h
					je seguirB
					mov byte  [esi],dl
					inc esi
					seguirB:
						inc edi
				jmp borrar
				salirB:
					invoke SendMessage,[hedit12],WM_SETTEXT,0,0
					invoke SendMessage,[hedit13],WM_SETTEXT,0,0
					invoke SendMessage,[hedit13],WM_SETTEXT,0,cad13
					mov edi,cad13
					stdcall limpiarCad


	       jmp	wmFin
	       subcadB:
			mov edi,cad1
			stdcall limpiarCad
			mov edi,cad2
			stdcall limpiarCad
					
			invoke SendMessage,[hedit14],WM_GETTEXT,50,cad1
			invoke SendMessage,[hedit15],WM_GETTEXT,50,cad2
					
					
			mov edi,cad1
			    cicloS:
					    cmp byte  [edi],0
					    je salir
					       mov esi,cad2
					       mov bh,0
						  continueS:
							 mov bl,byte [esi]
							 cmp byte[edi],bl
							 jne seguirS
							 cmp byte [esi+1],0
							 je  mostrarS
							  inc edi
							  inc esi
							  inc bh
							  jmp continueS
							   seguirS:
								cmp bh,0
								jne sigS
								inc di
							   sigS:
								
							jmp cicloS

							salir:
								noEs:
								invoke MessageBox,[hWnd],noSub,subcad,0
							jmp acabaS
							
							
							mostrarS:
								invoke MessageBox,[hWnd], esSub,subcad,0
							
							acabaS:
									invoke SendMessage,[hedit14],WM_SETTEXT,0,0
									invoke SendMessage,[hedit15],WM_SETTEXT,0,0

	       jmp	wmFin
	       caracB:
	       mov edi,cad1
	       stdcall limpiarCad
					mov edi,cad2
					stdcall limpiarCad
					mov edi,cad3
					stdcall limpiarCad
					invoke SendMessage,[hedit16],WM_GETTEXT,50,cad1
					invoke SendMessage,[hedit17],WM_GETTEXT,50,cad2
					
					mov edi, cad1
					xor dx,dx
					mov dl,0
					xor ecx,ecx
					mov esi,cad2
					xor bx,bx
					mov bl,byte [esi]
					
					cicloCa:
						cmp byte [edi],0
						je salirCa
						
						cmp byte[edi],bl
						jne saltarC
						inc ecx
						saltarC:
						inc edi

					jmp cicloCa

					salirCa:

				      ;  invoke dwtoa, ecx, addr cad3
					invoke	  wsprintf, cad3, strFormat, ecx
					invoke MessageBox,[hWnd],cad3,caracter,MB_OK
					invoke SendMessage,[hedit16],WM_SETTEXT,0,0
					invoke SendMessage,[hedit17],WM_SETTEXT,0,0



	       jmp	wmFin
	       invertirB:
					mov edi,cad1
					stdcall limpiarCad
					mov edi,cad2
					stdcall limpiarCad
					
					invoke SendMessage,[hedit18],WM_GETTEXT,50,cad1
					
					
					mov edi,cad1
					xor ecx,ecx
					avanI:
							cmp byte[edi],0
							je continueIn
							inc edi
							inc cx
					jmp avanI
					continueIn:
					
						mov esi,cad2
						dec edi
						cicloInv:
								mov dl,byte[edi]
								
								cmp dl,'z'
								ja saltarInv
								cmp dl,'A'
								jb saltarInv
								cmp dl,'a'
								jae contInv
								cmp dl,'Z'
								jae contInv
								jne saltarInv
								contInv:
									mov byte [esi],dl
									inc esi
								saltarInv:
									dec edi
						loop cicloInv
					salirInv:		
					invoke SendMessage,[hedit19],WM_SETTEXT,0,cad2
					invoke SendMessage,[hedit18],WM_SETTEXT,0,0


	       jmp	wmFin
	       intercalarMayMinB:
					mov edi,cad1
					stdcall limpiarCad
					mov edi,cad2
					stdcall limpiarCad
					
					invoke SendMessage,[hedit20],WM_GETTEXT,50,cad1
					mov edi,cad1
					mov esi,cad2
					xor ebx,ebx
					
					inter:
						mov dl, byte [edi]
						cmp  dl,0
						je salirInter
						cmp dl,'z'
						ja seI
						cmp dl,'A'
						jb seI
						cmp dl,'a'
						jae contInt
						cmp dl,'Z'
						jae contInt
						jne seI
						contInt:
						cmp bl,0
						je mayus
						jne min
						mayus:
						mov dl, byte [edi]
						sub dl,20h
						mov byte [esi],dl
						inc esi
						mov bl,1
						jmp seI
						min:
						mov dl, byte [edi]
						mov byte [esi],dl
						inc esi
						mov bl,0
								
						seI:
						inc edi 
						
						
					jmp inter
					salirInter:
						invoke SendMessage,[hedit21],WM_SETTEXT,0,cad2
						invoke SendMessage,[hedit20],WM_SETTEXT,0,0

	       jmp	wmFin


    wmDestroy:
	invoke	 PostQuitMessage,0
    wmFin:
    ret
endp
proc contarCad
      xor ecx,ecx
	cicloContar:
	mov al,[esi]
	cmp al,0
	je salirContar
	inc cx
	inc esi
	jmp cicloContar
	salirContar:
	ret
	  endp
proc limpiarCad

	limp:
		cmp byte [edi],0
		je salirL
		mov byte [edi],0
		inc edi
	jmp limp
	salirL:
	ret
  endp

section '.data' data readable writeable

  MsgCabecera	  db	"Control", 0
  NombreClase	  db	"SimpleWinClass", 0
  MsgError	  db	"Carga inicial fallida.",0
  boton db "BUTTON",0
	cboton1 db "Salir",0
	cboton2 db "Longitud Cadena",0
	editText1 db "Ingrese su numero 1",0
	editText2 db "Ingrese su numero 2",0
	editText3 db "resultado",0
	cadena1 db "el tamanio de cadena 1 es:",0
	cadena2 db "el tamanio de cadena 2 es:",0
		tcad1 db "Longitud cadena 1",0
		tcad2 db "Longitud cadena 2",0
	comparar db "Comparar",0
		asignar db "Asignar",0
		concatenar db "Concatenar",0
		sonIguales db "Son iguales",0
		noSonIguales db "No son Iguales",0
	comboBox db "ComboBox",0
		segmayor db "No son iguales.",10,13,"La segunda cadena es mayor que la primera",0
		primayor db "No son iguales.",10,13,"La primera cadena es mayor que la segunda",0
		edit	db "Edit",0
		scroll	db "ScrollBar",0
		static	 db "Static",0
		control  db "Control",0
		listBox  db "ListBox",0
		number dw 0
		convMay db "Conv. Mayusculas",0
		nueva db "Nueva Cadena",0
		supr db "Supr. Espacios",0
		subcad db "Busqueda subcadena",0
		esSub db "Si es subcadena",0
		noSub db "No es subcadena",0
		caracter db "Busqueda caracter",0
		invertir db "Invertir Cadena",0
		intercalar db "Intercalar May-Min",0
		 hInstance dd ?
	buffer1 db 50 dup(?)
	buffer2 db 50 dup(?)
	buffer3 db 50 dup(?)
		buffer4 db 50 dup(?)
		cad1 db 50 dup(?)
		cad2 db 50 dup(?)
		cad3 db 50 dup(?)
		cad4 db 50 dup(?)
		cad5 db 50 dup(?)
		
		cad6 db 50 dup(?)
		cad7 db 50 dup(?)
		cad8 db 50 dup(?)
		cad9 db 50 dup(?)
		
		cad10 db 50 dup(?)
		cad11 db 50 dup(?)
		
		cad12 db 50 dup(?)
		cad13 db 50 dup(?)
		
		cad14 db 50 dup(?)
		cad15 db 50 dup(?)
	hedit1 dd ?
	hedit2 dd ?
		hedit3 dd ?
	hedit4 dd ?
		hedit5 dd ?
		hedit6 dd ?
		hedit7 dd ?
		hedit8 dd ?
		hedit9 dd ?
		hedit10 dd ?
		hedit11 dd ?
		hedit12 dd ?
		hedit13 dd ?
		hedit14 dd ?
		hedit15 dd ?
		hedit16 dd ?
		hedit17 dd ?
		hedit18 dd ?
		hedit19 dd ?
		hedit20 dd ?
		hedit21 dd ?
		 strFormat	 db '%d',0


  wc		  WNDCLASS 0,WndProc,0,0,NULL,NULL,NULL,cdColFondo,NULL,NombreClase
  msg		  MSG
  rct		  RECT	   NULL, NULL, NULL, NULL
  CommandLine	  rd	1
  wHandle	  rd	1

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas para que el enlazador pueda trabajar
	  user32,'USER32.DLL'	       ; Importamos las bibliotecas para que el enlazador pueda trabajar

  include 'api\kernel32.inc'	       ; KERNEL32 API calls
  include 'api\user32.inc'	       ; USER32 API calls
 
