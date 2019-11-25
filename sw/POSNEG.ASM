data segment
        num dw -1h
        msg1 db "data is positive$",0ah,0dh,24h
        msg2 db "data is negative$",0ah,0dh,24h
data ends

print macro msg
	mov dx,offset msg
        mov ah,09h
	int 21h
        mov ah,4ch
	int 21h
endm

code segment
assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	mov ax,num
	rol ax,01
	jc l1
	print msg1
	l1:print msg2
code ends
end start

