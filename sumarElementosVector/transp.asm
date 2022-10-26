global  main
extern  printf

section .data
    output      db  " %hi ",0
    newLine     db  " ",10,0
    fila        dw  1
    columna     dw  1
    matriz      dw  1,2,3
                dw  4,5,6
                dw  7,8,9

    traspuesta  times   9   dw  0
    contadorColumna    db  0
section .bss
    desplaz     resw    10
    
section .text
main:
    sub     rbx,rbx
    sub     rax,rax
    sub     rcx,rcx

calculoDesplaz:
    cmp     word[fila],4
    je      cambioColumna
    mov     bx,[fila]
    dec     bx
    imul    bx,6
    mov     [desplaz],bx

    mov     bx,[columna]
    dec     bx
    imul    bx,2
    add     bx,[desplaz]

    mov     ax,[matriz + rbx]
    mov     [traspuesta + rcx],ax
    inc     word[fila]
    add     rcx,2    ;hacer un desplaz de la traspuesta
    jmp     calculoDesplaz

cambioColumna:
    cmp     cx,18
    je      fin
    inc     word[columna]
    mov     word[fila],1
    jmp     calculoDesplaz

fin:
    mov     rsi,0
imprimo:
    cmp     byte[contadorColumna],3
    je      imprimoLinea    

    cmp     rsi,18
    je      endprog
    mov     rcx,output
    mov     rdx,[traspuesta + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32
    add     rsi,2
    inc     byte[contadorColumna]
    jmp     imprimo

imprimoLinea:
    mov     rcx,newLine
    sub     rsp,32
    call    printf
    add     rsp,32
    mov     byte[contadorColumna],0
    jmp     imprimo
endprog:
    ret
