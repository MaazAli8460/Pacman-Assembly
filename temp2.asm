INCLUDE Irvine32.inc


GetStdHandle PROTO, a1:DWORD
WriteConsoleA PROTO, a1 : DWORD, a2 : PTR BYTE, a3 : Dword, a4 : ptr dword, a5 : dword
ReadConsoleA PROTO, a1 : DWORD, a2 : PTR BYTE, a3 : Dword, a4 : ptr dword, a5 : dword



.data
str1 db "Invalid",0
str2 db 30 dup(?)
str3 db 0ah,"Enter the string to reverse:", 0

arr dw 1, 7, 3, 4, 5, 6, 7, 8, 9, 10
var db ?
msg byte "Enter Marks:", 0dh, 0ah, 0
buffer byte 15 dup(? )
x dword ?

shopper STRUCT
name1 db 3 dup(? )
id dd ?
total_bill dd ?
total_items dd ?
discount dd ?
shopper ENDS


shopper_var shopper  <"XYZ", 1234, 5000, 10, 10>
.code

enter_data PROC

call crlf
mov edx,offset shopper_var.name1
call writestring


call crlf
mov eax, shopper_var.id
call writeint


call crlf
mov eax, shopper_var.total_bill
call writeint


call crlf
mov eax, shopper_var.total_items
call writeint

call crlf
mov eax, shopper_var.discount
call writeint


ret
enter_data ENDP


mymacro MACRO p1, p2, p3
mov ax, p1
mov bx, p2
mov cx, p3
endm
print_grade PROC
invoke GetStdHandle, -11
; EAX will have the handle
mov ebx, lengthof msg
dec ebx; Do not display the null character

mov ecx, lengthof msg
mov al, 0dh
invoke WriteConsoleA, eax, offset msg, ebx, offset x, 0
; TO get standard input handle
; We can read tfrom console using this handle
mov x, 1
mov eax, 0
call readint

.iF(al < 50)
	mov eax, 'F'
	call writechar
	jmp end1

	.ENDIF
	.iF(al >= 50) && (al <= 59)
	mov eax, 'D'
	call writechar
	jmp end1

	.ENDIF
	.iF(al >= 60) && (al <= 75)
	mov eax, 'C'
	call writechar
	jmp end1

	.ENDIF
	.iF(al >= 76) && (al <= 90)
	mov eax, 'B'
	call writechar
	jmp end1

	.ENDIF
	.iF(al >= 90) && (al <= 100)
	mov eax, 'A'
	call writechar
	jmp end1

	.ENDIF
	mov edx, offset str1
	call writestring
	jmp end1
	end1 :
ret
print_grade ENDP

print_reverse PROC
mov edx, offset str3
call writestring
mov edx, offset str2
call readstring
; push ebp
mov esi,0
mov ecx,eax

.while eax>0
mov ebx,0
mov bl,str2[esi]
add esi,1
push bx
dec eax
.endw

.while ecx > 0
pop bx
mov eax,0
mov ax,bx
call writechar
dec ecx
.endw

ret
print_reverse ENDP
main PROC


mymacro 1, 2, 3
; TO get standard output handle
; We can write to console using this handle
call print_grade
call print_reverse
call enter_data
exit
main endp
end main