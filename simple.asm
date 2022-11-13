%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

for:
    mov eax, 0
    ;; initializez registrul eax cu 0
    mov al, byte [esi+ecx-1]
    mov byte [edi+ecx-1], al 
    ;;mut o litera din string-ul care
    ;;trebuie criptat in edi, adresa la
    ;;care se va scrie textul criptat
    mov ebx, eax
    add ebx, edx
    ;;adaug step-ul
    cmp ebx, 90
    jg estez
    ;;compar ebx cu 90, adica cu Z in
    ;;ASCII, iar daca ebx>90, 
    add byte [edi+ecx-1], dl
    loop for
    jmp endfor
    ;;enfor= sfarsitul programului
estez:
    mov byte [edi+ecx-1], 'A'
    add byte [edi+ecx-1], dl
    add byte [edi+ecx-1], al
    sub byte [edi+ecx-1], 'Z'
    sub byte [edi+ecx-1], 1
    ;;efectuez operatia: 
    ;;enc_string='A'+step+plain-'Z'-1
    loop for
endfor:
    

    popa
    leave
    ret
    
