data segment
	pa equ 0dc50h
	pb equ 0dc51h
	pc equ 0dc52h
	ctrl equ 0dc53h
	str1 db 86h,88h,0f9h,8eh
	str2 db 8ch,0c3h,86h,89h
	msg db 13,10,"press q to exit$"
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
	mov al,80h
	mov dx,ctrl
	out dx,ax
	mov ah,09h
	lea dx,msg
	int 21h

	again:
	mov bx,offset str1
	call display
	call delay
	mov bx,offset str2
	call display
	call delay
	mov ah,06h
	mov dl,0ffh
	int 21h
	cmp al,'q'
	jne again
	mov ah,4ch
	int 21h

	display proc
		mov si,03h
		up1:
		mov cx,08h
		mov ah,[bx+si]
		up:
		mov dx,pb
		rol ah,1
		mov al,ah
		out dx,al
		call clock
		dec cx
		jnz up
		dec si
		cmp si,-1
		jne up1
		ret
	display endp

	clock proc
		mov dx,pc
		mov al,01h
		out dx,al
		mov dx,pc
		mov al,00h
		out dx,al
		mov dx,pb
		ret
	clock endp

	delay proc
		push bx
		push cx
		mov cx,0ffffh
		d2: mov bx,0ffffh
		d1: dec bx
		jnz d1
		loop d2
		pop bx
		pop cx
		ret
	delay endp

code ends
end begin
