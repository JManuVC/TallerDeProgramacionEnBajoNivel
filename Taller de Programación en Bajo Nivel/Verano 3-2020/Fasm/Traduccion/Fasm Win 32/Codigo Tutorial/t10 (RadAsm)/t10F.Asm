format PE GUI 4.0
entry inicio

include 'Win32a.inc'

ventana_1	equ		1
salir_btn	equ		1000

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
Msg db "Hola",0
hello db "Wow! I'm in an edit box now",0
buffer db 512 dup(?)
section '.code' code readable executable

inicio:
	invoke GetModuleHandle,0
	mov [Ist],eax
	invoke DialogBoxParam,eax,ventana_1,0,DlgProc,0 
fin:
	invoke ExitProcess,0

proc DlgProc,hWnd,uMsg,wParam,lParam
	push edi esi ebx
	
	mov eax,[uMsg]
	cmp	eax,WM_COMMAND
	je	jCOMMAND
	cmp	eax,WM_INITDIALOG
	je	jINITDIALOG
	cmp	eax,WM_CLOSE
	je	jCLOSE
	xor eax,eax
	jmp finish

jINITDIALOG:
	mov eax,[hWnd]
	mov [pWnd],eax
	
	mov eax,1
	jmp finish
	
jCOMMAND:
	mov eax,[wParam]
	cmp	eax,salir_btn
	je	salir
	cmp eax,10002
	je obtenerTexto
	cmp eax,10003
	je limpiar
	cmp eax,10004
	je salir
	cmp eax,1002
	je sayH
	xor eax,eax
	jmp finish
obtenerTexto:
	 invoke GetDlgItemText,[hWnd],1001,buffer,512
     invoke   MessageBox, [hWnd], buffer, 0, MB_OK     
	mov eax,1
	jmp finish
limpiar:
	 invoke SetDlgItemText,[hWnd],1001,NULL
	mov eax,1
	jmp finish
sayH:

	invoke SetDlgItemText,[hWnd],1001,hello
	mov eax,1
	jmp finish
	 	
salir:
	invoke SendMessage,[hWnd],WM_CLOSE,0,0
	mov eax,1
	jmp finish
	
jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1
	
finish:
	pop ebx esi edi
	ret
endp

section '.idata' import data readable writeable

  ;otra forma para importar los procedimientos importando archivos INC
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'

section '.rsrc' resource from 't10F.res' data readable
