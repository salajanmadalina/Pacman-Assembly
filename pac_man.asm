.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Exemplu proiect desenare",0
area_width EQU 640
area_height EQU 480
area DD 0

harta DD 6, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0
	  DD 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	  DD 0, 2, 5, 5, 5, 2, 0, 2, 2, 2, 2, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 2, 2, 2, 2, 2, 0, 2, 0, 0, 0, 2, 0, 0
	  DD 0, 2, 2, 2, 2, 2, 0, 2, 5, 5, 5, 2, 0, 2, 0, 0, 1, 0, 0, 0, 0, 2, 0, 2, 0, 0, 2, 0, 2, 0, 2, 5, 5, 5, 2, 0, 2, 2, 0, 0, 2, 0, 0
	  DD 0, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 2, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0, 0, 2, 0, 2, 2, 2, 2, 2, 0, 2, 0, 2, 0, 2, 0, 0
	  DD 0, 2, 0, 0, 0, 1, 0, 2, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2, 0, 2, 0, 0, 2, 2, 0, 1
	  DD 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 2, 2, 2, 0, 0, 2, 0, 0, 0, 1, 0, 0, 2, 0, 2, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2, 0, 0
	  DD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	  DD 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0
	  DD 0, 2, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0
	  DD 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

harta_copie DD 6, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0
			DD 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
			DD 0, 2, 5, 5, 5, 2, 0, 2, 2, 2, 2, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 2, 2, 2, 2, 2, 0, 2, 0, 0, 0, 2, 0, 0
			DD 0, 2, 2, 2, 2, 2, 0, 2, 5, 5, 5, 2, 0, 2, 0, 0, 1, 0, 0, 0, 0, 2, 0, 2, 0, 0, 2, 0, 2, 0, 2, 5, 5, 5, 2, 0, 2, 2, 0, 0, 2, 0, 0
			DD 0, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 2, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0, 0, 2, 0, 2, 2, 2, 2, 2, 0, 2, 0, 2, 0, 2, 0, 0
			DD 0, 2, 0, 0, 0, 1, 0, 2, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2, 0, 2, 0, 0, 2, 2, 0, 1
			DD 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 2, 2, 2, 0, 0, 2, 0, 0, 0, 1, 0, 0, 2, 0, 2, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2, 0, 0
			DD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			DD 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0
			DD 0, 2, 2, 2, 2, 0, 0, 2, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0
			DD 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	  
	  
counter DD 0 ; numara evenimentele de tip timer

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20


lin_max EQU 10
col_max EQU 42
simboluri_pe_rand EQU 43
lin_pixeli EQU 20
col_pixeli EQU 14
maxim EQU 313

x0 EQU 20
y0 EQU 40

xl EQU 190
yl EQU 360
xr EQU 305
yr EQU 360
xu EQU 250
yu EQU 300
xd EQU 250
yd EQU 420

x_pacman DD 20
y_pacman DD 40
poz_pacman DD 0
poz DD 0
scor DD 0
const_final_actualizare EQU 1848
const_winner DD 0


symbol_width EQU 14
symbol_height EQU 20
symbol_widthh EQU 10
symbol_heightt EQU 20
include digits.inc
include letters.inc
include simboluri.inc


.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_widthh
	mul ebx
	mov ebx, symbol_heightt
	mul ebx
	add esi, eax
	mov ecx, symbol_heightt
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_widthh
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
	
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

make_pac_man proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ;citim simbolul pe care vrem sa l afisam
	lea esi, simboluri ; punem in esi adresa lui simboluri 
	sub eax, '0'
	
desenare_simbol_pac:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii_simbol_pac:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane_pac:
	cmp byte ptr [esi], 3
	je simbol_pixel_albastru_pac
	cmp byte ptr [esi], 6
	je simbol_pixel_rosu_pac
	jmp simbol_pixel_next_simbol_pac
	
simbol_pixel_albastru_pac:
	mov dword ptr [edi], 00762C0h
	jmp simbol_pixel_next_simbol_pac
simbol_pixel_rosu_pac:
	mov dword ptr [edi], 0FF02F3h
	jmp simbol_pixel_next_simbol_pac

simbol_pixel_next_simbol_pac:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane_pac
	pop ecx
	loop bucla_simbol_linii_simbol_pac
	popa
	mov esp, ebp
	pop ebp
	ret
make_pac_man endp	

make_symboll proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ;citim simbolul pe care vrem sa l afisam
	lea esi, simboluri ; punem in esi adresa lui simboluri 
	sub eax, 0
	
desenare_simbol:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii_simbol:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb_simbol
	cmp byte ptr [esi], 2
	je simbol_pixel_galben
	cmp byte ptr [esi], 3
	je simbol_pixel_albastru
	cmp byte ptr [esi], 4
	je simbol_pixel_roz
	cmp byte ptr [esi], 5
	je simbol_pixel_mov
	cmp byte ptr [esi], 6
	je simbol_pixel_rosu
	jmp simbol_pixel_next_simbol	
	
simbol_pixel_alb_simbol:
	mov dword ptr [edi], 0FFFFFFh
	jmp simbol_pixel_next_simbol
simbol_pixel_galben:
	mov dword ptr [edi], 0F4F7A9h
	jmp simbol_pixel_next_simbol
simbol_pixel_albastru:
	mov dword ptr [edi], 00762C0h
	jmp simbol_pixel_next_simbol
simbol_pixel_rosu:
	mov dword ptr [edi], 0FF02F3h
	jmp simbol_pixel_next_simbol
simbol_pixel_mov:
	mov dword ptr [edi], 0E098F5h 
	jmp simbol_pixel_next_simbol
simbol_pixel_roz:
	mov dword ptr [edi], 0FD6C9Eh
	jmp simbol_pixel_next_simbol


simbol_pixel_next_simbol:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii_simbol
	popa
	mov esp, ebp
	pop ebp
	ret
make_symboll endp	

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

make_symbol_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_symboll
	add esp, 16
endm

make_pacman_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_pac_man
	add esp, 16
endm

line_horizontal macro x, y, len, color
local loop1
	mov eax, y ;EAX=y
	mov ebx, area_width
	mul ebx ;EAX=y*area_width
	add eax, x ;EAX=x+y*area_width 
	shl eax, 2 ;EAX=(x+y*area_width)*4=pozitia in vectorul de pixeli
	add eax, area
	mov ecx, len
loop1:
	mov dword ptr[eax], color
	add eax, 4 ; ne deplasam la dreapta
	loop loop1
endm

line_vertical macro x, y, len, color
local loop2
	mov eax, y ;EAX=y
	mov ebx, area_width
	mul ebx ;EAX=y*area_width
	add eax, x ;EAX=x+y*area_width 
	shl eax, 2 ;EAX=(x+y*area_width)*4=pozitia in vectorul de pixeli
	add eax, area
	mov ecx, len
loop2:
	mov dword ptr[eax], color
	add eax, area_width*4 ; ne deplasam in jos
	loop loop2
endm

desenare_harta macro
local construire, linie_noua, final
	mov ebp, 0
	mov edi, 0
	mov ebx, 0
	mov esi, 0
	mov eax, 0
construire:
	cmp ebx, lin_max ;ebx este y
	jg final ;daca am terminat cu ultima linie de desenat
	cmp ebp, col_max; ebp este x
	jg linie_noua
	mov eax, ebx
	mov ecx, simboluri_pe_rand
	;harta[(y*C+x)* 4] i-linia, j-coloana
	; eax=y*43
	mul ecx
	add eax, ebp ;eax=y*43+x
	shl eax, 2 ;eax=(y*43+x)*4 -formula
	mov ecx, eax; ecx=formula
	mov eax, ebp; eax=x
	mov edi, col_pixeli ;14
	mul edi ;eax=14*x
	add eax, x0 ;;eax=14*x+x0 unde x0 e marginea
	mov edi, eax ;edi=14*x+x0
	mov eax, ebx ;eax=y 
	mov esi, lin_pixeli ;20
	mul esi ;eax=20*y
	add eax, y0 ;eax=20*y+y0 unde y0 e marginea
	mov esi, eax ;esi=20*y+y0
	make_symbol_macro harta[ecx], area, edi, esi
	add ebp, 1; mergem mai departe in harta la alta coloana
	jmp construire

linie_noua:
	add ebx, 1
	mov ebp, 0
	jmp construire
final:
	mov ebp, 0
	mov edi, 0
	mov ebx, 0
	mov eax, 0
	mov edi, 0
endm	
	

; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click, 3 - s-a apasat o tasta)
; arg2 - x (in cazul apasarii unei taste, x contine codul ascii al tastei care a fost apasata)
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz conditie_buton_right
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255 ;sau 0 ca sa fie negru
	push area
	call memset
	add esp, 12
	
	desenare_harta ;AICI APELEZ DESENAREA
	
	jmp afisare_litere
	
	
	
bucla_linii:
	mov eax, [ebp+arg2]
	and eax, 0FFh
	; provide a new (random) color
	mul eax
	mul eax
	add eax, ecx
	push ecx
	mov ecx, area_width
bucla_coloane:
	mov [edi], eax
	add edi, 4
	add eax, ebx
	loop bucla_coloane
	pop ecx
	loop bucla_linii
	jmp afisare_litere
	
game_over:
	make_text_macro 'G', area, 250, 10
	make_text_macro 'A', area, 260, 10
	make_text_macro 'M', area, 270, 10
	make_text_macro 'E', area, 280, 10
	
	make_text_macro ' ', area, 290, 10
	make_text_macro ' ', area, 300, 10
	
	make_text_macro 'O', area, 310, 10
	make_text_macro 'V', area, 320, 10
	make_text_macro 'E', area, 330, 10
	make_text_macro 'R', area, 340, 10
	
	mov edx, 0
	
actualizare_harta_copie2:
	mov ebx, harta[edx]
	mov harta_copie[edx],ebx
	add edx, 4
	cmp edx, const_final_actualizare
	je continuare2
	jmp actualizare_harta_copie2
	
continuare2:
	
    desenare_harta ;REDESENEZ HARTA
	
	mov poz_pacman, 0
	mov x_pacman, 20
	mov y_pacman, 40
	mov scor, 0
	mov counter, 0
	jmp final_joc
	
winner: 
	make_text_macro 'W', area, 250, 10
	make_text_macro 'I', area, 260, 10
	make_text_macro 'N', area, 270, 10
	make_text_macro 'N', area, 280, 10
	make_text_macro 'E', area, 290, 10
	make_text_macro 'R', area, 300, 10
	
	make_text_macro ' ', area, 310, 10
	make_text_macro ' ', area, 320, 10
	make_text_macro ' ', area, 330, 10
	make_text_macro ' ', area, 340, 10
	
	mov edx, 0
	
actualizare_harta_copie:
	mov ebx, harta[edx]
	mov harta_copie[edx], ebx
	add edx, 4
	cmp edx, const_final_actualizare
	je continuare1
	jmp actualizare_harta_copie
	
continuare1:

	desenare_harta ;REDESENEZ HARTA
	
	mov poz_pacman, 0
	mov x_pacman, 20
	mov y_pacman, 40
	mov scor, 0
	mov counter, 0
	jmp final_joc

crestere_scor:
	
	mov eax, scor
	cmp eax, maxim
	je winner
	inc scor
	jmp final_joc
	
	
conditie_buton_right:
 
	mov eax, [ebp+arg2]
	cmp eax, xr
	jl conditie_buton_left
	cmp eax, xr+60
	jg conditie_buton_left
	mov eax, [ebp+arg3]
	cmp eax, yr
	jl conditie_buton_left
	cmp eax, yr+50
	jg conditie_buton_left
	
	mov eax, x_pacman
	cmp eax, 608
	je final_joc
	
	mov eax, poz_pacman
	add eax, 4
	mov ebx, harta_copie[eax]
	cmp ebx, 2
	je conditie_buton_left
	make_pacman_macro '5', area, x_pacman, y_pacman
	
	mov edx, 5; AICI
	mov harta_copie[eax], edx
	
	add poz_pacman, 4
	add x_pacman, 14
	make_pacman_macro '6', area, x_pacman, y_pacman
	cmp ebx, 1
	je game_over
	
	cmp ebx, 0
	je crestere_scor
	
	
conditie_buton_left:
	mov eax, [ebp+arg2]
	cmp eax, xl 
	jl conditie_buton_up
	cmp eax, xl+60
	jg conditie_buton_up
	mov eax, [ebp+arg3]
	cmp eax, yl
	jl conditie_buton_up
	cmp eax, yl+50
	jg conditie_buton_up
		
	mov eax, x_pacman
	cmp eax, x0
	je final_joc
	
	mov eax, poz_pacman
    sub eax, 4
    mov ebx, harta_copie[eax]
	cmp ebx, 2
	je conditie_buton_up
	make_pacman_macro '5', area, x_pacman, y_pacman
	
	mov edx, 5; AICI
	mov harta_copie[eax], edx
	
	sub poz_pacman, 4
	sub x_pacman, 14
	make_pacman_macro '9', area, x_pacman, y_pacman
	
		
	cmp ebx, 1
	je game_over
	
	cmp ebx, 0
	je crestere_scor

	
conditie_buton_up:
	mov eax, [ebp+arg2]
	cmp eax, xu
	jl conditie_buton_down
	cmp eax, xu+60
	jg conditie_buton_down
	mov eax, [ebp+arg3]
	cmp eax, yu
	jl conditie_buton_down
	cmp eax, yu+50
	jg conditie_buton_down
	
	mov eax, y_pacman
	cmp eax, y0
	je final_joc
		
	mov eax, poz_pacman
    sub eax, 172  ; lungimea in pixeli a unui rand de matrice 
    mov ebx, harta_copie[eax]
	cmp ebx, 2
	je conditie_buton_down
	make_pacman_macro '5', area, x_pacman, y_pacman
	
	mov edx, 5; AICI
	mov harta_copie[eax], edx
	
	sub poz_pacman, 172
	sub y_pacman, 20
	make_pacman_macro '6', area, x_pacman, y_pacman
	

	cmp ebx, 1
	je game_over
	
	cmp ebx, 0
	je crestere_scor
	
	
	
conditie_buton_down:
	mov eax, [ebp+arg2]
	cmp eax, xd
	jl button_fail
	cmp eax, xd+60
	jg button_fail
	mov eax, [ebp+arg3]
	cmp eax, yd
	jl button_fail
	cmp eax, yd+50
	jg button_fail
	
	mov eax, y_pacman
	cmp eax, 240
	je final_joc
			
	mov eax, poz_pacman
    add eax, 172  ; lungimea in pixeli a unui rand de matrice 
    mov ebx, harta_copie[eax]
	cmp ebx, 2
	je button_fail
	make_pacman_macro '5', area, x_pacman, y_pacman
	
	mov edx, 5; AICI
	mov harta_copie[eax], edx
	
	add poz_pacman, 172
	add y_pacman, 20
	make_pacman_macro '6', area, x_pacman, y_pacman

	cmp ebx, 1
	je game_over
	
	cmp ebx, 0
	je crestere_scor

button_fail:
	jmp afisare_litere
	
evt_timer:
	inc counter

	
afisare_litere:
	
	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 30, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 20, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 10, 10
	
	
	make_text_macro 'S', area, 500, 10
	make_text_macro 'C', area, 510, 10
	make_text_macro 'O', area, 520, 10
	make_text_macro 'R', area, 530, 10
	
	;SCOR
	mov ebx, 10
	mov eax, scor
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 580, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 570, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 560, 10
	
	;scriem un mesaj
	make_text_macro 'P', area, 50, 10
	make_text_macro 'A', area, 60, 10
	make_text_macro 'C', area, 70, 10
	make_text_macro ' ', area, 80, 10
	make_text_macro 'M', area, 90, 10
	make_text_macro 'A', area, 100, 10
	make_text_macro 'N', area, 110, 10
	
	make_text_macro 'R', area, 310, 370
	make_text_macro 'I', area, 320, 370
	make_text_macro 'G', area, 330, 370
	make_text_macro 'H', area, 340, 370
	make_text_macro 'T', area, 350, 370
	
	make_text_macro 'L', area, 200, 370
	make_text_macro 'E', area, 210, 370
	make_text_macro 'F', area, 220, 370
	make_text_macro 'T', area, 230, 370 
	
	make_text_macro 'U', area, 270, 310 
	make_text_macro 'P', area, 280, 310
	
	make_text_macro 'D', area, 260, 440
	make_text_macro 'O', area, 270, 440
	make_text_macro 'W', area, 280, 440
	make_text_macro 'N', area, 290, 440 
	
	make_pacman_macro '4', area, 210, 390; facem sageata LEFT
	make_pacman_macro '3', area, 330, 390 ;facem sageata RIGHT
	make_pacman_macro '7', area, 270, 330 ;facem sageata UP
	make_pacman_macro '8', area, 270, 420 ;facem sageata DOWN 
	
	;RIGHT
	line_horizontal 305, 360, 60, 01E7FCBh
	line_vertical 305, 360, 50, 01E7FCBh
	line_vertical 365, 360, 50, 01E7FCBh
	line_horizontal 305, 410, 60, 01E7FCBh
	
	;LEFT
	line_horizontal 190, 360, 60, 01E7FCBh
	line_vertical 190, 360, 50, 01E7FCBh
	line_vertical 250, 360, 50, 01E7FCBh
	line_horizontal 190, 410, 60, 01E7FCBh
	
	;UP
	line_horizontal 250, 300, 60, 01E7FCBh
	line_vertical 250, 300, 50, 01E7FCBh
	line_vertical 310, 300, 50, 01E7FCBh
	line_horizontal 250, 350, 60, 01E7FCBh
	
	;DOWN
	line_horizontal 250, 420, 60, 01E7FCBh
	line_vertical 250, 420, 50, 01E7FCBh
	line_vertical 310, 420, 50, 01E7FCBh
	line_horizontal 250, 470, 60, 01E7FCBh
	
final_joc:

	
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start
