
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
       
  ;Dados 3 num. dejar en bh el mayor, en ch el medio y en dh el menor
  
org 100h  
inicio:
mov bh,2
mov ch,4
mov dh,3
cmp bh, ch
ja continua
xchg bh, ch
continua:
cmp bh, dh
ja continua2
xchg bh, dh
continua2:
cmp ch, dh
ja fin
xchg dh, ch
fin:int 20h




