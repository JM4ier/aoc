global _start

section .text

read_char:
    xor eax, eax
    push rax
    mov rdi, 0
    mov rsi, rsp
    mov rdx, 1
    xor eax, eax
    syscall
    pop rax
    ret


read_dir:
    push rbx
    call read_char
    mov rbx, rax
.tail:
    call read_char
    cmp al, " "
    jne .tail
.exit:
    mov rax, rbx
    pop rbx
    ret


read_num:
    call read_char
    sub al, "0"
    push rax
    call read_char
    pop rax
    ret

_start:
    mov r12, 0
    mov r13, 0
    mov r14, 0
.loop:
    call read_dir
    mov rbx, rax
    call read_num

    cmp bl, "u"
    je .up
    cmp bl, "d"
    je .down
    cmp bl, "f"
    je .fwd

    jmp .exit
.up:
    sub r12, rax
    jmp .loop
.down:
    add r12, rax
    jmp .loop
.fwd:
    add r13, rax
    imul rax, r12
    add r14, rax
    jmp .loop


.exit:
    mov rax, r14
    imul rax, r13

    cmp rax, 0
    jg .pos
    neg rax
.pos:

    ; r12: length of buffer
    mov r12, 1
    mov byte [rsp], 0xA
.translate:
    mov edx, 0
    mov r13, 10
    div r13
    add dl, "0"
    dec rsp
    mov byte [rsp], dl
    inc r12
    cmp rax, 0
    jne .translate

    mov rdi, 1
    mov rsi, rsp
    mov rdx, r12
    mov rax, 1
    syscall


    mov rax, 60
    mov rdi, 0
    syscall


FWD     equ 1
UP      equ 2
DOWN    equ 4
EXIT    equ 8
