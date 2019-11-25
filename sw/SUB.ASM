data segment
        n1 db 04h
        n2 db 04h
	result db ?
data ends

code segment
assume cs:code, ds:data
begin:	mov ax,data
      	mov ds,ax
      	mov al,n1
      	sub al,n2
      	mov result,al
      	mov ah,4ch
      	int 21h
code ends
end begin
