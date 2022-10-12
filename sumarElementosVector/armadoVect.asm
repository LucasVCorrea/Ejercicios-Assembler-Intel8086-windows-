global  main
extern  gets
extern  sscanf
extern  printf

section .data
    msjIngres   db  "Ingrese un numero para almacenar en el vector: ",10,0
    numFormt    db  " %hi ",0
    otroVect    db  "%hi",0
    pivote      dw  1
    vectorOg    dw  2,2,2,2,2
section .bss
    vector      times   5 resw    1
    elemento    resw    1
    string      resw    1
    desplaz     resw    1   
section .text
main:
ingreso:
    cmp     word[pivote],6
    je      termino
    mov     rcx,msjIngres
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,string 
    sub     rsp,32
    call    gets
    add     rsp,32

    mov     rcx,string
    mov     rdx,numFormt
    mov     r8,elemento
    sub     rsp,32
    call    sscanf
    add     rsp,32
calculoDesplaz:
    mov     ax,[pivote]
    dec     ax
    imul    ax,2
    ;mov     [desplaz],ax
    cwde
    cdqe
almaceno:
    mov     rsi,rax
    mov     bx,[elemento]
    mov     [vector + rsi],bx
    add     [vectorOg + rsi],bx
    inc     word[pivote]
    jmp     ingreso

termino:
    mov     rsi,0
    jmp     finAlmacenado
finAlmacenado:
    cmp     rsi,10
    je      fin
    mov     rcx,numFormt
    mov     rdx,[vector + rsi]
    add     rsi,2
    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     finAlmacenado

fin:
    mov     rsi,0
    jmp     aca
aca:
    cmp     rsi,10
    je      ending
    mov     rcx,otroVect
    mov     rdx,[vectorOg + rsi]
    add     rsi,2
    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     aca
    
ending:
    ret

    
    