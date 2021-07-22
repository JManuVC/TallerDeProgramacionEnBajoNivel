
include 'win32ax.inc'
org 100h
    mov eax,09h
    mov edx, cad
    int 21h

    int 20h

cad db 'Hello world!$'