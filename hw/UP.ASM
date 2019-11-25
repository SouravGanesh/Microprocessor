data segment
	pa equ 0dc50h
	pb equ 0dc51h
	pc equ 0dc52h
	ctrl equ 0dc53h
	msg1 db "UP COUNTER $"
data ends

print macro msg
	lea dx,msg
	mov ah,09h
	int 21h
endm


code segment
assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
	mov dx,ctrl
	mov al,80h
	out dx,al

print msg1 
	mov al,00h
	mov cx,09h	
	mov dx,pa
	l1: out dx,al
	call delay
	inc al
	loop l1

mov ah,4ch
int 21h

delay proc
	push cx
	push bx
	mov cx,0ffffh
	d2: mov bx,8fffh
	d1:dec bx
	jnz d1
	loop d2
	pop bx	
	pop cx
	ret 
delay endp

code ends
end start

