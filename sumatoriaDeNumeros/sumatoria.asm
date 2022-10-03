global main
extern  printf
extern  sscanf
extern gets

section .data
    mensajeIngreso  db  "Ingrese un numero o 0 para terminar: ",0
    mensajeFin  db "Fin de programa. Total sumado: %lli",0
    numFormat   db  "%lli",0
    sumatoria   dq 0
    
section .bss
    numeroIngresado resq  1
    string resb 10

section .text
main:
    mov rcx,mensajeIngreso
    sub rsp,32
    call printf
    add rsp,32
    
    mov rcx,string
    sub rsp,32
    call gets
    add rsp,32

    mov rcx,string
    mov rdx,numFormat
    mov r8,numeroIngresado
    sub rsp,32
    call sscanf
    add rsp,32
    
    mov rax,[numeroIngresado]
    cmp rax,0
    je  fin
    mov rbx,[sumatoria]
    add rbx,rax
    mov [sumatoria],rbx
    jmp main

fin:
    mov rcx,mensajeFin
    mov rdx,[sumatoria]
    sub rsp,32
    call printf
    add rsp,32
    ret

