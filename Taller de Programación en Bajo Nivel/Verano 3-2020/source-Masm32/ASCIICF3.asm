; ----------------------------------------------------------------------------
; -      TITULO  : Caracteres ASCII COM-FASM con formato                     -
; -----                                                                  -----
; -      AUTOR   : Alfonso Víctor Caballero Hurtado                          -
; -----                                                                  -----
; -      VERSION : 1.0                                                       -
; -----                                                                  -----
; -      (c) 2010. Abre los Ojos al Ensamblador                              -
; ----------------------------------------------------------------------------
  use16 		         ; usa codigo de 16 bits
  ORG	    100h                 ; ES tipo COM
  INCLUDE   '..\LIB\CtesF.INC'   ; recogemos las constantes
  ; Constantes
  DirEsp   EQU  Espacio          ; Dirección donde se encuentran los espacios
  UnEsp    EQU  DirEsp + 2       ; Dirección para imprimir un espacio
  DosEsp   EQU  DirEsp + 1       ; Dirección para imprimir dos espacios
  NumCols  EQU  10               ; Número de columnas por cada fila
  ImpCad   EQU  9                ; Función imprimir cadena de INT 21h
  LeeCur   EQU  3                ; Función leer posición cursor de INT 10h
  PosCur   EQU  2                ; Función posicionar cursor de INT 10h
  ; ------------
  XOR       BL, BL               ; Contador de columnas
  $_loop:                        ; Aquí empieza el bucle principal
    ; 1. Justificamos el número a la derecha imprimiendo espacios
    MOV     AH, ImpCad           ; Función imprimir cadena de INT 21h
    CMP     [Car], 99            ; Comprobamos si el número necesita justificac
    JA      $_ImpNum             ; No hay que justificar a la derecha
    CMP     [Car], 9             ; Comprobamos si el número es < 10
    JA      $_DosDig
    MOV     DX, DosEsp           ; Con 1 dígito añadimos 2 espacios
    INT     21h                  ; Justificamos imprimiendo espacios
    JMP     $_ImpNum
    $_DosDig:
    MOV     DX, UnEsp            ; Con 2 dígitos añadimos 1 espacio
    INT     21h                  ; Justificamos imprimiendo espacios
    $_ImpNum:
    ; 2. Imprimimos el número propiamente
    XOR     AH, AH               ; Es un entero sin signo
    MOV     AL, [Car]            ; Usamos AL para pasar Car AL proc
    CALL    WriteByte            ; Escribimos el número Car
    ; 3. Imprimimos a su lado su carácter ASCII correspondiente
    ; 3.1. Primero obtenemos la posición del cursor
    MOV     AH, LeeCur           ; Obtenemos la posición del cursor
    XOR     BH, BH               ; Página 0
    INT     10h                  ; DH fila, DL columna
    ; 3.2. Hacemos los cálculos para impresión directa del carácter
    MOV     AX, 160              ; DI = 160*Fila+2*Columna
    MUL     DH
    MOV     DI, DX
    AND     DI, 0FFh             ; Limpiamos la parte superior
    SHL     DI, 1                ; Multiplicamos por 2
    ADD     DI, AX               ; En DI tenemos la posición de la mem pantalla
    ; 3.3. Ahora posicionamos el cursor un puesto a la derecha
    INC     DL                   ; Antes de imprimir nos posicionamos 1 derecha
    XOR     BH, BH               ; Página de vídeo activa
    MOV     AH, PosCur           ; Función posicionar el cursor
    INT     10h                  ; Posicionamos el cursor
    ; 3.4. Seleccionamos el resto de valores para impresión directa
    MOV     CX, 1                ; Número de caracteres a imprimir
    MOV     AH, 7                ; Atributo
    MOV     AL, [Car]            ; AL = carácter a imprimir
    CALL    WriteDirect          ; Imprimimos en la memoria pantalla el caracter
    ; 4. Imprimimos el espacio separador de columnas
    MOV     DX, DirEsp           ; Dirección al espacio separador de columnas
    ; 4.1. Contamos las columnas
    INC     BL                   ; Incrementamos contador de columnas
    ; 4.2. Si estamos al final de la fila saltamos a la siguiente
    CMP     BL, NumCols          ; Comprobamos que no hay más de NumCols colum
    JAE     $_NxtRow             ; Si es mayor, saltamos a otra fila
    MOV     AH, ImpCad           ; Función imprimir cadena de INT 21h
    INT     21h                  ; Imprimimos el espacio separador de columnas
    JMP     $_SgteASCII          ; No saltamos a la siguiente fila
    $_NxtRow:
    XOR     BL, BL               ; Inicializamos el contador de columnas
    MOV     DX, __CRLF           ; Metemos en DX la dirección de __CRLF
    MOV     AH, ImpCad           ; Función imprimir cadena de INT 21h
    INT     21h                  ; Saltamos al principio de la sgte fila
    ; 5. Incrementamos el contador de bytes
    $_SgteASCII:
    INC     BYTE [Car]           ; Siguiente carácter ASCII
  JNZ       $_loop               ; Mientras no superemos 255, volvemos
  MOV     AX, 4c00h              ; Servicio 4Ch, mensaje 0
  INT     21h                    ; volvemos AL DOS
; ****** Fin del programa
; ****** Aqui se pueden poner procedimientos y macros
  INCLUDE   '..\LIB\MathF.inc'   ; recogemos las op matemat
  INCLUDE   '..\LIB\TextoF.inc'  ; recogemos los procedimientos
  INCLUDE   '..\LIB\ScreenF.inc' ; Recogemos los procedimientos
; ****** Inicio de los datos
  INCLUDE   '..\LIB\DatosF.inc'  ; Recoge los datos
  Car       DB    0              ; Inicializamos el contador de bytes a 0
  Espacio   DB    '   $'         ; Espacio separador y formateador

; Salida por pantalla:
; Caracteres ASCII desde el 0 al 255
 
