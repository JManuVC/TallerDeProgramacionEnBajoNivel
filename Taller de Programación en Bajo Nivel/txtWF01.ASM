; ----------------------------------------------------------------------------
; -       TITULO  : Ejemplo de texto en una ventana Windows W-FASM           -
; -----                                                                  -----
; -       AUTOR   : Alfonso V�ctor Caballero Hurtado                         -
; -----                                                                  -----
; -       VERSION : 1.0                                                      -
; -----                                                                  -----
; -      (c) 2010. Abre los Ojos al Ensamblador                              -
; ----------------------------------------------------------------------------

; Todas las palabras reservadas deben estar en min�sculas

format  PE GUI 4.0
entry   start

include 'win32a.inc'         ; Inclu�mos definiciones de estructuras y constantes

cdXPos      EQU  128         ; Constante double X-Posici�n de la ventana(esq sup izqda)
cdYPos      EQU  128         ; Constante double Y-Posici�n de la ventana(esq sup izqda)
cdXSize     EQU  320         ; Constante double X-tama�o de la ventana
cdYSize     EQU  200         ; Constante double Y-tama�o de la ventana
cdColFondo  EQU  COLOR_BTNFACE + 1  ; Color de fondo de la ventana: gris de un bot�n de comando
cdVIcono    EQU  IDI_APPLICATION ; Icono de la ventana, v�ase Resource.H
cdVCursor   EQU  IDC_ARROW   ; Cursor para la ventana
; Tipo de ventana (Barra de cabecera)
; cdVBarTipo  EQU  WS_EX_TOOLWINDOW                     ; Tipo de barra de Cabecera: delgado, sin icono, sin reflejo en la barra de tareas
cdVBarTipo  EQU  NULL              ; Normal, con icono
cdVBtnTipo  EQU  WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU    ; Normal s�lo con bot�n cerrar
; cdVBtnTipo     EQU  WS_OVERLAPPEDWINDOW                ; Normal s�lo con los tres botones
; Constantes para la subventana del texto
cdVCarText  EQU  WS_CHILD + WS_VISIBLE + SS_CENTER
cdTXPos     EQU  15      ; Constante double X-Posici�n subventana para el texto(esq sup izqda)
cdTYPos     EQU  30      ; Constante double Y-Posici�n subventana para el texto(esq sup izqda)
cdTXSize    EQU  cdXSize-3*cdTXPos;[rct + RECT.right]         ; Constante double X-tama�o de la subventana para el texto
cdTYSize    EQU  40;[rct + RECT.bottom]        ; Constante double Y-tama�o de la subventana para el texto
cdTipoSubV  EQU  NULL           ; Tipo de subventana (flat-NULL, 3D-1, etc.)

      
section '.text' code readable executable
  start:
    invoke    GetModuleHandle, NULL
    mov       [wc.hInstance], eax
    mov       [wc.lpfnWndProc], WndProc
    mov       [wc.lpszClassName], NombreClase
    mov       [wc.hbrBackground], COLOR_BTNFACE+1
    stdcall   WinMain, [wc.hInstance], NULL, NULL, SW_SHOWNORMAL
    invoke    ExitProcess, [wMsg.wParam]

proc WinMain uses ebx esi edi, hInst, hPrevInst, CmdLine, CmdShow
    ;  Prop�sito: Inicializamos la ventana principal de la aplicaci�n y captura errores, si los hubiere
    ;  Entrada  : hInst, hPrevInst, CmdLine, CmdShow
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    invoke    LoadIcon,0,cdVIcono
    mov       edx, eax
    mov       eax, [hInst]
    mov       ebx, NombreClase
    mov       ecx, WndProc
    mov       [wc.hInstance], eax
    mov       [wc.lpszClassName], ebx
    mov       [wc.lpfnWndProc], ecx
    mov       [wc.hIcon], edx

    invoke    LoadCursor,0,cdVCursor
    mov       [wc.hCursor],eax

    invoke    RegisterClass,wc
    test      eax,eax
    jz        error

    invoke    CreateWindowEx,cdVBarTipo,NombreClase,MsgCabecera,\
              cdVBtnTipo,cdXPos, cdYPos, cdXSize, cdYSize,\
              NULL,NULL,[wc.hInstance],NULL
    mov       [wHMain],eax
    test      eax,eax
    jz        error

    mov       [hWnd], eax

    invoke    ShowWindow, dword hWnd, dword SW_SHOWNORMAL
    invoke    UpdateWindow, dword hWnd

  msg_loop:
    invoke    GetMessage,wMsg,NULL,0,0
    cmp       eax,1
    jb        end_loop
    jne       msg_loop
    invoke    TranslateMessage,wMsg
    invoke    DispatchMessage,wMsg
  jmp       msg_loop

  error:
    invoke    MessageBox,NULL,MsgError,NULL,MB_ICONERROR+MB_OK

  end_loop:
    mov       eax, [wMsg.wParam]
    ret
endp

proc WndProc,hWnd,uMsg,wParam,lParam
    push      ebx esi edi    
    cmp       [uMsg],WM_DESTROY
    je        wmDESTROY
    cmp       [uMsg],WM_PAINT
    je        wmPAINT
    
    wmDEFAULT: 
      invoke    DefWindowProc,[hWnd],[uMsg],[wParam],[lParam]
      jmp       wmBYE
    wmPAINT:
      invoke    BeginPaint,[hWnd],ps
      mov       [expDc],eax
      invoke    GetClientRect,[hWnd],rct 
      invoke    DrawText,\
                [expDc],\
                MsgTexto,\
                -1,\
                rct,\
                DT_CENTER or DT_VCENTER   ;or DT_SINGLELINE  (comentamos esto para haga dos lineas)
      invoke    EndPaint,[hWnd],ps 
      jmp       wmBYE
    wmDESTROY:
      invoke    PostQuitMessage,0 
    wmBYE: 
    pop       edi esi ebx
    ret
endp

section '.data' data readable writeable
  wHMain       rd    1
  hWnd         rd    1

  MsgCabecera  db    'Escribimos en nuestra ventana (FASM)',0
  NombreClase  db    'EXP01',0

  MsgError     db    'Carga inicial fallida.',0
  expDc        rd    1
  MsgTexto     db    '(c) Abre los ojos al ensamblador (FASM)',13,10
               db    'http://www.abreojosensamblador.net',0
             
  wMsg         MSG
  wc           WNDCLASS

  ps           PAINTSTRUCT
  rct          RECT

section '.idata' import data readable writable 

  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas para que el enlazador pueda trabajar
          user32,'USER32.DLL'          ; Importamos las bibliotecas para que el enlazador pueda trabajar

  include 'api\kernel32.inc'           ; KERNEL32 API calls
  include 'api\user32.inc'             ; USER32 API calls
 
