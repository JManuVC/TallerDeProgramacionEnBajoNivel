.386
.model flat,stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib       ; llamadas a las funciones en user32.lib y kernel32.lib
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

.DATA                     ; data inicializada
ClassName db "SimpleWinClass",0        ; el nombre de nuestra clase de ventana
AppName db "Our First Window",0        ; el nombre de nuestra ventana
clase_boton db 'BUTTON',0
okay db 'Ok',0

Ist  dd 0
pWnd dd 0

.DATA?                                           ; data no inicializada
hInstance HINSTANCE ?              ; manejador de instancia de nuestro programa
CommandLine LPSTR ?
.CODE                                             ; Aquí comienza nuestro código
start:
invoke GetModuleHandle, NULL ; obtener el manejador de instancia del programa.
                                                         ; En Win32, hmodule==hinstance

mov hInstance,eax
mov Ist,eax

invoke GetCommandLine    ; Obtener la línea de comando. No hay que llamar esta función
                                              ; si el programa no procesa la línea de comando
mov CommandLine,eax
invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT   ; llamar la función principal
invoke ExitProcess, eax      ; quitar nuestro programa. El código de salida es devuelto en eax desde WinMain.

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
    LOCAL wc:WNDCLASSEX                  ; crear variables locales en la pila (stack)
    LOCAL msg:MSG
    LOCAL hwnd:HWND

    mov   wc.cbSize,SIZEOF WNDCLASSEX      ; Llenar los valores de los miembros de wc
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
    mov   wc.hIconSm,eax
    invoke LoadCursor,NULL,IDC_ARROW
    mov   wc.hCursor,eax
	mov pWnd,eax
    invoke RegisterClassEx, addr wc                       ; registrar nuestra clase de ventana
    invoke CreateWindowEx,NULL,\
                ADDR ClassName,\
                ADDR AppName,\
                WS_OVERLAPPEDWINDOW,\
                CW_USEDEFAULT,\
                CW_USEDEFAULT,\
                CW_USEDEFAULT,\
                CW_USEDEFAULT,\
                NULL,\
                NULL,\
                hInst,\
                NULL
    mov   hwnd,eax
	;mov pWnd,eax;
    invoke ShowWindow, hwnd,CmdShow     ; desplegar nuestra ventana en el escritorio
    invoke UpdateWindow, hwnd                   ; refrescar el area cliente

    .WHILE TRUE                                         ; Introducir en bucle (loop) de mensajes
                invoke GetMessage, ADDR msg,NULL,0,0
                .BREAK .IF (!eax)
                invoke TranslateMessage, ADDR msg
                invoke DispatchMessage, ADDR msg
   .ENDW
    mov     eax,msg.wParam                             ; Regresar el código de salida en eax
    ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    .if
		invoke CreateWindowEx,NULL,clase_boton,okay,\
				BS_DEFPUSHBUTTON \
				,100,100,70,30,hwnd,2000,hInstance,0 ; crear un boton estilo boton normal
	.endif
	
	.IF uMsg==WM_DESTROY                      ; si el usuario cierra nuestra ventana
        invoke PostQuitMessage,NULL             ; quitar nuestra aplicación
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam ; Procesar el mensaje por defecto
        ret
    .ENDIF
    xor eax,eax
    ret
WndProc endp

end start