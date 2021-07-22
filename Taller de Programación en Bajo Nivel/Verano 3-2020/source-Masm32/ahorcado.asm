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
        AppName  db "El Ahorcado!!",0
        boton db "BUTTON",0
        
        ahorcadoT db  "EL AHORCADO",0
        
        salirBoton db "Salir",0
        FontName db "Segoe UI Semibold",0
		FontName2 db "Arial Bold",0
		FontName3 db "Impact",0
		palabra db "assembler",0
		
		rayas db "---------",0
		vidas dd 5
		felicidades db "FELICIDADES!",0
		sorry db "Lo siento",0
		perdiste db "Perdiste :(",0
		cabeza db "O",0
		brazoIzq db "/",0
		brazoDer db "\",0
		torso db "|",0
		pies db "/\",0
		poste1 db "|",0
		poste2 db "_____",0
		poste3 db "__/_\__",0
		ganaste db "GANASTE! :D",0
		vidasT db "Vidas: ",0
.data?
        hInstance dd ?
        CommandLine LPSTR ?
        hdc dd ?
        hFont dd ?
		vidasC db 10 dup(?)

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
	mov   wc.hbrBackground,COLOR_WINDOW+1
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
        800,520,40,23,hWnd,23,hInstance,NULL
		  
.ELSEIF eax==WM_PAINT
        
		invoke dwtoa,vidas,addr vidasC
		invoke BeginPaint,hWnd,addr ps
        mov hdc,eax
        invoke GetClientRect,hWnd,addr rect
;POSTE			
		invoke CreateFont,60,50,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName2
		invoke SelectObject,hdc,eax
        mov hFont,eax
         RGB 150, 104, 16
        invoke SetTextColor,hdc,eax
		RGB 255, 255, 255
        invoke SetBkColor,hdc,eax
		invoke TextOut,hdc,350,60,addr poste2,SIZEOF poste2  ;450,60
		invoke TextOut,hdc,475,380,addr poste3,SIZEOF poste3 ;574,380
		invoke CreateFont,60,26,0,0,0,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName2
		invoke SelectObject,hdc,eax
        mov hFont,eax
		invoke TextOut,hdc,650,100,addr poste1,SIZEOF poste1 ;750,100
		invoke TextOut,hdc,650,160,addr poste1,SIZEOF poste1 ;,160
		invoke TextOut,hdc,650,220,addr poste1,SIZEOF poste1
		invoke TextOut,hdc,650,280,addr poste1,SIZEOF poste1
		invoke TextOut,hdc,650,340,addr poste1,SIZEOF poste1 ;,340
		
		invoke TextOut,hdc,345,118,addr poste1,SIZEOF poste1 ;445,118
;TEXTO
;TITULO
         invoke CreateFont,70,60,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName3
        invoke SelectObject,hdc,eax
        mov hFont,eax

        
        RGB 136, 0, 255 
        invoke SetTextColor,hdc,eax
		RGB 234, 231, 44 
       invoke SetBkColor,hdc,eax
	   
       invoke TextOut,hdc,230,10,addr ahorcadoT,SIZEOF ahorcadoT-1
;VIDAS		
		invoke CreateFont,80,70,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName3
        invoke SelectObject,hdc,eax
        mov hFont,eax

        
        RGB 255, 251, 0 
        invoke SetTextColor,hdc,eax
		RGB 255, 6, 6 
		invoke SetBkColor,hdc,eax   
		invoke TextOut,hdc,130,200,addr vidasC,1
;RAYAS		
	    invoke CreateFont,50,30,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName2
        invoke SelectObject,hdc,eax
        mov hFont,eax

        
        RGB 28, 75, 209
        invoke SetTextColor,hdc,eax
		RGB 35, 255, 0  
       invoke SetBkColor,hdc,eax
		invoke TextOut,hdc,250,490,addr rayas,SIZEOF rayas-1
       
        invoke SelectObject,hdc,hFont
	
;MUÑECO
		invoke CreateFont,60,50,0,0,400,0,0,0,ANSI_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName2
		invoke SelectObject,hdc,eax
        mov hFont,eax
         RGB 0, 0, 0
        invoke SetTextColor,hdc,eax
		RGB 255, 255, 255
        invoke SetBkColor,hdc,eax
		.if vidas<=4
		invoke TextOut,hdc,312,170,addr cabeza,1
		.endif
		.if vidas<=3 && vidas<=4  
		invoke TextOut,hdc,337,219,addr torso,1
		.endif
		.if vidas<=2 && vidas<=4
		invoke TextOut,hdc,317,219,addr brazoIzq,1
		.endif
		.if vidas<=1 && vidas<=4
		invoke TextOut,hdc,358,219,addr brazoDer,1
		.endif
		.if vidas <=0 && vidas<=4
		invoke TextOut,hdc,323,268,addr pies,SIZEOF pies-1
		.endif
		

	   invoke EndPaint,hWnd,addr ps
        
.ELSEIF eax== WM_CHAR
        mov eax,wParam
		cmp vidas,0
		je acabar
		invoke reemplazar,addr rayas,addr palabra,eax
		lea edi,rayas
		lea esi,palabra
		
		comparar:
		mov dl,byte ptr[esi]
		cmp dl,0
		je ganar
		cmp byte ptr [edi],dl
		jne se
		inc edi
		inc esi
		jmp comparar
		se:
		cmp cx,0
		je quitarVidas
		jne saltarV
		quitarVidas:
			dec vidas
			invoke InvalidateRect,hWnd,NULL,TRUE
			cmp vidas,0
			je acabar
		saltarV:
        invoke InvalidateRect,hWnd,NULL,TRUE
		
		jmp seguir
		ganar:
			invoke InvalidateRect,hWnd,NULL,TRUE
			invoke MessageBox,hWnd,addr ganaste,addr felicidades,0
			jmp terminar
		acabar:
			invoke MessageBox,hWnd,addr perdiste,addr sorry,0
			
			 
		terminar:
			mov vidas,5
			invoke limpiarCad,addr rayas
			invoke InvalidateRect,hWnd,NULL,TRUE
		seguir:
			
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
reemplazar proc dir:DWORD,dir2:DWORD,ca:DWORD
	mov edi,dir  ; rayas
	mov esi,dir2 ;palabra
	xor edx,edx
	mov edx,ca
	xor ecx,ecx
	ciclo:
	cmp byte ptr[esi],0
	je salirR
	cmp byte ptr [esi],dl
	jne saltarR
	mov byte ptr [edi],dl
	inc cx
	saltarR:
		inc esi
		inc edi
	jmp ciclo
	salirR:
	
ret
reemplazar endp
limpiarCad proc dir:dword
	mov edi,dir
	limp:
		cmp byte ptr[edi],0
		je salirL
		mov byte ptr[edi],2Dh
		inc edi
	jmp limp
	salirL:
	
ret
limpiarCad endp
        end start
        
