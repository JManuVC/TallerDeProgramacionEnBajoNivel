        .386
.model flat, stdcall
        option casemap :none   ; case sensitive
        
        include c:\masm32\include\windows.inc
        include c:\masm32\include\user32.inc
        include c:\masm32\include\kernel32.inc
        include c:\masm32\include\gdi32.inc
        
        includelib c:\masm32\lib\user32.lib
        includelib c:\masm32\lib\kernel32.lib
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
        AppName  db "El Ahorcado!!",0
        boton db "BUTTON",0
        textoA db  "_ a _ b _ _",0
        textoB db  "EL AHORCADO",0
        titulo db "Mensaje",0
        cboton1 db "Salir",0
        cboton2 db "Sumar",0
        editText1 db "Ingrese su numero 1",0
        editText2 db "Ingrese su numero 2",0
        editText3 db "resultado",0
        FontName db "coure",0
        comboBox db "ComboBox",0
        edit    db "Edit",0
        scroll  db "ScrollBar",0
        static   db "Static",0
        control  db "Control",0
        listBox  db "ListBox",0
        bandera db 1
.data?
        hInstance dd ?
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
        local ps:PAINTSTRUCT
        local rect:RECT
        
	mov   eax,uMsg
.IF eax== WM_CREATE
        

.ELSEIF eax==WM_PAINT
        invoke BeginPaint,hWnd,addr ps
        mov hdc,eax
        invoke GetClientRect,hWnd,addr rect
        invoke DrawText,hdc,addr textoA,-1,addr rect,DT_SINGLELINE or DT_CENTER or DT_VCENTER

         invoke CreateFont,54,16,0,0,400,0,0,0,OEM_CHARSET,\
                                       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
                                       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
        ADDR FontName
        invoke SelectObject,hdc,eax
        mov hFont,eax

        .if bandera==0
        RGB 200,200,50
        invoke SetTextColor,hdc,eax
        RGB 0,30,0
        invoke SetBkColor,hdc,eax
        invoke TextOut,hdc,100,100,addr textoA,SIZEOF textoB

        .endif
        invoke SelectObject,hdc,hFont
        
        invoke EndPaint,hWnd,addr ps
        
.ELSEIF eax== WM_CHAR
        mov eax,wParam
.if eax==61h
     ;   invoke MessageBox,hWnd,addr textoA,addr titulo,0
        mov bandera,0
        invoke InvalidateRect,hWnd,NULL,TRUE

.elseif eax==62h
        invoke MessageBox,hWnd,addr textoB,addr titulo,0
.endif
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
        
