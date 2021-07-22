
format PE GUI 4.0
entry start
include 'win32a.inc'

section '.text' code readable executable

     start:
	 invoke  MessageBox,0,texto,titulo,MB_OK
	 invoke  ExitProcess,0

section '.data' data readable writeable
	 titulo      db "Iczelion Tutorial No.2",0
	 texto	     db "Win32 Assembly is Great!",0

section '.idata' import data readable writeable
	  library kernel32,'KERNEL32.DLL',\    ; Importamos las bibliotecas
		   user32,'USER32.DLL'

	  include 'api\kernel32.inc'	       ; KERNEL32 API calls
	  include 'api\user32.inc'	       ; USER32 API calls
