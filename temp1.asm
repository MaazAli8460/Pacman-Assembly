include Irvine32.inc

.data
array DB 1,2,4,5,3,7,9,11,22,33
array2 DB 5 dup(?)
    prompt DB "Enter the index of array: ", 0
    prompt1 db "Enter the character:",0
    prompt2 db"ENTER NUMBER:",0
    prompt3 db"ENTER POWER:",0
    prompt4 db"ANS:",0
    prompt5 db"ENTER NUMBER IN SUBJECT:",0
    prompt6 db"YOUR GRADE IS:",0
    prompt7 db"ENTER THE number of lines:",0
    prompt8 db"ENTER THE CHARACTER:",0
    spacevar DD 0
    spacevar2 DD 0

    starT db "*",0
    space db " ",0
    spacechar db 0,0
    newline db 10,0
    chart db 0
    nameStr DB 255 Dup (?)
    result DB "Your name is: ", 0

.code
;works fine

readchar1 PROC
    mov edx, offset prompt1   ; mov string offset in edx
    call writestring

    mov edx, offset chart
    mov ecx, 2
    call readstring
    mov al,chart
    dec al
    mov edx,0
    mov chart,al
    mov edx, offset chart   ; mov string offset in edx
    call writestring

    ret
readchar1 ENDP
;works fine
    

TASK4_POWEROFNUM PROC
    mov edx,offset newline
    call writestring
    mov edx, offset prompt2   ; mov string offset in edx
    call writestring

    mov eax,0
    call readint
    mov ebx,eax

    mov edx,offset newline
    call writestring

    mov edx,offset prompt3
    call writestring

    mov eax,0
    call readint
    mov ecx,eax
    
    mov eax,0
    mov eax,1
    l5:
        mul bl
    LOOP l5
    mov edx,offset newline
    call writestring

    mov edx,offset prompt4
    call writestring
    call writeint
ret
TASK4_POWEROFNUM ENDP
;works fine

TASK5_GPA PROC
    mov edx,offset newline
    call writestring

    mov edx, offset prompt5   ; mov string offset in edx
    call writestring

    mov eax,0
    call readint
    mov ebx,eax
    cmp al,50
    jl tagD
    cmp al,70
    jl tagC
            cmp al,90
            jl tagB
                mov eax,0
                mov al,'A'
                jmp end1
            
            tagB:
            mov eax,0
            mov al,'B'
            jmp end1

        tagC:
        mov eax,0
        mov al,'C'
        jmp end1

    tagD:
    mov eax,0
    mov al,'D'
    jmp end1

    end1:
    mov edx, offset prompt6   ; mov string offset in edx
    call writestring
    call writechar
ret

TASK5_GPA ENDP
;works fine

TASK6_I_PATTERN1 PROC
    mov edx,offset newline
    call writestring
    mov edx, offset prompt7   ; mov string offset in edx
    call writestring
    mov eax,0
    call readint

    mov ecx,eax
    mov ebx,1
    mov eax,1
    Starloop:
        XCHG ecx,ebx
        itt:
            mov edx,offset starT
            call writestring
        loop itt
        inc eax
        XCHG ecx,ebx
        mov ebx,eax
        mov edx,offset newline
        call writestring

    loop Starloop

ret

TASK6_I_PATTERN1 ENDP

;works fine
TASK6_II_PATTERN2 PROC
    mov edx,offset newline
    call writestring
    mov edx, offset prompt7   ; mov string offset in edx
    call writestring
    mov eax,0
    call readint

    mov ecx,eax
    mov ebx,eax
    Starloop:
        XCHG ecx,ebx
        itt:
            mov edx,offset starT
            call writestring
        loop itt
        dec eax
        XCHG ecx,ebx
        mov ebx,eax
        mov edx,offset newline
        call writestring

    loop Starloop


ret
TASK6_II_PATTERN2 ENDP

;HALF diamond is printed
TASK6_III_DIAMOND PROC
    push ebp
    mov ebp,esp
    mov edx,offset newline
    call writestring
    mov edx, offset prompt8   ; mov string offset in edx
    call writestring

    mov eax,0
    call readchar
    mov ebx,eax
    mov edx, offset prompt7   ; mov string offset in edx
    call writestring
    mov eax,0
    call readint
    mov spacevar,eax
    mov spacevar2,eax
    mov spacechar,bl

    mov ecx,eax
    mov ebx,1
    Diamond:
        XCHG eax,ecx
        spacel:
            mov edx, offset space   ; mov string offset in edx
            ;push offset space
            call writestring
        loop spacel
        dec spacevar
        XCHG eax,ecx
        mov eax,ebx
        XCHG eax,ecx
        pattrendiamond:
            mov edx, offset spacechar   ; mov string offset in edx
            call writestring
        loop pattrendiamond
        mov edx,offset newline
        call writestring
        XCHG eax,ecx
        add ebx,2
        mov eax,spacevar
    LOOP Diamond
    mov ecx,spacevar2
    inc ecx
    mov ebx,spacevar2
    dec ebx
    mov spacevar,1
    mov eax,1
    ;COMMENT %
    Diamond1:
        XCHG eax,ecx
        spacel2:
            mov edx, offset space   ; mov string offset in edx
            call writestring
        loop spacel2
        inc spacevar
        XCHG eax,ecx
        mov eax,ebx
        XCHG eax,ecx
        pattrendiamond2:
            mov edx, offset spacechar   ; mov string offset in edx
            call writestring
        loop pattrendiamond2
        mov edx,offset newline
        call writestring
        XCHG eax,ecx
        dec ebx
        mov eax,spacevar
    LOOP Diamond1
    ;%
    mov esp,ebp
    pop ebp
ret
TASK6_III_DIAMOND ENDP
TASK1 PROC


ret
TASK1 ENDP
main PROC
    comment &
    mov edx, offset prompt   ; mov string offset in edx
    call writestring    ; writestring will print content in edx

    
    mov eax,0
    call readint
    dec eax
    mov esi,eax;
    movzx eax,array[esi]
    call writeint
    mov edx,offset newline
    call writestring
    mov esi,0
    mov ecx,5
    L1:
         mov edx, offset prompt   ; mov string offset in edx
         call writestring    ;
         mov eax,0
         call readint
         mov array2[esi],al
         inc esi
    Loop L1

    mov esi,0
    mov ecx,5
    mov eax,0;
    L3:
         add al,array2[esi]
         inc esi
    Loop L3
    call writeint
    &
    ;CALL readchar1
    ;CALL TASK4_POWEROFNUM
    ;CALL TASK5_GPA
    CALL TASK6_I_PATTERN1
    CALL TASK6_II_PATTERN2
    CALL TASK6_III_DIAMOND
    Exit

main ENDP

END main