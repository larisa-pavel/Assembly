%include "../include/io.mac"
section .data
    num1 dd 2
section .text
    global is_square
    extern printf

is_square:
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    mov [num1], eax
    ;;num1=lungimea vectorului
    ;;am ramas fara registrii :)
    ;;plus ca trebuie sa folosesc eax pt mul :)
    mov esi, 0
    ;;initializez esi cu 0
    ;;esi= contuor pentru distante
dist_loop:
    mov edi, 0
    ;;edi= contuor pentru calcularea radacinii
sq_loop:
    mov eax, edi
    mul eax
    ;;fac operatia: eax=edi^2
    add edi, 1
    cmp [ebx+4*esi], eax
    ;;compar distanta curenta cu eax
    jg sq_loop
    ;;daca distanta e mai mare decat eax
    ;;atunci mai avem nevoie de o iteratie
    je its_sq
    ;;daca sunt egale, atunci distanta= patrat perfect
    jl not_sq
    ;;daca eax e mai mare decat distanta,
    ;;atunci inseamna ca distanta nu este patrat perfect
not_sq:
    mov [ecx+4*esi],dword 0
    jmp end_dist_loop
its_sq:
    mov [ecx+4*esi],dword 1
    jmp end_dist_loop
end_dist_loop:
    add esi, 1
    cmp esi, [num1]
    je termin
    jl dist_loop
termin:
    popa
    leave
    ret