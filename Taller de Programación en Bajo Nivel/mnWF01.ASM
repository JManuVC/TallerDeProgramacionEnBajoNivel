; ----------------------------------------------------------------------------
; -       TITULO  : Ejemplo de menúes W-FASM                                 -
; -----                                                                  -----
; -       AUTOR   : Alfonso Víctor Caballero Hurtado                         -
; -----                                                                  -----
; -       VERSION : 1.0                                                      -
; -----                                                                  -----
; -      (c) 2010. Abre los Ojos al Ensamblador                              -
; ----------------------------------------------------------------------------

; Todas las palabras reservadas deben estar en minúsculas

format PE GUI 4.0
entry start

include 'win32a.inc'         ; Incluímos definiciones de estructuras y constantes
;WinMain proto dword,dword,dword,dword

cdXPos      EQU  128         ; Constante double X-Posición de la ventana(esq sup izqda)
cdYPos      EQU  128         ; Constante double Y-Posición de la ventana(esq sup izqda)
cdXSize     EQU  320         ; Constante double X-tamaño de la ventana
cdYSize     EQU  200         ; Constante double Y-tamaño de la ventana
cdColFondo  EQU  COLOR_WINDOW+1
cdVIcono    EQU  IDI_APPLICATION ; Icono de la ventana, véase Resource.H
cdVCursor   EQU  IDC_ARROW   ; Cursor para la ventana
cdVBarTipo  EQU  NULL                                 ; Normal, con icono
cdVBtnTipo  EQU  WS_VISIBLE+WS_OVERLAPPEDWINDOW    ; Botones de minimizar, maximizar y cerrar
IDM_ARCHIVO               EQU  40000
IDM_ARCHIVO_NUEVO         EQU  40001
IDM_ARCHIVO_ABRIR         EQU  40002
IDM_ARCHIVO_GUARDAR       EQU  40003
IDM_ARCHIVO_GUARDAR_COMO  EQU  40004
IDM_ARCHIVO_SALIR         EQU  40005
IDM_FONDO                 EQU  40010
IDM_FONDO_BLANCO          EQU  40011
IDM_FONDO_GRIS            EQU  40020
IDM_GRIS_CLARO            EQU  40012
IDM_GRIS_STD              EQU  40013
IDM_GRIS_OSCURO           EQU  40014
IDM_FONDO_NEGRO           EQU  40015
IDM_AYUDA                 EQU  40030

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
    ;  Entrada  : hInst, hPrevInst, CmdLine, CmdShow
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    invoke    LoadIcon,0,cdVIcono
    mov       [wc.hIcon],eax
    MOV       [wc.lpszMenuName], main_menu
    invoke    LoadCursor,0,cdVCursor
    mov       [wc.hCursor],eax
    invoke    RegisterClass,wc
    test      eax,eax
    jz        error

    invoke    LoadMenu,[wc.hInstance],37
    invoke    CreateWindowEx,cdVBarTipo,NombreClase,MsgCabecera,\
              cdVBtnTipo,cdXPos, cdYPos, cdXSize, cdYSize,\
              NULL,eax,[wc.hInstance],NULL
    test      eax,eax
    jz        error

    msg_loop:
      invoke    GetMessage,msg,NULL,0,0
      cmp       eax,1
      jb        end_loop
      jne       msg_loop
      invoke    TranslateMessage,msg
      invoke    DispatchMessage,msg
    jmp       msg_loop

  error:
    invoke    MessageBox,NULL,MsgError,NULL,MB_ICONERROR+MB_OK

  end_loop:
    MOV       EAX, [msg.wParam]
    ret
endp

proc WndProc uses ebx esi edi, hwnd,wmsg,wparam,lparam
    ;  Propósito: Procesa los mensajes provenientes de las ventanas
    ;  Entrada  : hwnd,wmsg,wparam,lparam
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    mov       eax, [wmsg]
    cmp       eax, WM_COMMAND
    jz        wmCommand
    cmp       eax, WM_DESTROY
    jz        wmDestroy
    cmp       eax, WM_CREATE
    jz        wmCreate

    wmDefault:
        invoke   DefWindowProcA, [hwnd], [wmsg], [wparam], [lparam]
        jmp      wmFin
    wmCreate:
        invoke   GetMenu, [hwnd]
        invoke   CheckMenuItem, eax, [iSelection], MF_CHECKED
        jmp      wmFin
    wmCommand:
        invoke    GetMenu, [hwnd]
        MOV       [hMenu],eax
        MOV       EAX, [wparam]
        AND       EAX, 0FFFFh
        CMP       EAX, IDM_ARCHIVO_NUEVO
        JE        mnu_archivo_nuevo
        CMP       EAX, IDM_ARCHIVO_ABRIR
        JE        mnu_archivo_abrir
        CMP       EAX, IDM_ARCHIVO_GUARDAR
        JE        mnu_archivo_guardar
        CMP       EAX, IDM_ARCHIVO_GUARDAR_COMO
        JE        mnu_archivo_guardar_como
        CMP       EAX, IDM_ARCHIVO_SALIR
        JE        mnu_archivo_salir
        CMP       EAX, IDM_AYUDA
        JE        mnu_ayuda
        CMP       EAX, IDM_FONDO_BLANCO
        JL        wmDefault
        CMP       EAX, IDM_FONDO_NEGRO
        JLE       mnu_cambiar_fondo
        JMP       wmDefault
        mnu_archivo_nuevo:
            invoke   MessageBox,[hwnd],MsgTxtArchNue, MsgCabecera,MB_OK+MB_ICONASTERISK  ; hWnd es la ventana padre => mensaje modal
            JMP      wmFin
        mnu_archivo_abrir:
            invoke   MessageBox,[hwnd],MsgTxtArchAbr, MsgCabecera,MB_OK+MB_ICONASTERISK  ; hWnd es la ventana padre => mensaje modal
            JMP      wmFin
        mnu_archivo_guardar:
            invoke   MessageBox,[hwnd],MsgTxtArchGrd, MsgCabecera,MB_OK+MB_ICONASTERISK  ; hWnd es la ventana padre => mensaje modal
            JMP      wmFin
        mnu_archivo_guardar_como:
            invoke   MessageBox,[hwnd],MsgTxtArchGrdC, MsgCabecera,MB_OK+MB_ICONASTERISK  ; hWnd es la ventana padre => mensaje modal
            JMP      wmFin
        mnu_archivo_salir:
            invoke   MessageBox,[hwnd],MsgTxtArchSal, MsgCabecera,MB_YESNO+MB_ICONASTERISK  ; hWnd es la ventana padre => mensaje modal
            CMP      EAX, IDYES   ; yes->eax=6, no->eax=7
            JNE      wmFin
                invoke    SendMessage, [hwnd], WM_CLOSE, 0, 0
            JMP      wmFin
        mnu_cambiar_fondo:
            invoke    CheckMenuItem, [hMenu], [iSelection], MF_UNCHECKED
            MOV       EAX, [wparam]
            MOV       [iSelection], EAX
            MOV       EBX, EAX
            SUB       EBX, IDM_FONDO_BLANCO
            SHL       EBX, 2                    ; Puesto que tratamos con DWORDS
            PUSH      EBX
            invoke    CheckMenuItem, [hMenu], EAX, MF_CHECKED
            POP       EBX
            PUSH      EBX
            invoke    GetStockObject, [idColour+EBX]
            invoke    SetClassLong, [hwnd], GCL_HBRBACKGROUND, EAX
            invoke    InvalidateRect, [hwnd], NULL, TRUE
            POP       EBX
            invoke   MessageBox,[hwnd],[vmColDirs+EBX], MsgCabecera,MB_OK+MB_ICONASTERISK  ; hWnd es la ventana padre => mensaje modal
            JMP      wmFin
        mnu_ayuda:
            invoke   MessageBox,[hwnd],MsgTxtAyuda, MsgCabAyuda,MB_OK+MB_ICONASTERISK  ; hWnd es la ventana padre => mensaje modal
        jmp      wmFin
    wmDestroy:
        invoke   PostQuitMessage,0
    wmFin:    
    ret
endp

section '.bss' data readable writeable
  CommandLine     DD       ?
  hMenu           DD    ?
  msg             MSG
  client          RECT

section '.data' data readable writeable

  NombreClase     DB    "SimpleWinClass", 0
  MsgCabecera     DB    "Desmostración de menú (FASM)", 0
  MsgError        DB    "Carga inicial fallida.",0
  MenuName        DB    "MENUDEMO",0         ; Nombre del menú en el fichero de recursos
  idColour        DD    WHITE_BRUSH, LTGRAY_BRUSH, GRAY_BRUSH, DKGRAY_BRUSH, BLACK_BRUSH
  iSelection      DD    IDM_FONDO_BLANCO
  szAppName       DB    "Menu Demo", 0
  MsgTxtArchNue   DB    "Has elegido Archivo->Nuevo",0
  MsgTxtArchAbr   DB    "Has elegido Archivo->Abrir",0
  MsgTxtArchGrd   DB    "Has elegido Archivo->Guardar",0
  MsgTxtArchGrdC  DB    "Has elegido Archivo->Guardar como",0
  MsgTxtArchSal   DB    "Has elegido Archivo->Salir",13,10,"¿Realmente quieres salir?", 0
  MsgTxtFndBln    DB    "Has elegido Fondo->Blanco",0
  MsgTxtFndGrC    DB    "Has elegido Fondo->Gris claro",0
  MsgTxtFndGris   DB    "Has elegido Fondo->Gris",0
  MsgTxtFndGrO    DB    "Has elegido Fondo->Gris oscuro",0
  MsgTxtFndNegro  DB    "Has elegido Fondo->Negro",0
  MsgCabAyuda     DB    "Ayuda", 0
  MsgTxtAyuda     DB    "Programado 100% en ensamblador",13,10,"(c)Abre ojos ensamblador",0
  vmColDirs       DD    MsgTxtFndBln, MsgTxtFndGrC, MsgTxtFndGris
                  DD    MsgTxtFndGrO, MsgTxtFndNegro
  wc              WNDCLASS 0,WndProc,0,0,NULL,NULL,NULL,cdColFondo,main_menu,NombreClase
  
section '.idata' import data readable writeable
  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas para que el enlazador pueda trabajar
          user32,  'USER32.DLL',\      ; Importamos las bibliotecas para que el enlazador pueda trabajar
          gdi32,   'GDI32.DLL'         ; Sólo necesario para cambiar la fuente del botón

  include 'api\kernel32.inc'           ; KERNEL32 API calls
  include 'api\user32.inc'             ; USER32 API calls
  include 'api\gdi32.inc'              ; Sólo necesario para cambiar la fuente del botón

  import user,\
         LoadMenu,'LoadMenuA'

    import    GDI32,\
      CreateFont,      'CreateFontA',\
      SelectObject,    'SelectObjectA',\
      DeleteObject,    'DeleteObjectA'

section '.rsrc' resource data readable

  directory RT_MENU,menus

  resource menus,\
           37,LANG_ENGLISH+SUBLANG_DEFAULT,main_menu
           
  menu main_menu
    menuitem '&Archivo',IDM_ARCHIVO,MFR_POPUP
       menuitem '&Nuevo',IDM_ARCHIVO_NUEVO
       menuitem 'A&brir',IDM_ARCHIVO_ABRIR
       menuitem '&Guardar',IDM_ARCHIVO_GUARDAR
       menuitem 'Guardar &como',IDM_ARCHIVO_GUARDAR_COMO
       menuseparator
    menuitem '&Salir',IDM_ARCHIVO_SALIR,MFR_END
    menuitem '&Fondo',IDM_FONDO,MFR_POPUP
       menuitem '&Blanco',IDM_FONDO_BLANCO
       menuitem 'G&ris',IDM_FONDO_GRIS,MFR_POPUP
           menuitem 'Gris c&laro',IDM_GRIS_CLARO
           menuitem 'Gr&is', IDM_GRIS_STD
       menuitem 'Gris &oscuro', IDM_GRIS_OSCURO,MFR_END 
    menuitem 'N&egro',IDM_FONDO_NEGRO,MFR_END
    menuitem 'A&yuda',IDM_AYUDA,MFR_END
 
