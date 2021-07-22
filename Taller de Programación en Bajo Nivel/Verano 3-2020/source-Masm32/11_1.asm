.386
.model flat,stdcall
option casemap:none
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

.data
ClassName db "SimpleWinClass",0
AppName  db "Vocales",0
MenuName db "FirstMenu",0
ButtonClassName db "button",0
ButtonText db "Contar",0
EditClassName db "edit",0
TestString db "Wow! I'm in an edit box now",0
cant dd 0
va db "a",0
 

.data?
hInstance HINSTANCE ?
CommandLine LPSTR ?
hwndButton HWND ?
hwndEdit HWND ?
buffer db 512 dup(?)     
vocales db 512 dup(?)             ; buffer to store the text retrieved from the edit box

.const
ButtonID equ 1                                ; The control ID of the button control
EditID equ 2                                    ; The control ID of the edit control
IDM_HELLO equ 1
IDM_CLEAR equ 2
IDM_GETTEXT equ 3
IDM_EXIT equ 4

.code
start:
    invoke GetModuleHandle, NULL
    mov    hInstance,eax
    invoke GetCommandLine
    mov CommandLine,eax
    invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
    invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
    LOCAL wc:WNDCLASSEX
    LOCAL msg:MSG
    LOCAL hwnd:HWND
    mov   wc.cbSize,SIZEOF WNDCLASSEX
    mov   wc.style, CS_HREDRAW or CS_VREDRAW
    mov   wc.lpfnWndProc, OFFSET WndProc
    mov   wc.cbClsExtra,NULL
    mov   wc.cbWndExtra,NULL
    push  hInst
    pop   wc.hInstance
    mov   wc.hbrBackground,COLOR_BTNFACE+1
    mov   wc.lpszMenuName,OFFSET MenuName
    mov   wc.lpszClassName,OFFSET ClassName
    invoke LoadIcon,NULL,IDI_APPLICATION
    mov   wc.hIcon,eax
    mov   wc.hIconSm,eax
    invoke LoadCursor,NULL,IDC_ARROW
    mov   wc.hCursor,eax
    invoke RegisterClassEx, addr wc
    invoke CreateWindowEx,WS_EX_CLIENTEDGE,ADDR ClassName, \
                        ADDR AppName, WS_OVERLAPPEDWINDOW,\
                        CW_USEDEFAULT, CW_USEDEFAULT,\
                        300,200,NULL,NULL, hInst,NULL
    mov   hwnd,eax
    invoke ShowWindow, hwnd,SW_SHOWNORMAL
    invoke UpdateWindow, hwnd
    .WHILE TRUE
        invoke GetMessage, ADDR msg,NULL,0,0
        .BREAK .IF (!eax)
        invoke TranslateMessage, ADDR msg
        invoke DispatchMessage, ADDR msg
    .ENDW
    mov     eax,msg.wParam
    ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    .IF uMsg==WM_DESTROY
        invoke PostQuitMessage,NULL
    .ELSEIF uMsg==WM_CREATE
        invoke CreateWindowEx,WS_EX_CLIENTEDGE, ADDR EditClassName,NULL,\
                        WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or\
                        ES_AUTOHSCROLL,\
                        50,35,200,25,hWnd,8,hInstance,NULL
        mov  hwndEdit,eax
        invoke SetFocus, hwndEdit
        invoke CreateWindowEx,NULL, ADDR ButtonClassName,ADDR ButtonText,\
                        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
                        75,70,140,25,hWnd,ButtonID,hInstance,NULL
        mov  hwndButton,eax
    .ELSEIF uMsg==WM_COMMAND
        mov eax,wParam
        .IF lParam==0
            .IF ax==IDM_HELLO
                invoke SetWindowText,hwndEdit,ADDR TestString
            .ELSEIF ax==IDM_CLEAR
                invoke SetWindowText,hwndEdit,NULL
            .ELSEIF  ax==IDM_GETTEXT
                invoke GetWindowText,hwndEdit,ADDR buffer,512
            
                
                mov eax,ds
                mov es,eax 
                lea di, buffer
                lea si,va
                
               
                ciclo:
                    cmp [di],'?'                                            
                    je salir 
                    mov dl,[di]                                   
                    cmp [si],dl      
                    je incrementar
                    jne saltar

                    incrementar:
                        add cant,1
                                                            
                    
                    saltar:
                    add di,1
                jmp ciclo

                salir:
                add cant,30h
                
                invoke MessageBox,NULL,ADDR cant,ADDR AppName,MB_OK
                mov cant,0
            .ELSE
                invoke DestroyWindow,hWnd
            .ENDIF
        .ELSE
            .IF ax==ButtonID
                shr eax,16
                .IF ax==BN_CLICKED
                    invoke SendMessage,hWnd,WM_COMMAND,IDM_GETTEXT,0
                .ENDIF
            .ENDIF
        .ENDIF
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
     xor    eax,eax
    ret
WndProc endp

end start