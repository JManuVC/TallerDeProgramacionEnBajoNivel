format PE GUI
include 'win32ax.inc'
; import, code, data in the same section
MAXRECTS = 40
 xor ebx,ebx
 mov edi,wTitle
 mov esi,400000h
 ; +------------------------------+
 ; | registering the window class |
 ; +------------------------------+
 invoke RegisterClass,esp,ebx,WndProc,ebx,\
 ebx,esi,ebx,10011h,COLOR_WINDOW+1,ebx,edi
 ; +--------------------------+
 ; | creating the main window |
 ; +--------------------------+
 push ebx esi ebx ebx
 shl esi,9
 invoke CreateWindowEx,ebx,edi,edi,WS_OVERLAPPEDWINDOW+\
 WS_VISIBLE,esi,esi,esi,esi
 mov ebp,esp
 ; +---------------------------+
 ; | entering the message loop |
 ; +---------------------------+
message_loop: invoke GetMessage,ebp,ebx,ebx,ebx
 invoke DispatchMessage,ebp
 jmp message_loop
 ; +----------------------+
 ; | the window procedure |
 ; +----------------------+
proc WndProc hWnd, uMsg, wParam, lParam
local ps:PAINTSTRUCT
local Rect:RECT
 mov eax,[uMsg]
 mov edi,[hWnd]
 dec eax; cmp uMsg,WM_DESTROY
 dec eax
 je .wmDESTROY
 sub eax,WM_PAINT-WM_DESTROY; cmp uMsg,WM_PAINT
 je .wmPAINT
 sub eax,WM_LBUTTONDOWN-WM_PAINT;cmp eax,WM_LBUTTONDOWN
 je .wmLBUTTONDOWN
 sub eax,WM_RBUTTONDOWN-WM_LBUTTONDOWN
 je .wmRBUTTONDOWN
 leave
 jmp dword [DefWindowProc]
.wmPAINT:  mov ebx,[nextRect]
 inc ebx;cmp nextRect,-1
 jz .1
 invoke BeginPaint,edi,esp
 invoke SetBkMode,eax,TRANSPARENT
.3:  mov edx,8
 mov eax,[ebx*4+recs-4]
 mov ecx,eax
 shl ecx,1
 jnc @f
 shl edx,1
@@:  shr ecx,17
 push [PS+edx] [PS+edx+4] ecx
 push word 0
 push ax
 invoke  TextOut,dword[esp+16]
 dec  ebx
 jnz .3
 invoke EndPaint,edi,esp
 jmp .1
.wmLBUTTONDOWN:  mov eax,80000000h
.wmRBUTTONDOWN:  add eax,[lParam]
 cmp [nextRect],MAXRECTS-1
 jge short @f
 inc [nextRect]
 mov ecx,[nextRect]
 mov [ecx*4+recs],eax
 movzx edx,ax
 shl eax,1
 shr eax,17
 lea esi,[Rect]
 mov [esi+RECT.left],edx
 mov [esi+RECT.top],eax
 add edx,150
 mov [esi+RECT.right],edx
 add eax,20
 mov [esi+RECT.bottom],eax
 invoke InvalidateRect,edi,esi,ebx
 jmp .1
@@:  invoke MessageBeep,ebx
.1:  ret
.wmDESTROY: invoke ExitProcess,ebx
endp
;-------------------------------------------
     ;exp = experiment
      wTitle db   'Iczelion Tutorial #7:Mouse Input',0 ;name of our window
      text1 db '?????? ????? ??????'
      text2 db '?????? ?????? ??????'
      PS dd 0,0,text2-text1, text1, PS-text2, text2
      recs dd MAXRECTS dup (?)
      nextRect dd -1
;--------------------------------
data import
 library KERNEL32, 'KERNEL32.DLL',\
user32,   'USER32.DLL',\
GDI32,	  'GDI32.DLL'
 import KERNEL32,\
      ExitProcess,   'ExitProcess'
 import user32,\
RegisterClass,	  'RegisterClassA',\
CreateWindowEx,     'CreateWindowExA',\
DefWindowProc,	  'DefWindowProcA',\
GetMessage,    'GetMessageA',\
BeginPaint,    'BeginPaint',\
EndPaint,    'EndPaint',\
DispatchMessage,    'DispatchMessageA',\
InvalidateRect,     'InvalidateRect',\
MessageBeep,	'MessageBeep'
  import    GDI32,\
      TextOut,	 'TextOutA',\
      SetBkMode,   'SetBkMode'
end data