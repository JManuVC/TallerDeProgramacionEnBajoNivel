format PE GUI 4.0
entry inicio

include 'Win32a.inc'
include 'Win32ax.inc'

ventana_1	equ		1
salir_btn	equ		1000

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
 
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
	cmp eax,1001
	je  eleminarF
	mov ebx,eax
	cmp ebx,4000
	jb  .siguiente
	cmp ebx,5000
	ja  .siguiente
	jmp eventoBTN
.siguiente:
	xor eax,eax
	jmp finish
eleminarF:
	stdcall eliminar,3
	mov eax,1
	jmp finish
eventoBTN:
	sub ebx,4000
	sub eax,4000
	shr eax,8
	mov bh,0
	invoke SetDlgItemInt,[pWnd],1010,eax,0
	invoke SetDlgItemInt,[pWnd],1011,ebx,0
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

proc eliminar,fila
	push eax ebx ecx edx
	mov eax,[fila]
	mov ecx,3
	mov edx,0100h
	.ciclo:
		mov ebx,[fila]
		or  ebx,edx
		add ebx,4000
		push eax ebx ecx edx
		invoke GetDlgItem,[pWnd],ebx
		invoke ShowWindow,eax,SW_HIDE
		pop edx ecx ebx eax
		add edx,0100h
		loop .ciclo
	pop edx ecx ebx eax
	ret
endp

section '.idata' import data readable writeable
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'

section '.rsrc' resource from 'MatrizBotones.res' data readable
