data segment
	pa equ 0dc50h
	pb equ 0dc51h
	pc equ 0dc52h
	ctrl equ 0dc53h
	table db "0123456789.+-*%ack=MRmn"
	str db 13,10,"press any key on the matrix key board$"
	str1 db 13,10,"press y to repeat and any key to exit$"
	msg db 13,10,"the code of the key pressed is "
	key db ?
	msg1 db 13,10,"the row is"
	row db ?
	msg2 db 13,10,"the column is "
	col db ?
	msge db 13,10,"$"
data ends

disp macro msg
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
	mov al,90h
	out dx,al
	again1: disp str
	mov si,0h

	again:
	call scan
	mov al,bh
	add al,31h
	mov row,al
	mov al,ah
	add al,31h
	mov col,al
	cmp si,00
	je again
	mov cl,03
	rol bh,cl
	mov cl,bh
	mov al,ah
	lea bx,table
	add bl,cl
	xlat
	mov key,al
	disp msg
	disp str1
	mov ah,01
	int 21h
	cmp al,'y'
	je again1
	mov ah,4ch
	int 21h

	scan proc
	mov cx,03
	mov bx,00
	mov al,80h

	nxtrow:
	rol al,01
	mov bl,al
	mov dx,pc
	out dx,al
	mov dx,pa
	in al,dx
	cmp al,0
	jne keyid
	mov al,bl
	inc bh
	ret
	
	keyid:
	mov si,1
	mov cx,8
	mov ah,0

	agn:
	ror al,1
	jc skip
	inc ah
	loop agn

	skip:
	ret
scan endp
code ends
end start

