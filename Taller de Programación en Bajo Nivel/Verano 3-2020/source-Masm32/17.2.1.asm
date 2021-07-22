      
        .386
.model flat, stdcall
        option casemap :none   ; case sensitive
        
        include c:\masm32\include\windows.inc
        include c:\masm32\include\user32.inc
        include c:\masm32\include\kernel32.inc
        include c:\masm32\include\masm32.inc
        includelib c:\masm32\lib\user32.lib
        includelib c:\masm32\lib\kernel32.lib
        includelib c:\masm32\lib\masm32.lib
        WinMain proto :DWORD,:DWORD,:DWORD,:SDWORD
        WndProc proto :DWORD,:DWORD,:DWORD,:DWORD
        contarCad proto 
		limpiarCad proto :DWORD
.const

.data
        ClassName db "SimpleWinClass",0
        salirText db "Adios Vuelva pronto",0
        AppName  db "Operaciones con cadenas",0
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
		edit    db "Edit",0
		scroll  db "ScrollBar",0
		static   db "Static",0
		control  db "Control",0
		listBox  db "ListBox",0
		number dword 0
		convMay db "Conv. Mayusculas",0
		nueva db "Nueva Cadena",0
		supr db "Supr. Espacios",0
		subcad db "Busqueda subcadena",0
		esSub db "Si es subcadena",0
		noSub db "No es subcadena",0
		caracter db "Busqueda caracter",0
		invertir db "Invertir Cadena",0
		intercalar db "Intercalara May-Min",0
.data?
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
        CommandLine LPSTR ?
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
.code
        start:
	invoke GetModuleHandle, NULL
	mov    hInstance,eax
	invoke GetCommandLine
	mov    CommandLine,eax
        invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
	invoke ExitProcess,eax
WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:SDWORD
	LOCAL wc:WNDCLASSEX
	LOCAL msg:MSG
        LOCAL hwnd:HWND
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
        push  hInstance
        pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_WINDOW+1 ;
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,OFFSET ClassName
        invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
        mov   wc.hIconSm,0
        invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
        invoke RegisterClassEx, addr wc
        INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
           WS_OVERLAPPEDWINDOW,100,\
           100,500,600,NULL,NULL,\
           hInst,NULL
        mov   hwnd,eax
        INVOKE ShowWindow, hwnd,SW_SHOWNORMAL
        INVOKE UpdateWindow, hwnd
        .WHILE TRUE
                INVOKE GetMessage, ADDR msg,NULL,0,0
                .BREAK .IF (!eax)
                INVOKE TranslateMessage, ADDR msg
                INVOKE DispatchMessage, ADDR msg
        .ENDW
        mov     eax,msg.wParam
        ret
WinMain endp
WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	mov   eax,uMsg
.IF eax== WM_CREATE
        invoke CreateWindowEx,NULL, ADDR boton,ADDR cboton1,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        420,520,40,23,hWnd,23,hInstance,NULL

        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,30,130,25,hWnd,24,hInstance,NULL
        mov hedit1,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        180,30,130,25,hWnd,25,hInstance,NULL
        mov hedit2,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR cboton2,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,30,120,25,hWnd,26,hInstance,NULL                             ;longitudes
		
		 invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,80,130,25,hWnd,27,hInstance,NULL
        mov hedit3,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        180,80,130,25,hWnd,28,hInstance,NULL
        mov hedit4,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR comparar,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,80,130,25,hWnd,29,hInstance,NULL
		
		 invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,130,130,25,hWnd,30,hInstance,NULL
        mov hedit5,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        180,130,100,25,hWnd,31,hInstance,NULL
        mov hedit6,eax
		  invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_NUMBER	or ES_CENTER or WS_BORDER,\
        300,130,45,25,hWnd,32,hInstance,NULL
        mov hedit7,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR asignar,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        350,130,80,25,hWnd,33,hInstance,NULL
		
		 invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,180,130,25,hWnd,34,hInstance,NULL
        mov hedit8,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        180,180,130,25,hWnd,35,hInstance,NULL
        mov hedit9,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR concatenar,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,180,80,25,hWnd,36,hInstance,NULL
		
		invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or ES_LOWERCASE	or WS_BORDER,\
        40,230,130,25,hWnd,37,hInstance,NULL
        mov hedit10,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY	or WS_BORDER,\
        180,230,130,25,hWnd,38,hInstance,NULL
        mov hedit11,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR convMay,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,230,130,25,hWnd,39,hInstance,NULL
		
		invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,280,130,25,hWnd,40,hInstance,NULL
        mov hedit12,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY	or WS_BORDER,\
        180,280,130,25,hWnd,41,hInstance,NULL
        mov hedit13,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR supr,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,280,130,25,hWnd,42,hInstance,NULL
		
		invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,330,130,25,hWnd,43,hInstance,NULL
        mov hedit14,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        180,330,130,25,hWnd,44,hInstance,NULL
        mov hedit15,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR subcad,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,330,150,25,hWnd,45,hInstance,NULL
		
		invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,380,130,25,hWnd,46,hInstance,NULL
        mov hedit16,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        180,380,130,25,hWnd,47,hInstance,NULL
        mov hedit17,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR caracter,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,380,150,25,hWnd,48,hInstance,NULL
		
		invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or WS_BORDER,\
        40,430,130,25,hWnd,49,hInstance,NULL
        mov hedit18,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY or WS_BORDER,\
        180,430,130,25,hWnd,50,hInstance,NULL
        mov hedit19,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR invertir,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,430,150,25,hWnd,51,hInstance,NULL
		
		invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or ES_LOWERCASE or WS_BORDER,\
        40,480,130,25,hWnd,52,hInstance,NULL
        mov hedit20,eax
        invoke CreateWindowEx,NULL, ADDR edit,NULL,\
        WS_CHILD or WS_VISIBLE or ES_CENTER or ES_READONLY or WS_BORDER,\
        180,480,130,25,hWnd,53,hInstance,NULL
        mov hedit21,eax
        invoke CreateWindowEx,NULL, ADDR boton,ADDR intercalar,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        320,480,150,25,hWnd,54,hInstance,NULL

        
.ELSEIF  eax==WM_COMMAND

      mov eax,wParam
       
			.IF eax==23
			;invoke MessageBox,hWnd,addr salirText,0,1
			invoke SendMessage,hWnd,WM_CLOSE,NULL,NULL
			
			.elseif eax==26
			invoke SendMessage,hedit1,WM_GETTEXT,50,addr buffer1
			invoke SendMessage,hedit2,WM_GETTEXT,50,addr buffer2

			lea esi,buffer1
        
			invoke contarCad	
			invoke dwtoa,ecx,addr buffer3
			lea esi,buffer2
			invoke contarCad
			invoke dwtoa,ecx,addr buffer4
			invoke MessageBox,hWnd,addr buffer3,addr tcad1,0

			invoke MessageBox,hWnd,addr buffer4,addr tcad2,0
			 invoke SendMessage,hedit1,WM_SETTEXT,0,0
			invoke SendMessage,hedit2,WM_SETTEXT,0,0
			
			.elseif eax==29
			invoke SendMessage,hedit3,WM_GETTEXT,50,addr cad1
			invoke SendMessage,hedit4,WM_GETTEXT,50,addr cad2
			lea esi,cad1
			invoke contarCad
			xor edx,edx
			mov dx,cx
			lea esi,cad2
			call contarCad
			cmp cx,dx
			ja segMayor
			jb priMayor
			
			lea edi,cad1
			lea esi,cad2
			cicloC:
				cmp byte ptr[edi],0
				je salirC
				mov dl,byte ptr [edi]
				cmp byte ptr [esi],dl
				jne mostrarNoSon
				inc edi
				inc esi
			jmp cicloC
			salirC:
			sonMisma:
			invoke MessageBox,hWnd,addr sonIguales,addr comparar,0
			jmp terminar
			mostrarNoSon:
			invoke MessageBox,hWnd,addr noSonIguales,addr comparar,0
			jmp terminar
			segMayor:
			invoke MessageBox,hWnd,addr segmayor,addr comparar,0
			jmp terminar
			priMayor:
			invoke MessageBox,hWnd,addr primayor,addr comparar,0
			jmp terminar
	
			
			terminar:
			invoke SendMessage,hedit3,WM_SETTEXT,0,0
			invoke SendMessage,hedit4,WM_SETTEXT,0,0 
			
			.elseif eax==36
				invoke SendMessage,hedit8,WM_GETTEXT,50,addr cad3
				invoke SendMessage,hedit9,WM_GETTEXT,50,addr cad4
				
				lea edi,cad3
				lea esi,cad5
				
			
				cicloCo:
					cmp byte ptr[edi],0
					je salirCo
					mov dl,byte ptr[edi]
					mov byte ptr[esi],dl
					inc edi
					inc esi
				jmp cicloCo
				salirCo:
				lea edi,cad4
				
				cicloCo2:
					cmp byte ptr[edi],0
					je salirCoc
					mov dl,byte ptr[edi]
					mov byte ptr[esi],dl
					inc edi
					inc esi
				jmp cicloCo2
				
				salirCoc:
					invoke MessageBox,hWnd,addr cad5,addr concatenar,0
					invoke SendMessage,hedit8,WM_SETTEXT,0,0
					invoke SendMessage,hedit9,WM_SETTEXT,0,0 
					invoke limpiarCad,addr cad5
			.elseif eax==33
				invoke SendMessage,hedit5,WM_GETTEXT,50,addr cad6
				invoke SendMessage,hedit6,WM_GETTEXT,50,addr cad7
				invoke SendMessage,hedit7,WM_GETTEXT,50,addr cad8
				
				invoke atodw,addr cad8
				mov number,eax
				lea edi,cad6
				lea ebx,cad9
				
				xor ecx,ecx
				mov ecx,number
				avanzar:
						mov dl,byte ptr[edi]
						mov byte ptr [ebx],dl
						inc edi
						inc ebx
				loop avanzar
				lea esi,cad7
				insertar:
					cmp byte ptr[esi],0
					je contI
					mov dl,byte ptr [esi]
					mov byte ptr [ebx],dl
					inc esi
					inc ebx
				jmp insertar
				contI:
				insertar2:
					cmp byte ptr [edi],0
					je salirI
					mov dl,byte ptr [edi]
					mov byte ptr [ebx],dl
					inc edi
					inc ebx
				jmp insertar2
				salirI:
				invoke MessageBox,hWnd,addr cad9,addr nueva,0
				invoke SendMessage,hedit5,WM_SETTEXT,0,0
				invoke SendMessage,hedit6,WM_SETTEXT,0,0 
				invoke SendMessage,hedit7,WM_SETTEXT,0,0
			.elseif eax==39
				invoke limpiarCad,addr cad10
				invoke limpiarCad,addr cad11
				invoke SendMessage,hedit10,WM_GETTEXT,50,addr cad10
				
				lea edi,cad10
				lea esi,cad11
				cicloMay:
								mov dl,byte ptr[edi]
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
									mov byte ptr[esi],dl
									inc esi
								saltarMay:
									inc edi
				jmp cicloMay
				salirM:
					
					invoke SendMessage,hedit10,WM_SETTEXT,0,0
					invoke SendMessage,hedit11,WM_SETTEXT,0,0
					invoke SendMessage,hedit11,WM_SETTEXT,0,addr cad11					
					invoke limpiarCad, addr cad11
			.elseif eax==42
				invoke SendMessage,hedit12,WM_GETTEXT,50,addr cad12
				
				lea edi,cad12
				lea esi,cad13
				borrar:
					cmp byte ptr [edi],0
					je salirB
					mov dl,byte ptr [edi]
					cmp dl,20h
					je seguirB
					mov byte ptr [esi],dl
					inc esi
					seguirB:
						inc edi
				jmp borrar
				salirB:
					invoke SendMessage,hedit12,WM_SETTEXT,0,0
					invoke SendMessage,hedit13,WM_SETTEXT,0,0
					invoke SendMessage,hedit13,WM_SETTEXT,0,addr cad13					
					invoke limpiarCad, addr cad13
				.elseif eax==45
					invoke limpiarCad, addr cad1
					invoke limpiarCad, addr cad2
					
					invoke SendMessage,hedit14,WM_GETTEXT,50,addr cad1
					invoke SendMessage,hedit15,WM_GETTEXT,50,addr cad2
					
					
							lea edi,cad1
							cicloS:
							cmp byte ptr [edi],0
							je salir
							lea esi,cad2
							mov bh,0  
							   continueS: 
								mov bl,byte ptr[esi]
								cmp byte ptr[edi],bl
								jne seguirS
								cmp byte ptr[esi+1],0
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
								invoke MessageBox,hWnd,addr noSub,addr subcad,0
							jmp acabaS
							
							
							mostrarS:
								invoke MessageBox,hWnd,addr esSub,addr subcad,0
							
							acabaS:
									invoke SendMessage,hedit14,WM_SETTEXT,0,0
									invoke SendMessage,hedit15,WM_SETTEXT,0,0
				.elseif eax==48
					invoke limpiarCad, addr cad1
					invoke limpiarCad, addr cad2
					invoke limpiarCad, addr cad3
					invoke SendMessage,hedit16,WM_GETTEXT,50,addr cad1
					invoke SendMessage,hedit17,WM_GETTEXT,50,addr cad2
					
					lea edi, cad1
					xor dx,dx
					mov dl,0
					xor ecx,ecx
					lea esi,cad2
					xor bx,bx
					mov bl,byte ptr [esi]
					
					cicloCa:
						cmp byte ptr[edi],0
						je salirCa
						
						cmp byte ptr[edi],bl
						jne saltarC
						inc ecx
						saltarC:
						inc edi

					jmp cicloCa

					salirCa:
					invoke dwtoa, ecx, addr cad3
					invoke MessageBox,hWnd,addr cad3,addr caracter,MB_OK
					invoke SendMessage,hedit16,WM_SETTEXT,0,0
					invoke SendMessage,hedit17,WM_SETTEXT,0,0
				.elseif eax==51
					invoke limpiarCad, addr cad1
					invoke limpiarCad, addr cad2
					
					invoke SendMessage,hedit18,WM_GETTEXT,50,addr cad1
					
					
					lea edi,cad1
					xor ecx,ecx
					avanI:
							cmp byte ptr [edi],0
							je continueIn
							inc edi
							inc cx
					jmp avanI
					continueIn:
					
						lea esi,cad2
						dec edi
						cicloInv:
								mov dl,byte ptr[edi]
								
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
									mov byte ptr[esi],dl
									inc esi
								saltarInv:
									dec edi
						loop cicloInv
					salirInv:		
					invoke SendMessage,hedit19,WM_SETTEXT,0,addr cad2
					invoke SendMessage,hedit18,WM_SETTEXT,0,0
					
				.elseif eax==54
					invoke limpiarCad, addr cad1
					invoke limpiarCad, addr cad2
					
					invoke SendMessage,hedit20,WM_GETTEXT,50,addr cad1
					lea edi,cad1
					lea esi,cad2
					xor ebx,ebx
					
					inter:
						mov dl, byte ptr [edi]
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
						mov dl, byte ptr [edi]
						sub dl,20h
						mov byte ptr [esi],dl
						inc esi
						mov bl,1
						jmp seI
						min:
						mov dl, byte ptr [edi]
						mov byte ptr [esi],dl
						inc esi
						mov bl,0
								
						seI:
						inc edi 
						
						
					jmp inter
					salirInter:
						invoke SendMessage,hedit21,WM_SETTEXT,0,addr cad2
						invoke SendMessage,hedit20,WM_SETTEXT,0,0
			.endif
        
.ELSEIF eax==WM_DESTROY
		invoke PostQuitMessage,NULL
		xor eax,eax
        .ELSE
        
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
	.ENDIF
	ret
        WndProc endp
contarCad proc
		xor ecx,ecx
	cicloContar:
        mov al,[esi]
        cmp al,0
        je salir
        inc cx
        inc esi
        jmp cicloContar
		salir:
		ret
		contarCad endp
       
limpiarCad proc dir:dword
	mov edi,dir
	limp:
		cmp byte ptr[edi],0
		je salirL
		mov byte ptr[edi],0
		inc edi
	jmp limp
	salirL:
	
ret
limpiarCad endp
	   
		end start


