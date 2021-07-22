      
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
.const

.data
        ClassName db "SimpleWinClass",0
        salirText db "Adios Vuelva pronto",0
        AppName  db "Our First Window",0
        boton db "BUTTON",0
        cboton1 db "Salir",0
        cboton2 db "Sumar",0
        editText1 db "Ingrese su numero 1",0
        editText2 db "Ingrese su numero 2",0
        editText3 db "resultado",0
        
        comboBox db "ComboBox",0
edit    db "Edit",0
scroll  db "ScrollBar",0
static   db "Static",0
control  db "Control",0
listBox  db "ListBox",0
.data?
hInstance dd ?
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
     invoke CreateWindowEx,NULL, ADDR boton,ADDR cboton1,\
                        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        300,300,50,50,hWnd,23,hInstance,NULL

        

        
	INVOKE CreateWindowEx,NULL,ADDR edit,NULL ,\
	WS_CHILD+WS_VISIBLE+ES_CENTER+ES_NUMBER+WS_BORDER,100,30,100,50,\
	hWnd,25,hInstance,NULL

        INVOKE CreateWindowEx,NULL,ADDR edit,NULL ,\
	WS_CHILD or WS_VISIBLE or ES_CENTER or ES_NUMBER+WS_BORDER,100,100,100,50,\
	hWnd,26,hInstance,NULL

        INVOKE CreateWindowEx,NULL,ADDR edit,NULL,\
	WS_CHILD+WS_VISIBLE+ES_CENTER+ES_NUMBER+WS_BORDER,300,100,100,50,\
	hWnd,27,hInstance,NULL

        invoke CreateWindowEx,NULL, ADDR boton,ADDR cboton2,\
        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
        140,150,50,50,hWnd,24,hInstance,NULL

        
        
		; INVOKE CreateWindowEx,NULL,ADDR comboBox,NULL,\
		;    WS_CHILD+WS_VISIBLE,120,10,100,50,\
		;    hWnd,333,hInstance,NULL
		   
		
		; INVOKE CreateWindowEx,NULL,ADDR edit,ADDR control,\
		;    WS_CHILD+WS_VISIBLE,220,30,100,50,\
		;    hWnd,11111,hInstance,NULL
		   
		
		; INVOKE CreateWindowEx,NULL,ADDR scroll,NULL,\
		;    WS_CHILD+WS_VISIBLE,320,20,100,50,\
		;    hWnd,1234,hInstance,NULL
		

		; INVOKE CreateWindowEx,NULL,ADDR boton,ADDR control,\
		;    WS_CHILD+WS_VISIBLE+BS_RADIOBUTTON+WS_TABSTOP,10,110,100,50,\
		;    hWnd,13,hInstance,NULL
		   

		; INVOKE CreateWindowEx,NULL,ADDR static,ADDR control,WS_CHILD+WS_VISIBLE,10,110,100,50,hWnd,12,hInstance,NULL
	

	; INVOKE CreateWindowEx,WS_EX_CLIENTEDGE,ADDR listBox,ADDR control, WS_CHILD+WS_VISIBLE+ES_AUTOVSCROLL,110,110,100,50, hWnd,11,hInstance,NULL
        
        
        ;5 controles
.ELSEIF  eax==WM_COMMAND

        mov eax,wParam
       .if eax==24
       .elseif eax==23

        invoke MessageBox,hWnd,addr salirText,0,1
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
