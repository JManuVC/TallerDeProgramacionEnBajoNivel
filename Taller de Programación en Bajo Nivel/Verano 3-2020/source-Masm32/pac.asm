        .386
.model flat, stdcall
        option casemap :none   ; case sensitive
        
        include c:\masm32\include\windows.inc
        include c:\masm32\include\user32.inc
        include c:\masm32\include\kernel32.inc
        include c:\masm32\include\gdi32.inc
        include c:\masm32\include\masm32.inc
        includelib c:\masm32\lib\user32.lib
        includelib c:\masm32\lib\kernel32.lib
        includelib c:\masm32\lib\gdi32.lib
		includelib c:\masm32\lib\masm32.lib
        WinMain proto :DWORD,:DWORD,:DWORD,:SDWORD
        WndProc proto :DWORD,:DWORD,:DWORD,:DWORD
		reemplazar proto :DWORD,:DWORD,:DWORD
		limpiarCad proto :DWORD
		obtenerPosPac proto :DWORD
		verificarGanar proto :DWORD
		restablecerMapa proto :DWORD,:DWORD
        RGB macro red,green,blue
        xor eax,eax
        mov ah,blue
        shl eax,8
        mov ah,green
        mov al,red
        endm 
.const

.data
        ClassName db "SimpleWinClass",0
        salirText db "Adios Vuelva pronto",0
        AppName  db "Pac-Man",0
        boton db "BUTTON",0
        
       
        
        salirBoton db "limpiar",0
        FontName db "Segoe UI Semibold",0
		FontName2 db "Tahoma",0
		FontName3 db "Impact",0
		palabra db "assembler",0
		
		rayas db "---------",0
		vidas dd 3
		felicidades1 db "FELICIDADES!",10,13,"Pasaste al segundo nivel",0
		felicidades2 db "FELICIDADES!",10,13,"Pasaste al tercer nivel",0
		felicidades3 db "FELICIDADES!",10,13,"Pasaste todos los niveles :D",0
		sorry db "Lo siento",0
		perdiste1 db "Perdiste :(",10,13,"Te quedaste sin vidas",0
		perdiste2 db "Perdiste :(",10,13,"Te quedaste sin vidas",10,13,"Volveras a empezar",0
		ganaste db "GANASTE! :D",0
		vidasT db "Vidas",0
		nivel dd 1
		nivelT db "Nivel",0
		puntos dd 0
		puntosT db "Puntaje",0
		puntuacion db "Puntuacion: ",0
		limp db "            ",0
		nombre db "Jose Manuel Vargas Cruz",0
		bandera dd 0
		mapa db "XXXXXXXXXX",10,13
			 db "Xo$ooooooX",10,13
			 db "XoXXXoXXoX",10,13
			 db "XoXXXoXX$X",10,13
			 db "XoXXXoXXoX",10,13
			 db "XooooooooX",10,13
			 db "XoXXXXXXoX",10,13
			 db "X<XXXXXXoX",10,13
			 db "XooooooooX",10,13
			 db "XXXXXXXXXX",10,13,0
			 
	   mapa1 db "XXXXXXXXXX",10,13
			 db "Xo$ooooooX",10,13
			 db "XoXXXoXXoX",10,13
			 db "XoXXXoXX$X",10,13
			 db "XoXXXoXXoX",10,13
			 db "XooooooooX",10,13
			 db "XoXXXXXXoX",10,13
			 db "X<XXXXXXoX",10,13
			 db "XooooooooX",10,13
			 db "XXXXXXXXXX",10,13,0

	   mapa2 db "XXXXXXXXXX",10,13
			 db "Xoooo$oooX",10,13
			 db "XoXoXoXXoX",10,13
			 db "Xo$oo<XXoX",10,13
			 db "XoXXXoXXoX",10,13
			 db "XooooooooX",10,13
			 db "XoXXXXXoXX",10,13
			 db "X$XXooooXX",10,13
			 db "Xoooo$oooX",10,13
			 db "XXXXXXXXXX",10,13,0
	   
	   mapa3 db "XXXXXXXXXX",10,13
			 db "X<oooooooX",10,13
			 db "XoXXXoXXoX",10,13
			 db "XoooX$XXoX",10,13
			 db "X$XoXoXX$X",10,13
			 db "XoooooXXoX",10,13
			 db "XoXoXoo$oX",10,13
			 db "X$XoXoXXoX",10,13
			 db "XooooooooX",10,13
			 db "XXXXXXXXXX",10,13,0
			 	 
.data?
        hInstance dd ?
        CommandLine LPSTR ?
        hdc dd ?
        hFont dd ?
		vidasC db 10 dup(?)
		posIni1 dd ?
		posIni2 dd ?
		posIni3 dd ?
		nivelC db 10 dup(?)
		puntosC db 10 dup(?)

.code
start:
	invoke obtenerPosPac,addr mapa1
	mov posIni1,ecx
	invoke obtenerPosPac,addr mapa2
	mov posIni2,ecx
	invoke obtenerPosPac,addr mapa3
	mov posIni3,ecx
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
	mov   wc.hbrBackground,COLOR_WINDOW+20
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,OFFSET ClassName
        invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
        mov   wc.hIconSm,0
        invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
        invoke RegisterClassEx, addr wc
        INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
        WS_OVERLAPPEDWINDOW,20,\
        20,900,600,NULL,NULL,\
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
        local ps:PAINTSTRUCT
        local rect:RECT
        
	mov   eax,uMsg
.IF eax== WM_CREATE
		 invoke CreateWindowEx,NULL, ADDR boton,ADDR salirBoton,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        100,120,40,23,hWnd,23,hInstance,NULL
		  
.ELSEIF  eax==WM_COMMAND

        mov eax,wParam
	.if eax==23
		mov bandera,1
		invoke InvalidateRect,hWnd,NULL,TRUE
      .endif
.ELSEIF eax==WM_PAINT
		.if bandera ==0
		invoke dwtoa,vidas,addr vidasC
		invoke dwtoa,nivel,addr nivelC
		invoke dwtoa,puntos,addr puntosC
        invoke BeginPaint,hWnd,addr ps
		 mov hdc,eax
        invoke GetClientRect,hWnd,addr rect 
		invoke CreateFont,40,30,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName2
		invoke SelectObject,hdc,eax
        mov hFont,eax
		invoke DrawText,hdc,addr mapa,-1,addr rect,DT_VCENTER or DT_CENTER ; or DT_CALCRECT
;VIDAS
		invoke CreateFont,50,40,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName3
        invoke SelectObject,hdc,eax
        mov hFont,eax		
        RGB 255, 251, 0 
        invoke SetTextColor,hdc,eax
		RGB 255, 6, 6
		invoke SetBkColor,hdc,eax
		invoke TextOut,hdc,30,150,addr vidasT,SIZEOF vidasT-1
		
		invoke CreateFont,50,40,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName3
        invoke SelectObject,hdc,eax
        mov hFont,eax	
		invoke TextOut,hdc,60,200,addr vidasC,1		
;Nivel
	invoke CreateFont,50,40,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName3
        invoke SelectObject,hdc,eax
        mov hFont,eax		
        RGB 255, 251, 0 
        invoke SetTextColor,hdc,eax
		RGB 10, 59, 223
		invoke SetBkColor,hdc,eax
		invoke TextOut,hdc,680,150,addr nivelT,SIZEOF nivelT-1
		
		invoke CreateFont,50,40,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName3
        invoke SelectObject,hdc,eax
        mov hFont,eax	
		invoke TextOut,hdc,710,200,addr nivelC,1		
;PUNTAJE
		invoke SelectObject,hdc,eax
        mov hFont,eax		
        RGB 255, 244, 11 
        invoke SetTextColor,hdc,eax
		RGB 198, 10, 223 
		invoke SetBkColor,hdc,eax
		invoke TextOut,hdc,370,480,addr puntosC,sizeof puntosC-7
		invoke TextOut,hdc,350,420,addr puntosT,sizeof puntosT-1
	invoke EndPaint,hWnd,addr ps
     .endif   
.ELSEIF eax== WM_CHAR
        mov eax,wParam
		xor edx,edx
		
		.if eax==61h   ;IZQUIERDA A
			invoke obtenerPosPac,addr mapa
			cmp mapa[ecx-1],58h
			je seguir
			cmp mapa[ecx-1],24h
			jne izq
			dec vidas
			;invoke MessageBox,hWnd,addr nombre,0,0
			.if vidas==0
				invoke InvalidateRect,hWnd,NULL,TRUE
				jmp perder
			.endif
			.if nivel==1
				mov edx,posIni1
				.elseif nivel==2
					mov edx,posIni2
				.elseif nivel==3
					mov edx,posIni3
			.endif
			
			mov mapa [edx],3Ch
			mov mapa [ecx],5Fh
			invoke InvalidateRect,hWnd,NULL,TRUE
			jmp seguir
			izq:
				cmp mapa [ecx-1],6Fh
				jne contI
				inc puntos
				contI:
			
			mov mapa [ecx-1],3Ch
			mov mapa [ecx],5Fh
			invoke InvalidateRect,hWnd,NULL,TRUE
			invoke verificarGanar,addr mapa
			cmp ecx,0
			jne seguir
			je ganar
		.elseif eax==64h				;DERECHA D
			invoke obtenerPosPac,addr mapa
			cmp mapa[ecx+1],58h
			je seguir
			cmp mapa[ecx+1],24h
			jne der
			
			dec vidas
			;invoke MessageBox,hWnd,addr nombre,0,0
			.if vidas==0
				invoke InvalidateRect,hWnd,NULL,TRUE
				jmp perder
			.endif
			.if nivel==1
				mov edx,posIni1
				.elseif nivel==2
					mov edx,posIni2
				.elseif nivel==3
					mov edx,posIni3
			.endif
			mov mapa [edx],3Ch
			mov mapa [ecx],5Fh
			invoke InvalidateRect,hWnd,NULL,TRUE
			jmp seguir
			der:
				cmp mapa [ecx+1],6Fh
				jne contD
				inc puntos
				contD:
			
			mov mapa [ecx+1],3Ch
			mov mapa [ecx],5Fh
			
			
			invoke InvalidateRect,hWnd,NULL,TRUE
		invoke verificarGanar,addr mapa
			cmp ecx,0
			jne seguir
			je ganar
		.elseif eax==77h    ;ARRIBA W
			invoke obtenerPosPac,addr mapa
			cmp mapa[ecx-12],58h     ; 58h =X
			je seguir				 ; 24h = $
			cmp mapa[ecx-12],24h     ; 40h = @
			jne arriba				 ;5Fh = _
			dec vidas
			;invoke MessageBox,hWnd,addr nombre,0,0
			.if vidas==0
				invoke InvalidateRect,hWnd,NULL,TRUE
				jmp perder
			.endif
			.if nivel==1
				mov edx,posIni1
				.elseif nivel==2
					mov edx,posIni2
				.elseif nivel==3
					mov edx,posIni3
			.endif
			mov mapa [edx],3Ch
			mov mapa [ecx],5Fh
			invoke InvalidateRect,hWnd,NULL,TRUE
			jmp seguir
			arriba:
				cmp mapa [ecx-12],6Fh
			jne contA
				inc puntos
			contA:
			
			mov mapa [ecx-12],3Ch
			mov mapa [ecx],5Fh
			invoke InvalidateRect,hWnd,NULL,TRUE
			invoke verificarGanar,addr mapa
			cmp ecx,0
			jne seguir
			je ganar
		.elseif eax==73h			;ABAJO S
			invoke obtenerPosPac,addr mapa
			cmp mapa[ecx+12],58h
			je seguir
			cmp mapa[ecx+12],24h
			jne abajo
			dec vidas
			;invoke MessageBox,hWnd,addr nombre,0,0
			.if vidas==0
				invoke InvalidateRect,hWnd,NULL,TRUE
				jmp perder
			.endif
			.if nivel==1
				mov edx,posIni1
				.elseif nivel==2
					mov edx,posIni2
				.elseif nivel==3
					mov edx,posIni3
			.endif
			mov mapa [edx],3Ch
			mov mapa [ecx],5Fh
			invoke InvalidateRect,hWnd,NULL,TRUE
			jmp seguir
			abajo:
				cmp mapa [ecx+12],6Fh
				jne contB
				inc puntos
			contB:
			
			mov mapa [ecx+12],3Ch
			mov mapa [ecx],5Fh
			invoke InvalidateRect,hWnd,NULL,TRUE
			invoke verificarGanar,addr mapa
			cmp ecx,0
			jne seguir
			je ganar
			ganar:
					
			.if nivel==1
				invoke MessageBox,hWnd,addr felicidades1,addr ganaste,0
				invoke restablecerMapa,addr mapa2,addr mapa
				inc nivel
				.elseif nivel==2
					invoke MessageBox,hWnd,addr felicidades2,addr ganaste,0
					invoke restablecerMapa,addr mapa3,addr mapa
					inc nivel
				.elseif nivel==3
					invoke MessageBox,hWnd,addr felicidades3,addr ganaste,0
					invoke MessageBox,hWnd,addr puntosC,addr puntosT,0
					invoke restablecerMapa,addr mapa1,addr mapa
					mov nivel,1
					mov vidas,3
					xor ebx,ebx
					mov puntos,ebx
					invoke restablecerMapa,addr limp,addr puntosC  ;Limpiar Puntos
			.endif
			jmp seguir
		perder:
			xor ebx,ebx
			
			
			.if nivel==1
				invoke MessageBox,hWnd,addr perdiste1,addr sorry,0
				invoke MessageBox,hWnd,addr puntosC,addr puntosT,0
				invoke restablecerMapa,addr mapa1,addr mapa
				mov vidas,3
				mov puntos,ebx
			.elseif nivel==2
				invoke MessageBox,hWnd,addr perdiste2,addr sorry,0
				invoke MessageBox,hWnd,addr puntosC,addr puntosT,0
				invoke restablecerMapa,addr mapa1,addr mapa
				mov nivel,1
				mov vidas,3
				mov puntos,ebx
				.elseif nivel==3
					invoke MessageBox,hWnd,addr perdiste2,addr sorry,0
					invoke MessageBox,hWnd,addr puntosC,addr puntosT,0
					invoke restablecerMapa,addr mapa1,addr mapa
					mov nivel,1
					mov vidas,3
					mov puntos,ebx
					invoke restablecerMapa,addr limp,addr puntosC   ;Limpiar puntos
			.endif
		seguir:
			invoke InvalidateRect,hWnd,NULL,TRUE
		.endif
		
		
		
		
			
.ELSEIF  eax==WM_COMMAND

        mov eax,wParam
.if eax==24
.elseif eax==23

        invoke MessageBox,hWnd,addr salirText,addr salirBoton,0
        invoke SendMessage,hWnd,WM_CLOSE,NULL,NULL
.endif
        
.ELSEIF eax==WM_DESTROY
	invoke PostQuitMessage,NULL
	xor eax,eax
.ELSE
        
	invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
.ENDIF
	ret
        WndProc endp

obtenerPosPac proc dmap:dword
	xor ecx,ecx
	mov edi,dmap
	encontrar:
		cmp byte ptr [edi],3Ch
		je salirObtener
		inc edi
		inc cx
	jmp encontrar
	salirObtener:
ret
obtenerPosPac endp
verificarGanar proc dir:dword
	xor ecx,ecx
	mov edi,dir
	verificar:
		cmp byte ptr [edi],0
		je salirVerificar
		cmp byte ptr [edi],6Fh
		jne segV
		inc ecx
		jmp salirVerificar
		segV:
		inc edi
	jmp verificar
	salirVerificar:
ret
verificarGanar endp
restablecerMapa proc dir:DWORD, dmap:DWORD
	mov edi,dir
	mov esi,dmap
	restab:
		cmp byte ptr [edi],0
		je salirResta
		mov dl,byte ptr [edi]
		mov byte ptr[esi],dl
		inc edi
		inc esi
	jmp restab
	salirResta:
ret
restablecerMapa endp
        end start
        
