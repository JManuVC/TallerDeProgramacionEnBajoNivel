

format PE GUI 4.0
entry start

include 'win32a.inc'	; Incluímos definiciones de estructuras y constantes
;WinMain proto dword,dword,dword,dword

cdXPos	      EQU  128	       ; Constante double X-Posición de la ventana(esq sup izqda)
cdYPos	      EQU  128	       ; Constante double Y-Posición de la ventana(esq sup izqda)
cdXSize       EQU  720	       ; Constante double X-tamaño de la ventana
cdYSize       EQU  400	       ; Constante double Y-tamaño de la ventana
cdColFondo    EQU  COLOR_WINDOW + 1  ; Color de fondo de la ventana: gris de un botón de comando
cdVIcono      EQU  IDI_APPLICATION ; Icono de la ventana, véase Resource.H
cdVCursor     EQU  IDC_ARROW   ; Cursor para la ventana
; Tipo de ventana (Barra de cabecera)
;cdVBarTipo  EQU  WS_EX_TOOLWINDOW		      ; Tipo de barra de Cabecera: delgado, sin icono, sin reflejo en barra de tareas
cdVBarTipo    EQU  NULL 			      ; Normal, con icono
cdVBtnTipo    EQU  WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU  ; Normal sólo con botón cerrar
cdID_MSG      EQU  500
cdID_SALIR    EQU  501

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
    ;  Si usáramos WM_PAINT, al menos aquí habría que redireccionar a wmDefault para que funcione
    
    mov       eax, [wmsg]
    cmp       eax, WM_DESTROY
    jz	      wmDestroy
    cmp       eax, WM_COMMAND
    jz	      wmCommand
    cmp       eax, WM_CREATE
    jz	      wmCreate

    wmDefault:
	invoke	 DefWindowProcA, [hwnd], [wmsg], [wparam], [lparam]
	jmp	 wmFin
    wmCreate:
	invoke	 CreateWindowEx, NULL, ClaseBoton, MsgbtnTexto1, WS_CHILD + WS_VISIBLE + BS_DEFPUSHBUTTON,\
		 160, 230,125, 30, [hwnd], 500, [wc.hInstance], NULL
	 invoke   CreateWindowEx, NULL, claseEdit, 0, WS_CHILD + WS_VISIBLE+WS_BORDER,\
		 80, 70, 175, 30, [hwnd], 501, [wc.hInstance], NULL
	 mov [hedit1],eax

	 invoke CreateWindowEx,NULL, etiqueta,texto,\
			WS_CHILD or WS_VISIBLE or SS_CENTER	,\
			100,100,100,50,[hwnd],23,[wc.hInstance],NULL
	 invoke CreateWindowEx,NULL, combo,0,\
			WS_CHILD or WS_VISIBLE or CBS_SIMPLE	,\
			290,80,100,100,[hwnd],23,[wc.hInstance],NULL
	  invoke CreateWindowEx,NULL, listab,cboton,\
			WS_CHILD or WS_VISIBLE or LBS_STANDARD	,\
			100,300,50,50,[hwnd],23,[wc.hInstance],NULL
	
		 invoke CreateWindowEx,NULL,ClaseBoton,apro,\
			WS_CHILD or WS_VISIBLE or BS_CHECKBOX,\
			500,300,150,50,[hwnd],23,[wc.hInstance],NULL
						
		invoke CreateWindowEx,NULL,scrollb,0,\
			WS_CHILD or WS_VISIBLE or SBS_BOTTOMALIGN	,\
			300,200,150,150,[hwnd],23,[wc.hInstance],NULL

	jmp	 wmFin
    wmCommand:
	cmp [wparam],500
	je btn_Salir
       jmp	wmDefault

	btn_Salir:
	    jmp      wmDestroy
	jmp	 wmFin
    wmDestroy:
	invoke	 PostQuitMessage,0
    wmFin:
    ret
endp

section '.data' data readable writeable

  MsgCabecera	  db	"Control", 0
  NombreClase	  db	"SimpleWinClass", 0
  MsgError	  db	"Carga inicial fallida.",0
  MsgCabBoton	  db	"El texto",0
  ClaseBoton	  db	"BUTTON", 0
  claseEdit	  db	"EDIT",0
  MsgbtnTexto1	  db	"Salir", 0
  etiqueta db "STATIC",0
		texto db "Hola soy un label",0
		combo db "COMBOBOX",0
		ccombo db "soy combo",0
		edit_class db "EDIT",0
		cedit db "soy edit",0
		listab db "LISTBOX",0
		scrollb db "SCROLLBAR",0
		apro db "aprobado :D",0
		 cboton db "Salir",0

  wc		  WNDCLASS 0,WndProc,0,0,NULL,NULL,NULL,cdColFondo,NULL,NombreClase
  msg		  MSG
  rct		  RECT	   NULL, NULL, NULL, NULL
  CommandLine	  rd	1
  wHandle	  rd	1
  hedit1	  dd ?

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas para que el enlazador pueda trabajar
	  user32,'USER32.DLL'	       ; Importamos las bibliotecas para que el enlazador pueda trabajar

  include 'api\kernel32.inc'	       ; KERNEL32 API calls
  include 'api\user32.inc'	       ; USER32 API calls
 
