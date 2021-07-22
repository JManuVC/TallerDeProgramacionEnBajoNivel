; ----------------------------------------------------------------------------
; -      TITULO  : Romance del Prisionero COM-MASM como ejemplo de           -
; -                cadenas de caracteres y varias líneas de datos            -
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
  Entrada PROC                            ; Abre el procedimiento
    ; Imprimimos el título
    MOV   DX, OFFSET Titulo               ; PARA la int21h
    MOV   AH, 9                           ; Llamamos a la función 9
    INT   21h                             ; de la interrupción 21h
    ; Imprimimos el contenido del poema
    MOV   DX, OFFSET Poema               ; PARA la int21h
    MOV   AH, 9                           ; Llamamos a la función 9
    INT   21h                             ; de la interrupción 21h

    MOV   AX, 4c00h                       ; Servicio 4Ch, mensaje 0
    INT   21h                             ; volvemos AL DOS
  Entrada ENDP                            ; cierra el procedimiento

  Titulo  DB 201, 26 DUP(205), 187, 13, 10
          DB 186, '  ROMANCE DEL PRISIONERO  ', 186, 13, 10
          DB 200, 26 DUP(205), 188, 13, 10, '$'
  Poema   DB 'Que por mayo era por mayo,', 13, 10
          DB 'cuando hace la calor,', 13, 10
          DB 'cuando los trigos enca¤an', 13, 10
          DB 'y est n los campos en flor,', 13, 10
          DB 'cuando canta la calandria', 13, 10
          DB 'y responde el ruise¤or,', 13, 10
          DB 'cuando los enamorados', 13, 10
          DB 'van a servir al amor,', 13, 10
          DB 'sino yo, triste, cuitado,', 13, 10
          DB 'que vivo en esta prisi¢n,', 13, 10
          DB 'que ni s‚ cu ndo es de d¡a,', 13, 10
          DB 'ni cu ndo las noches son,', 13, 10
          DB 'sino por una avecilla', 13, 10
          DB 'que me cantaba al albor.', 13, 10
          DB 'Mat¢mela un ballestero,', 13, 10
          DB 'd‚le Dios mal galard¢n.', 13, 10, '$'
codigo ENDS
END Entrada
; Salida por pantalla:
; C:\Trabajo\AOE\Codigos\Cap03>RomanCM1
; +--------------------------+
; ¦  ROMANCE DEL PRISIONERO  ¦
; +--------------------------+
; Que por mayo era por mayo,
; cuando hace la calor,
; cuando los trigos encañan
; y están los campos en flor,
; cuando canta la calandria
; y responde el ruiseñor,
; cuando los enamorados
; van a servir al amor,
; sino yo, triste, cuitado,
; que vivo en esta prisión,
; que ni sé cuándo es de día,
; ni cuándo las noches son,
; sino por una avecilla
; que me cantaba al albor.
; Matómela un ballestero;
; déle Dios mal galardón.
 
