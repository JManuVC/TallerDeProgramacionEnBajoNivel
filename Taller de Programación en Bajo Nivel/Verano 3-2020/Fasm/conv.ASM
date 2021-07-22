include 'win32ax.inc'

.data

 strFormat	 db 'THE RESULT IS: %d',0
strTitle      db 'RESULT OF ADDITION',0
strBuffer	 rb 64

.code

  start:
     mov     eax, 53627
add	  eax, 73893
invoke	  wsprintf, strBuffer, strFormat, eax
add	 esp, 3*4

invoke	MessageBox, 0, strBuffer, strTitle, MB_OK
    push 0
	call [ExitProcess]

.end start