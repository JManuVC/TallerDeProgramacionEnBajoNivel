; ----------------------------------------------------------------------------
; -       TITULO  : Ejemplo de texto con resources internos W-MASM           -
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

include     dialogs.inc
INCLUDE     windows.inc      ; Incluímos definiciones de estructuras y constantes
INCLUDE     user32.inc       ; Incluímos los prototipos de uso más habitual
INCLUDE     kernel32.inc     ; Incluímos los prototipos de uso más habitual
INCLUDELIB  user32.lib       ; Importamos las bibliotecas para que el enlazador pueda trabajar
INCLUDELIB  kernel32.lib     ; Importamos las bibliotecas para que el enlazador pueda trabajar

FUNC MACRO parameters:VARARG
  invoke parameters
  EXITM <eax>
ENDM

WndProc   PROTO :HWND,:UINT,:WPARAM,:LPARAM

.DATA?
  hInstance   DD  ?
  CommandLine DD ?

.CODE
  start:
    ; INVOKE    GetModuleHandle, NULL
    MOV       hInstance, FUNC(GetModuleHandle,NULL)
    CALL      WinMain
    INVOKE    ExitProcess,eax

  WinMain proc
    ;  Propósito: Inicializamos la ventana principal de la aplicación
    ;  Entrada  : hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    Dialog    "Ventana con resource interno (MASM)","MS Sans Serif",10, \  ; caption,font,pointsize
              WS_VISIBLE or WS_CAPTION or WS_SYSMENU or WS_THICKFRAME or WS_MINIMIZEBOX, \
              1, \                          ; control count <- Atención a esto, debe coincidir exactamente
              128, 128, 194, 102, \         ; x y co-ordinates
              1024                          ; memory buffer size
    DlgButton "&Aceptar",WS_TABSTOP,135,78,54,15,IDCANCEL
    ; DlgStatic "Simple Dialog Written In MASM32",SS_CENTER,2,20,140,9,100
    CallModalDialog hInstance,0,WndProc,NULL
    RET
  WinMain endp

  WndProc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
    ;  Propósito: Procesa los mensajes provenientes de las ventanas
    ;  Entrada  : hWin:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    MOV       EAX, uMsg
    .IF       EAX == WM_INITDIALOG
      INVOKE    SendMessage,hWin,WM_SETICON,1,FUNC(LoadIcon,NULL,IDI_APPLICATION)
    .ELSEIF   EAX == WM_COMMAND
      .IF       wParam == IDCANCEL
        JMP       quit_dialog
      .ENDIF    
    .ELSEIF   EAX == WM_CLOSE
      quit_dialog:
      INVOKE    EndDialog,hWin,0
    .ENDIF
    XOR       EAX, EAX
    RET
  WndProc endp
end start 
