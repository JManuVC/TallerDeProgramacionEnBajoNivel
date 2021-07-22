      
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
        tecla db "Tecla a",0
        cadena2 db "el tamanio de cadena 2 es:",0
        
        comboBox db "ComboBox",0
edit    db "Edit",0
scroll  db "ScrollBar",0
static   db "Static",0
control  db "Control",0
listBox  db "ListBox",0
.data?
        hInstance dd ?
        buffer1 db 50 dup(?)
        buffer2 db 50 dup(?)
        buffer3 db 50 dup(?)
        CommandLine LPSTR ?
        hedit1 dd ?
        hedit2 dd ?
		hdc dd ?
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
           100,500,500,NULL,NULL,\
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
        300,300,50,50,hWnd,23,hInstance,NULL
.elseif eax==WM_PAINT
		invoke BeginPaint,hWnd,addr ps
		invoke GetClientRect,hWnd,addr rect
		invoke DrawText,hdc,addr texto,-1,addr rect,DT_SINGLE_LINE	
		invoke EndPaint,hWnd,addr ps
.elseif eax==WM_CHAR
		mov eax,wParam
		.if eax==61h
		invoke MessageBox,hWnd,addr tecla,0,0
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
