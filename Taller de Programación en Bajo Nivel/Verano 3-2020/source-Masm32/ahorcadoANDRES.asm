      
 .386
.model flat, stdcall
        option casemap :none   ; case sensitive
        
        include c:\masm32\include\windows.inc
        include c:\masm32\include\user32.inc
        include c:\masm32\include\kernel32.inc
        include c:\masm32\include\masm32.inc
		include c:\masm32\include\gdi32.inc
        
        includelib c:\masm32\lib\user32.lib
        includelib c:\masm32\lib\kernel32.lib
        includelib c:\masm32\lib\masm32.lib
		includelib c:\masm32\lib\gdi32.lib
        WinMain proto :DWORD,:DWORD,:DWORD,:SDWORD
        WndProc proto :DWORD,:DWORD,:DWORD,:DWORD
 
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
        AppName  db "Ahorcado",0
        boton db "BUTTON",0
        cboton1 db "Salir",0
        texto1 	db "Juego del Ahorcado",0
		textoA db  "XXXXX",0
		textoCorrecto db "perro",0
		bandera db 1 
		bandera2 db 2
		edit    db "Edit",0

.data?
        hInstance dd ?
        buffer1 db 50 dup(?)
        buffer2 db 50 dup(?)
        buffer3 db 50 dup(?)
        CommandLine LPSTR ?
        hdc dd ?
		hFont dd ?
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
           100,600,600,NULL,NULL,\
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
        invoke CreateWindowEx,NULL, ADDR boton,ADDR cboton1,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        400,500,50,50,hWnd,23,hInstance,NULL
	
.elseif eax==WM_PAINT
		invoke BeginPaint,hWnd,addr ps
		mov hdc,eax
		invoke GetClientRect,hWnd,addr rect
        invoke DrawText,hdc,addr textoA,-1,addr rect,DT_VCENTER or DT_CENTER or DT_SINGLELINE
		
		.if bandera==0
		  RGB 200,200,50
		 invoke SetTextColor,hdc,eax
		  RGB 0,30,0
		 invoke SetBkColor,hdc,eax
		  invoke TextOut,hdc,200,30,addr texto1,SIZEOF texto1
		 .endif
		invoke SelectObject,hdc,hFont
	invoke EndPaint,hWnd,addr ps
  
	.elseif eax==WM_CHAR
		 mov eax,wParam
		 .if eax==20h			;espacio  para el titulo
		 mov bandera,0
		 invoke InvalidateRect,hWnd,NULL,TRUE
		 .endif
		 .if eax>=61h ;&& eax<=7Ah                      ;HABIA QUE USAR OTRO IF, NO SE PORQUE xd
		 lea edi,textoCorrecto					;perro
		 lea esi,textoA							;_ _ _ _	
		 ciclo:
										;letra p
     	cmp byte ptr[edi],0
		 je  salir
		 mov dl,al
		 cmp byte ptr[edi],dl
		 jne  saltar
		 mov byte ptr[esi],dl
		 saltar:
		 inc edi
		 inc esi
		 jmp ciclo
		
	
		salir:
			invoke InvalidateRect,hWnd,NULL,TRUE
		
		;.elseif eax==WM_PAINT
		;invoke BeginPaint,hWnd,addr ps                      ;NO PUEDES TENER DOS WM_PAINT
		;mov hdc,eax
		;invoke GetClientRect,hWnd,addr rect
        ;invoke TextOut,hdc,200,30,addr textoA,SIZEOF textoA
	    ;invoke EndPaint,hWnd,addr ps
		.endif
		
.ELSEIF  eax==WM_COMMAND

        mov eax,wParam
       
       .if eax==23
        ;invoke MessageBox,hWnd,addr salirText,0,1
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

        
        end start
