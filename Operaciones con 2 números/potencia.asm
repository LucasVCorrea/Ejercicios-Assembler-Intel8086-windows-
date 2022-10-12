global  main
extern  sscanf  
extern  gets
extern  printf

section .data
    ingBase     db  "Ingrese la base: ",0
    ingPotencia db  "Ingrese la potencia: ",0
    msjeFracc   db  "1/%lli",0
    numFormat   db  "%lli",0

section .bss
    string      resb    100
    base        resq    1
    potencia    resq    1
    resultado   resq    1

section .text
main:
;base
    mov     rcx,ingBase
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,string
    sub     rsp,32
    call    gets
    add     rsp,32

    mov     rcx,string
    mov     rdx,numFormat
    mov     r8, base
    sub     rsp,32
    call    sscanf
    add     rsp,32

;potencia
    mov     rcx,ingPotencia
    sub     rsp,32
    call    printf
    add     rsp,32    

    mov     rcx,string
    sub     rsp,32
    call    gets
    add     rsp,32

    mov     rcx,string
    mov     rdx,numFormat
    mov     r8, potencia
    sub     rsp,32
    call    sscanf
    add     rsp,32

    sub     rcx,rcx
    mov     rcx,[potencia]
    dec     rcx
    mov     rax,[base]
potenciaUnoOCero:
    cmp     qword[potencia],1
    je      imprimoBase
    cmp     qword[potencia],0
    jl      calculoFracc
    je      imprimoUno
    jmp     calculo

imprimoBase:
    mov     rbx,[base]
    mov     [resultado],rbx
    jmp     imprimoRes
calculoFracc:
    cmp     qword[potencia],0
    je      imprimoFracc
    imul    rax,[base]
    mov     [resultado],rax
    mov     rax,[resultado]
    add     qword[potencia],2
    jmp     calculoFracc
imprimoFracc:
    mov     rcx,msjeFracc
    mov     rdx,[resultado]

    sub     rsp,32
    call    printf
    add     rsp,32

    jmp     fin
imprimoUno:
    mov     qword[resultado],1
    jmp     imprimoRes
calculo:
    imul    rax,[base]
    mov     [resultado],rax
    mov     rax,[resultado]
    loop    calculo

imprimoRes:
    mov     rcx,numFormat
    mov     rdx,[resultado]
    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     fin
fin:
    ret