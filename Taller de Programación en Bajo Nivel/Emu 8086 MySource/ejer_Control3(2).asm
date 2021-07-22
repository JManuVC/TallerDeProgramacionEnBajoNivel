
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
   ;Dados 3 num. dejar en bh el mayor, en ch el medio y en dh el menor
org 100h
inicio:     
    mov bh,5
    mov ch,10
    mov dh,1
    
    cmp bh,ch
    jb  intercambio1
    jmp continuar1 
intercambio1:
    xchg bh,ch
continuar1:
    cmp bh,dh 
    jb  intercambio2
    jmp continuar2
intercambio2:
    xchg bh,dh
continuar2:
    cmp ch,dh
    jb  intercambio3
    jmp fin2
intercambio3:
    xchg ch,dh

fin2:
    int 20h




