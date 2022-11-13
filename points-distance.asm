%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    xor ecx, ecx
    xor edx, edx
    ;;initializez cu 0 ecx si edx
    mov cx,word [ebx]
    mov dx,word [ebx+4]
    ;;in cx si dx retin coordonatele pe x
    ;;ale celor 2 puncte
    cmp cx, dx
    je x_zero
    jne y_zero
x_zero:
    mov cx, word [ebx+2]
    mov dx, word [ebx+6]
    ;;in cx si dx retin coordonatele pe y
    ;;ale celor 2 puncte
    cmp cx, dx
    jg primul_mare
    jl al_doilea_mare
y_zero:
    cmp cx, dx
    jg primul_mare
    jl al_doilea_mare
primul_mare:
    sub cx, dx
    mov [eax], ecx
    jmp termin
al_doilea_mare:
    sub dx, cx
    mov [eax], edx
    jmp termin

termin:
    popa
    leave
    ret
