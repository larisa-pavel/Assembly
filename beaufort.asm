%include "../include/io.mac"

section .data
    len_key: dd 1
    len_plain: dd 1
    caut: dd 0

section .text
    global beaufort
    extern printf

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc

    mov [len_key], ecx
    mov edi, 0
    mov [len_plain], eax
    mov eax, 0
plain_loop:
    mov ecx, 0
key_loop:
    mov eax, [edx+ecx]
    sub eax, [ebx+edi]
    add eax, 65
    ;;eax=key-plain+'A'
    cmp al, 65
    ;;daca al<'A'
    jl mai_incolo
    ;;atunci aplic formula din label
    mov [esi+edi], eax
    jmp end_key_loop
mai_incolo:
    add eax, 26
    mov [esi+edi], eax
    ;;eax=eax+26
    jmp end_key_loop
end_key_loop:
    add edi, 1
    ;;maresc indexul pt plain
    cmp edi, [len_plain]
    ;;compar indexul cu lungimea plain-ului
    je termin
    ;;daca sunt egale, programul se termina
    add ecx, 1
    ;;maresc indexul cheii
    cmp ecx, [len_key]
    ;;compar indexul cu lungimea cheii
    jl key_loop
    ;;daca indexul e mai mic, iteratia continua
    je plain_loop
    ;;daca sunt egali, atunci reinitializez
    ;;indexul cu 0 si astfel sirul se va repeta
    ;;de len_plain ori
termin:
    mov eax, [len_plain]
    mov [esi+eax],byte 0
    popa
    leave
    ret
