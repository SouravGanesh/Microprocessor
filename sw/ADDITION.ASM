data segment
a db 1fh
b db 0fh
sum db ?
data ends

code segment
assume cs:code,ds:data
begin:mov ax,data
      mov ds,ax
      mov al,a
      add al,b
      mov sum,al
      mov ah,4ch
      int 21h
code ends
end begin
