; ----------------------------------------------------------------------------
; -      TITULO  : COM-MASM Punteros a estructuras                           -
; -----                                                                  -----
; -      AUTOR   : Alfonso Víctor Caballero Hurtado                          -
; -----                                                                  -----
; -      VERSION : 1.0                                                       -
; -----                                                                  -----
; -      (c) 2010. Abre los Ojos al Ensamblador                              -
; ----------------------------------------------------------------------------

codigo SEGMENT PARA PUBLIC 'CODE'         ; Abre el segmento de código
  ASSUME CS:codigo, DS:codigo, ES:codigo, SS:codigo
  ORG 100h                                ; COM -> comienza en 100h
  Entrada PROC                            ; Abre el procedimiento principal
    ; Imprimimos "Mis" datos
    MOV   AH, 9                           ; Llamamos a la función 9
    MOV   DX, [PDatos]                    ; Para la int21h
    INT   21h                             ; de la interrupción 21h
;   MOV   DX, [PDatos+40]                 ; No funciona, evidentemente
    ADD   DX, 40                          ; Para la int21h
    INT   21h                             ; de la interrupción 21h
    ; Salimos al DOS
    MOV   AX, 4c00h                       ; Servicio 4Ch, mensaje 0
    INT   21h                             ; volvemos AL DOS
  Entrada ENDP                            ; cierra el procedimiento
;   PEstruc    TYPEDEF  PTR               ; Puntero a estructura
;   PDatos     PEstruc  Datos             ; Puntero a estructura
  Datos        STRUC
    Nombre     BYTE  40 DUP(?)
    Direccion  BYTE  30 DUP(?)
  Datos        ENDS
  ; Definimos unas variables de tipo Identidad
  Mis      Datos  <'Alfonso Victor Caballero Hurtado$', 'C/ Madrid, 138$'>
  PDatos   WORD  OFFSET Mis               ; Puntero a estructura
  J        EQU   SIZEOF Datos             ; Tamaño en bytes de la estructura
codigo ENDS
END Entrada
; Salida por pantalla:
; C:\Trabajo\AOE\Codigos\Cap03>PStruCM1
; Alfonso Victor Caballero HurtadoC/ Madrid, 138
 
