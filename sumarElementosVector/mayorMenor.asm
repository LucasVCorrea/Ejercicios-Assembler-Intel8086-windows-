global  main    
extern  printf

section .data
    vector  dd  3,2,9,5,4,1,8,7,6
    pivote      dd    1
    msjPromedio       db  "promedio: %i (total: %i y longitud: %i)",10,0
    msjMenor       db  "menor: %i",10,0
    msjMayor       db  "mayor: %i",10,0
    longitud    dd  9
section .bss
    mayor       resd    1
    menor       resd    1
    promedio    resd    1
    sumatoria   resd    1
    desplaz     resd    1
section .text
main:

    sub     rsp,32
    call    inicializoMayor
    add     rsp,32

    sub     rsp,32
    call    calcDesplaz
    add     rsp,32

    sub     rsp,32
    call    recorrido
    add     rsp,32

    mov     rcx,msjMayor
    mov     rdx,[mayor]
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,msjMenor
    mov     rdx,[menor]
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,msjPromedio
    mov     rdx,[promedio]
    mov     r8,[sumatoria]
    mov     r9,[longitud]
    sub     rsp,32
    call printf
    add     rsp,32

fin:    
    ret

inicializoMayor:
    mov     eax,[vector]
    mov     [mayor],eax
    mov     [menor],eax

calcDesplaz:
    mov     ebx,[pivote]
    dec     ebx
    imul    ebx,4
    mov     [desplaz],ebx

recorrido:
    cmp     dword[pivote],10
    je      calculoPromedio
    mov     esi,[desplaz]
    mov     eax,[vector + esi]
    cmp     eax,[mayor]
    jg      cambioMayor
    cmp     eax,[menor]
    jl      cambioMenor
    mov     ebx,[sumatoria]
    add     ebx,[vector + esi]
    mov     [sumatoria],ebx
    inc     dword[pivote]
    jmp     calcDesplaz

cambioMayor:
    mov     eax,[vector + esi]
    mov     [mayor],eax
    jmp     recorrido

cambioMenor:
    mov     eax,[vector + esi]
    mov     [menor],eax
    jmp     recorrido

calculoPromedio:
    mov     edx,0
    mov     eax,[sumatoria]
    mov     ecx,[longitud]
    div     ecx
    mov     [promedio],eax
    jmp     fin