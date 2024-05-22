INCLUDE Irvine32.inc

.data
SENTENCE BYTE "Hi, nice to meet you.", 0ah, 0

prompt1 BYTE "Yellow on Blue.", 0ah, 0
prompt2 BYTE "Cyan on Red.", 0ah, 0

colors_menu BYTE "00-Black", 0ah, "01-Blue ", 0ah, "02-Green ", 0ah, "03-Cyan ", 0ah, "04-red ", 0ah, "05-magenta ", 0ah, "06-brown ", 0ah, "07-ligthgray ", 0ah, "08-gray ", 0ah, "09-lightblue ", 0ah, "10-lightgreen ", 0ah, "11-lightcyan ", 0ah, "12-lightred ", 0ah, "13-lightmagenta ", 0ah, "14-yellow ", 0ah, "15-white", 0ah, 0
input_prompt BYTE 0ah, "Enter Text Color : ", 0
output_prompt BYTE 0ah, "Chosen Color.", 0

prompt3 BYTE "00-Black", 0ah, "01-Blue", 0ah, "02-Green", 0ah, "03-Cyan ", 0ah, "04-red ", 0ah, "05-magenta", 0ah, " 06-brown", 0
prompt4 BYTE 0ah, "Enter Text Color : ", 0
prompt5 BYTE 0ah, "Enter the Background Color : ", 0
prompt6 BYTE 0ah, "Required Color.", 0

empty BYTE " ", 0
str1 byte "hello world", 0
str2 db 020h,"                                                                                                                       "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        "
db "                                                                                                                        ",0
lightCyanTextOnCyan = black + (white * 16)
.code
Question5 PROC

mov ecx,20
mov edx,2
mov eax,black+(white*16)
call settextcolor
l1:
	call Randomize
	mov eax,990
	call RandomRange
	call writeint
	call crlf
	mov edi,ecx
	cmp ecx,1
	je break
	mov ecx,edx

		l2:
		mov eax , lightCyanTextOnCyan
		call settextcolor
		mov al , empty
		call writechar
		loop l2

	mov eax,black+(white*16)
	call settextcolor	
	add edx,2
	mov ecx,edi
loop l1

break:

mov eax,white+(black*16)
call settextcolor

ret
Question5 ENDP


main PROC
mov eax, lightCyanTextOnCyan
Call Settextcolor
mov edx,offset str2
call writestring
mov dl,0
mov dh,0
call gotoxy
call Question5
mov eax, lightCyanTextOnCyan
Call Settextcolor
call waitmsg
exit
main ENDP
End main

