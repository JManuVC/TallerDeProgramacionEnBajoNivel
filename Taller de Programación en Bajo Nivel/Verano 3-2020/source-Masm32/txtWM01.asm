; ----------------------------------------------------------------------------
; -       TITULO  : Ejemplo de texto en una ventana Windows W-MASM           -
; -----                                                                  -----
; -       AUTOR   : Alfonso Víctor Caballero Hurtado                         -
; -----                                                                  -----
; -       VERSION : 1.0                                                      -
; -----                                                                  -----
; -      (c) 2010. Abre los Ojos al Ensamblador                              -
; ----------------------------------------------------------------------------

.386

.MODEL      flat, stdcall
OPTION      casemap:none

INCLUDE     windows.inc      ; Incluímos definiciones de estructuras y constantes
INCLUDE     user32.inc       ; Incluímos los prototipos de uso más habitual
INCLUDE     kernel32.inc     ; Incluímos los prototipos de uso más habitual
INCLUDELIB  user32.lib       ; Importamos las bibliotecas para que el enlazador pueda trabajar
INCLUDELIB  kernel32.lib     ; Importamos las bibliotecas para que el enlazador pueda trabajar

cdXPos      EQU  128         ; Constante double X-Posición de la ventana(esq sup izqda)
cdYPos      EQU  128         ; Constante double Y-Posición de la ventana(esq sup izqda)
cdXSize     EQU  320         ; Constante double X-tamaño de la ventana
cdYSize     EQU  200         ; Constante double Y-tamaño de la ventana
cdColFondo  EQU  COLOR_BTNFACE + 1  ; Color de fondo de la ventana: gris de un botón de comando
cdVIcono    EQU  IDI_APPLICATION ; Icono de la ventana, véase Resource.H
cdVCursor   EQU  IDC_ARROW   ; Cursor para la ventana
; Tipo de ventana (Barra de cabecera)
; cdVBarTipo  EQU  WS_EX_TOOLWINDOW                     ; Tipo de barra de Cabecera: delgado, sin icono, sin reflejo en la barra de tareas
cdVBarTipo  EQU  NULL                                 ; Normal, con icono
cdVBtnTipo  EQU  WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU    ; Normal sólo con botón cerrar
; cdVBtnTipo     EQU  WS_OVERLAPPEDWINDOW                ; Normal sólo con los tres botones
; Constantes para la subventana del texto
cdVCarText  EQU  WS_CHILD + WS_VISIBLE + SS_CENTER
cdTXPos     EQU  15           ; Constante double X-Posición subventana para el texto(esq sup izqda)
cdTYPos     EQU  30           ; Constante double Y-Posición subventana para el texto(esq sup izqda)
cdTXSize    EQU  cdXSize-3*cdTXPos;[rct + RECT.right]         ; Constante double X-tamaño de la subventana para el texto
cdTYSize    EQU  40;[rct + RECT.bottom]        ; Constante double Y-tamaño de la subventana para el texto
cdTipoSubV  EQU  NULL                          ; Tipo de subventana (flat-NULL, 3D-1, etc.)

WinMain PROTO :DWORD,:DWORD,:DWORD,:DWORD

.DATA
  NombreClase   DB          "SimpleWinClass", 0
  MsgCabecera   DB          "Escribimos en nuestra ventana (MASM)", 0
  MsgTexto      DB          "(c) Abre los ojos al ensamblador (MASM)", 13,10
                DB          "http://www.abreojosensamblador.net",0
  MsgError      DB          'Carga inicial fallida.',0
  wc            WNDCLASSEX  <>

.DATA?
  CommandLine DD ?

.CODE
  start:
    INVOKE    GetModuleHandle, NULL
    MOV       wc.hInstance, EAX
    INVOKE    GetCommandLine
    MOV       CommandLine, EAX
    INVOKE    WinMain, wc.hInstance, NULL, CommandLine, SW_SHOWDEFAULT
    INVOKE    ExitProcess, EAX

  WinMain PROC hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
    ;  Propósito: Inicializamos la ventana principal de la aplicación y captura errores, si los hubiere
    ;  Entrada  : hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    LOCAL     msg:MSG
    LOCAL     hwnd:HWND
    ; Si inicializamos wc con sus valores corremos el riesgo de hacerlo desordenadamente en caso
    ; de que se cambie la definición de la estructura WNDCLASSEX
    MOV       wc.cbSize, SIZEOF WNDCLASSEX
    MOV       wc.style, CS_HREDRAW OR CS_VREDRAW
    MOV       wc.lpfnWndProc, OFFSET WndProc
    MOV       wc.cbClsExtra, NULL
    MOV       wc.cbWndExtra, NULL 
    ; hInstance ya está valorado arriba
    MOV       wc.hbrBackground, cdColFondo  ; Color de fondo de la ventana
    MOV       wc.lpszMenuName, NULL
    MOV       wc.lpszClassName, OFFSET NombreClase
    INVOKE    LoadIcon, NULL, cdVIcono
    MOV       wc.hIcon, EAX
    MOV       wc.hIconSm, EAX
    INVOKE    LoadCursor, NULL, cdVCursor
    MOV       wc.hCursor, EAX
    INVOKE    RegisterClassEx, ADDR wc
    TEST      EAX, EAX
    JZ        L_Error
    INVOKE    CreateWindowEx,cdVBarTipo,ADDR NombreClase,ADDR MsgCabecera,\
              cdVBtnTipo,cdXPos, cdYPos, cdXSize, cdYSize,\
              NULL,NULL,hInst,NULL
    TEST      EAX, EAX
    JZ        L_Error
    MOV       hwnd, EAX
    INVOKE    ShowWindow, hwnd, SW_SHOWNORMAL
    INVOKE    UpdateWindow, hwnd
    .WHILE    TRUE
        INVOKE    GetMessage, ADDR msg, NULL, 0, 0
        .BREAK    .IF (!EAX)
        INVOKE    TranslateMessage, ADDR msg
        INVOKE    DispatchMessage, ADDR msg
    .ENDW
    JMP       L_Fin
    
    L_Error:
      INVOKE    MessageBox, NULL,ADDR MsgError, NULL, MB_ICONERROR+MB_OK

    L_Fin:
    MOV       EAX, msg.wParam
    RET
  WinMain ENDP
  
  WndProc PROC hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    ;  Propósito: Procesa los mensajes provenientes de las ventanas
    ;  Entrada  : hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    LOCAL hdc:HDC
    LOCAL ps:PAINTSTRUCT
    LOCAL rct:RECT
    .IF uMsg==WM_DESTROY
        invoke PostQuitMessage,NULL
    .ELSEIF uMsg==WM_PAINT
        invoke BeginPaint,hWnd, ADDR ps
        mov    hdc,eax
        invoke GetClientRect,hWnd, ADDR rct
        invoke DrawText, hdc,ADDR MsgTexto,-1, ADDR rct, DT_CENTER or DT_VCENTER ; or DT_SINGLELINE
        invoke EndPaint,hWnd, ADDR ps
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
    XOR       EAX, EAX
    RET
  WndProc ENDP
END start
 
