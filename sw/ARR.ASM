data segment
	arr db 05h,02h,10h,15h,01h
	len equ $-arr
	big db ?
data ends

code segment
assume cs:code,ds:data

start:
	mov ax,data
	mov ds,ax
	lea si,arr
	mov al,[si]
	mov big,al
	mov cx,len-1
	next:
		inc si
		mov al,[si]
	cmp al,big
	jc nochange
	mov big,al
	nochange:
		dec cx
		jnz next
        mov bl,big
	mov ah,4ch
	int 21h
code ends
end start
