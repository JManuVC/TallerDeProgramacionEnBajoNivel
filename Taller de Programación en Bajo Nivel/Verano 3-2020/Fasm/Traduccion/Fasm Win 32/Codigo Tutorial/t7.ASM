

format PE GUI 4.0
entry start

include 'win32a.inc'	     ; Incluímos definiciones de estructuras y constantes
;WinMain proto dword,dword,dword,dword

cdXPos	      EQU  128	       ; Constante double X-Posición de la ventana(esq sup izqda)
cdYPos	      EQU  128	       ; Constante double Y-Posición de la ventana(esq sup izqda)
cdXSize       EQU  320	       ; Constante double X-tamaño de la ventana
cdYSize       EQU  200	       ; Constante double Y-tamaño de la ventana
cdColFondo    EQU  COLOR_BTNFACE + 1  ; Color de fondo de la ventana: gris de un botón de comando
cdVIcono      EQU  IDI_APPLICATION ; Icono de la ventana, véase Resource.H
cdVCursor     EQU  IDC_ARROW   ; Cursor para la ventana
; Tipo de ventana (Barra de cabecera)
;cdVBarTipo  EQU  WS_EX_TOOLWINDOW		      ; Tipo de barra de Cabecera: delgado, sin icono, sin reflejo en barra de tareas
cdVBarTipo    EQU  NULL 			      ; Normal, con icono
cdVBtnTipo    EQU  WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU  ; Normal sólo con botón cerrar
; cdVBtnTipo	 EQU  WS_OVERLAPPEDWINDOW	      ; Normal sólo con los tres botones

section '.text' code readable executable
  start:
    invoke    GetModuleHandle,0
    mov       [wc.hInstance],eax
    invoke    GetCommandLine
    mov       [CommandLine], EAX
    stdcall   WinMain, [wc.hInstance], NULL, [CommandLine], SW_SHOWDEFAULT
    invoke    ExitProcess,[msg.wParam]

proc WinMain uses ebx esi edi, hInst, hPrevInst, CmdLine, CmdShow
    ;  Propósito: Inicializamos la ventana principal de la aplicación y captura errores, si los hubiere
    ;  Entrada	: hInst, hPrevInst, CmdLine, CmdShow
    ;  Salida	: Ninguna
    ;  Destruye : Ninguna
    invoke    LoadIcon,0,cdVIcono
    mov       [wc.hIcon],eax
    invoke    LoadCursor,0,cdVCursor
    mov       [wc.hCursor],eax
    invoke    RegisterClass,wc
    test      eax,eax
    jz	      error

    invoke    CreateWindowEx,cdVBarTipo,NombreClase,MsgCabecera,\
	      cdVBtnTipo,cdXPos, cdYPos, cdXSize, cdYSize,\
	      NULL,NULL,[wc.hInstance],NULL
    test      eax,eax
    jz	      error

    msg_loop:
      invoke	GetMessage,msg,NULL,0,0
      cmp	eax,1
      jb	end_loop
      jne	msg_loop
      invoke	TranslateMessage,msg
      invoke	DispatchMessage,msg
    jmp       msg_loop

  error:
    invoke    MessageBox,NULL,MsgError,NULL,MB_ICONERROR+MB_OK

  end_loop:
    MOV       EAX, [msg.wParam]
    ret
endp

proc WndProc uses ebx esi edi, hwnd,wmsg,wparam,lparam
    ;  Propósito: Procesa los mensajes provenientes de las ventanas
    ;  Entrada	: hwnd,wmsg,wparam,lparam
    ;  Salida	: Ninguna
    ;  Destruye : Ninguna
    cmp       [wmsg],WM_DESTROY
    je	      .wmdestroy
   ; cmp       [wmsg],WM_MOUSEMOVE
   ; je        .wmmousemove
    cmp       [wmsg],WM_PAINT
    je	      .wmpaint
    cmp       [wmsg],WM_LBUTTONDOWN
    je	      .wmLBUTTONDOWN
    
  .defwndproc:
    invoke    DefWindowProc,[hwnd],[wmsg],[wparam],[lparam]
    jmp       .finish
  .wmLBUTTONDOWN:
    mov       eax, [lparam]
    mov       edx, eax
    and       eax, 0ffffh
    inc       eax
    mov       [xPos], eax
    shr       edx, 16
    inc       edx
    mov       [yPos], edx
     mov [mouseClick],TRUE
    invoke    InvalidateRect,[hwnd],NULL,TRUE
    xor       eax,eax
    jmp       .finish
  .wmpaint:
    invoke    BeginPaint,[hwnd], Ps
    mov       [hDC],eax
    invoke    lstrlen,MsgRaton
    cmp [mouseClick],0
     je .seguir
	  invoke    TextOut,[hDC],[xPos],[yPos],MsgRaton,eax
    .seguir:
    invoke    EndPaint, [hwnd], Ps
    xor       eax,eax
    jmp       .finish
 .wmdestroy:
    invoke    PostQuitMessage,0
    xor       eax,eax
  .finish:
    ret
endp

section '.data' data readable writeable

  NombreClase TCHAR    'SimpleWinClass',0
  MsgCabecera TCHAR    'Raton', 0
  MsgError    TCHAR    'Carga inicial fallida.',0
  MsgRaton    TCHAR    'Hiciste click aqui',0
  wc	      WNDCLASS 0,WndProc,0,0,NULL,NULL,NULL,cdColFondo,NULL,NombreClase
  msg	      MSG
  rect	      RECT
  Ps	      PAINTSTRUCT
  CommandLine RD       1
  xPos	      RD       1
  yPos	      RD       1
  hDC	      RD       1
  mouseClick db 0

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas para que el enlazador pueda trabajar
	  user32,'USER32.DLL',\        ; Importamos las bibliotecas para que el enlazador pueda trabajar
	  gdi32,'GDI32.DLL'	      ; Importamos las bibliotecas para que el enlazador pueda trabajar

  include 'api\kernel32.inc'	       ; KERNEL32 API calls
  include 'api\user32.inc'	       ; USER32 API calls
  include 'api\gdi32.inc'	       ; GDI32 API calls
 
