

format	PE GUI 4.0
entry	start

include 'win32a.inc'
		      ; Incluímos definiciones de estructuras y constantes

cdXPos	    EQU  2'	    ; Constante double X-Posición de la ventana(esq sup izqda)
cdYPos	    EQU  20	    ; Constante double Y-Posición de la ventana(esq sup izqda)
cdXSize     EQU  900	     ; Constante double X-tamaño de la ventana
cdYSize     EQU  600	     ; Constante double Y-tamaño de la ventana
cdColFondo  EQU  COLOR_WINDOW+1
cdVIcono    EQU  IDI_APPLICATION ; Icono de la ventana, véase Resource.H
cdVCursor   EQU  IDC_ARROW   ; Cursor para la ventana
; Tipo de ventana (Barra de cabecera)
; cdVBarTipo  EQU  WS_EX_TOOLWINDOW			; Tipo de barra de Cabecera: delgado, sin icono, sin reflejo en la barra de tareas
cdVBarTipo  EQU  NULL		   ; Normal, con icono
cdVBtnTipo  EQU  WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU    ; Normal sólo con botón cerrar
; cdVBtnTipo	 EQU  WS_OVERLAPPEDWINDOW		 ; Normal sólo con los tres botones
; Constantes para la subventana del texto
cdVCarText  EQU  WS_CHILD + WS_VISIBLE + SS_CENTER
cdTXPos     EQU  15	 ; Constante double X-Posición subventana para el texto(esq sup izqda)
cdTYPos     EQU  30	 ; Constante double Y-Posición subventana para el texto(esq sup izqda)
cdTXSize    EQU  cdXSize-3*cdTXPos;[rct + RECT.right]	      ; Constante double X-tamaño de la subventana para el texto
cdTYSize    EQU  40;[rct + RECT.bottom]        ; Constante double Y-tamaño de la subventana para el texto
cdTipoSubV  EQU  NULL		; Tipo de subventana (flat-NULL, 3D-1, etc.)

      
section '.text' code readable executable
  start:
    invoke    GetModuleHandle, NULL
    mov       [wc.hInstance], eax
    mov       [wc.lpfnWndProc], WndProc
    mov       [wc.lpszClassName], NombreClase
    mov       [wc.hbrBackground], COLOR_WINDOW+1
    stdcall   WinMain, [wc.hInstance], NULL, NULL, SW_SHOWNORMAL
    invoke    ExitProcess, [wMsg.wParam]

proc WinMain uses ebx esi edi, hInst, hPrevInst, CmdLine, CmdShow
    ;  Propósito: Inicializamos la ventana principal de la aplicación y captura errores, si los hubiere
    ;  Entrada	: hInst, hPrevInst, CmdLine, CmdShow
    ;  Salida	: Ninguna
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
    jz	      error

    invoke    CreateWindowEx,NULL,NombreClase,MsgCabecera,\
	      WS_OVERLAPPEDWINDOW+WS_VISIBLE,cdXPos, cdYPos, cdXSize, cdYSize,\
	      NULL,NULL,[wc.hInstance],NULL
    mov       [wHMain],eax
    test      eax,eax
    jz	      error

    mov       [hWnd], eax

    invoke    ShowWindow, dword hWnd, dword SW_SHOWNORMAL
    invoke    UpdateWindow, dword hWnd

  msg_loop:
    invoke    GetMessage,wMsg,NULL,0,0
    cmp       eax,1
    jb	      end_loop
    jne       msg_loop
    invoke    TranslateMessage,wMsg
    invoke    DispatchMessage,wMsg
  jmp	    msg_loop

  error:
    invoke    MessageBox,NULL,MsgError,NULL,MB_ICONERROR+MB_OK

  end_loop:
    mov       eax, [wMsg.wParam]
    ret
endp

proc WndProc,hWnd,uMsg,wParam,lParam
    push      ebx esi edi    
    cmp       [uMsg],WM_DESTROY
    je	      wmDESTROY
    cmp       [uMsg],WM_PAINT
    je	      wmPAINT
    cmp       [uMsg],WM_CHAR
    je	      wmChar
    
    wmDEFAULT: 
      invoke	DefWindowProc,[hWnd],[uMsg],[wParam],[lParam]
      jmp	wmBYE
    wmPAINT:

      invoke	BeginPaint,[hWnd],ps
      mov	[expDc],eax
       invoke GetClientRect,[hWnd],rct
;POSTE			
		invoke CreateFont,60,50,0,0,400,0,0,0,ANSI_CHARSET,\
				       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
				       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
	 FontName2
		invoke SelectObject,[expDc],eax
		mov [hFont],eax
	; RGB 150, 104, 16
       invoke SetTextColor,[expDc],0x001457    ; #8B4E00
	;	 RGB 255, 255, 255
       ; invoke SetBkColor,hdc,eax
		invoke TextOut,[expDc],350,60,poste2,5	;450,60
		invoke TextOut,[expDc],475,380,poste3,7 ;574,380
		invoke CreateFont,60,26,0,0,0,0,0,0,ANSI_CHARSET,\
				       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
				       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
	 FontName2
		invoke SelectObject,[expDc],eax
	mov[ hFont],eax
		invoke TextOut,[expDc],650,100, poste1, 1 ;750,100
		invoke TextOut,[expDc],650,160, poste1,1 ;,160
		invoke TextOut,[expDc],650,220, poste1,1
		invoke TextOut,[expDc],650,280, poste1,1
		invoke TextOut,[expDc],650,340,poste1,1 ;,340
		
		invoke TextOut,[expDc],345,118, poste1, 1 ;445,118


	 invoke CreateFont,70,60,0,0,400,0,0,0,ANSI_CHARSET,\
				       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
				       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
	 FontName3
	invoke SelectObject,[expDc],eax
	mov [hFont],eax

	
       ; RGB 136, 0, 255
      ;  invoke SetTextColor,[epxDc],eax
	     ;	 RGB 234, 231, 44
     ;	invoke SetBkColor,hdc,eax
	   
       invoke TextOut,[expDc],230,10,ahorcadoT,11
      ;VIDAS
	   invoke CreateFont,80,70,0,0,400,0,0,0,ANSI_CHARSET,\
				       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
				       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
	FontName3
	invoke SelectObject,[expDc],eax
	mov [hFont],eax

	
      ;  RGB 255, 251, 0
       ; invoke SetTextColor,hdc,eax
	;	 RGB 255, 6, 6
	 ;	 invoke SetBkColor,hdc,eax
	  mov edx,[vidas]
	  invoke    wsprintf, vidasC, strFormat, edx
	  invoke TextOut,[expDc],130,200,vidasC,1

;RAYAS
	    invoke CreateFont,50,30,0,0,400,0,0,0,ANSI_CHARSET,\
				       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
				       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
	FontName2
	invoke SelectObject,[expDc],eax
	mov [hFont],eax

	
       ; RGB 28, 75, 209
       ; invoke SetTextColor,hdc,eax
	;	 RGB 35, 255, 0
      ; invoke SetBkColor,hdc,eax
	      invoke TextOut,[expDc],250,490,rayas,9
       
	invoke SelectObject,[expDc],hFont


	invoke SelectObject, [expDc], ps
   ;MUÑECO
	invoke CreateFont,60,50,0,0,400,0,0,0,ANSI_CHARSET,\
				       OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,\
				       DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,\
	 FontName2
		invoke SelectObject,[expDc],eax
	mov [hFont],eax
      ;   RGB 0, 0, 0
      ;  invoke SetTextColor,hdc,eax
       ;	 RGB 255, 255, 255
       ; invoke SetBkColor,hdc,eax
	     cmp [vidas],4
	     jbe cab
	     jne ste
	     cab:
		invoke TextOut,[expDc],312,170, cabeza,1
	    ste:
	      cmp [vidas],3
	      jbe tor
	      jne sbI
	      tor:

		invoke TextOut,[expDc],337,219, torso,1
		     sbI:
		cmp [vidas],2
		jbe biz
		jne sbD
	    biz:

		invoke TextOut,[expDc],317,219, brazoIzq,1
	 sbD:
	     cmp [vidas],1
	     jbe bder
	     jne spies
	     bder:


		invoke TextOut,[expDc],358,219, brazoDer,1

	      spies:
	     cmp [vidas],0
	     je mpies
	     jne pasar
	     mpies:
		invoke TextOut,[expDc],323,268, pies,2
	     pasar:

      invoke	EndPaint,[hWnd],ps 
      jmp	wmBYE

    wmChar:
		mov eax,[wParam]
		cmp [vidas],0
		je acabar
		stdcall reemplazar,rayas, palabra,eax
		mov edi,rayas
		mov esi,palabra
		
		comparar:
		mov dl,byte [esi]
		cmp dl,0
		je ganar
		cmp byte  [edi],dl
		jne se
		inc edi
		inc esi
		jmp comparar
		se:
		cmp cx,0
		je quitarVidas
		jne saltarV
		quitarVidas:
			sub [vidas],1
			invoke InvalidateRect,[hWnd],NULL,TRUE
			cmp [vidas],0
			je acabar
		saltarV:
		   invoke InvalidateRect,[hWnd],NULL,TRUE

		jmp seguir
		ganar:
			invoke InvalidateRect,[hWnd],NULL,TRUE
			invoke MessageBox,[hWnd], ganaste,felicidades,0
			jmp terminar
		acabar:
			invoke MessageBox,[hWnd], perdiste,sorry,0
			
			 
		terminar:
			mov [vidas],5
			mov edi,rayas
			stdcall limpiarCad
			invoke InvalidateRect,[hWnd],NULL,TRUE
		seguir:
		      invoke InvalidateRect,[hWnd],NULL,TRUE
	  jmp	    wmBYE

    wmDESTROY:
      invoke	PostQuitMessage,0 
    wmBYE: 
    pop       edi esi ebx
    ret
endp
proc reemplazar  dir:DWORD,dir2:DWORD,ca:DWORD
	mov edi,[dir]  ; rayas
	mov esi,[dir2] ;palabra
	xor edx,edx
	mov edx,[ca]
	xor ecx,ecx
	ciclo:
	cmp byte [esi],0
	je salirR
	cmp byte  [esi],dl
	jne saltarR
	mov byte  [edi],dl
	inc cx
	saltarR:
		inc esi
		inc edi
	jmp ciclo
	salirR:
	
ret
 endp
 proc limpiarCad

	limp:
		cmp byte [edi],0
		je salirL
		mov byte [edi],2Dh
		inc edi
	jmp limp
	salirL:
	ret
  endp

section '.data' data readable writeable
  wHMain       rd    1
  hWnd	       rd    1

  MsgCabecera  db    'Escribimos en nuestra ventana (FASM)',0
  NombreClase  db    'SimpleWinClass',0

  MsgError     db    'Carga inicial fallida.',0
  expDc        rd    1

	     
  wMsg	       MSG
  wc	       WNDCLASS

  ps	       PAINTSTRUCT
  rct	       RECT
 ; hfont	HFONT
  OurText  db "Win32 assembly is great and easy!",0
  len =$-OurText

   ahorcadoT db  "EL AHORCADO",0
	
	salirBoton db "Salir",0
	FontName db "Segoe UI Semibold",0
		FontName2 db "Arial Bold",0
		FontName3 db "Impact",0
		palabra db "assembler",0
		
		rayas db "---------",0
		vidas dd 5
		felicidades db "FELICIDADES!",0
		sorry db "Lo siento",0
		perdiste db "Perdiste :(",0
		cabeza db "O",0
		brazoIzq db "/",0
		brazoDer db "\",0
		torso db "|",0
		pies db "/\",0

		poste1 db "|",0

		poste2 db "_____",0

		poste3 db "__/_\__",0

		ganaste db "GANASTE! :D",0
		vidasT db "Vidas: ",0
		poste1.len =$-poste1
		poste2.len =$-poste2
		poste3.len =$-poste3
		hdc dd ?
		hFont dd ?
		vidasC db 50 dup(?)
		  strFormat	  db '%d',0

section '.idata' import data readable writable 

  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas para que el enlazador pueda trabajar
	  user32,'USER32.DLL',\
	  gdi32,'GDI32.DLL'	     ; Importamos las bibliotecas para que el enlazador pueda trabajar

  include 'api\kernel32.inc'	       ; KERNEL32 API calls
  include 'api\user32.inc'	       ; USER32 API calls
  include 'api\gdi32.inc'
 
