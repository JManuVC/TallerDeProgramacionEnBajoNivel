      
        .386
.model flat, stdcall
        option casemap :none   ; case sensitive
        
        include c:\masm32\include\windows.inc
        include c:\masm32\include\user32.inc
        include c:\masm32\include\kernel32.inc
        includelib c:\masm32\lib\user32.lib
        includelib c:\masm32\lib\kernel32.lib
        WinMain proto :DWORD,:DWORD,:DWORD,:SDWORD
        WndProc proto :DWORD,:DWORD,:DWORD,:DWORD
.data
ClassName db "SimpleWinClass",0
        AppName  db "Our First Window",0
        boton db "BUTTON",0
        cboton db "Salir",0
		etiqueta db "STATIC",0
		texto db "Hola soy un label",0
		combo db "COMBOBOX",0
		ccombo db "soy combo",0
		edit_class db "EDIT",0
		cedit db "soy edit",0
		listab db "LISTBOX",0
		scrollb db "SCROLLBAR",0
		apro db "aprobado :D",0
		
.data?
hInstance HINSTANCE ?
CommandLine LPSTR ?
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
           WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,\
           CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,NULL,NULL,\
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
     invoke CreateWindowEx,NULL, ADDR boton,ADDR cboton,\
                        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
                        15,10,50,50,hWnd,23,hInstance,NULL
						
       invoke CreateWindowEx,NULL, ADDR etiqueta,ADDR texto,\
                        WS_CHILD or WS_VISIBLE or SS_CENTER	,\
                        100,100,100,50,hWnd,23,hInstance,NULL
		invoke CreateWindowEx,NULL, ADDR combo,0,\
                        WS_CHILD or WS_VISIBLE or CBS_SIMPLE	,\
                        290,80,100,100,hWnd,23,hInstance,NULL
	
						
		invoke CreateWindowEx,NULL, ADDR edit_class,addr cedit,\
                        WS_CHILD or WS_VISIBLE or ES_PASSWORD	,\
                        500,150,50,50,hWnd,23,hInstance,NULL
		invoke CreateWindowEx,NULL, ADDR listab,ADDR cboton,\
                        WS_CHILD or WS_VISIBLE or LBS_STANDARD	,\
                        100,300,50,50,hWnd,23,hInstance,NULL
	
		 invoke CreateWindowEx,NULL, ADDR boton,ADDR apro,\
                        WS_CHILD or WS_VISIBLE or BS_CHECKBOX,\
                        500,300,150,50,hWnd,23,hInstance,NULL
						
		invoke CreateWindowEx,NULL, ADDR scrollb,0,\
                        WS_CHILD or WS_VISIBLE or SBS_BOTTOMALIGN	,\
                        300,200,150,150,hWnd,23,hInstance,NULL
										
        ;5 controles
	.ELSEIF eax==WM_DESTROY
		invoke PostQuitMessage,NULL
		xor eax,eax
        .ELSE
        
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
	.ENDIF
	ret
WndProc endp
        end start
