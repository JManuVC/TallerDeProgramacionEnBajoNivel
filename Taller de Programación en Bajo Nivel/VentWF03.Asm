; ----------------------------------------------------------------------------
; -	  TITULO  : Ejemplo de ventana con resource interno W-FASM	     -
; ----- 								 -----
; -	  AUTOR   : Alfonso Víctor Caballero Hurtado			     -
; ----- 								 -----
; -	  VERSION : 1.0 						     -
; ----- 								 -----
; -	 (c) 2010. Abre los Ojos al Ensamblador 			     -
; ----------------------------------------------------------------------------

format PE GUI 4.0
entry start

cdIDD_DLG1  EQU 37
cdIDC_BTN1	  EQU  1000	    ; Id del botón de salir

include 'Win32a.inc'

section '.data' data readable writeable
  hInstance   DD  ?

section '.code' code readable executable
  start:
    invoke    GetModuleHandle, NULL
    MOV       [hInstance], EAX
    invoke    DialogBoxParam,[hInstance],cdIDD_DLG1,NULL,WndProc,NULL
    invoke    ExitProcess,0

proc WndProc uses ebx esi edi, hWnd,wmsg,wParam,lparam
    ;  Propósito: Procesa los mensajes provenientes de la ventana principal
    ;  Entrada	: hwnd,wmsg,wparam,lparam
    ;  Salida	: Ninguna
    ;  Destruye : Ninguna
    mov       eax, [wmsg]
    cmp       eax, WM_INITDIALOG
    je	      wmInitDialog
    cmp       eax, WM_COMMAND
    jz	      wmCommand
    cmp       eax, WM_CLOSE
    jz	      wmClose

    wmDefault:
	MOV	  EAX,FALSE
	jmp	  wmDFin
    wmInitDialog:
	jmp	  wmFin
    wmCommand:
	cmp	  [wParam], cdIDC_BTN1
	jne	  wmFin
	  invoke    EndDialog,[hWnd],0
	jmp	  wmFin
    wmClose:
	invoke	  EndDialog,[hWnd],0
    wmFin:    
    mov       eax,TRUE
    wmDFin:    
    ret
endp

section '.idata' import data readable writeable
  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas para que el enlazador pueda trabajar
	  user32,  'USER32.DLL'
	  
  include 'api\kernel32.inc'	       ; KERNEL32 API calls
  include 'api\user32.inc'	       ; USER32 API calls

section '.rsrc' resource data readable

  directory RT_DIALOG,dialogs

  resource dialogs,\
     cdIDD_DLG1,LANG_SPANISH+SUBLANG_DEFAULT,demonstration

  dialog demonstration,'Ventana con resource interno (FASM)',128, 128, 194, 102,20000h+80000h+10000000h  ; WS_GROUP+WS_SYSTEM+WS_VISIBLE
    dialogitem 'BUTTON','Exit',cdIDC_BTN1,130,60,50,13,WS_VISIBLE+WS_TABSTOP+BS_DEFPUSHBUTTON
  enddialog
 
