global main
extern printf
extern gets


section .data
    msjSumatoria     db  "Sumatoria de la diagonal: %hi",10,0
    matriz          dw     1,1,1,1,1
                    dw     2,9,2,2,2
                    dw     3,3,8,3,3
                    dw     4,4,4,3,4
                    dw     5,5,5,5,6

    sumatoria       dw  0
    posX            dw  1
    posY            dw  1

section .bss
    pivote  resw    1

section .text
main:
    cmp     word[posX],6
    je      fin
    cmp     word[posY],6
    je      fin

;desplazamiento fila
    mov     ax,[posX] ;fila
    dec     ax ;(i-1)
    imul    ax,10 ;2bytes * 5 columnas  ;(i-1)*longitudFila
    mov     [pivote],ax ;por las dudas de no perder es desplazamiento fila

;desplazamiento columna 
    mov     bx,[posY]
    dec     bx
    imul    bx,2        ;(j-1)*longitudElemento

    add     bx,[pivote] ;(i-1)*longitudFila + (j-1)*longitudElemento
    cwde    ;ebx
    cdqe    ;rbx 
    mov     rsi,rbx

    mov     ax,[sumatoria]
    add     ax,[matriz + rsi]
    mov     [sumatoria],ax
    inc     word[posX]
    inc     word[posY]
    jmp     main

fin:
    mov     rcx, msjSumatoria
    mov     rdx,[sumatoria]
    sub     rsp,32
    call    printf
    add     rsp,32
    ret