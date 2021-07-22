format PE GUI 4.0
entry MyEntry

include 'Win32a.inc'

ventana_1	equ		1
;IDs de los campos de texto
text_ed1	equ		1001
text_ed2	equ		1002
text_ed3	equ		1003
;IDs de los botones
mostrar_btn			equ	1004
intercambiar_btn	equ 1005
borrar_btn			equ 1006

section '.data' data readable writeable

Ist 	dd 0
pWnd 	dd 0
;titulo del mensaje
caption	db "Mensaje",0
;reservas de memoria de 1024 bytes para guardar cadenas y poder enviarlas en nuestros mensajes
buffer1	rb 1024
buffer2	rb 1024

section '.code' code readable executable

MyEntry:
	invoke GetModuleHandle,HWND_DESKTOP
	mov [Ist],eax
	invoke DialogBoxParam,eax,ventana_1,0,DlgProc,0 
ExitApp:
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
	cmp	eax,1000
	je	a1000
	cmp eax,mostrar_btn				;comprobamos que boton fue presionado
	je  mostrarMensaje				;comparando el contenido de wParam con los ids de los botones
	cmp eax,intercambiar_btn
	je  intercambiarText
	cmp eax,borrar_btn
	je  borrarTodo
	xor eax,eax
	jmp finish
mostrarMensaje:
	;obtenemos el texto en buffer enviandole el tamaño de buffer1(1024) y el id del campo de texto
	;del cual queremos obtener la cadena
	invoke SendDlgItemMessage,[pWnd],text_ed1,WM_GETTEXT,1024,buffer1
	;mostramos un mensaje con MessageBox enviandole el buffer1 q ya contiene a la cadena
	;y caption q sera el titulo del mensaje.	
	invoke MessageBox,[pWnd],buffer1,caption,MB_OK
	mov eax,1
	jmp finish
intercambiarText:
	;obtenemos las cadenas de ambos en buffer1 y buffer2 respectivamente
	invoke SendDlgItemMessage,[pWnd],text_ed2,WM_GETTEXT,1024,buffer1
	invoke SendDlgItemMessage,[pWnd],text_ed3,WM_GETTEXT,1024,buffer2
	;e intercambiamos cadenas enviando el mensaje WM_SETTEXT
	invoke SendDlgItemMessage,[pWnd],text_ed2,WM_SETTEXT,0,buffer2
	invoke SendDlgItemMessage,[pWnd],text_ed3,WM_SETTEXT,0,buffer1
	mov eax,1
	jmp finish
borrarTodo:
	;para borrar todos los campos de texto solo sera necesario enviar 0
	;enviando el mensaje WM_SETTEXT
	invoke SendDlgItemMessage,[pWnd],text_ed1,WM_SETTEXT,0,0
	invoke SendDlgItemMessage,[pWnd],text_ed2,WM_SETTEXT,0,0
	invoke SendDlgItemMessage,[pWnd],text_ed3,WM_SETTEXT,0,0
	mov eax,1
	jmp finish	
a1000:
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
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'

section '.rsrc' resource from 'camposdetextos.res' data readable
