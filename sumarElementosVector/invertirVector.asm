global main
extern printf
extern  puts
section .data
    vector  dq  3,2,6,7,1
    muestro db  " %lli ",0
    asd     db  "vector invertido: ",0
    posicion    dq  5
    posicioninvert  dq  1
section .bss
    vectorInvertido resq    1   

section .text
main:

invierto:
    cmp     qword[posicioninvert],6
    je      final

    mov     rbx,[posicioninvert]
    dec     rbx
    imul    rbx,8
    mov     rdi,rbx

    mov     rax,[posicion]
    dec     rax
    imul    rax,8
    mov     rsi,rax

    mov     rax,[vector + rsi]
    mov     [vectorInvertido + rdi],rax
    dec     qword[posicion]
    inc     qword[posicioninvert]
    jmp     invierto

final:
    mov     rcx,asd
    sub     rsp,32
    call    printf
    add     rsp,32

    jmp     finVect

finVect:
    cmp     rsi,40
    je      end
    mov     rcx,muestro
    mov     rdx,[vectorInvertido + rsi]
    add     rsi,8

    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     finVect
end:
    ret

