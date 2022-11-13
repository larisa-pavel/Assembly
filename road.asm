%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global road
    extern printf

road:
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
   
    mov edx, 0
    sub ecx, 1
    ;;edx va fi contuor, iar eu fac parcurgerea
    ;; de la 0 la ecx-1, asemanator cu c
my_loop:
    xor esi, esi
    xor edi, edi
    ;;initializez esi, edi cu 0
    mov di, word [eax+4*edx] 
    mov si, word [eax+4+4*edx]
    ;;in di si si retin coordonatele pe x
    ;;ale celor 2 puncte
    cmp di, si
    je x_zero
    jne y_zero
x_zero:
    mov si, word [eax+2+4*edx]
    mov di, word [eax+6+4*edx]
    ;;in si si di retin coordonatele pe y
    ;;ale celor 2 puncte
    cmp di, si
    jg primul_mare
    jl al_doilea_mare
y_zero:
    cmp di, si
    jg primul_mare
    jl al_doilea_mare
primul_mare:
    sub di, si
    mov [ebx+4*edx], edi
    add edx, 1
    cmp edx, ecx
    je termin
    jne my_loop
al_doilea_mare:
    sub si, di
    mov [ebx+4*edx], esi
    add edx, 1
    cmp edx, ecx
    je termin
    jl my_loop
termin:
    
    popa
    leave
    ret