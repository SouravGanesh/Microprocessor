data segment
	msg1 db "hai$"
	msg2 db 13,10,"hello$"
data ends

print macro msg
	lea dx,msg
	mov ah,09h
	int 21h
endm

code segment
assume cs:code,ds:data
begin:
	mov ax,data
      	mov ds,ax
      	print msg1
      	print msg2
      	mov ah,4ch
      	int 21h
code ends
end begin
