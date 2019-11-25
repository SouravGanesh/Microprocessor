data segment
	pa equ 0dc50h
	pb equ 0dc51h
	pc equ 0dc52h
	ctrl equ 0dc53h
data ends

code segment
assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
	mov dx,ctrl
	mov al,82h
	out dx,al
	mov dx,pb
	in al,dx
	mov bl,00h
	mov cx,08h

	up:
	shr al,1
	jnc down
	inc bl

	down:
	loop up
	test bl,01h
	jnz oddp
	mov al,0ffh
	jmp next

	oddp:
	mov al,00h

	next:
	mov dx,pa
	out dx,al
	call delay
	mov al,bl
	mov dx,pa
	out dx,al
mov ah,4ch
int 21h

delay proc
	push cx
	push bx
	mov cx,0ffffh

	d2:
	mov bx,8fffh

	d1:
	dec bx
	
	jnz d1
	loop d2
	pop bx
	pop cx
	ret
delay endp

code ends
end start
