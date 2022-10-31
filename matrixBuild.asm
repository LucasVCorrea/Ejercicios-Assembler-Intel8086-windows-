global  main
extern  gets
extern  sscanf
extern  printf
extern  puts

section .data
    ;***Seccion de mensajes-------------------------------------------------------------------------------------------------
        ;***Ingresos
    pedirCantMatrices   db  "Ingrese la cantidad de matrices que va a ingresar (de 1 a 5): " ,0
    pedirDimension      db  "Ingrese la dimension de la/s matriz/ces (1 a 8). Fila x Columna separados por un espacio: ",0
    mensajeIngreso      db  "Ingrese (valor entre -99 y 99) para llenar la matriz en la posicion [%hi] [%hi]: ",0
    mensajeOpcion       db  "Ingrese una opcion: ",0
        ;***Errores
    msjErrorDimension   db  "Dimension ingresada invalida. Vuelva a ingresar.",10,0
    msjErrorIngreso     db  "Ingreso invalido. El numero debe estar entre -99 y 99",10,0
    msjErrorCantidad    db  "Ingreso invalido. El numero debe estar entre 1 y 5",10,0
    
        ;***Opciones
    msjOpciones         db  "======================================",10,"Opciones:",10," 1- suma de matrices ",10, 
                        db  " 2- producto de matrices",10," 3- mostrar la traspuesta",10," 4- modificar un elemento de la matriz",10,
                        db  " 5- consultar valor en una posicion",10," 6- terminar el programa",10,"======================================",0

    msjeIndicadorMatr   db  "Complete la matriz %hi",10,0
        ;***contadores por pantalla
    mensajeMatriz       db  "- - - - Matriz %hi - - - -",10,0
    ;------------------------------------------------------------------------------------------------------------------------
        ;***Debug y formats
    debug       db      " %hi ",0
    newLine     db      " ",10,0
    format      db      "%hi %hi",0
    elemFormat  db      "%hi",0
    pivote      dw  0
    debug2      db      "%hi",10,0
    cantidadFormat  db  "%hi",0
    ;***Seccion de la matriz--------------------------------------------------------------------------------------------------
    fila        dw  1
    columna     dw  1
    traspuesta  times   64   dw  0
    matricesArmadas dw  1
    ;***Cosas usadas para la pantalla
    matrizMostrada  dw  1
    
section .bss
    cantidadMatricesNum     resw    1
    cantidadStr             resw    1
    desplaz                 resw    1
    dimensionStr            resb    10
    filadimensionNum        resw    1
    coludimensionNum        resw    1
    dimensionMatriz         resw    1
    auxiliarColumna         resw    1
    opcionElegida           resb    1
    
;-------------------------------------------------------------------------------------------------------------------------
    matrizA     times   64  resw    1
    matrizB     times   64  resw    1
    matrizC     times   64  resw    1
    matrizD     times   64  resw    1
    matrizE     times   64  resw    1

    elemento    resw    10
    elementoNum resw    10
    finColumna  resw    1
    
    ;***Seccion para validaciones-------------------------------------------------------------------------------------------
    dimensionEsValida   resb    1
    ingresoEsValido     resb    1
    cantidadEsValida    resb    1
    opcionEsValida      resb    1
section .text

main:

pidoCantidadMatrices:
    mov     rcx,pedirCantMatrices
    sub     rsp,32
    call    printf
    add     rsp,32
    
    mov     rcx,cantidadStr
    sub     rsp,32
    call    gets    
    add     rsp,32
    
    call    validarCantidadMatrices
    cmp     byte[cantidadEsValida],'N'
    je      errorCantidad

pidoDimension:
    mov     rcx,pedirDimension
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,dimensionStr
    sub     rsp,32
    call    gets
    add     rsp,32

    call    validarDimension
    cmp     byte[dimensionEsValida],'N'
    je      errorDimension

    
    mov     rcx,msjeIndicadorMatr
    mov     rdx,[matricesArmadas]
    sub     rsp,32
    call    printf
    add     rsp,32

    sub     rax,rax
    sub     rbx,rbx
;Obtengo la dimension haciendo      fila X columna
    mov     ax,[filadimensionNum]
    mov     bx,[coludimensionNum]
    mov     [finColumna],bx
    inc     word[finColumna]
    imul    ax,bx
    mov     [dimensionMatriz],ax


finDeFila:
    mov     ax,word[finColumna]
    cmp     word[columna],ax
    je      bajoFila    
    
pidoIngreso:
    mov     rcx,mensajeIngreso
    mov     rdx,[fila]
    mov     r8,[columna]
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,elemento
    sub     rsp,32
    call    gets
    add     rsp,32

    call    validarIngreso
    cmp     byte[ingresoEsValido],'N'
    je      errorIngreso

  
    call    calculoDesplaz
    cmp     word[matricesArmadas],1
    je      armoMatrizUno
    cmp     word[matricesArmadas],2
    je      armoMatrizDos
    cmp     word[matricesArmadas],3
    je      armoMatrizTres
    cmp     word[matricesArmadas],4
    je      armoMatrizCuatro
    cmp     word[matricesArmadas],5
    je      armoMatrizCinco


armoMatrizUno:
    mov     ax,[elementoNum]
    mov     [matrizA + ebx],ax

    inc     word[columna]
    jmp     finDeFila
    
armoMatrizDos:
    mov     ax,[elementoNum]
    mov     [matrizB + ebx],ax

    inc     word[columna]
    jmp     finDeFila
armoMatrizTres:
    mov     ax,[elementoNum]
    mov     [matrizC + ebx],ax

    inc     word[columna]
    jmp     finDeFila
armoMatrizCuatro:
    mov     ax,[elementoNum]
    mov     [matrizD + ebx],ax

    inc     word[columna]
    jmp     finDeFila
armoMatrizCinco:
    mov     ax,[elementoNum]
    mov     [matrizE + ebx],ax

    inc     word[columna]
    jmp     finDeFila
bajoFila:
    mov     ax,[filadimensionNum]
    cmp     word[fila],ax
    je      siguienteMatriz            ;reemplazar con una que me resetee todo y lo uso para la segunda matriz
    inc     word[fila]
    mov     word[columna],1
    jmp     finDeFila


errorDimension:
    mov     rcx,msjErrorDimension
    sub     rsp,32
    call    puts
    add     rsp,32
    jmp     pidoDimension
errorIngreso:
    mov     rcx,msjErrorIngreso
    sub     rsp,32
    call    puts
    add     rsp,32
    jmp     pidoIngreso
errorCantidad:
    mov     rcx,msjErrorCantidad
    sub     rsp,32
    call    puts
    add     rsp,32
    jmp     pidoCantidadMatrices

siguienteMatriz:
    sub     rax,rax
    inc     word[matricesArmadas]


    mov     ax,word[cantidadMatricesNum]
    inc     ax
    cmp     word[matricesArmadas],ax
    je      fin

;mov     rcx,debug2
;mov     dx,ax
;sub     rsp,32
;call    printf
;add     rsp,32


    mov     word[columna],1
    mov     word[fila],1

    mov     rcx,newLine
    sub     rsp,32 
    call    printf  
    add     rsp,32
    mov     rcx,msjeIndicadorMatr
    mov     rdx,[matricesArmadas]
    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     pidoIngreso


fin:
    sub     rbx,rbx
    sub     rax,rax
    mov     rsi,0
    mov     bx,2
    imul    bx,word[dimensionMatriz]

    
mov     rcx,mensajeMatriz
mov     rdx,[matrizMostrada]
sub     rsp,32
call    printf
add     rsp,32



imprimoUna:
    push    rsi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb   ;revisar de vuelta

    pop     rsi
    je      printf_newLine

    cmp     rsi,rbx 
    je      finImpresion

    mov     rcx,debug
    mov     rdx,[matrizA + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rsi,2
    add     word[pivote],1
    jmp     imprimoUna

finImpresion:
    sub     rax,rax
    
    mov     ax,word[matrizMostrada]
    cmp     ax,word[cantidadMatricesNum]
    je      gg

    inc     word[matrizMostrada]
    cmp     word[matrizMostrada],6  ;tiene que ser 6
    je      gg

mov     rcx,mensajeMatriz   ;Mensaje   "---- Matriz x ----"
mov     rdx,[matrizMostrada]
sub     rsp,32
call    printf
add     rsp,32

    mov     rsi,0
    mov     word[pivote],0

    cmp     word[matrizMostrada],2
    je      imprimoDos
    cmp     word[matrizMostrada],3
    je      imprimoTres
    cmp     word[matrizMostrada],4
    je      imprimoCuatro
    cmp     word[matrizMostrada],5
    je      imprimoCinco
    cmp     word[matrizMostrada],6
    je      gg



imprimoDos:
    push    rsi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb 

    pop     rsi
    je      printf_newLine

    cmp     rsi,rbx 
    je      finImpresion  

    mov     rcx,debug
    mov     rdx,[matrizB + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32
    add     rsi,2
    add     word[pivote],1
    jmp     imprimoDos

imprimoTres:
    push    rsi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb   
    pop     rsi
    je      printf_newLine

    cmp     rsi,rbx 
    je      finImpresion  

    mov     rcx,debug
    mov     rdx,[matrizC + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rsi,2
    add     word[pivote],1
    jmp     imprimoTres

imprimoCuatro:
    push    rsi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb   

    pop     rsi
    je      printf_newLine

    cmp     rsi,rbx 
    je      finImpresion

    mov     rcx,debug
    mov     rdx,[matrizD + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rsi,2
    add     word[pivote],1
    jmp     imprimoCuatro

imprimoCinco:
    push    rsi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb   

    pop     rsi
    je      printf_newLine

    cmp     rsi,rbx 
    je      finImpresion

    mov     rcx,debug
    mov     rdx,[matrizE + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rsi,2
    add     word[pivote],1
    jmp     imprimoCinco


gg:

    mov     rcx,msjOpciones
    sub     rsp,32
    call    puts
    add     rsp,32

    mov     rcx,mensajeOpcion
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,opcionElegida
    sub     rsp,32
    call    gets
    add     rsp,32
;call   validarOpcion   (1 jmp a la suma, 2 jump a la ... 6, jmp endProg con un mensaje)
ret

;************************
;*** RUTINAS INTERNAS ***
;************************
validarCantidadMatrices:
    mov     byte[cantidadEsValida],'N'

    mov     rcx,cantidadStr
    mov     rdx,cantidadFormat
    mov     r8,cantidadMatricesNum
    sub     rsp,32
    call    sscanf
    add     rsp,32

    cmp     rax,1
    jl      cantidadInvalida

    cmp     word[cantidadMatricesNum],1
    jl      cantidadInvalida
    cmp     word[cantidadMatricesNum],5
    jg      cantidadInvalida

    mov     byte[cantidadEsValida],'S'
cantidadInvalida:
    ret

validarDimension:
    mov     byte[dimensionEsValida],'N'
    
    mov     rcx,dimensionStr
    mov     rdx,format
    mov     r8,filadimensionNum
    mov     r9,coludimensionNum
    sub     rsp,32
    call    sscanf
    add     rsp,32

    cmp     rax,2
    jl      dimInvalida

    cmp     word[filadimensionNum],1
    jl      dimInvalida
    cmp     word[filadimensionNum],8
    jg      dimInvalida

    cmp     word[coludimensionNum],1
    jl      dimInvalida
    cmp     word[coludimensionNum],8
    jg      dimInvalida

    mov     byte[dimensionEsValida],'S'

dimInvalida:
    ret

validarIngreso:
    mov     byte[ingresoEsValido],'N'

    mov     rcx,elemento
    mov     rdx,elemFormat
    mov     r8,elementoNum
    sub     rsp,32
    call    sscanf
    add     rsp,32

    cmp     rax,1
    jl      ingresoInvalido

    cmp     word[elementoNum],-99
    jl      ingresoInvalido
    cmp     word[elementoNum],99
    jg      ingresoInvalido

    mov     byte[ingresoEsValido],'S'

ingresoInvalido:
    ret
calculoDesplaz:
    sub     rbx,rbx
    mov     bx,[fila]
    dec     bx
    imul    bx,2
    imul    bx,[coludimensionNum]
    mov     [desplaz],bx

    mov     bx,[columna]
    dec     bx
    imul    bx,2
    add     bx,[desplaz]
ret
printf_newLine:
    mov     rcx,newLine
    sub     rsp,32
    call    printf
    add     rsp,32
    mov     word[pivote],0
    
;mov     rcx,debug2
;mov     rdx,[matrizMostrada]
;sub     rsp,32
;call    printf
;add     rsp,32

    cmp     word[matrizMostrada],1
    je      imprimoUna
    cmp     word[matrizMostrada],2
    je      imprimoDos
    cmp     word[matrizMostrada],3
    je      imprimoTres
    cmp     word[matrizMostrada],4
    je      imprimoCuatro
    cmp     word[matrizMostrada],5
    je      imprimoCinco