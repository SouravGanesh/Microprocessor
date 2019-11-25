data segment
        a dw 2h
        b dw 4h
        d dw 2h
        avg dw ?
data ends

code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax

        mov ax,a
        add ax,b

        div d
        mov avg,ax

        mov ax,4ch
        int 21h
code ends
end start
