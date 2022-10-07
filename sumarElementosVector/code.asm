global  main
extern  printf
extern  gets    

section .data
    msjeSalida  db  "Sumatoria de elementos: %hi",10,0
    msjeInicio  db  "desear ver la sumatoria de los elementos? (s/n): ",10,0
    msjeFin     db  "Fin de programa.",10,0
    sumatoria   dw  0
    vector      dw  1,2,3,4,5
    posicion    dw  1
    

section .bss
    respuesta   resb    1
    desplaz     resw    1

section .text
main:
    mov     rcx,msjeInicio
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,respuesta
    sub     rsp,32
    call    gets
    add     rsp,32

    sub     rsp,32
    call    validarIng
    add     rsp,32

continuar:
    cmp     word[posicion],6 ;longitud + 1
    je      finale
    mov     bx,[posicion]
    dec     bx  ;pos - 1
    imul    bx,bx,2 ;(longitud del elemento 2 bytes)
    cwde    ;ebx
    cdqe    ;rbx 
    mov     [desplaz],rbx   ;para guardarlo en algun lado
    mov     rsi,rbx ;copio el desplazamiento en el indice
    
    mov     ax,[sumatoria]
    add     ax,[vector + rsi] ;sumo el elemento en la posicion rsi
    mov     [sumatoria],ax
    inc     word[posicion] ;avanzo una posicion
    jmp     continuar

finale:
    mov     rcx,msjeSalida
    mov     rdx,[sumatoria]
    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     fin
    


;rutinas internas
validarIng:
    cmp     byte[respuesta],'s'
    je      continuar
    cmp     byte[respuesta],'n'
    je      fin

fin:
    mov     rcx,msjeFin
    call    printf
    add     rsp,32
    ret
