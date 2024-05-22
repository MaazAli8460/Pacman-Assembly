INCLUDE Irvine32.inc
INCLUDE macros.inc
include graphwin.inc
INCLUDELIB Irvine32.lib
INCLUDELIB winMM.lib

PlaySound PROTO, pszSound:PTR BYTE, hmod : DWORD, fdwSound : DWORD
SetConsoleTitle PROTO;     
ReadConsole PROTO
BUFFER_SIZE = 1000

.data
deviceConnect BYTE "DeviceConnect", 0
file BYTE "pacman_beginning.wav", 0
file1 BYTE"pacman_chomp_1.wav", 0
; file1 BYTE"pacman_chomp.wav", 0
file2 BYTE "pacman_death.wav", 0
file3 BYTE "pacman_eatghost.wav",0
file4 BYTE "pacman_eatfruit.wav",0
SND_ALIAS    DWORD 00010000h
SND_RESOURCE DWORD 00040005h
SND_FILENAME DWORD 00020000h
SND_SYNC DWORD 00020000h

delayPrint dd 300
delaystart dd 500

titleText   db "PAC-MAN :-)", 0; null - terminated string for the console title
String1 db "                                                           .         .                                                  ", 0ah, 0
string1size = ($ - string1) - 1
String2 db "      8 888888888o      .8.          ,o888888o.           ,8.       ,8.                    .8.          b.             8", 0ah, 0
String3 db "      8 8888    `88.   .888.        8888     `88.        ,888.     ,888.                  .888.         888o.          8", 0ah, 0
String4 db "      8 8888     `88  :88888.    ,8 8888       `8.      .`8888.   .`8888.                :88888.        Y88888o.       8", 0ah, 0
String5 db "      8 8888     ,88 . `88888.   88 8888               ,8.`8888. ,8.`8888.              . `88888.       .`Y888888o.    8", 0ah, 0
String6 db "      8 8888.   ,88'.8. `88888.  88 8888              ,8'8.`8888,8^8.`8888.            .8. `88888.      8o. `Y888888o. 8", 0ah, 0
String7 db "      8 888888888P'.8`8. `88888. 88 8888             ,8' `8.`8888' `8.`8888.          .8`8. `88888.     8`Y8o. `Y88888o8", 0ah, 0
String8 db "      8 8888      .8' `8. `88888.88 8888            ,8'   `8.`88'   `8.`8888.        .8' `8. `88888.    8   `Y8o. `Y8888", 0ah, 0
String9 db "      8 8888     .8'   `8. `88888`8 8888       .8' ,8'     `8.`'     `8.`8888.      .8'   `8. `88888.   8      `Y8o. `Y8", 0ah, 0
String10 db "      8 8888    .888888888. `88888. 8888     ,88' ,8'       `8        `8.`8888.    .888888888. `88888.  8         `Y8o.8", 0ah, 0
String11 db "      8 8888   .8'       `8. `88888. `8888888P'  ,8'         `         `8.`8888.  .8'       `8. `88888. 8            `88", 0ah, 0
String12 db "      8 8888  .8'         `8. '88888. `88888p'  ,8'                     `8.`8888..8'         `8. `88888.8              8", 0ah, 0
copyright1 db "           -------------------------------------------------------------------------------------------------------", 0ah, 0
copyright2 db "          | COPYWRIGHT RESERVED@ :                                                                                |", 0ah, 0
copyright3 db "          |                     MAAZ ALI                                                                          |", 0ah, 0
copyright4 db "          |                     COAL FINAL PROJECT 2023                                                           |", 0ah, 0
copyright5 db "           -------------------------------------------------------------------------------------------------------", 0ah, 0

instructions1 db "  _           _                   _   _             ",0ah,0
instructions2 db " | |         | |                 | | (_)            ", 0ah, 0
instructions3 db " | |  __  ___| |_ _ __ _   _  ___| |_ _  ___  _ __  ", 0ah, 0
instructions4 db " | | '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \ ", 0ah, 0
instructions5 db " | | | | \__ | |_| |  | |_| | (__| |_| | (_) | | | |", 0ah, 0
instructions6 db " |_|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|", 0ah, 0

play1 db " ____   _      ____ __ __ ", 0ah, 0
play2 db " |    \| |    /    |  |  |", 0ah, 0
play3 db " |  o  | |   |  o  |  |  |", 0ah, 0
play4 db " |   _/| |___|     |  ~  |", 0ah, 0
play5 db " |  |  |     |  _  |___, |", 0ah, 0
play6 db " |  |  |     |  |  |     |", 0ah, 0
play7 db " |__|  |_____|__|__|____/ ", 0ah, 0

highscore1 db "  __ __ ____  ____ __ __       _____   __  ___  ____    ___ ", 0ah, 0
highscore2 db " |  |  |    |/    |  |  |     / ___/  /  ]/   \|    \  /  _]", 0ah, 0
highscore3 db " |  |  ||  ||   __|  |  |    (   \_  /  /|     |  D  )/  [_ ", 0ah, 0
highscore4 db " |  _  ||  ||  |  |  _  |     \__  |/  / |  O  |    /|    _]", 0ah, 0
highscore5 db " |  |  ||  ||  |_ |  |  |     /  \ /   \_|     |    \|   [_ ", 0ah, 0
highscore6 db " |  |  ||  ||     |  |  |     \    \     |     |  .  |     |", 0ah, 0
highscore7 db " |__|__|____|___,_|__|__|      \___|\____|\___/|__|\_|_____|", 0ah, 0                                                     


instruction_decode db "Press 'i' for Instructions,'p' for Play, 'h' for Highscore, 'x' for exit",0
instruction_choice dd ?
                         


ground BYTE "-----------------------------------------------------------------", 0ah, 0
ground1 BYTE "|", 0ah, 0
ground2 BYTE "|", 0
prevChar BYTE ?
temp byte ?
buffer db ?
strScore BYTE "Your score is: ", 0
score DD 0
xPos BYTE 39
yPos BYTE 24
xCoinPos BYTE ?
yCoinPos BYTE ?
inputChar BYTE ?
handle1 Handle 0; input handle
; handle Handle 0; input handle

lpBuffer BYTE 0; pointer to buffer
nNumberOfCharsToRead DWORD 0; number of chars to read
lpNumberOfCharsRead DWORD 0; number of chars read
lpReserved DWORD 0; 0 (not used - reserved)
cursorInfo CONSOLE_CURSOR_INFO <>
priv coord <>
bytesRead DWORD ?

; set screen buffer size and windows info variables
ScreenBufferSize COORD <119, 29>
WindowsInfo SMALL_RECT <0, 0, 119, 29>

; Lives graphic
;<3
Lives_string1a db "<3 <3 <3",0
Lives_string1b db "3 Lives ",0
Lives_string2a db "<3 <3   ",0
Lives_string2b db "2 lives ",0
Lives_string3a db "<3      ",0
Lives_string3b db "Last Life",0
lives_length = ($ - Lives_string3b) - 1; 5
lives_length_temp = lives_length
no_of_lives_per_level = 3
lives_temp db no_of_lives_per_level
increment_factor =1
collision_bool dd 0
; Power_UPs
delayPalet dd 20000
delayStart1 dd ?
getTick dd ?
delayElapsed dd ?
p_palet_eaten dd 0
p_palet db "0";
Fruit1 db "^"; cherry

; Ghost
Inky dd  brown
Clyde dd cyan
Pinky dd magenta
bluey dd blue
bluey_cord_X byte 39
bluey_cord_Y byte 12
bluey_release word 10
counter1 SYSTEMTIME <>
bluey_pos_palet dd 0
bluey_pos_power dd 0


pinky_cord_X byte 38
pinky_cord_Y byte 12
pinky_release word 15
pinky_pos_palet dd 0
pinky_pos_power dd 0


inky_cord_X byte  40
inky_cord_Y byte  12
inky_release word 20
inky_pos_palet dd 0
inky_pos_power dd 0

clyde_cord_X byte 41
clyde_cord_Y byte 12
clyde_release word 25
clyde_pos_palet dd 0
clyde_pos_power dd 0

Ghost_Char dd "G"

; border Map


resume1 db " ____    ___ _______ __ ___ ___   ___ ",0ah,0
resume2 db "|    \  /  _/ ___|  |  |   |   | /  _]", 0ah, 0
resume3 db "|  D  )/  [(   \_|  |  | _   _ |/  [_ ", 0ah, 0
resume4 db "|    /|    _\__  |  |  |  \_/  |    _]", 0ah, 0
resume5 db "|    \|   [_/  \ |  :  |   |   |   [_ ", 0ah, 0
resume6 db "|  .  |     \    |     |   |   |     |", 0ah, 0
resume7 db "|__|\_|_____|\___|\__,_|___|___|_____|", 0ah, 0

Quit1 db "  ___  __ __ ____ ______ ",0ah,0
Quit2 db " /   \|  |  |    |      |", 0ah, 0
Quit3 db "|     |  |  ||  ||      |", 0ah, 0
Quit4 db "|  Q  |  |  ||  ||_|  |_|", 0ah, 0
Quit5 db "|     |  :  ||  |  |  |", 0ah, 0
Quit6 db "|     |     ||  |  |  |", 0ah, 0
Quit7 db " \__,_|\__,_|____| |__| ", 0ah, 0

Pause_instruct db "press 'r' to resume, press 'q' to quit",0


Grid2 db "11111111111111111111111111111111111111111111111111111111111111111111111111111111"
db "200000O000000000000000000000000000000000000000000000000000000000000000000O000002"
db "20111111111111111111011111111111111111101111111111111111111011111111111111111102"
db "20000000000000000000000000000000000000000000000000000000000000000000000000000002"
db "20111111111110111111111111111111111111101111111111111111111111111111111111111102"
db "20000000000000220000000000000000000000000000000000000O00000000000000000000000002"
db "20000000000000220000000001000000022222222222222200000000000000000000^00000000002"
db "2000111110000022000000000100000002CCCCCCCCCCCCC200000000001111111111111111000002"
db "2000000000000022000000000100000002CCCCCCCCCCCCC200000000001CCCCCCCCCCCCCC1000002"
db "2000000000000022000000000100000002CCCCCCCCCCCCC200000000001CCCCCCCCCCCCCC1000002"
db "20000000000000000000000001000000022222222222222200000000001111111111111111000002"
db "20000000100000000000000000000000000000000000000000000000000000000000000000000002"
db "20000000100000000001111111111111111111111111111111111111111110000000000000000002"
db "20000000100000000000000000000000000000000000000000000000000000000000000000000002"
db "20000000100000000000000000000000011111111111111000000000000000000010000000000002"
db "20000000100^00000000000000000000000000000000000000000000000000000010000000^00002"
db "200000001000000000000000000O0000000000000000000000000000000000000010000000000002"
db "20000000000000000000000000000000011111111111110000000000000000000010000000000002"
db "20000000000000000000000000000000000000010000000000000000000000000010000000000002"
db "20111111111111100000000111111111000000010000000011111111111100000010000000000002"
db "201CCCCCCCCCCC100000000000000000000000010000000000000000000000000010000000000002"
db "201CCCCCCCCCCC100000000000000O000000000C0000000000000000000000000010000O00000002"
db "20111111111111100000000000000000000000000000000000000000000000000010000000000002"
db "200000000O0000000000000000000000000000000000000000000000000000000000000000000002"
db "21111111111111111111111111111111111111111111111111111111111111111111111111111112"

Grid3 db "11111111111111111111111111111111111111111111111111111111111111111111111111111111"
db "20000000000O00000000000000000000000000000000000000000000000000000000000000000002"
db "20111111111111111111011111111111111111101111111111111111111011111111111111111102"
db "20000O00000000000000000000000000000000000000000000000000000000000O00000000000002"
db "20111111111110111111111111111111111111101111111111111111111111111111111111111102"
db "20000000000000220000000000000000000000000000000000000O00000000000000000000000002"
db "20000000000000220000000000000000222222222222222200000000000000000000000000000002"
db "2000000O0000002200000000000000002CCCCCCCCCCCCCC20000010000000000000000000^000002"
db "200000000000002200111111110000002CCCCCCCCCCCCCC200000100000000000000000000000002"
db "200011111111102200000O00000000002CCCCCCCCCCCCCC200000100000010000000000000000002"
db "20001CCCCCCC1000000000000000000022222222222222220000010000001000000O000000000002"
db "20001111111110000000001000000000000000000000000000000000000010000000000000000002"
db "C000000000000000000000100000000000000000000000000000000000001000000000000000000C"
db "200000000^0000000000001000000000000000000000000222222222220010000000000100000002"
db "200000000000000000000010000000000000000000000002CCCCCCCCC20010000000000100000002"
db "20000000000000000000001000000111111111111110000222222222220010000000000100000002"
db "20001111111111111000001000000000000010000000000000000000000000000000000100000002"
db "20000000000000000000001000000000000010000000000000000000000000000000000000000002"
db "200000000000000000000000^0000000000010000000000000111111111111111111111110000002"
db "20111111111111100000000000000000000010000000002000000000000010000000000000000002"
db "201CCCCCCCCCCC100000000000000000000010000000002000000000000010000000000000000002"
db "201CCCCCCCCCCC100000111111100O000000100C0000002000000O00000010000000000000^00002"
db "2011111111111110000000000000000000000000000000200000000000001000O000000000000002"
db "2O000000000000000000000000000000000000000000000000000000000000000000000000000002"
db "21111111111111111111111111111111111111111111111111111111111111111111111111111112"

; main grid and the rest of the map is drawn on this matrix.
border1up db "11111111111111111111111111111111111111111111111111111111111111111111111111111111"
db "20000000000000000000000000000000000000000000000000000000000000000000000000000002"
db "20111111111111111111011111111111111111101111111111111111111011111111111111111102"
db "20000000000000000000000000000000000000000000000000000000000000000000000000000002"
db "20111111111110111111111111111111111111101111111111111111111111111111111111111102"
db "20000000000000220000000000000000000000000000000000000000000000000000000000000002"
db "20000010000000220000000000000000022222222222222200000000000000000000000000000002"
db "2000001000000022001000000000000002CCCCCCCCCCCCC200000000011111111111111100000002"
db "2000001000000022001000000000000002CCCCCCCCCCCCC200000000000000000000000100000002"
db "2000001000000022001000001000000002CCCCCCCCCCCCC200000100000000000000000100000002"
db "20000010000000000010000010000000022222222222222200000100001000000000000100000002"
db "20000010000000000010000010000100000000000010000000000100001000000000000100000002"
db "20000000000000000000000010000100000000000010000000000100001000000000000100000002"
db "20111111111111111110111110000100000000000010000000000100001000000000000000000002"
db "20000000000000000020000000000100000000000011110000000100001000000000000000000002"
db "20000000000000000020000000000100000000000000000000000100001111111111000000000002"
db "20000000000000000020000000000100000011111111111000000100000000000000000000000002"
db "20000000000000000020000000000000000000000000000000000000000000000000000000000002"
db "20000000000000000000000000000111111111111111111110000000111111111111111100000002"
db "201111111111111000200000000000000000000000000000000000001CCCCCCCCCCCCCC100000002"
db "201CCCCCCCCCCC1000200000000000000000000000000000000000001CCCCCCCCCCCCCC100000002"
db "201CCCCCCCCCCC1000100000111111111110000C00000000000000001CCCCCCCCCCCCCC100000002"
db "20111111111111100000000000000000000000000000000000000000111111111111111100000002"
db "20000000000000000000000000000000000000000000000000000000000000000000000000000002"
db "21111111111111111111111111111111111111111111111111111111111111111111111111111112"

len_border = 80
height_border = 25
grid_Start_row = 3
grid_Start_col = 0
border_color dd blue
palet_color dd red
palet_count dd 0
temp_palet dd 0
palet_removed db 0
; Collision variables
collision_with_wall_X_cord db 4; subtract 4 to check on grid ploted on(0, 0)
Grid_pos_character db 0; here we will mul total number of cols with row num of character and add col no of character to rach the desegnated memory


; file handling variables
buffer1 BYTE BUFFER_SIZE DUP(? )
New_buffer BYTE BUFFER_SIZE DUP(? )
buffer_temp_size dd 0
new_buffer_size dd 0

filename     BYTE "highscore.txt", 0
fileHandle   HANDLE ?

stringLength DWORD ?
bytesWritten DWORD ?
str1 BYTE "Cannot create file", 0dh, 0ah, 0
str2 BYTE "Bytes written to file [output.txt]:", 0
str3 BYTE "Enter up to 500 characters and press"
BYTE "[Enter]: ", 0dh, 0ah, 0
; score dd 2734
score_temp dd 123456
temp_player db 10 dup(0)
level_user db 0
tempstr db "0001234567", 0
result dd 0; Variable to store the result
scorestr db 11 dup(0)
strLevel db "  LEVEL:", 0

player1_score dd 0
player1_score_str db 11 dup(0)
player1_name db 10 dup(? )
p1_level db 0

player2_score dd 0
player2_score_str db 11 dup(0)
player2_name db 10 dup(? )
p2_level db 0


player3_score dd 0
player3_score_str db 11 dup(0)
player3_name db 10 dup(? )
p3_level db 0

top_scorer db 3 dup(? )
tempvar dd 0
character1 db "c"
.code
END_SCRENE PROC
call clrscr

mwrite<"PlayerName:">
mov edx,offset temp_player
mov ecx,10
call writestring
call crlf
mwrite<"Playerscore:">

mov eax,score
call writedec
call crlf

call read_buffer
call update_buffer
ret
END_SCRENE ENDP

Pause_menu PROC

mov dl,82
mov dh,1
call gotoxy
mov eax, 4
call settextcolor
mov  edx, OFFSET resume1
call WriteString
mov dl, 82
mov dh,2
call gotoxy
mov  edx, OFFSET resume2
call WriteString
mov dl, 82
mov dh, 3

call gotoxy
mov  edx, OFFSET resume3
call WriteString
mov dl, 82
mov dh, 4

call gotoxy
mov  edx, OFFSET resume4
call WriteString
mov dl, 82
mov dh, 5

call gotoxy
mov  edx, OFFSET resume5
call WriteString
mov dh, 6
mov dl, 82
call gotoxy
mov  edx, OFFSET resume6
call WriteString
mov dh, 7
mov dl, 82
call gotoxy
mov  edx, OFFSET resume7
call WriteString
mov dh, 8
mov dl, 82
call gotoxy
mov  edx, OFFSET Quit1
call WriteString
mov dl, 82
mov dh, 9
call gotoxy
mov  edx, OFFSET Quit2
call WriteString
mov dl, 82
mov dh, 10

call gotoxy
mov  edx, OFFSET Quit3
call WriteString
mov dl, 82
mov dh, 11

call gotoxy
mov  edx, OFFSET Quit4
call WriteString
mov dl, 82
mov dh, 12

call gotoxy
mov  edx, OFFSET Quit5
call WriteString
mov dh, 13
mov dl, 82
call gotoxy
mov  edx, OFFSET Quit6
call WriteString
mov dh, 14
mov dl, 82
call gotoxy
mov  edx, OFFSET Quit7
call WriteString
mov dh, 15
mov dl, 82
call gotoxy
mwrite<"press 'r' to resume, press 'q' to quit",0dh,0ah>
mov eax,0
call readchar
ret
Pause_menu ENDP

Print_Menu PROC

call clrscr
mov eax, 3
call settextcolor

mov  edx, OFFSET instructions1
call WriteString
mov  edx, OFFSET instructions2
call WriteString
mov  edx, OFFSET instructions3
call WriteString
mov  edx, OFFSET instructions4
call WriteString
mov  edx, OFFSET instructions5
call WriteString
mov  edx, OFFSET instructions6
call WriteString

mov  edx, OFFSET ground
call WriteString

mov eax, 4
call settextcolor
mov  edx, OFFSET play1
call WriteString
mov  edx, OFFSET play2
call WriteString
mov  edx, OFFSET play3
call WriteString
mov  edx, OFFSET play4
call WriteString
mov  edx, OFFSET play5
call WriteString
mov  edx, OFFSET play6
call WriteString
mov  edx, OFFSET play7
call WriteString
mov  edx, OFFSET ground
call WriteString

mov eax, 5
call settextcolor
mov  edx, OFFSET highscore1
call WriteString
mov  edx, OFFSET highscore2
call WriteString
mov  edx, OFFSET highscore3
call WriteString
mov  edx, OFFSET highscore4
call WriteString
mov  edx, OFFSET highscore5
call WriteString
mov  edx, OFFSET highscore6
call WriteString
mov  edx, OFFSET highscore7
call WriteString
mov  edx, OFFSET ground
call WriteString
mov eax, 6
call settextcolor
mov  edx, OFFSET instruction_decode
call WriteString
mov eax, 0
call readchar
; mov instruction_choice, al
cmp al,"p"
je start_game
    cmp al,"h"
    je print_high
        cmp al,"i"
        je print_instruct
            cmp al,"x"
            je Exit_game
                 
            Exit_game:
            mov eax,1
            ret
        print_instruct:
        call print_instructions
        call Print_Menu
    print_high:
    call print_highscore
    call Print_Menu

start_game:
ret

Print_Menu ENDP

print_instructions PROC
call clrscr

mWrite <"Objective:", 0dh, 0ah>
mWrite <"Navigate Pac-Man through the maze, eat all the dots, and avoid the ghosts. Collect ", 0dh, 0ah>
mWrite <"power pellets to turn the tables and eat ghosts for extra points. Reach the highest ", 0dh, 0ah>
mWrite <"score possible.", 0dh, 0ah>
mWrite <"Controls:", 0dh, 0ah>
mWrite <"w for up. s for down. d for right. a for left. x for pause menu", 0dh, 0ah>
mWrite <"Game Elements:", 0dh, 0ah>
mWrite <"Pac-Man: You control Pac-Man.", 0dh, 0ah>
mWrite <"Dots: Collect all dots to advance to the next level.", 0dh, 0ah>
mWrite <"Power Pellets: Consume these to temporarily turn the ghosts blue, making them vulnerable for eating.", 0dh, 0ah>
mWrite <"Ghosts: Avoid Bluey, Pinky, Inky, and Clyde. They will chase Pac-Man. Eat power pellets to kill ghost.", 0dh, 0ah>
mWrite <"Fruit: Occasionally appears for bonus points. Collect it when it appears.", 0dh, 0ah>
mWrite <"Dots: 1 points each.", 0dh, 0ah>
mWrite <"Power Pellets: 10 points each.", 0dh, 0ah>
mWrite <"Eating Ghosts: 400 points each.", 0dh, 0ah>
mWrite <"Fruit: 100 poins each.", 0dh, 0ah>
mWrite <"Game Over:", 0dh, 0ah>
mWrite <"Pac-Man loses a life if caught by a ghost.", 0dh, 0ah>
mWrite <"Lives remaining are displayed on the screen.", 0dh, 0ah>
mWrite <"Game ends when all lives are lost.", 0dh, 0ah>
mWrite <"Have Fun and Happy Chomping!", 0dh, 0ah>

call waitmsg

ret
print_instructions ENDP

print_highscore PROC

call clrscr
mov eax, 5
call settextcolor
mov  edx, OFFSET highscore1
call WriteString
mov  edx, OFFSET highscore2
call WriteString
mov  edx, OFFSET highscore3
call WriteString
mov  edx, OFFSET highscore4
call WriteString
mov  edx, OFFSET highscore5
call WriteString
mov  edx, OFFSET highscore6
call WriteString
mov  edx, OFFSET highscore7
call WriteString
mov  edx, OFFSET ground
call WriteString
mov eax, 6
call settextcolor
call read_buffer

call set_variables
call waitmsg
ret
print_highscore ENDP

;file handling code
convert_to_sting PROC

mov eax, score
mov esi, 9
mov ecx, 10
mov ebx, 0
mov ebx, 10
L1:
xor edx, edx
div ebx
; mov dh, ah; remainder
; mov dl, al; quotent

add dl, 48;
mov character1, dl
mov dl, character1
mov scorestr[esi], dl; pass by parameter
dec esi

Loop L1
ret
convert_to_sting ENDP

Convert_to_int PROC; pass paramenter esi offset

mov eax, 0; Clear eax to accumulate the result

loopL1 :
movzx edx, byte ptr[esi]; Load the ASCII character into edx
sub edx, '0'; Convert ASCII to integer
imul eax, 10; Multiply the current result by 10
add eax, edx; Add the current digit to the result
inc esi; Move to the next character
cmp byte ptr[esi], 0; Check for the null terminator
jne loopL1; Continue parsing if not the end of the string

; The result is now stored in eax
ret; result is in eax
Convert_to_int ENDP

set_variables PROC
mov edi, 0
mov ecx, buffer_temp_size
L1 :
cmp buffer1[edi], ":"
je break1
mov al, buffer1[edi]
mov player1_name[edi], al
inc edi
loop L1
break1 :
mov al, buffer1[edi]
mov player1_name[edi], al
inc edi
mov al, 0
mov player1_name[edi], al
dec edi
mov edx, offset player1_name
call writestring
inc edi
mov al, buffer1[edi]
mov p1_level, al
inc edi
dec ecx
mov esi, 0
L2:
cmp buffer1[edi], ","
je break2
mov al, buffer1[edi]
mov player1_score_str[esi], al
inc edi
inc esi
loop L2
break2 :
mov al, 0; buffer1[edi]
mov player1_score_str[esi], al
mov edx, offset player1_score_str
call writestring
mov edx, offset strLevel
call writestring
mov eax, 0
mov al, p1_level
call writechar
call crlf

inc edi
dec ecx
mov esi, 0
L3:
cmp buffer1[edi], ":"
je break3
mov al, buffer1[edi]
mov player2_name[esi], al
inc edi
inc esi

loop L3
break3 :
mov al, buffer1[edi]
mov player2_name[esi], al
inc esi
mov al, 0
mov player2_name[edi], al
mov edx, offset player2_name
call writestring
inc edi
mov al, buffer1[edi]
mov p2_level, al
inc edi

dec ecx
mov esi, 0
L4:
cmp buffer1[edi], ","
je break4
mov al, buffer1[edi]
mov player2_score_str[esi], al
inc edi
inc esi

loop L4
break4 :
mov al, 0
mov player2_score_str[esi], al
mov edx, offset player2_score_str
call writestring
mov edx, offset strLevel
call writestring
mov eax, 0
mov al, p2_level
call writechar
call crlf

inc edi
dec ecx
mov esi, 0
L5:
cmp buffer1[edi], ":"
je break5
mov al, buffer1[edi]
mov player3_name[esi], al
inc edi
inc esi

loop L5
break5 :
mov al, buffer1[edi]
mov player3_name[esi], al
inc esi
mov al, 0
mov player3_name[edi], al
mov edx, offset player3_name
call writestring
inc edi
mov al, buffer1[edi]
mov p3_level, al
inc edi
dec ecx
mov esi, 0
L6:
cmp buffer1[edi], ","
je break6
mov al, buffer1[edi]
mov player3_score_str[esi], al
inc edi
inc esi

loop L6
break6 :
mov al, 0
mov player3_score_str[esi], al
mov edx, offset player3_score_str
call writestring
mov edx, offset strLevel
call writestring
mov eax, 0
mov al, p3_level
call writechar
call crlf
mov esi, offset player1_score_str
call Convert_to_int
mov player1_score, eax
mov esi, offset player2_score_str
call Convert_to_int
mov player2_score, eax
mov esi, offset player3_score_str
call Convert_to_int
mov player3_score, eax
ret
set_variables ENDP


set_in_order PROC
mov eax, score
mov esi, 0
cmp eax, player1_score
jge user_is_largest
mov top_scorer[esi], 1; 1 for player1
inc esi
cmp eax, player2_score
jge user_is_2ndlargest
mov top_scorer[esi], 2; 2 for player2
inc esi
cmp eax, player3_score
jge user_is_3ndlargest
mov top_scorer[esi], 3; 3 for player3
jmp end12

user_is_3ndlargest :
mov top_scorer[esi], 0; 0 for current player
jmp end12

user_is_2ndlargest :
mov top_scorer[esi], 0; 0 for current player
inc esi
mov top_scorer[esi], 2; 2 for player2
jmp end12

user_is_largest :
mov top_scorer[esi], 0; 0 for current player
inc esi
mov top_scorer[esi], 1; 1 for player1
inc esi
mov top_scorer[esi], 2; 2 for player2
jmp end12

end12 :
ret

set_in_order ENDP

copyBuffer_to_new_buffer PROC
mov ecx, buffer_temp_size
mov edi, 0

L3:
mov al, buffer1[edi]
mov New_buffer[edi], al
inc edi
inc new_buffer_size
loop L3
mov New_buffer[edi], 0
mov edx, offset New_buffer
call writestring

ret
copyBuffer_to_new_buffer ENDP

rewriteBuffer PROC
mov esi, 0
mov edi, 0
cmp top_scorer[esi], 0; user is number1
je user_is_1
inc esi
cmp top_scorer[esi], 0; player1 is number1
je palyer1_is_1
add esi, 1
cmp top_scorer[esi], 0; player2 is number1
je user_is_3rd
; copy buffer as it is
call copyBuffer_to_new_buffer
ret
user_is_3rd :
mov esi, 0
mov edi, 0
player1_copy1 :
    mov al, buffer1[esi]
    cmp al, ","
    je Exit_player1_copy1
    mov New_buffer[esi], al
    inc esi
    inc new_buffer_size
    jmp player1_copy1
    Exit_player1_copy1 :
mov New_buffer[esi], al
inc esi
inc new_buffer_size

player2_copy1 :
mov al, buffer1[esi]
cmp al, ","
je Exit_player2_copy1
mov New_buffer[esi], al
inc esi
inc new_buffer_size
jmp player2_copy1
Exit_player2_copy1 :
mov New_buffer[esi], al
inc esi
inc new_buffer_size
mov tempvar, esi
mov ecx, lengthof temp_player
L1_2_3 :
cmp temp_player[edi],0
je exit21
mov al, temp_player[edi]
mov New_buffer[esi], al
inc esi
inc edi
inc new_buffer_size
loop L1_2_3
exit21:
mov al, ":"
mov New_buffer[esi], al
inc esi
inc new_buffer_size
mov al, level_user
add al, 30h
mov New_buffer[esi], al
inc esi
inc new_buffer_size
call convert_to_sting
mov esi, new_buffer_size
mov edi, 0
mov ecx, lengthof scorestr
L2_2_3 :
mov al, scorestr[edi]
mov New_buffer[esi], al
inc esi
inc edi
inc new_buffer_size
loop L2_2_3
dec esi
mov New_buffer[esi], 0
mov edx, offset New_buffer
call writestring
ret
palyer1_is_1 :
mov esi, 0
mov edi, 0
player1_copy :
    mov al, buffer1[esi]
    cmp al, ","
    je Exit_player1_copy
    mov New_buffer[esi], al
    inc esi
    inc new_buffer_size
    jmp player1_copy
    Exit_player1_copy :
mov New_buffer[esi], al
inc esi
inc new_buffer_size
mov tempvar, esi
mov ecx, lengthof temp_player
L1_2 :
cmp temp_player[edi], 0
je exit22
mov al, temp_player[edi]
mov New_buffer[esi], al
inc esi
inc edi
inc new_buffer_size
loop L1_2
exit22:
mov al, ":"
mov New_buffer[esi], al
inc esi
inc new_buffer_size
mov al, level_user
add al, 30h
mov New_buffer[esi], al
inc esi
inc new_buffer_size
call convert_to_sting
mov esi, new_buffer_size
mov edi, 0
mov ecx, lengthof scorestr
L2_2 :
mov al, scorestr[edi]
mov New_buffer[esi], al
inc esi
inc edi
inc new_buffer_size
loop L2_2
dec esi
mov al, ","
mov New_buffer[esi], al
inc esi
inc new_buffer_size
mov edi, tempvar
L3_2 :
mov al, buffer1[edi]
cmp al, 0
je exitL3_2
mov New_buffer[esi], al
inc esi
inc edi
inc new_buffer_size

loop L3_2
exitL3_2 :
mov New_buffer[esi], 0
mov edx, offset New_buffer
call writestring
ret
user_is_1 :
mov esi, 0
mov edi, 0
mov ecx, lengthof temp_player
L1 :
cmp temp_player[esi],0
je exit1
mov al, temp_player[esi]
mov New_buffer[esi], al
inc esi
inc new_buffer_size
loop L1
exit1:
mov al, ":"
mov New_buffer[esi], al
inc esi
inc new_buffer_size
mov al, level_user
add al, 30h
mov New_buffer[esi], al
inc esi
inc new_buffer_size
call convert_to_sting
mov esi, new_buffer_size
mov ecx, lengthof scorestr
L2 :
mov al, scorestr[edi]
mov New_buffer[esi], al
inc esi
inc edi
inc new_buffer_size
loop L2
dec esi
mov al, ","
mov New_buffer[esi], al
inc esi
inc new_buffer_size
mov ecx, buffer_temp_size
mov edi, 0
L3:
mov al, buffer1[edi]
mov New_buffer[esi], al
inc esi
inc edi

inc new_buffer_size
loop L3
mov New_buffer[esi], 0
mov edx, offset New_buffer
call writestring
ret

rewriteBuffer ENDP

read_buffer PROC
mov edx, OFFSET filename
call OpenInputFile
mov fileHandle, eax
; Check for errors.
cmp eax, INVALID_HANDLE_VALUE; error opening file ?
jne file_ok
; no: skip
mWrite <"Cannot open file", 0dh, 0ah>
jmp quit
; and quit
file_ok :
; Read the file into a buffer.
mov edx, OFFSET buffer1
mov ecx, BUFFER_SIZE
call ReadFromFile
jnc check_buffer_size
; error reading ?
mWrite "Error reading file. "
; yes: show error message
call WriteWindowsMsg
jmp close_file
check_buffer_size :
cmp eax, BUFFER_SIZE
; buffer large enough ?
jb buf_size_ok
; yes
mWrite <"Error: Buffer too small for the file", 0dh, 0ah>
jmp quit
; and quit
buf_size_ok :
; screne ouput !!!!!!!!!!!!!!!!!!!
mov buffer1[eax], 0

mov buffer_temp_size, eax; store size of string from file in buffer_temp_size

close_file :
mov eax, fileHandle
call CloseFile
quit :



ret

read_buffer ENDP

update_buffer PROC

mov edx, OFFSET filename
invoke CreateFile, edx, GENERIC_WRITE, FILE_SHARE_WRITE, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov fileHandle, eax

; Check for errors.
cmp eax, INVALID_HANDLE_VALUE; error opening file ?
jne file_ok2
; no: skip
mWrite <"Cannot open file", 0dh, 0ah>
jmp quit
; and quit
file_ok2 :
call set_variables
call set_in_order
call rewriteBuffer


mov eax, fileHandle
mov edx, OFFSET New_buffer
mov ecx, new_buffer_size
call WriteToFile
mov eax, fileHandle
call CloseFile
quit :

ret

update_buffer ENDP

Draw_Grid_2 Proc
mov esi, 0
mov edi, 0
mov ebx, len_border
; mov  dl, 79; column
; mov  dh, 24; row
; call Gotoxy
mov ecx, height_border
mov edx, 0
Draw1:
        xchg ebx,ecx
            Draw2:
                mov al,Grid2[esi]
                mov border1up[esi],al
                inc esi
        loop Draw2
        mov ecx, len_border
        xchg ebx,ecx
    loop Draw1
call Print_Grid
ret
Draw_Grid_2 ENDP

Draw_Grid_3 Proc
mov esi, 0
mov edi, 0
mov ebx, len_border
; mov  dl, 79; column
; mov  dh, 24; row
; call Gotoxy
mov ecx, height_border
mov edx, 0
Draw1:
        xchg ebx,ecx
            Draw2:
                mov al,Grid3[esi]
                mov border1up[esi],al
                inc esi
        loop Draw2
        mov ecx, len_border
        xchg ebx,ecx
    loop Draw1
call Print_Grid
ret
Draw_Grid_3 ENDP

Print_Grid Proc
    mov esi,0
    mov edi,0
    mov ebx, len_border
    ; mov  dl, 79; column
    ; mov  dh, 24; row
    ; call Gotoxy
    mov ecx, height_border
    mov edx,0
    mov dl, grid_Start_col
    mov dh, grid_Start_row
    Draw1:
        xchg ebx,ecx
            Draw2:
            mov eax, 0
            call gotoxy
            cmp border1up[esi],"1"
            je TopBorder
                cmp border1up[esi], "2"
                je SideBorder
                    cmp border1up[esi], "0"
                    je Palet
                        cmp border1up[esi], "C"
                            je Empty_space
                            cmp border1up[esi],"O"
                                je Power_palet
                                cmp border1up[esi],"^"
                                je Power_palet

                TopBorder:
                    call print_TopBorder
                    jmp exit_draw
                    SideBorder :
                        call print_SideBorder
                        jmp exit_draw
                        Palet:
                            call print_palet1
                            jmp exit_draw
                                Empty_space:
                                 call print_Empty_space
                                 jmp exit_draw
                             Power_palet:
                                call print_Power_palet
                                jmp exit_draw
                exit_draw:
                inc esi
        loop Draw2
        inc dh
        mov dl, grid_Start_col
        mov ecx, len_border
        xchg ebx,ecx
    loop Draw1

ret
Print_Grid EndP

print_Power_palet PROC
inc  palet_count
mov eax, Red
call settextcolor
cmp border1up[esi], "^"
je print_fruit
mov eax,"0"
inc dl
call writechar
ret
print_fruit:
    mov eax,"^"
dec palet_count
inc dl
call writechar
ret
ret
print_Power_palet ENDP

print_Empty_space PROC
mov eax,15
call settextcolor
mov eax, " "
inc dl
inc palet_count
call writechar
ret
print_Empty_space ENDP
print_TopBorder PROC
    mov eax, border_color
    add eax,15
    call settextcolor
    mov eax, " "; "|"
    inc dl
    call writechar
    ret
print_TopBorder ENDP

print_SideBorder PROC
mov eax, border_color
add eax, 15

call settextcolor
mov eax, " "; "|"
inc dl
call writechar
ret
print_SideBorder ENDP

print_palet1 PROC
mov eax, 15
inc  palet_count

call settextcolor
mov eax, "."
inc dl
call writechar
ret
print_palet1 ENDP
Print_Pac_Man Proc
    ;mov ecx,string1size
    ;mov ebx,0
    ;mov ecx,0
    INVOKE PlaySound, OFFSET file, NULL,1 ; SND_FILENAME or SND_SYNC 
    mov eax, delaystart
    call delay

    mov eax,2
    call settextcolor
    mov ecx,lengthof String1
    mov  edx,OFFSET String1
       call WriteString
       mov eax, delayPrint
           call delay
           mov eax, 3

           call settextcolor
           ;mov ecx, lengthof String1

           mov  edx, OFFSET String2
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 4
           call settextcolor
           mov ecx, lengthof String1
           mov  edx, OFFSET String3
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 5
           call settextcolor
           mov ecx, lengthof String1

           mov  edx, OFFSET String4
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 6
           call settextcolor
           mov ecx, lengthof String1

           mov  edx, OFFSET String5
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 7
           call settextcolor
           mov  edx, OFFSET String6
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 8
           call settextcolor
           mov  edx, OFFSET String7
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 9
           call settextcolor
           mov  edx, OFFSET String8
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 10
           call settextcolor
           mov  edx, OFFSET String9
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 11
           call settextcolor
           mov  edx, OFFSET String10
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 12
           call settextcolor
           mov  edx, OFFSET String11
           call WriteString
           mov eax, delayPrint
           call delay
           mov eax, 13
           call settextcolor
           mov  edx, OFFSET String12
           call WriteString
           mov eax, delayPrint
           call delay

           mov eax, 13
           call settextcolor
           mov  edx, OFFSET copyright1
           call WriteString
           mov eax, 13
           call settextcolor
           mov  edx, OFFSET copyright2
           call WriteString
           mov eax, 13
           call settextcolor
           mov  edx, OFFSET copyright3
           call WriteString
           mov eax, 13
           call settextcolor
           mov  edx, OFFSET copyright4
           call WriteString
           mov eax, 13
           call settextcolor
           mov  edx, OFFSET copyright5
           call WriteString

           mov eax, 7
           call settextcolor
           ; INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
           mwrite<"Enter your NAME:",0dh,0ah>
           mov edx,offset temp_player
           mov ecx,10
           call readstring
           

                ret
Print_Pac_Man ENDP
                

colision_with_wall_right Proc
                
                mov eax, len_border
                mov bl, dh
                sub bl, grid_Start_row; to factor position on grid
                
                mul bl
                mov esi, 0
                mov esi, eax
                movzx eax, dl
                add esi, eax
                inc esi; to check right position
                cmp border1up[esi], "2"
                je Right_is_wall

                    cmp border1up[esi], "1"
                    je Right_is_wall
                    mov eax,1
                    ret
                Right_is_wall:
                mov eax, 0;false
            ret 
            colision_with_wall_right ENDP

colision_with_wall_left Proc
                mov eax, len_border
                mov bl, dh
                sub bl, grid_Start_row; to factor position on grid
                mul bl
                mov esi, 0
                mov esi, eax
                movzx eax, dl
                add esi, eax
                dec esi; to check right position
                cmp border1up[esi], "2"
                je Left_is_wall

                    cmp border1up[esi], "1"
                    je Left_is_wall
                    mov eax, 1
                    ret
                Left_is_wall :
                mov eax, 0; false
                       
ret
colision_with_wall_left ENDP

colision_with_wall_up Proc
        mov eax, len_border
        mov bl, dh
        dec bl; to move one row up
        sub bl, grid_Start_row; to factor position on grid
        mul bl
        mov esi, 0
        mov esi, eax
        movzx eax, dl
        add esi, eax
        
        cmp border1up[esi], "1"
        je UP_is_wall
                cmp border1up[esi], "2"
                je UP_is_wall
                mov eax, 1
                ret
        UP_is_wall :
                mov eax, 0; false

ret
colision_with_wall_up ENDP

colision_with_wall_down Proc
        mov eax, len_border
        mov bl, dh
        inc bl; to move one row up
        sub bl, grid_Start_row; to factor position on grid
        mul bl
        mov esi, 0
        mov esi, eax
        movzx eax, dl
        add esi, eax

            cmp border1up[esi], "1"
            je Down_is_wall
                cmp border1up[esi], "2"
                je Down_is_wall
                mov eax, 1
                ret
            Down_is_wall :
                mov eax, 0; false

ret
colision_with_wall_down ENDP
Check_palet Proc
    mov eax, len_border
    mov bl, dh
    sub bl, grid_Start_row
    mul bl; to factor position on grid
    mov esi, 0
    mov esi, eax
    movzx eax, dl
    add esi, eax
        cmp border1up[esi], "0"
        je Palet_Found
            mov eax, 0

            ret
            Palet_Found :
            mov eax, 1; true
ret
Check_palet ENDP

Check_power_palet Proc
mov eax, len_border
mov bl, dh
sub bl, grid_Start_row
mul bl; to factor position on grid
mov esi, 0
mov esi, eax
movzx eax, dl
add esi, eax
cmp border1up[esi], "O"
je Power_Palet_Found
mov eax, 0
ret
Power_Palet_Found :
                INVOKE PlaySound, OFFSET file4, NULL, 1
                invoke GetTickCount
                mov delayStart1, eax
                mov eax, 2; true
                ret
Check_power_palet ENDP
Power_palet_delay_control PROC
    
invoke GetTickCount
mov getTick, eax

sub eax, delayStart1
mov delayElapsed, eax

cmp delayElapsed, 20000; 20 seconds in milliseconds
jge timer_complete
    ret
timer_complete :
mov eax,0
mov p_palet_eaten,eax
ret
Power_palet_delay_control ENDP

Pacman_chase PROC
mov al, dl; Get ghost's X position
sub al, 5; 
cmp xPos, al; 
jl  Lup2; 

mov al, dl; Get ghost's X position
add al, 5; 
cmp xPos, al; 
jg  Lup2; 

mov bl, dh; Get ghost's Y position
sub bl, 5; 
cmp yPos, bl; 
jl  Lup2; 

mov bl, dh; Get ghost's Y position
add bl, 5; 
cmp yPos, bl; 
jg  Lup2; 

mov eax, 1; 
ret

Lup2 :
mov eax, 0; Default return value
ret
Pacman_chase ENDP
Pacman_chase_movement PROC
    mov eax,0
    mov ebx,0
    mov al,xPos
    mov bl,yPos
    sub al,dl
    sub bl,dh
    cmp xPos,dl
    ja move_right
        cmp xPos, dl
        jb move_left
            cmp xPos, dl
            je Check_updown

        
    move_right:
        call colision_with_wall_right
        cmp eax, 0
        je Invalid
            inc dl
            jmp Exit1
    move_left:
        call colision_with_wall_left
        cmp eax, 0
        je Invalid
            dec dl
            jmp Exit1
    Invalid:
        Check_updown:
        cmp yPos,dh
        ja move_down
            cmp yPos,dh
            jb move_up
                jmp Invalid1
        move_down:
        call colision_with_wall_down
            cmp eax, 0
            je Invalid1
            inc dh
            jmp Exit1
        move_up:
        call colision_with_wall_up
            cmp eax, 0
            je Invalid1
            dec dh
            jmp Exit1


Invalid1:
        mov eax,0
            ret
    Exit1:
        mov eax,1
    ret

Pacman_chase_movement ENDP

main PROC
    ; Call SetConsoleTitle to set the console window title
    INVOKE SetConsoleTitle, ADDR titleText
    invoke GetStdHandle, STD_OUTPUT_HANDLE

    mov handle1, eax
    invoke SetConsoleScreenBufferSize, handle1, ScreenBufferSize
    invoke SetConsoleWindowInfo, handle1, 1, ADDR WindowsInfo

    call Print_Pac_Man
    mov dl, 45
    mov dh, 18
            call gotoxy
    call waitmsg
    call Print_Menu
    cmp eax,1
    je terminate
    call clrscr
    mov al,1
    mov level_user,al
    
    call Print_Grid
    call DrawPlayer
    call Draw_Ghost_bluey
    
    gameLoop1:
        call Level_End
            cmp eax,1
               je exitGame1
        call Draw_Score
            cmp lives_temp,3
            je Draw3
                cmp lives_temp, 2
                je Draw2
                    cmp lives_temp, 1
                    je Draw1
                        cmp lives_temp, 0
                        je exitGame1
            Draw1 :
                call Draw_Lives3
                jmp refPoint
            Draw2:
                call Draw_Lives2
                jmp refPoint
            Draw3:
            call Draw_Lives1
            refPoint:
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call update_Ghost

            mov ax, 0
            mov ax, bluey_release
            dec bluey_release

            cmp ax, 0
            jne no_release
                mov eax,15
                call settextcolor
                call gotoxy
                mov eax," "
                call writechar
                mov ax, 0
                mov al, 8
                mov bluey_cord_Y, al
            no_release:
            cmp ax, 0
            jle no_release1
                jmp temp_relese
                no_release1:
                call move_Bluey

                    temp_relese:
                    cmp p_palet_eaten,1
                    je special
                    mov dl, bluey_cord_X
                    mov dh, bluey_cord_Y
                    call Ghost_collision
                        jmp temp_tag
                        special:
                    call bluey_collision_in_power_palet
                        temp_tag:
                    cmp eax, 0
                    jmp next1
                    INVOKE PlaySound, OFFSET file2, NULL,1
        next1 :
        call Power_palet_delay_control
        call UpdatePlayer
        call DrawPlayer

        mov eax,0
        
        mov  eax, 250; sleep
        call Delay; (otherwise, some key presses are lost)
        mov eax,0
        call Readkey; look for keyboard input
        jz   gameLoop1; no key pressed yet

        ; get user key input:
        mov inputChar,al

        ; exit game if user types 'x': open pause menu
        cmp inputChar,"x";menu
        je temp_tag1_1
            jmp check_next1_1
            temp_tag1_1 :
            call Pause_menu
            cmp eax, "q"
            je terminate
            call clrscr
            mov eax, palet_count
            mov temp_palet, eax
            call Print_grid
            call DrawPlayer
            call Draw_Ghost_bluey
            mov eax, temp_palet
            mov palet_count, eax
            jmp gameloop1
            check_next1_1 :

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight
            inc ecx

        moveUp:
        ; allow player to jump:
        call UpdatePlayer
            call colision_with_wall_up
            cmp eax, 0
            je gameLoop1
            dec yPos
            call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case; bluey_collision_in_power_palet
                mov dl, bluey_cord_X
                mov dh, bluey_cord_Y
                call Ghost_collision
                cmp eax, 0
                je gameLoop1
                INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case:
                call bluey_collision_in_power_palet
            jmp gameLoop1

        moveDown:
        call UpdatePlayer
        call colision_with_wall_down
        cmp eax, 0
            je gameLoop1
        inc yPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case1; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop1
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case1 :
        call bluey_collision_in_power_palet
        jmp gameLoop1

        moveLeft:
        call UpdatePlayer

            
        call colision_with_wall_left
            cmp eax, 0
            je gameLoop1
        dec xPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case2; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop1
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case2 :
            call bluey_collision_in_power_palet
        jmp gameLoop1

        moveRight:
        call UpdatePlayer
        call colision_with_wall_right
            cmp eax,0
            je gameLoop1
        inc xPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case3; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop1
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case3 :
            call bluey_collision_in_power_palet
        jmp gameLoop1

    jmp gameLoop1
    
    exitGame1:
     
    cmp lives_temp,0
    je terminate
    
    inc level_user

    call clrscr
    call Draw_Grid_2
    call DrawPlayer
    call Draw_Ghost_bluey
    call Draw_Ghost_pinky

    mov al,3
    mov lives_temp,al

    gameLoop2:
        call Level_End
            cmp eax,1
               je exitGame2
        call Draw_Score
            cmp lives_temp,3
            je Draw_2_3
                cmp lives_temp, 2
                je Draw_2_2
                    cmp lives_temp, 1
                    je Draw_2_1
                        cmp lives_temp, 0
                        je exitGame2
            Draw_2_1 :
                call Draw_Lives3
                jmp refPoint2
            Draw_2_2:
                call Draw_Lives2
                jmp refPoint2
            Draw_2_3:
            call Draw_Lives1
            refPoint2:
            call Bluey_control
            call Pinky_control

        
        call Power_palet_delay_control
        call UpdatePlayer
        call DrawPlayer
        mov eax,0
        
        mov  eax, 200; sleep
        call Delay; (otherwise, some key presses are lost)
        mov eax,0
        call Readkey; look for keyboard input
        jz   gameLoop2; no key pressed yet

        ; get user key input:
        mov inputChar,al

        ; exit game if user types 'x': open pause menu
        cmp inputChar,"x";menu
            je temp_tag1_2
            jmp check_next1_2
            temp_tag1_2 :
            call Pause_menu
            cmp eax, "q"
            je terminate
            call clrscr
            mov eax, palet_count
            mov temp_palet, eax
            call Print_grid
            call DrawPlayer
            call Draw_Ghost_bluey
            call Draw_Ghost_pinky
            mov eax, temp_palet
            mov palet_count, eax
            jmp gameloop2
            check_next1_2 :

        cmp inputChar,"w"
        je moveUp2

        cmp inputChar,"s"
        je moveDown2

        cmp inputChar,"a"
        je moveLeft2

        cmp inputChar,"d"
        je moveRight2
            inc ecx

        moveUp2:
        ; allow player to jump:
        call UpdatePlayer
            call colision_with_wall_up
            cmp eax, 0
            je gameLoop2
            dec yPos
            call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_2; bluey_collision_in_power_palet
                mov dl, bluey_cord_X
                mov dh, bluey_cord_Y
                call Ghost_collision
                cmp eax, 0
                je gameLoop2
                INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_2:
                call bluey_collision_in_power_palet
            jmp gameLoop2

        moveDown2:
        call UpdatePlayer
        call colision_with_wall_down
        cmp eax, 0
            je gameLoop2
        inc yPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_2_1; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop2
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_2_1 :
        call bluey_collision_in_power_palet
        jmp gameLoop2

        moveLeft2:
        call UpdatePlayer
        call colision_with_wall_left
            cmp eax, 0
            je gameLoop2
        dec xPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_2_2; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop2
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_2_2 :
            call bluey_collision_in_power_palet
        jmp gameLoop2

        moveRight2:
        call UpdatePlayer
        call colision_with_wall_right
            cmp eax,0
            je gameLoop2
        inc xPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_2_3; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop2
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_2_3 :
            call bluey_collision_in_power_palet
        jmp gameLoop2

    jmp gameLoop2
                exitGame2:
            
cmp lives_temp,0
    je terminate
    
    inc level_user
    call clrscr
    call Draw_Grid_3
    call DrawPlayer
    call Draw_Ghost_bluey
    call Draw_Ghost_pinky
    call Draw_Ghost_inky
    call Draw_Ghost_clyde


    mov al,3
    mov lives_temp,al

    gameLoop3:
        call Level_End
            cmp eax,1
               je exitGame3
        call Draw_Score
            cmp lives_temp,3
            je Draw_3_3
                cmp lives_temp, 2
                je Draw_3_2
                    cmp lives_temp, 1
                    je Draw_3_1
                        cmp lives_temp, 0
                        je exitGame3
            Draw_3_1 :
                call Draw_Lives3
                jmp refPoint3
            Draw_3_2:
                call Draw_Lives2
                jmp refPoint3
            Draw_3_3:
            call Draw_Lives1
            refPoint3:
            call Bluey_control
            call Pinky_control
            call Inky_control
            call Clyde_control


        
        call Power_palet_delay_control
        call UpdatePlayer
        call DrawPlayer
        mov eax,0
        
        mov  eax, 150; sleep
        call Delay; (otherwise, some key presses are lost)
        mov eax,0
        call Readkey; look for keyboard input
        jz   gameLoop3; no key pressed yet

        ; get user key input:
        mov inputChar,al

        ; exit game if user types 'x': open pause menu
        cmp inputChar,"x";menu
        je temp_tag1
            jmp check_next1
        temp_tag1:
        call Pause_menu
        cmp eax,"q"
        je terminate
            call clrscr
            mov eax,palet_count
            mov temp_palet,eax
            call Print_grid
            call DrawPlayer
            call Draw_Ghost_bluey
            call Draw_Ghost_pinky
            call Draw_Ghost_inky
            call Draw_Ghost_clyde
            mov eax, temp_palet
            mov palet_count, eax
            jmp gameloop3
        check_next1:
        cmp inputChar,"w"
        je moveUp3

        cmp inputChar,"s"
        je moveDown3

        cmp inputChar,"a"
        je moveLeft3

        cmp inputChar,"d"
        je moveRight3
            inc ecx

        moveUp3:
        ; allow player to jump:
        call UpdatePlayer
            call colision_with_wall_up
            cmp eax, 0
            je gameLoop3
            dec yPos
            call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_3; bluey_collision_in_power_palet
                mov dl, bluey_cord_X
                mov dh, bluey_cord_Y
                call Ghost_collision
                cmp eax, 0
                je gameLoop3
                INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_3:
                call bluey_collision_in_power_palet
            jmp gameLoop3

        moveDown3:
        call UpdatePlayer
        call colision_with_wall_down
        cmp eax, 0
            je gameLoop3
        inc yPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_3_1; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop3
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_3_1 :
        call bluey_collision_in_power_palet
        jmp gameLoop3

        moveLeft3:
        call UpdatePlayer
            cmp xPos, 0
            je MoveOposite
            jmp continue1
            MoveOposite :
            mov dl, 78
            mov dh, 15
            call gotoxy
            mov eax, "a"
            call writechar
            mov xPos, dl
            mov yPos, dh
            call UpdatePlayer


            jmp gameLoop3
            continue1 :
        call colision_with_wall_left
            cmp eax, 0
            je gameLoop3
        dec xPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_3_2; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop3
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_3_2 :
            call bluey_collision_in_power_palet
        jmp gameLoop3

        moveRight3:
        call UpdatePlayer
            cmp xPos, 78
            je MoveOposite2
            jmp continue2
            MoveOposite2 :
            mov dl, 0
            mov dh, 15
            call gotoxy
    
            mov xPos, dl
            mov yPos, dh
            call UpdatePlayer


            jmp gameLoop3
            continue2:
        call colision_with_wall_right
            cmp eax,0
            je gameLoop3
        inc xPos
        call DrawPlayer
            cmp p_palet_eaten, 1
            je special_case_3_3; bluey_collision_in_power_palet
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call Ghost_collision
            cmp eax, 0
            je gameLoop3
            INVOKE PlaySound, OFFSET file2, NULL, 0; SND_FILENAME or SND_SYNC
            special_case_3_3 :
            call bluey_collision_in_power_palet
        jmp gameLoop3

    jmp gameLoop3
                exitGame3:
terminate:
            call END_SCRENE
        exit
main ENDP
;Bluey Ghost Code
Bluey_control Proc
mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call update_Ghost
            mov ax, 0
            mov ax, bluey_release
            dec bluey_release
            cmp ax, 0
            jne no_release2
                mov eax,15
                call settextcolor
                call gotoxy
                mov eax," "
                call writechar
                mov ax, 0
                mov al, 8
                mov bluey_cord_Y, al
            no_release2:
            cmp ax, 0
            jle no_release_2_1
                jmp temp_relese2
                no_release_2_1:
                call move_Bluey

                    temp_relese2:
                    cmp p_palet_eaten,1
                    je special2
                    mov dl, bluey_cord_X
                    mov dh, bluey_cord_Y
                    call Ghost_collision
                        jmp temp_tag2
                        special2:
                    call bluey_collision_in_power_palet
                        temp_tag2:
                    cmp eax, 0
                    jmp next2
                    INVOKE PlaySound, OFFSET file2, NULL,1
        next2:
        ret
Bluey_control ENDP
update_Ghost proc
    ;Check_palet
     mov eax,15
     call settextcolor
     
     call gotoxy
     call Check_palet
     cmp eax, 1
        jne coin_not_found
            mov eax,1
            mov bluey_pos_palet,eax
            jmp next_check
            coin_not_found :
            mov eax, 0
            mov bluey_pos_palet, eax
    
    next_check:
    call Check_power_palet
                cmp eax, 2
                jne power_not_found
                mov eax, 1
                mov bluey_pos_power, eax
                ret
                power_not_found :
                mov eax, 0
                mov bluey_pos_power, eax
ret
update_Ghost ENDP

Draw_Ghost_bluey Proc
            mov eax, bluey
            call SetTextColor
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call gotoxy
            mov eax, Ghost_Char
            call writechar
            ret
Draw_Ghost_bluey Endp

print_priv_palet PROC

    cmp bluey_pos_palet,1
        je print_palet
            mov eax,0
            mov eax," "
            call writechar
            jmp check_power
            print_palet:
              mov eax,15
              call settextcolor
              mov eax,0
              mov eax,"."
              call gotoxy
              call writechar
    check_power:
    cmp bluey_pos_power,1
        je print_palet2
        ret
        print_palet2 :
        mov eax, RED
        call settextcolor
        mov eax, 0
        mov eax, "0"
        call gotoxy
        call writechar
ret
print_priv_palet ENDP
bluey_collision_in_power_palet PROC
mov dl, bluey_cord_X
mov dh, bluey_cord_Y
cmp dl, xPos
je x_pos_same
mov eax, 0
ret

x_pos_same :
cmp dh, yPos
je y_pos_same
mov eax, 0

ret
y_pos_same :
INVOKE PlaySound, OFFSET file1, NULL, 0
; dec lives_temp
mov bluey_cord_X, 39; Default Pacman Position
mov bluey_cord_Y, 12
call Draw_Ghost_bluey
mov eax,10
mov bluey_release,ax
INVOKE PlaySound, OFFSET file3, NULL, 0

mov eax,400
add score,eax
mov eax, 1

ret
bluey_collision_in_power_palet Endp

move_Bluey PROC
mov dl, bluey_cord_X
mov dh, bluey_cord_Y
call Pacman_Chase
cmp eax,0
je invalid
    call Pacman_chase_movement
    cmp eax,0
    je invalid
            mov cl,dl
            mov ch,dh
            mov dl, bluey_cord_X
            mov dh, bluey_cord_Y
            call print_priv_palet
            mov  bluey_cord_X, cl
            mov  bluey_cord_Y, ch
            call update_Ghost
            call Draw_Ghost_bluey
            jmp end_move
invalid :
    mov eax, 4; 0 for up, 1 for down, 2 for left, 3 for right
    call RandomRange
    cmp eax, 0; 
    je move_up; 
    cmp eax, 1; 
    je move_down; 
    cmp eax, 2; 
    je move_left; 
    cmp eax, 3; 
    je move_right; 
    jmp invalid; 
    move_up :
    ; code for moving up
        call colision_with_wall_up
        cmp eax, 0
        je invalid
        mov dl, bluey_cord_X
        mov dh, bluey_cord_Y
            call print_priv_palet
            dec bluey_cord_Y
            jmp Down_below
    move_down :
    ; code for moving down
        call colision_with_wall_down
        cmp eax, 0
        je invalid
        mov dl, bluey_cord_X
        mov dh, bluey_cord_Y
            call print_priv_palet
            inc bluey_cord_Y
            jmp Down_below
    move_left :
    ; code for moving left
        call colision_with_wall_left
        cmp eax, 0
        je invalid
        mov dl, bluey_cord_X
        mov dh, bluey_cord_Y
            call print_priv_palet
            dec bluey_cord_X
            jmp Down_below
        
    move_right :
    ; code for moving right
        call colision_with_wall_right
        cmp eax, 0
        je invalid
        mov dl, bluey_cord_X
        mov dh, bluey_cord_Y
            call print_priv_palet
            inc bluey_cord_X
            jmp Down_below
        Down_below:
        mov dl, bluey_cord_X
        mov dh, bluey_cord_Y
            
        call update_Ghost
        call Draw_Ghost_bluey
        jmp end_move;
    end_move :
ret
move_Bluey ENDP


; Pinky Ghost Code
Pinky_Control PROC
mov dl, pinky_cord_X
        mov dh, pinky_cord_Y
        call update_Ghost_pinky
        mov ax, 0
            mov ax, pinky_release
            dec pinky_release
            cmp ax, 0
            jne no_release2_pinky
                mov eax,15
                call settextcolor
                call gotoxy
                mov eax," "
                call writechar
                mov ax, 0
                mov al, 8
                mov pinky_cord_Y, al
            no_release2_pinky:
            cmp ax, 0
            jle no_release_2_1_pinky
                jmp temp_relese2_pinky
                no_release_2_1_pinky :
                call move_Pinky

                    temp_relese2_pinky:
                    cmp p_palet_eaten,1
                    je special2_pinky
                    mov dl, pinky_cord_X
                    mov dh, pinky_cord_Y
                    call Ghost_collision
                        jmp temp_tag2_pinky
                        special2_pinky:
                    call pinky_collision_in_power_palet
                        temp_tag2_pinky:
                    cmp eax, 0
                    jmp next2_pinky
                    INVOKE PlaySound, OFFSET file2, NULL,1
        next2_pinky :

ret

Pinky_Control ENDP
            
Draw_Ghost_pinky PROC
            mov eax, Pinky
            call SetTextColor
            mov dl, pinky_cord_X
            mov dh, pinky_cord_Y
            call gotoxy
            mov eax, Ghost_Char
            call writechar
            ret
Draw_Ghost_pinky ENDP
update_Ghost_pinky proc
    ;Check_palet
     mov eax,15
     call settextcolor
     
     call gotoxy
     call Check_palet
     cmp eax, 1
        jne coin_not_found
            mov eax,1
            mov pinky_pos_palet,eax
            jmp next_check
            coin_not_found :
            mov eax, 0
            mov pinky_pos_palet, eax
    
    next_check:
    call Check_power_palet
                cmp eax, 2
                jne power_not_found
                mov eax, 1
                mov pinky_pos_power, eax
                ret
                power_not_found :
                mov eax, 0
                mov pinky_pos_power, eax
ret
update_Ghost_pinky ENDP


print_priv_palet_pinky PROC

cmp pinky_pos_palet, 1
je print_palet
mov eax, 0
mov eax, " "
call writechar
jmp check_power
print_palet :
             mov eax, 15
                    call settextcolor
                    mov eax, 0
                    mov eax, "."
                    call gotoxy
                    call writechar
                    check_power :
                cmp pinky_pos_power, 1
                    je print_palet2
                    ret
                    print_palet2 :
                mov eax, RED
                    call settextcolor
                    mov eax, 0
                    mov eax, "0"
                    call gotoxy
                    call writechar
ret
print_priv_palet_pinky ENDP

pinky_collision_in_power_palet PROC
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
cmp dl, xPos
je x_pos_same
mov eax, 0
ret

x_pos_same :
cmp dh, yPos
je y_pos_same
mov eax, 0

ret
y_pos_same :
INVOKE PlaySound, OFFSET file1, NULL, 0
; dec lives_temp
mov pinky_cord_X, 40; Default Pinky Position
mov pinky_cord_Y, 12
call Draw_Ghost_pinky
mov eax,15
mov pinky_release,ax
INVOKE PlaySound, OFFSET file3, NULL, 0

mov eax,400
add score,eax
mov eax, 1

ret
pinky_collision_in_power_palet Endp

move_Pinky PROC
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
call Pacman_Chase
cmp eax, 0
je invalid
call Pacman_chase_movement
cmp eax, 0
je invalid
mov cl, dl
mov ch, dh
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
call print_priv_palet_pinky
mov  pinky_cord_X, cl
mov  pinky_cord_Y, ch
call update_Ghost_pinky
call Draw_Ghost_pinky
jmp end_move
invalid :
mov eax, 4;  0 for up, 1 for down, 2 for left, 3 for right
call RandomRange
cmp eax, 0;
je move_up; 
cmp eax, 1;
je move_down; 
cmp eax, 2;
je move_left; 
cmp eax, 3;
je move_right; 
jmp invalid;
move_up:
; code for moving up
call colision_with_wall_up
cmp eax, 0
je invalid
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
call print_priv_palet_pinky
dec pinky_cord_Y
jmp Down_below
move_down :
; code for moving down
call colision_with_wall_down
cmp eax, 0
je invalid
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
call print_priv_palet_pinky
inc pinky_cord_Y
jmp Down_below
move_left :
; code for moving left
call colision_with_wall_left
cmp eax, 0
je invalid
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
call print_priv_palet_pinky
dec pinky_cord_X
jmp Down_below
move_right :
; code for moving right
call colision_with_wall_right
cmp eax, 0
je invalid
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
call print_priv_palet_pinky
inc pinky_cord_X
jmp Down_below
Down_below :
mov dl, pinky_cord_X
mov dh, pinky_cord_Y
call update_Ghost_pinky
call Draw_Ghost_pinky
jmp end_move;
end_move:
ret
move_Pinky ENDP

; Inky Ghost Code
Inky_Control PROC
mov dl, inky_cord_X
        mov dh, inky_cord_Y
        call update_Ghost_inky
        mov ax, 0
            mov ax, inky_release
            dec inky_release
            cmp ax, 0
            jne no_release2_inky
                mov eax,15
                call settextcolor
                call gotoxy
                mov eax," "
                call writechar
                mov ax, 0
                mov al, 14
                mov inky_cord_Y, al
            no_release2_inky:
            cmp ax, 0
            jle no_release_2_1_inky
                jmp temp_relese2_inky
                no_release_2_1_inky :
                call move_Inky

                    temp_relese2_inky:
                    cmp p_palet_eaten,1
                    je special2_inky
                    mov dl, inky_cord_X
                    mov dh, inky_cord_Y
                    call Ghost_collision
                        jmp temp_tag2_inky
                        special2_inky:
                    call inky_collision_in_power_palet
                        temp_tag2_inky:
                    cmp eax, 0
                    jmp next2_inky
                    INVOKE PlaySound, OFFSET file2, NULL,1
        next2_inky :

ret

Inky_Control ENDP
            
Draw_Ghost_inky PROC
            mov eax, Inky
            call SetTextColor
            mov dl, inky_cord_X
            mov dh, inky_cord_Y
            call gotoxy
            mov eax, Ghost_Char
            call writechar
            ret
Draw_Ghost_inky ENDP

update_Ghost_inky proc
    ;Check_palet
     mov eax,15
     call settextcolor
     
     call gotoxy
     call Check_palet
     cmp eax, 1
        jne coin_not_found
            mov eax,1
            mov inky_pos_palet,eax
            jmp next_check
            coin_not_found :
            mov eax, 0
            mov inky_pos_palet, eax
    
    next_check:
    call Check_power_palet
                cmp eax, 2
                jne power_not_found
                mov eax, 1
                mov inky_pos_power, eax
                ret
                power_not_found :
                mov eax, 0
                mov inky_pos_power, eax
ret
update_Ghost_inky ENDP


print_priv_palet_inky PROC

cmp inky_pos_palet, 1
je print_palet
mov eax, 0
mov eax, " "
call writechar
jmp check_power
print_palet :
             mov eax, 15
                    call settextcolor
                    mov eax, 0
                    mov eax, "."
                    call gotoxy
                    call writechar
                    check_power :
                cmp inky_pos_power, 1
                    je print_palet2
                    ret
                    print_palet2 :
                mov eax, RED
                    call settextcolor
                    mov eax, 0
                    mov eax, "0"
                    call gotoxy
                    call writechar
ret
print_priv_palet_inky ENDP

inky_collision_in_power_palet PROC
mov dl, inky_cord_X
mov dh, inky_cord_Y
cmp dl, xPos
je x_pos_same
mov eax, 0
ret

x_pos_same :
cmp dh, yPos
je y_pos_same
mov eax, 0

ret
y_pos_same :
INVOKE PlaySound, OFFSET file1, NULL, 0
; dec lives_temp
mov inky_cord_X, 38; Default inky Position
mov inky_cord_Y, 12
call Draw_Ghost_inky
mov eax,20
mov inky_release,ax
INVOKE PlaySound, OFFSET file3, NULL, 0

mov eax,400
add score,eax
mov eax, 1

ret
inky_collision_in_power_palet Endp

move_Inky PROC
mov dl, inky_cord_X
mov dh, inky_cord_Y
call Pacman_Chase
cmp eax, 0
je invalid
call Pacman_chase_movement
cmp eax, 0
je invalid
mov cl, dl
mov ch, dh
mov dl, inky_cord_X
mov dh, inky_cord_Y
call print_priv_palet_inky
mov  inky_cord_X, cl
mov  inky_cord_Y, ch
call update_Ghost_inky
call Draw_Ghost_inky
jmp end_move
invalid :
mov eax, 4;  0 for up, 1 for down, 2 for left, 3 for right
call RandomRange
cmp eax, 0;
je move_up; 
cmp eax, 1;
je move_down; 
cmp eax, 2;
je move_left; 
cmp eax, 3;
je move_right; 
jmp invalid;
move_up:
; code for moving up
call colision_with_wall_up
cmp eax, 0
je invalid
mov dl, inky_cord_X
mov dh, inky_cord_Y
call print_priv_palet_inky
dec inky_cord_Y
jmp Down_below
move_down :
; code for moving down
call colision_with_wall_down
cmp eax, 0
je invalid
mov dl, inky_cord_X
mov dh, inky_cord_Y
call print_priv_palet_inky
inc inky_cord_Y
jmp Down_below
move_left :
; code for moving left
call colision_with_wall_left
cmp eax, 0
je invalid
mov dl, inky_cord_X
mov dh, inky_cord_Y
call print_priv_palet_inky
dec inky_cord_X
jmp Down_below
move_right :
; code for moving right
call colision_with_wall_right
cmp eax, 0
je invalid
mov dl, inky_cord_X
mov dh, inky_cord_Y
call print_priv_palet_inky
inc inky_cord_X
jmp Down_below
Down_below :
mov dl, inky_cord_X
mov dh, inky_cord_Y
call update_Ghost_inky
call Draw_Ghost_inky
jmp end_move;
end_move:
ret
move_Inky ENDP

; Clyde Ghost Code
Clyde_Control PROC
mov dl, clyde_cord_X
        mov dh, clyde_cord_Y
        call update_Ghost_clyde
        mov ax, 0
            mov ax, clyde_release
            dec clyde_release
            cmp ax, 0
            jne no_release2_clyde
                mov eax,15
                call settextcolor
                call gotoxy
                mov eax," "
                call writechar
                mov ax, 0
                mov al, 8
                mov clyde_cord_Y, al
            no_release2_clyde :
            cmp ax, 0
            jle no_release_2_1_clyde
                jmp temp_relese2_clyde
                no_release_2_1_clyde :
                call move_Clyde

                    temp_relese2_clyde :
                    cmp p_palet_eaten,1
                    je special2_clyde
                    mov dl, clyde_cord_X
                    mov dh, clyde_cord_Y
                    call Ghost_collision
                        jmp temp_tag2_clyde
                        special2_clyde :
                    call clyde_collision_in_power_palet
                        temp_tag2_clyde :
                    cmp eax, 0
                    jmp next2_clyde
                    INVOKE PlaySound, OFFSET file2, NULL,1
        next2_clyde :

ret

Clyde_Control ENDP
            
Draw_Ghost_clyde PROC
            mov eax, Clyde
            call SetTextColor
            mov dl, clyde_cord_X
            mov dh, clyde_cord_Y
            call gotoxy
            mov eax, Ghost_Char
            call writechar
            ret
Draw_Ghost_clyde ENDP

update_Ghost_clyde proc
    ;Check_palet
     mov eax,15
     call settextcolor
     
     call gotoxy
     call Check_palet
     cmp eax, 1
        jne coin_not_found
            mov eax,1
            mov clyde_pos_palet,eax
            jmp next_check
            coin_not_found :
            mov eax, 0
            mov clyde_pos_palet, eax
    
    next_check:
    call Check_power_palet
                cmp eax, 2
                jne power_not_found
                mov eax, 1
                mov clyde_pos_power, eax
                ret
                power_not_found :
                mov eax, 0
                mov clyde_pos_power, eax
ret
update_Ghost_clyde ENDP


print_priv_palet_clyde PROC

cmp clyde_pos_palet, 1
je print_palet
mov eax, 0
mov eax, " "
call writechar
jmp check_power
print_palet :
             mov eax, 15
                    call settextcolor
                    mov eax, 0
                    mov eax, "."
                    call gotoxy
                    call writechar
                    check_power :
                cmp clyde_pos_power, 1
                    je print_palet2
                    ret
                    print_palet2 :
                mov eax, RED
                    call settextcolor
                    mov eax, 0
                    mov eax, "0"
                    call gotoxy
                    call writechar
ret
print_priv_palet_clyde ENDP

clyde_collision_in_power_palet PROC
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
cmp dl, xPos
je x_pos_same
mov eax, 0
ret

x_pos_same :
cmp dh, yPos
je y_pos_same
mov eax, 0

ret
y_pos_same :
INVOKE PlaySound, OFFSET file1, NULL, 0
; dec lives_temp
mov clyde_cord_X, 41; Default clyde Position
mov clyde_cord_Y, 12
call Draw_Ghost_clyde
mov eax,25
mov clyde_release,ax
INVOKE PlaySound, OFFSET file3, NULL, 0

mov eax,400
add score,eax
mov eax, 1

ret
clyde_collision_in_power_palet Endp

move_Clyde PROC
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
call Pacman_Chase
cmp eax, 0
je invalid
call Pacman_chase_movement
cmp eax, 0
je invalid
mov cl, dl
mov ch, dh
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
call print_priv_palet_clyde
mov  clyde_cord_X, cl
mov  clyde_cord_Y, ch
call update_Ghost_clyde
call Draw_Ghost_clyde
jmp end_move
invalid :
mov eax, 4;  0 for up, 1 for down, 2 for left, 3 for right
call RandomRange
cmp eax, 0;
je move_up; 
cmp eax, 1;
je move_down; 
cmp eax, 2;
je move_left; 
cmp eax, 3;
je move_right; 
jmp invalid;
move_up:
; code for moving up
call colision_with_wall_up
cmp eax, 0
je invalid
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
call print_priv_palet_clyde
dec clyde_cord_Y
jmp Down_below
move_down :
; code for moving down
call colision_with_wall_down
cmp eax, 0
je invalid
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
call print_priv_palet_clyde
inc clyde_cord_Y
jmp Down_below
move_left :
; code for moving left
call colision_with_wall_left
cmp eax, 0
je invalid
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
call print_priv_palet_clyde
dec clyde_cord_X
jmp Down_below
move_right :
; code for moving right
call colision_with_wall_right
cmp eax, 0
je invalid
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
call print_priv_palet_clyde
inc clyde_cord_X
jmp Down_below
Down_below :
mov dl, clyde_cord_X
mov dh, clyde_cord_Y
call update_Ghost_clyde
call Draw_Ghost_clyde
jmp end_move;
end_move:
ret
move_Clyde ENDP

Draw_Score Proc
            mov eax, white(black * 16)
            call SetTextColor
            mov dl, 0
            mov dh, 0
            call Gotoxy
            mov edx, OFFSET strScore
            call WriteString
            mov eax,score ; counter1.wSecond; score
            call WriteInt
                  mov al, ","; counter1.wSecond; score
                  call Writechar
                  mov eax, palet_count; counter1.wSecond; score
                  call WriteInt
            ret;

Draw_Score Endp

Level_End PROC
    cmp palet_count,0
    je level_complete
        mov eax,0
        ret
    level_complete:
    mov eax,1
ret
Level_End ENDP

Ghost_collision PROC

    cmp dl,xPos
    je x_pos_same
        mov eax,0
        ret

    x_pos_same:
        cmp dh, yPos
        je y_pos_same
            mov eax, 0

            ret
            y_pos_same:
        INVOKE PlaySound, OFFSET file2, NULL, 0
            dec lives_temp
            mov xPos, 39;Default Pacman Position
                mov yPos, 24

            mov eax, 1

ret
Ghost_collision Endp


Draw_Lives1 PROC
    mov eax, RED
    call SetTextColor
    mov dl, 0
    mov dh, 1
    call Gotoxy
    mov ecx, lives_length_temp
    dec ecx
    mov edx, OFFSET Lives_string1a
    call WriteString
    mov dl, 0
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET Lives_string1b
    call WriteString
ret
Draw_Lives1 ENDP

Draw_Lives2 PROC
mov eax, RED
call SetTextColor
mov dl, 0
mov dh, 1
call Gotoxy
mov ecx, lives_length_temp
dec ecx
mov edx, OFFSET Lives_string2a
call WriteString
mov dl, 0
mov dh, 2
call Gotoxy
mov edx, OFFSET Lives_string2b
call WriteString
ret
Draw_Lives2 ENDP
Draw_Lives3 PROC
mov eax, RED
call SetTextColor;
mov dl, 0
mov dh, 1
call Gotoxy
mov ecx, lives_length_temp
dec ecx
mov edx, OFFSET Lives_string3a
call WriteString
mov dl, 0
mov dh, 2
call Gotoxy
mov edx, OFFSET Lives_string3b
call WriteString
ret
Draw_Lives3 ENDP
DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    call Check_palet
    cmp eax, 1
        jne recheck 
            INVOKE PlaySound, OFFSET file1, NULL, 1
            mov bl, "C"
            mov border1up[esi], bl
            inc score
            dec palet_count

            jmp end_update
    recheck:
    call Check_power_palet
        cmp eax, 2
        jne end_update
        INVOKE PlaySound, OFFSET file1, NULL, 1
        mov bl, "C"
        mov border1up[esi], bl
        dec palet_count

        mov eax,10
        add score,eax
        mov eax,1
        mov p_palet_eaten,eax
    end_update:
    mov al, " "
    call WriteChar
    ret
UpdatePlayer ENDP


END main