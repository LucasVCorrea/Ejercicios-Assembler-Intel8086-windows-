global main
extern printf
extern gets
extern sscanf

section .data
    msjPrimero      db  "Ingrese el primer numero: ",0
    msjSegundo      db  "Ingrese el segundo numero: ",0
    msjResultado    db  "%lli",0
    msjeFinal       db  "result: %lli (resto: %lli)",0
    msjeError       db  "ERROR - DIVISION BY ZERO",0
section .bss
    resultado   resq  1
    resto       resq  1
    string      resq  1
    num1        resq  1
    num2        resq  1

section .text
main:
    mov rcx, msjPrimero
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, string
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, string
    mov rdx, msjResultado
    mov r8, num1
    sub rsp, 32
    call sscanf
    add rsp, 32

    mov rcx, msjSegundo
    sub rsp, 32
    call printf
    add rsp, 32

    mov rcx, string
    sub rsp, 32
    call gets
    add rsp, 32

    mov rcx, string
    mov rdx, msjResultado
    mov r8, num2
    sub rsp, 32
    call sscanf
    add rsp, 32

    mov rax, [num2]
    cmp rax,0
    je error
    jmp operacion

error:
    mov rcx, msjeError
    sub rsp, 32
    call printf
    add rsp, 32
    ret

operacion:
    mov rdx, 0
    mov rax, [num1]
    mov rcx, [num2]
    div rcx
    mov [resultado], rax
    mov [resto],rdx
    
fin:
    mov rcx, msjeFinal
    mov rdx, [resultado]
    mov r8, [resto]
    sub rsp, 32
    call printf
    add rsp, 32

    ret