global main
extern puts

section .data
    mensaje     db  "Hola Mundo Intel",0

section .text
main:

    mov     rcx,mensaje
    sub     rsp,32
    call    puts
    add     rsp,32

    ret
