format PE GUI 4.0
entry inicio

include 'Win32a.inc'

ventana_1	equ		1
salir_btn	equ		1000
bt1	equ 1001
bt2	equ 1002
bt3	equ 1003
bt4	equ 1004
bt5	equ 1005
bt6	equ 1006
bt7	equ 1007
bt8	equ 1008
bt9	equ 1009
bt10	equ 1010
bt11	equ 1011
bt12	equ 1012
bt13	equ 1013
bt14	equ 1014
bt15	equ 1015
bt16	equ 1016

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
flag dd 3 

bmp1 dd ?		;Handles de las imagenes en la posición original
bmp2 dd ?
bmp3 dd ?
bmp4 dd ?
bmp5 dd ?
bmp6 dd ?
bmp7 dd ?
bmp8 dd ? 
bmp9 dd ?		;Handles de las imagenes en la posición original
bmp10 dd ?
bmp11 dd ?
bmp12 dd ?
bmp13 dd ?
bmp14 dd ?
bmp15 dd ?

menuB dd ?


mensaje db '¡¡¡¡¡GANASTE!!!!!!',0
titulo db 'Felicidades',0    

clase_boton db 'BUTTON',0
resolver db 'Resolver',0
tamanio db 'Tamanio',0
texto db 'EDIT',0
okay db 'Ok',0
four db '4',0
section '.code' code readable executable
numero dd 0
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
	invoke CreateMenu
	mov [menuB],eax
	invoke AppendMenu,[menuB],MF_MENUBREAK,1040,MF_STRING
	invoke SetMenu,[hWnd],[menuB]
	
	
	
	cmp [flag],3
	je ocultar
		invoke LoadBitmap,[Ist],3001
	mov [bmp1],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[bmp1]
	invoke LoadBitmap,[Ist],3002
	mov [bmp2],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[bmp2]
	invoke LoadBitmap,[Ist],3003
	mov [bmp3],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[bmp3]
	invoke LoadBitmap,[Ist],3004
	mov [bmp4],eax
	invoke SendDlgItemMessage,[pWnd],1004,BM_SETIMAGE,IMAGE_BITMAP,[bmp4]
	invoke LoadBitmap,[Ist],3005
	mov [bmp5],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[bmp5]
	invoke LoadBitmap,[Ist],3006
	mov [bmp6],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[bmp6]
	invoke LoadBitmap,[Ist],3007
	mov [bmp7],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[bmp7]
	invoke LoadBitmap,[Ist],3008
	mov [bmp8],eax
	invoke SendDlgItemMessage,[pWnd],1008,BM_SETIMAGE,IMAGE_BITMAP,[bmp8] 
	
	 invoke LoadBitmap,[Ist],3009
	mov [bmp9],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[bmp9]
	invoke LoadBitmap,[Ist],3010
	mov [bmp10],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[bmp10]
	invoke LoadBitmap,[Ist],3011
	mov [bmp11],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,[bmp11]
	invoke LoadBitmap,[Ist],3012
	mov [bmp12],eax
	invoke SendDlgItemMessage,[pWnd],1012,BM_SETIMAGE,IMAGE_BITMAP,[bmp12]
	invoke LoadBitmap,[Ist],3013
	mov [bmp13],eax
	invoke SendDlgItemMessage,[pWnd],1013,BM_SETIMAGE,IMAGE_BITMAP,[bmp13]
	invoke LoadBitmap,[Ist],3014
	mov [bmp14],eax
	invoke SendDlgItemMessage,[pWnd],1014,BM_SETIMAGE,IMAGE_BITMAP,[bmp14]
	invoke LoadBitmap,[Ist],3015
	mov [bmp15],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_SETIMAGE,IMAGE_BITMAP,[bmp15]
	
	invoke SendDlgItemMessage,[pWnd],1016,BM_SETIMAGE,IMAGE_BITMAP,0
	
	
	
	
		stdcall intercalar4x4
      ;  jmp crearBoton
		
	mov eax,1
	jmp finish
	
jCOMMAND:
	mov eax,[wParam]
	cmp	eax,salir_btn
	je	salir
							;botones
	cmp eax,1018			;4x4
	je verificar4x4
	
	cmp eax,1017			;3x3
	je verificar3x3
	
	cmp eax,1019			;Nuevo Juego
	je mezclar
	
	cmp eax,1020			;Cambiar Modo
	je verificarImg
	
							;Botones Juego
	cmp eax,1001
	je obtener1
	
	cmp eax,1002
	je obtener2
	
	cmp eax,1003
	je obtener3
	
	cmp eax,1004
	je obtener4

	cmp eax,1005
	je obtener5
	
	cmp eax,1006
	je obtener6
	
	cmp eax,1007
	je obtener7
	
	cmp eax,1008
	je obtener8
	
	cmp eax,1009
	je obtener9
	
	cmp eax,1010
	je obtener10
		
	cmp eax,1011
	je obtener11
	
	cmp eax,1012
	je obtener12
	
	cmp eax,1013
	je obtener13
	
	cmp eax,1014
	je obtener14
	
	cmp eax,1015
	je obtener15
	
	cmp eax,1016
	je obtener16

	cmp eax,1098
	je ordenar
	cmp eax,1099
	je obt
	;cmp eax,1090
	;je verTexto
	cmp eax,2000
	je verTexto
	xor eax,eax
	jmp finish
obt:
	invoke CreateWindowEx,0x00000200,texto,0,0x50010000,400,380,70,30,[pWnd],1090,[Ist],0
	invoke CreateWindowEx,0x00000000,clase_boton,okay,0x50010000,400,445,70,30,[pWnd],2000,[Ist],0 ; crear un boton estilo boton normal
	mov eax,1											   ; boton BMP	 0x50010080	50010000										     ;0x50010000 estilo bs bitmap: 0x50010080
	jmp finish
	mov eax,1
	jmp finish
verTexto:
	invoke DefWindowProc ,[pWnd],1090,WM_GETTEXT,1,[numero]

	mov eax,four
	cmp [numero],eax
	je con
	jmp f
	con:	mov [flag],4
		jmp mostrar4x4

	f:

	mov eax,1
	jmp finish
ordenar:
	cmp[flag],13
	jne saltar

	ord3:
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[bmp1]
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[bmp2]
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[bmp3]
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[bmp5]
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[bmp6]
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[bmp7]

	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[bmp10]
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[bmp9]
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,[bmp11]


	saltar:
		cmp [flag],14
		je ord4

		jmp salt
		ord4:
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[bmp1]
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[bmp2]
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[bmp3]
	invoke SendDlgItemMessage,[pWnd],1004,BM_SETIMAGE,IMAGE_BITMAP,[bmp4]
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[bmp5]
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[bmp6]
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[bmp7]
	invoke SendDlgItemMessage,[pWnd],1008,BM_SETIMAGE,IMAGE_BITMAP,[bmp8]

	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[bmp10]
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[bmp12]
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,[bmp9]
	invoke SendDlgItemMessage,[pWnd],1012,BM_SETIMAGE,IMAGE_BITMAP,[bmp11]
	invoke SendDlgItemMessage,[pWnd],1013,BM_SETIMAGE,IMAGE_BITMAP,[bmp14]
	invoke SendDlgItemMessage,[pWnd],1014,BM_SETIMAGE,IMAGE_BITMAP,[bmp13]
	invoke SendDlgItemMessage,[pWnd],1015,BM_SETIMAGE,IMAGE_BITMAP,[bmp15]
	invoke SendDlgItemMessage,[pWnd],1016,BM_SETIMAGE,IMAGE_BITMAP,0

	salt:

	mov eax,1
	jmp finish
obtener1:
	 local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover1
	mov eax,1
	jmp finish   
obtener2:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover2
	mov eax,1
	jmp finish	 
obtener3:
	 local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover3
	mov eax,1
	jmp finish
obtener4:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	
	
	cmp [t],0
	jne mover4
	mov eax,1
	jmp finish    
	
obtener5:
	 local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover5
	mov eax,1
	jmp finish  
obtener6:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover6
	mov eax,1
	jmp finish  
obtener7:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover7
	mov eax,1
	jmp finish
obtener8:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover8
	mov eax,1
	jmp finish 
obtener9:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover9
	mov eax,1
	jmp finish  
obtener10:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover10
	mov eax,1
	jmp finish  
obtener11:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover11
	mov eax,1
	jmp finish  
obtener12:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover12
	mov eax,1
	jmp finish  
obtener13:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover13
	mov eax,1
	jmp finish  
obtener14:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover14
	mov eax,1
	jmp finish
obtener15:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover15
	mov eax,1
	jmp finish  
	
obtener16:
	local t:DWORD
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t],eax
	cmp [t],0
	jne mover16
	mov eax,1
	jmp finish  
mover1:
	
	
	
		local b2:DWORD,b5:DWORD,b3:DWORD,b9:DWORD
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b2],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b5],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b3],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b9],eax
	
	cmp [b2],0
	je mover1_2
	
	cmp [b5],0
	je mover1_5
	
	cmp [b3],0
	je mover12_3
	
	cmp [b9],0
	je mover15_9
	cmp [flag],4
	je mover1B
	cmp [flag],14
	je mover1B
	
	mov eax,1
	jmp finish
mover1B:
	local b13:DWORD,b4:DWORD
		invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b13],eax
	invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b4],eax
	
	cmp[b13],0
	je mover1_5_9_13
	cmp[b4],0
	je mover1_2_3_4
	mov eax,1
	jmp finish
mover1_5_9_13:
	stdcall cambiar3,bt1,bt5,bt9,bt13
	stdcall verificar
	 mov eax,1
     jmp finish
mover1_2_3_4:
	stdcall cambiar3,bt1,bt2,bt3,bt4
	stdcall verificar
	 mov eax,1
     jmp finish
mover1_2:
	 stdcall cambiar,bt1,bt2
	 stdcall verificar
	 mov eax,1
     jmp finish
mover1_5:
	stdcall cambiar,bt1,bt5
	 stdcall verificar
	 mov eax,1
     jmp finish
mover12_3:
	stdcall cambiar2,bt1,bt2,bt3
	stdcall verificar
	mov eax,1
    jmp finish
mover15_9:
	stdcall cambiar2,bt1,bt5,bt9
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
    
mover2:
	
		local b1:DWORD,b3:DWORD,b6:DWORD,b10:DWORD
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b1],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b3],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b6],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b10],eax
	
	cmp [b1],0
	je mover2_1
	cmp [b3],0
	je mover2_3
	cmp [b6],0
	je mover2_6
	cmp [b10],0
	je mover26_10
	cmp [flag],4
	je mover2B
	cmp [flag],14
	je mover2B
	mov eax,1
	jmp finish
mover2B:
	local b4:DWORD,b14:DWORD
		invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b4],eax 
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b14],eax 
	
	cmp [b4],0
	je mover23_4 
	cmp [b14],0
	je mover2_6_10_14 
	mov eax,1
	jmp finish
mover23_4:
	stdcall cambiar2,bt2,bt3,bt4
	stdcall verificar
	mov eax,1
    jmp finish
mover2_6_10_14:
	stdcall cambiar3,bt2,bt6,bt10,bt14
	stdcall verificar
	mov eax,1
    jmp finish
mover2_1:
	stdcall cambiar,bt2,bt1
	stdcall verificar
	mov eax,1
    jmp finish
mover2_3:
	stdcall cambiar,bt2,bt3
	stdcall verificar
	mov eax,1
    jmp finish
mover2_6:
	stdcall cambiar,bt2,bt6
	stdcall verificar
	mov eax,1
    jmp finish
mover26_10:
	stdcall cambiar2,bt2,bt6,bt10
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
    

mover3:
	
	local b2:DWORD,b7:DWORD,b1:DWORD,b11:DWORD
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b2],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b7],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b1],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b11],eax
	
	cmp [b2],0
	je mover3_2
	cmp [b7],0
	je mover3_7
	cmp [b1],0
	je mover32_1
	cmp [b11],0
	je mover37_11
	
	cmp [flag],4
	je mover3B
	cmp [flag],14
	je mover3B
	
	mov eax,1
	jmp finish    
mover3B:
	local b4:DWORD,b15:DWORD,
	invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b4],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b15],eax
	
	cmp [b4],0
	je mover3_4
	cmp[b15],0
	je mover3_7_11_15
	
	mov eax,1
	jmp finish  
mover3_4:
	stdcall cambiar,bt3,bt4
	stdcall verificar
	mov eax,1
    jmp finish
mover3_7_11_15:
	stdcall cambiar3,bt3,bt7,bt11,bt15
	stdcall verificar
	mov eax,1
    jmp finish

mover3_2:
	stdcall cambiar,bt3,bt2
	stdcall verificar
	mov eax,1
    jmp finish
mover3_7:
	stdcall cambiar,bt3,bt7
	stdcall verificar
	mov eax,1
    jmp finish
mover32_1:
	stdcall cambiar2,bt3,bt2,bt1
	stdcall verificar
	mov eax,1
    jmp finish
	
mover37_11:
	stdcall cambiar2,bt3,bt7,bt11
	stdcall verificar
	mov eax,1
    jmp finish
	
mover4:
	local b3:DWORD,b8:DWORD,b2:DWORD,b12:DWORD,b16:DWORD,b1:DWORD
		invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b3],eax
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b8],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b2],eax
	 invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b12],eax
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b16],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b1],eax
	
	cmp [b3],0
	je mover4_3
	cmp [b8],0
	je mover4_8
	cmp [b2],0
	je mover43_2
	
	cmp [b12],0
	je mover48_12
	
	cmp [b16],0
	je mover4_8_12_16
	cmp [b1],0
	je mover4_3_2_1
	
		mov eax,1
	jmp finish
mover4_3:
	stdcall cambiar,bt4,bt3
	stdcall verificar
	mov eax,1
    jmp finish
mover4_8:
    stdcall cambiar,bt4,bt8
    stdcall verificar
	mov eax,1
    jmp finish
mover43_2:
	stdcall cambiar2,bt4,bt3,bt2
    stdcall verificar
	mov eax,1
    jmp finish
mover48_12:
	stdcall cambiar2,bt4,bt8,bt12
    stdcall verificar
	mov eax,1
    jmp finish
mover4_8_12_16:
	stdcall cambiar3,bt4,bt8,bt12,bt16
    stdcall verificar
	mov eax,1
    jmp finish
mover4_3_2_1:
	stdcall cambiar3,bt4,bt3,bt2,bt1
    stdcall verificar
	mov eax,1
    jmp finish
    
mover5:
	 local b1:DWORD,b6:DWORD,b9:DWORD,b7:DWORD
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b1],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b6],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b9],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b7],eax
	
	cmp [b1],0
	je mover5_1
	cmp [b6],0
	je mover5_6
	cmp [b9],0
	je mover5_9
	
	cmp[b7],0
	je mover56_7
	
	cmp [flag],4
	je mover5B
	cmp [flag],14
	je mover5B
	
	mov eax,1
	jmp finish
mover5B:
	local b13:DWORD,b8:DWORD
		invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b13],eax
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b8],eax
	
	cmp [b13],0
	je mover59_13
	
	cmp [b8],0
	je mover5_6_7_8
	
	mov eax,1
	jmp finish  
mover5_1:
	stdcall cambiar,bt5,bt1
	stdcall verificar
	mov eax,1
    jmp finish
mover5_6:
	stdcall cambiar,bt5,bt6
	stdcall verificar
	mov eax,1
    jmp finish
mover5_9:
	stdcall cambiar,bt5,bt9
	stdcall verificar
	mov eax,1
    jmp finish
mover56_7:
	stdcall cambiar2,bt5,bt6,bt7
	stdcall verificar
	mov eax,1
    jmp finish
	
mover59_13:
	stdcall cambiar2,bt5,bt9,bt13
	stdcall verificar
	mov eax,1
    jmp finish
	
mover5_6_7_8:
	stdcall cambiar3,bt5,bt6,bt7,bt8
	stdcall verificar
	mov eax,1
    jmp finish
	
mover6:
	local b2:DWORD,b5:DWORD,b7:DWORD,b10:DWORD
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b2],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b5],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b7],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b10],eax
	
	cmp [b2],0
	je mover6_2
	cmp [b5],0
	je mover6_5
	cmp [b7],0
	je mover6_7
	cmp [b10],0
	je mover6_10
	
	cmp [flag],4
	je mover6B
	cmp [flag],14
	je mover6B
	
	mov eax,1
	jmp finish 
mover6B:
	local b8:DWORD,b14:DWORD
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b8],eax
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b14],eax
	
	cmp [b8],0
	je mover67_8
	cmp [b14],0
	je mover610_14
	
	mov eax,1
	jmp finish 
mover67_8:
	stdcall cambiar2,bt6,bt7,bt8
	stdcall verificar
	mov eax,1
    jmp finish
mover610_14:
	stdcall cambiar2,bt6,bt10,bt14
	stdcall verificar
	mov eax,1
    jmp finish
mover6_2:
	stdcall cambiar,bt6,bt2
	stdcall verificar
	mov eax,1
    jmp finish
mover6_5:
	stdcall cambiar,bt6,bt5
	stdcall verificar
	mov eax,1
    jmp finish
 mover6_7:
	stdcall cambiar,bt6,bt7
	stdcall verificar
	mov eax,1
    jmp finish
 mover6_10:
	stdcall cambiar,bt6,bt10
	stdcall verificar
	mov eax,1
    jmp finish
    
mover7:
	local b3:DWORD,b6:DWORD,b11:DWORD,b5:DWORD
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b3],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b6],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b11],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b5],eax
	
	cmp [b3],0
	je mover7_3
	cmp [b6],0
	je mover7_6
	cmp [b11],0
	je mover7_11
	cmp [b5],0
	je mover76_5
	
	cmp [flag],4
	je mover7B
	cmp[flag],14
	je mover7B
	
	mov eax,1
	jmp finish  
mover7B:
	local b8:DWORD,b15:DWORD
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b8],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b15],eax
	
	cmp [b8],0
	je mover7_8
	cmp[b15],0
	je mover7_11_15
	
	mov eax,1
	jmp finish 
	
mover7_8:
	stdcall cambiar,bt7,bt8
	stdcall verificar
	mov eax,1
    jmp finish
mover7_11_15:
	stdcall cambiar2,bt7,bt11,bt15
	stdcall verificar
	mov eax,1
    jmp finish
mover7_3:
	stdcall cambiar,bt7,bt3
	stdcall verificar
	mov eax,1
    jmp finish
mover7_6:
	stdcall cambiar,bt7,bt6
	stdcall verificar
	mov eax,1
    jmp finish
mover7_11:
	stdcall cambiar,bt7,bt11
	stdcall verificar
	mov eax,1
    jmp finish
mover76_5:
	stdcall cambiar2,bt7,bt6,bt5
	stdcall verificar
	mov eax,1
    jmp finish
    
mover8:
	local b4:DWORD,b7:DWORD,b12:DWORD,b6:DWORD,b16:DWORD,b5:DWORD
		invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b4],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b7],eax
	invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b12],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b6],eax
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b16],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b5],eax
	
	cmp [b4],0
	je mover8_4
	cmp [b7],0
	je mover8_7
	cmp [b12],0
	je mover8_12
	cmp [b6],0
	je mover87_6
	cmp [b16],0
	je mover812_16
	
	cmp [b5],0
	je mover8_7_6_5
	mov eax,1
	jmp finish
mover8_4:
	stdcall cambiar,bt8,bt4
	stdcall verificar
	mov eax,1
    jmp finish
mover8_7:
	stdcall cambiar,bt8,bt7
	stdcall verificar
	mov eax,1
    jmp finish
mover8_12:
	stdcall cambiar,bt8,bt12
	stdcall verificar
	mov eax,1
    jmp finish
mover87_6:
	stdcall cambiar2,bt8,bt7,bt6
	stdcall verificar
	mov eax,1
    jmp finish
mover812_16:
	stdcall cambiar2,bt8,bt12,bt16
	stdcall verificar
	mov eax,1
    jmp finish
mover8_7_6_5:
	stdcall cambiar3,bt8,bt7,bt6,bt5
	stdcall verificar
	mov eax,1
    jmp finish
    
mover9:
	local b5:DWORD,b10:DWORD,b1:DWORD,b11:DWORD
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b5],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b10],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b1],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b11],eax
	
	cmp [b5],0
	je mover9_5
	cmp [b10],0
	je mover9_10
	cmp [b1],0
	je mover95_1
	cmp [b11],0
	je mover910_11
	
	cmp [flag],4
	je mover9B
	cmp [flag],14
	je mover9B
	
	mov eax,1
	jmp finish
mover9B:
	local b13:DWORD,b12:DWORD
		invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b13],eax
	invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b12],eax
	
	cmp [b13],0
	je mover9_13
	
	cmp [b12],0
	je mover9_10_11_12
		mov eax,1
	jmp finish
mover9_13:
	stdcall cambiar,bt9,bt13
	stdcall verificar
	mov eax,1
    jmp finish
mover9_10_11_12:
	stdcall cambiar3,bt9,bt10,bt11,bt12
	stdcall verificar
	mov eax,1
    jmp finish
mover9_5:
	stdcall cambiar,bt9,bt5
	stdcall verificar
	mov eax,1
    jmp finish
mover9_10:
	stdcall cambiar,bt9,bt10
	stdcall verificar
	mov eax,1
    jmp finish
mover95_1:
	stdcall cambiar2,bt9,bt5,bt1
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
mover910_11:
	stdcall cambiar2,bt9,bt10,bt11
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
mover10:
	local b9:DWORD,b6:DWORD,b11:DWORD,b2:DWORD
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b9],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b6],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b11],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b2],eax
	
	cmp [b9],0
	je mover10_9
	cmp [b6],0
	je mover10_6
	cmp [b11],0
	je mover10_11
	cmp [b2],0
	je mover106_2
	
	cmp[flag],4
	je mover10B
	cmp[flag],14
	je mover10B
	
	mov eax,1
	jmp finish 
mover10B:
	local b14:DWORD,b12:DWORD
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
    mov [b14],eax   
    invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
    mov [b12],eax
    
    cmp [b14],0
    je mover10_14 
    cmp [b12],0
    je mover1011_12 
    mov eax,1
    jmp finish 
mover10_14:
	stdcall cambiar,bt10,bt14
	stdcall verificar
	mov eax,1
    jmp finish
mover1011_12:
	stdcall cambiar2,bt10,bt11,bt12
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
mover10_9:
	stdcall cambiar,bt10,bt9
	stdcall verificar
	mov eax,1
    jmp finish
mover10_6:
	stdcall cambiar,bt10,bt6
	stdcall verificar
	mov eax,1
    jmp finish
mover10_11:
	stdcall cambiar,bt10,bt11
	stdcall verificar
	mov eax,1
    jmp finish
mover106_2:
	stdcall cambiar2,bt10,bt6,bt2
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
    
mover11:
	 local b10:DWORD,b7:DWORD,b9:DWORD,b3:DWORD
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b10],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b7],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b9],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b3],eax
	
	cmp [b10],0
	je mover11_10
	cmp [b7],0
	je mover11_7
	cmp [b9],0
	je mover1110_9
	cmp [b3],0
	je mover117_3
	
	cmp [flag],4
	je mover11B
	cmp [flag],14
	je mover11B
	mov eax,1
	jmp finish
mover11B:
	local b12:DWORD, b15:DWORD
		invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b12],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b15],eax
	
	cmp [b12],0
	je mover11_12
	cmp [b15],0
	je mover11_15
	mov eax,1
	jmp finish
mover11_12:
	stdcall cambiar,bt11,bt12
	stdcall verificar
	mov eax,1
    jmp finish
mover11_15:
	stdcall cambiar,bt11,bt15
	stdcall verificar
	mov eax,1
    jmp finish
    
mover11_10:
	stdcall cambiar,bt11,bt10
	stdcall verificar
	mov eax,1
    jmp finish

mover11_7:
	stdcall cambiar,bt11,bt7
	stdcall verificar
	mov eax,1
    jmp finish

mover1110_9:
	stdcall cambiar2,bt11,bt10,bt9
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
mover117_3:
	stdcall cambiar2,bt11,bt7,bt3
	stdcall verificar
	mov eax,1
    jmp finish
	mov eax,1
    jmp finish
    
    
mover12:
	local b8:DWORD,b11:DWORD,b16:DWORD,b10:DWORD,b4:DWORD,b9:DWORD
		invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b8],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b11],eax
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b16],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b10],eax
	invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b4],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b9],eax
	
	cmp [b8],0
	je mover12_8
	cmp [b11],0
	je mover12_11
	cmp [b16],0
	je mover12_16
	
	cmp [b10],0
	je mover1211_10
	cmp [b4],0
	je mover128_4
	
	cmp [b9],0
	je mover12_11_10_9
	
	mov eax,1
	jmp finish
mover12_8:
	stdcall cambiar,bt12,bt8
	stdcall verificar
	mov eax,1
    jmp finish
mover12_11:
	stdcall cambiar,bt12,bt11
	stdcall verificar
	mov eax,1
    jmp finish
mover12_16:
	stdcall cambiar,bt12,bt16
	stdcall verificar
	mov eax,1
    jmp finish
mover1211_10:
	stdcall cambiar2,bt12,bt11,bt10
	stdcall verificar
	mov eax,1
    jmp finish	
mover128_4:
	stdcall cambiar2,bt12,bt8,bt4
	stdcall verificar
	mov eax,1
    jmp finish 
mover12_11_10_9:
	stdcall cambiar3,bt12,bt11,bt10,bt9
	stdcall verificar
	mov eax,1
    jmp finish 

mover13:
	local b9:DWORD,b14:DWORD,b15:DWORD,b5:DWORD,b1:DWORD,b16:DWORD
		invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b9],eax
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b14],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b15],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b5],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b1],eax
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b16],eax
	
	cmp [b9],0
	je mover13_9
	cmp [b14],0
	je mover13_14
	cmp [b15],0
	je mover1314_15
	cmp [b5],0
	je mover139_5
	
	cmp [b1],0
	je mover13_9_5_1
	cmp [b16],0
	je mover13_14_15_16
	
	mov eax,1
	jmp finish
mover13_9:
	stdcall cambiar,bt13,bt9
	stdcall verificar
	mov eax,1
    jmp finish
mover13_14:
	stdcall cambiar,bt13,bt14
	stdcall verificar
	mov eax,1
    jmp finish
mover1314_15:
	stdcall cambiar2,bt13,bt14,bt15
	stdcall verificar
	mov eax,1
    jmp finish
mover139_5:
	stdcall cambiar2,bt13,bt9,bt5
	stdcall verificar
	mov eax,1
    jmp finish
mover13_9_5_1:
	stdcall cambiar3,bt13,bt9,bt5,bt1
	stdcall verificar
	mov eax,1
    jmp finish
mover13_14_15_16:
	stdcall cambiar3,bt13,bt14,bt15,bt16
	stdcall verificar
	mov eax,1
    jmp finish
mover14:
	local b13:DWORD,b10:DWORD,b15:DWORD,b16:DWORD,b6:DWORD,b2:DWORD
		invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b13],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b10],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b15],eax
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b16],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b6],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b2],eax
	
	cmp [b13],0
	je mover14_13
	cmp [b10],0
	je mover14_10
	cmp [b15],0
	je mover14_15
	cmp[b16],0
	je mover1415_16
	cmp[b6],0
	je mover1410_6
	
	cmp[b2],0
	je mover14_10_6_2
	
	mov eax,1
	jmp finish
mover14_13:
	stdcall cambiar,bt14,bt13
	stdcall verificar
	mov eax,1
    jmp finish
mover14_10:
	stdcall cambiar,bt14,bt10
	stdcall verificar
	mov eax,1
    jmp finish
mover14_15:
	stdcall cambiar,bt14,bt15
	stdcall verificar
	mov eax,1
    jmp finish
mover1415_16:
	stdcall cambiar2,bt14,bt15,bt16
	stdcall verificar
	mov eax,1
    jmp finish 
mover1410_6:
	stdcall cambiar2,bt14,bt10,bt6
	stdcall verificar
	mov eax,1
    jmp finish 
mover14_10_6_2:
	stdcall cambiar3,bt14,bt10,bt6,bt2
	stdcall verificar
	mov eax,1
    jmp finish 
	
mover15:
	local b14:DWORD,b11:DWORD,b16:DWORD,b13:DWORD,b7:DWORD,b3:DWORD
		invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b14],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b11],eax
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b16],eax
	invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b13],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b7],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b3],eax
	
	cmp [b14],0
	je mover15_14
	cmp [b11],0
	je mover15_11
	cmp [b16],0
	je mover15_16
	
	cmp [b13],0
	je mover1514_13
	cmp [b7],0
	je mover1511_7
	
	cmp [b3],0
	je mover15_11_7_3
	
	mov eax,1
	jmp finish
	
mover15_14:
	stdcall cambiar,bt15,bt14
	stdcall verificar
	mov eax,1
    jmp finish
mover15_11:
	stdcall cambiar,bt15,bt11
	stdcall verificar
	mov eax,1
    jmp finish
mover15_16:
	stdcall cambiar,bt15,bt16
	stdcall verificar
	mov eax,1
    jmp finish
    
mover1514_13:
	stdcall cambiar2,bt15,bt14,bt13
	stdcall verificar
	mov eax,1
    jmp finish
mover1511_7:
	stdcall cambiar2,bt15,bt11,bt7
	stdcall verificar
	mov eax,1
    jmp finish
mover15_11_7_3:
	stdcall cambiar3,bt15,bt11,bt7,bt3
	stdcall verificar
	mov eax,1
    jmp finish


mover16:
	local b12:DWORD,b15:DWORD,b14:DWORD,b8:DWORD,b4:DWORD,b13:DWORD
		invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b12],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b15],eax
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b14],eax
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b8],eax
	invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b4],eax
	invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [b13],eax
	
	cmp [b12],0
	je mover16_12
	cmp [b15],0
	je mover16_15
	
	cmp [b14],0
	je mover1615_14
	cmp [b8],0
	je mover1612_8
	
	cmp [b4],0
	je mover16_12_8_4
	cmp [b13],0
	je mover16_15_14_13
	mov eax,1
	jmp finish
mover16_12:
	stdcall cambiar,bt16,bt12
	stdcall verificar
	mov eax,1
    jmp finish
mover16_15:
	stdcall cambiar,bt16,bt15
	stdcall verificar
	mov eax,1
    jmp finish 
mover1615_14:
	stdcall cambiar2,bt16,bt15,bt14
	stdcall verificar
	mov eax,1
    jmp finish
mover1612_8:
	stdcall cambiar2,bt16,bt12,bt8
	stdcall verificar
	mov eax,1
    jmp finish
mover16_12_8_4:
	stdcall cambiar3,bt16,bt12,bt8,bt4
	stdcall verificar
	mov eax,1
    jmp finish	   
mover16_15_14_13:
	stdcall cambiar3,bt16,bt15,bt14,bt13
	stdcall verificar
	mov eax,1
    jmp finish 
ocultar:
	invoke GetDlgItem,[pWnd],1004
	invoke ShowWindow,eax,SW_HIDE
	
	invoke GetDlgItem,[pWnd],1008
	invoke ShowWindow,eax,SW_HIDE
	
	invoke GetDlgItem,[pWnd],1012
	invoke ShowWindow,eax,SW_HIDE
	
	invoke GetDlgItem,[pWnd],1016
	invoke ShowWindow,eax,SW_HIDE
	
	invoke GetDlgItem,[pWnd],1013
	invoke ShowWindow,eax,SW_HIDE
	
	invoke GetDlgItem,[pWnd],1014
	invoke ShowWindow,eax,SW_HIDE
	
	invoke GetDlgItem,[pWnd],1015
	invoke ShowWindow,eax,SW_HIDE
	
		invoke LoadBitmap,[Ist],3001
	mov [bmp1],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[bmp1]
	
	invoke LoadBitmap,[Ist],3002
	mov [bmp2],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[bmp2]
	
	invoke LoadBitmap,[Ist],3003
	mov [bmp3],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[bmp3]
	
	invoke LoadBitmap,[Ist],3004
	mov [bmp5],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[bmp5]
	
	invoke LoadBitmap,[Ist],3005
	mov [bmp6],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[bmp6]
	
	invoke LoadBitmap,[Ist],3006
	mov [bmp7],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[bmp7]
	
	invoke LoadBitmap,[Ist],3007
	mov [bmp9],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[bmp9]
	
	invoke LoadBitmap,[Ist],3008
	mov [bmp10],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[bmp10] 
	
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,0
		
		stdcall intercalar
      ; jmp crearBoton
		
	mov eax,1
	jmp finish
verificar4x4:
	cmp [flag],3
	je mostrar4x4
	
	
	mov eax,1
	jmp finish	
verificar3x3:
	cmp [flag],4
	je mostrar3x3
	
	mov eax,1
	jmp finish	
verificarImg:
	cmp [flag],3
	je mostrarImg3x3
	cmp [flag],13
	je mostrar3x3Num
	cmp [flag],4
	je mostrarImg4x4
	cmp [flag],14
	je mostrar4x4
	mov eax,1
	jmp finish	
mostrar3x3:
	mov [flag],3
	jmp ocultar
	mov eax,1
	jmp finish	
mostrar3x3Num:
	mov [flag],3
		invoke LoadBitmap,[Ist],3001
	mov [bmp1],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[bmp1]
	invoke LoadBitmap,[Ist],3002
	mov [bmp2],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[bmp2]
	invoke LoadBitmap,[Ist],3003
	mov [bmp3],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[bmp3]
	invoke LoadBitmap,[Ist],3004
	mov [bmp4],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[bmp4]
	invoke LoadBitmap,[Ist],3005
	mov [bmp5],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[bmp5]
	invoke LoadBitmap,[Ist],3006
	mov [bmp6],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[bmp6]
	invoke LoadBitmap,[Ist],3007
	mov [bmp7],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[bmp7]
	invoke LoadBitmap,[Ist],3008
	mov [bmp8],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[bmp8] 
	
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,0
		
		stdcall intercalar
	
	mov eax,1
	jmp finish
mostrar4x4:
	mov [flag],4
	
	jmp inicio
	mov eax,1
	jmp finish
mostrarImg3x3:
	
		mov [flag],13
		invoke LoadBitmap,[Ist],3021
	mov [bmp1],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[bmp1]
	
	invoke LoadBitmap,[Ist],3022
	mov [bmp2],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[bmp2]
	
	invoke LoadBitmap,[Ist],3023
	mov [bmp3],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[bmp3]
	
	invoke LoadBitmap,[Ist],3024
	mov [bmp5],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[bmp5]
	
	invoke LoadBitmap,[Ist],3025
	mov [bmp6],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[bmp6]
	
	invoke LoadBitmap,[Ist],3026
	mov [bmp7],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[bmp7]
	
	invoke LoadBitmap,[Ist],3027
	mov [bmp9],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[bmp9]
	
	invoke LoadBitmap,[Ist],3028
	mov [bmp10],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[bmp10] 
	
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,0
	
	stdcall intercalar
	mov eax,1
	jmp finish
	
mostrarImg4x4:

		mov [flag],14
		
		invoke LoadBitmap,[Ist],3031
	mov [bmp1],eax
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[bmp1]
	invoke LoadBitmap,[Ist],3032
	mov [bmp2],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[bmp2]
	invoke LoadBitmap,[Ist],3033
	mov [bmp3],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[bmp3]
	invoke LoadBitmap,[Ist],3034
	mov [bmp4],eax
	invoke SendDlgItemMessage,[pWnd],1004,BM_SETIMAGE,IMAGE_BITMAP,[bmp4]
	invoke LoadBitmap,[Ist],3035
	mov [bmp5],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[bmp5]
	invoke LoadBitmap,[Ist],3036
	mov [bmp6],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[bmp6]
	invoke LoadBitmap,[Ist],3037
	mov [bmp7],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[bmp7]
	invoke LoadBitmap,[Ist],3038
	mov [bmp8],eax
	invoke SendDlgItemMessage,[pWnd],1008,BM_SETIMAGE,IMAGE_BITMAP,[bmp8] 
	
	 invoke LoadBitmap,[Ist],3039
	mov [bmp9],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[bmp9]
	invoke LoadBitmap,[Ist],3040
	mov [bmp10],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[bmp10]
	invoke LoadBitmap,[Ist],3041
	mov [bmp11],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,[bmp11]
	invoke LoadBitmap,[Ist],3042
	mov [bmp12],eax
	invoke SendDlgItemMessage,[pWnd],1012,BM_SETIMAGE,IMAGE_BITMAP,[bmp12]
	invoke LoadBitmap,[Ist],3043
	mov [bmp13],eax
	invoke SendDlgItemMessage,[pWnd],1013,BM_SETIMAGE,IMAGE_BITMAP,[bmp13]
	invoke LoadBitmap,[Ist],3044
	mov [bmp14],eax
	invoke SendDlgItemMessage,[pWnd],1014,BM_SETIMAGE,IMAGE_BITMAP,[bmp14]
	invoke LoadBitmap,[Ist],3045
	mov [bmp15],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_SETIMAGE,IMAGE_BITMAP,[bmp15]
	
	invoke SendDlgItemMessage,[pWnd],1016,BM_SETIMAGE,IMAGE_BITMAP,0
	
	stdcall intercalar
	stdcall intercalar
	mov eax,1
	jmp finish
mezclar:
	cmp [flag],3
	je mezclar3x3
	cmp [flag],4
	je mezclar4x4
	cmp [flag],13
	je mezclar3x3
	cmp [flag],14
	je mezclar4x4
	mov eax,1
	jmp finish
mezclar3x3:
	stdcall intercalar
	mov eax,1
	jmp finish	
	
mezclar4x4:
	stdcall intercalar4x4
	mov eax,1
	jmp finish
crearBoton:
	invoke CreateWindowEx,0x00000000,clase_boton,resolver,0x50010000,520,380,70,30,[pWnd],1098,[Ist],0
	jmp crearBoton2; crear un boton estilo boton normal
	mov eax,1											   ; boton BMP	 0x50010080	50010000										     ;0x50010000 estilo bs bitmap: 0x50010080
	jmp finish
crearBoton2:
	invoke CreateWindowEx,0x00000000,clase_boton,tamanio,0x50010001,520,345,70,30,[pWnd],1099,[Ist],0 ; crear un boton estilo boton normal
	mov eax,1											   ; boton BMP	 0x50010080	50010000										     ;0x50010000 estilo bs bitmap: 0x50010080
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

proc verificar
		
	cmp [flag],4
	je ver4
	cmp [flag],14
	je ver4
	
		
		invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp1],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp2],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
       
	cmp [bmp3],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp5],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp6],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp7],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp9],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp10],eax
	jne parar
	
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0  
	
	invoke MessageBox,[pWnd],mensaje,titulo,MB_OK
	jmp mezclar
	
    ver4:
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp1],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp2],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
       
	cmp [bmp3],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp4],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp5],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp6],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp7],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp8],eax
	jne parar
	
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0  
	
	cmp [bmp9],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp10],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp11],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
       
	cmp [bmp12],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp13],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp14],eax
	jne parar
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	
	cmp [bmp15],eax
	jne parar
	;invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	
       ; cmp 0,eax
	jne parar
	
	invoke MessageBox,[pWnd],mensaje,titulo,MB_OK
	jmp mezclar
	
	
	parar:
		
		 
	ret
endp

proc cambiar b1,b2
	local t1:DWORD,t2:DWORD
	invoke SendDlgItemMessage,[pWnd],[b1],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t1],eax
	invoke SendDlgItemMessage,[pWnd],[b2],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t2],eax
	invoke SendDlgItemMessage,[pWnd],[b1],BM_SETIMAGE,IMAGE_BITMAP,[t2]
	invoke SendDlgItemMessage,[pWnd],[b2],BM_SETIMAGE,IMAGE_BITMAP,[t1]	
	ret
endp
proc cambiar2 b1,b2,b3
	local t1:DWORD,t2:DWORD,t3:DWORD
	invoke SendDlgItemMessage,[pWnd],[b1],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t1],eax
	invoke SendDlgItemMessage,[pWnd],[b2],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t2],eax
	invoke SendDlgItemMessage,[pWnd],[b3],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t3],eax
	
	invoke SendDlgItemMessage,[pWnd],[b1],BM_SETIMAGE,IMAGE_BITMAP,[t3]
	invoke SendDlgItemMessage,[pWnd],[b2],BM_SETIMAGE,IMAGE_BITMAP,[t1]
	invoke SendDlgItemMessage,[pWnd],[b3],BM_SETIMAGE,IMAGE_BITMAP,[t2]
	
	mov eax,1
	jmp finish	  
	ret
	endp
proc cambiar3 b1,b2,b3,b4
	local t1:DWORD,t2:DWORD,t3:DWORD,t4:DWORD
	invoke SendDlgItemMessage,[pWnd],[b1],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t1],eax
	invoke SendDlgItemMessage,[pWnd],[b2],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t2],eax
	invoke SendDlgItemMessage,[pWnd],[b3],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t3],eax
	invoke SendDlgItemMessage,[pWnd],[b4],BM_GETIMAGE,IMAGE_BITMAP,0
	mov [t4],eax
	
	invoke SendDlgItemMessage,[pWnd],[b1],BM_SETIMAGE,IMAGE_BITMAP,[t4]
	invoke SendDlgItemMessage,[pWnd],[b2],BM_SETIMAGE,IMAGE_BITMAP,[t1]
	invoke SendDlgItemMessage,[pWnd],[b3],BM_SETIMAGE,IMAGE_BITMAP,[t2]
	invoke SendDlgItemMessage,[pWnd],[b4],BM_SETIMAGE,IMAGE_BITMAP,[t3]
	
	mov eax,1
	jmp finish	  
	ret
	endp
proc intercalar
	 local tmp1:DWORD,tmp2:DWORD,tmp3:DWORD,tmp4:DWORD,tmp5:DWORD,tmp6:DWORD,tmp7:DWORD,tmp8:DWORD,tmp9:DWORD 
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp1],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp2],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp3],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp4],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp5],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp6],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp7],eax
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp8],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp9],eax
	
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[tmp6]
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[tmp3]
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[tmp7]
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[tmp9]
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[tmp1]
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[tmp8]
	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[tmp2]
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[tmp4]
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,[tmp5]	
	ret
endp
proc intercalar4x4
	local tmp1:DWORD,tmp2:DWORD,tmp3:DWORD,tmp4:DWORD,tmp5:DWORD,tmp6:DWORD,tmp7:DWORD,tmp8:DWORD,tmp9:DWORD,tmp10:DWORD,tmp11:DWORD,tmp12:DWORD,tmp13:DWORD,tmp14:DWORD,tmp15:DWORD,tmp16:DWORD
	
	invoke SendDlgItemMessage,[pWnd],1001,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp1],eax
	invoke SendDlgItemMessage,[pWnd],1002,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp2],eax
	invoke SendDlgItemMessage,[pWnd],1003,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp3],eax
	invoke SendDlgItemMessage,[pWnd],1004,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp4],eax
	invoke SendDlgItemMessage,[pWnd],1005,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp5],eax
	invoke SendDlgItemMessage,[pWnd],1006,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp6],eax
	invoke SendDlgItemMessage,[pWnd],1007,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp7],eax
	invoke SendDlgItemMessage,[pWnd],1008,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp8],eax
	invoke SendDlgItemMessage,[pWnd],1009,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp9],eax
	
	invoke SendDlgItemMessage,[pWnd],1010,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp10],eax
	invoke SendDlgItemMessage,[pWnd],1011,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp11],eax
	invoke SendDlgItemMessage,[pWnd],1012,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp12],eax
	invoke SendDlgItemMessage,[pWnd],1013,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp13],eax
	invoke SendDlgItemMessage,[pWnd],1014,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp14],eax
	invoke SendDlgItemMessage,[pWnd],1015,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp15],eax
	invoke SendDlgItemMessage,[pWnd],1016,BM_GETIMAGE,IMAGE_BITMAP,0
	mov [tmp16],eax
	
	invoke SendDlgItemMessage,[pWnd],1001,BM_SETIMAGE,IMAGE_BITMAP,[tmp6]
	invoke SendDlgItemMessage,[pWnd],1002,BM_SETIMAGE,IMAGE_BITMAP,[tmp3]
	invoke SendDlgItemMessage,[pWnd],1003,BM_SETIMAGE,IMAGE_BITMAP,[tmp7]
	invoke SendDlgItemMessage,[pWnd],1004,BM_SETIMAGE,IMAGE_BITMAP,[tmp9]
	invoke SendDlgItemMessage,[pWnd],1005,BM_SETIMAGE,IMAGE_BITMAP,[tmp1]
	invoke SendDlgItemMessage,[pWnd],1006,BM_SETIMAGE,IMAGE_BITMAP,[tmp8]
	invoke SendDlgItemMessage,[pWnd],1007,BM_SETIMAGE,IMAGE_BITMAP,[tmp2]
	invoke SendDlgItemMessage,[pWnd],1008,BM_SETIMAGE,IMAGE_BITMAP,[tmp4]
	invoke SendDlgItemMessage,[pWnd],1009,BM_SETIMAGE,IMAGE_BITMAP,[tmp5]
	
	invoke SendDlgItemMessage,[pWnd],1010,BM_SETIMAGE,IMAGE_BITMAP,[tmp16]
	invoke SendDlgItemMessage,[pWnd],1011,BM_SETIMAGE,IMAGE_BITMAP,[tmp13]
	invoke SendDlgItemMessage,[pWnd],1012,BM_SETIMAGE,IMAGE_BITMAP,[tmp11]
	invoke SendDlgItemMessage,[pWnd],1013,BM_SETIMAGE,IMAGE_BITMAP,[tmp14]
	invoke SendDlgItemMessage,[pWnd],1014,BM_SETIMAGE,IMAGE_BITMAP,[tmp10]
	invoke SendDlgItemMessage,[pWnd],1015,BM_SETIMAGE,IMAGE_BITMAP,[tmp12]
	invoke SendDlgItemMessage,[pWnd],1016,BM_SETIMAGE,IMAGE_BITMAP,[tmp15]
	ret
	
	endp	   

section '.idata' import data readable writeable
  
  ;otra forma para importar los procedimientos importando archivos INC
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'

section '.rsrc' resource from 'Puzzle v4.res' data readable
