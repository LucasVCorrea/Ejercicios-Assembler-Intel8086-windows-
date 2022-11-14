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
    mensajeElegMatrices db  "Ingrese que matrices quiere sumar (2 matrices) separadas por un espacio: ",0
    mensajeElegMatricesProducto db  "Ingrese que matrices quiere multiplicar (2 matrices) separadas por un espacio: ",0
    mensajeElegirTransp db  "Ingrese a que matriz quiere calcularle la traspuesta: ",0
    mensajeCambiarElem  db  "Ingrese de que matriz quiere modificar el elemento: ",0
    mensajeConsultElem  db  "Ingrese de que matriz quiere consultar el elemento: ",0
    mensajeIngPosicion  db  "Ingrese la posicion separada por un espacio: ",0
    mensajeIngresoNuevoValor    db    "Ingrese el nuevo valor a la matriz: ",0
        ;***Errores
    msjErrorDimension   db  "Dimension ingresada invalida. Vuelva a ingresar.",10,0
    msjErrorIngreso     db  "Ingreso invalido. El numero debe estar entre -99 y 99",10,0
    msjErrorCantidad    db  "Ingreso invalido. El numero debe estar entre 1 y 5",10,0
    msjErrorOpcion      db  "Ingreso invalido. La opcion debe ser una de las mostradas en pantalla. Vuelva a intenar.",10,0
    msjErrorMatNoExiste db  "Una de las matrices elegidas no fue completada. Solo se llenaron de 1 a %hi matrices",10,0
    msjErrorTrasp       db  "La matriz elegida no fue completada. Solo se llenaron de 1 a %hi matrices",10,0
    msjErrorPosicion    db  "La posicion ingresada es invalda. ",10,0
    mensajeNoCuadradas  db  "Las matrices ingresadas no son cuadradas. Esta opcion no esta disponible",10,0
        ;***Opciones
    msjOpciones         db  "======================================",10,"Opciones:",10," 1- suma de matrices ",10, 
                        db  " 2- producto de matrices",10," 3- mostrar la traspuesta",10," 4- modificar un elemento de la matriz",10,
                        db  " 5- consultar valor en una posicion",10," 6- terminar el programa",10,"======================================",0

    msjeIndicadorMatr   db  "Complete la matriz %hi",10,0
        ;***contadores por pantalla
    mensajeMatriz       db  "- - - - Matriz %hi - - - -",10,0
    mensajeMatrizResult db  "- - - - Resultado - - - -",10,0
    mensajeMatrizChange db  "- - - - Matriz %hi modificada - - - -",10,0
    mensajeMatrizTraspu db  "- - - - Matriz %hi traspuesta - - - -",10,0
    mensajeMatrizConsul db  "- - - - En la posicion [%hi][%hi] de la matriz %hi hay un %hi - - - -",10,0
    instanciaExito      db  "Se llego a esta instancia con exito",0

        ;***Mensajes constantes
    msjeTitutloOpcion   db  "Se eligio %s",10,0
    tituloSumaMatrices  db  "Suma de matrices",10,0
    tituloProducMatces  db  "Producto de matrices",10,0
    tituloHallarTransp  db  "Hallar la traspuesta de una matriz",10,0
    tituloModificarElem db  "Modificar elemento de una matriz",10,0
    tituloConsultarElem db  "Consultar valor en una posicion",10,0
    MENSAJEFINPROGRAMA  db  "Fin de programa",0
    ;------------------------------------------------------------------------------------------------------------------------
        ;***Debug y formats
    debug       db      " %hi ",0
    newLine     db      " ",10,0
    format      db      "%hi %hi",0
    elemFormat  db      "%hi",0
    pivote      dw  0
    debug2      db      "%hi",10,0
    cantidadFormat  db  "%hi",0
    format1     db  "%hi",0
        ;***Seccion de la matriz--------------------------------------------------------------------------------------------------
    fila        dw  1
    columna     dw  1
    traspuesta  times   64   dw  0
    matricesArmadas dw  1
    vectorMatrices  times   5   dq  0
    ;   ---------------------- **Seccion de la parte del producto
    filaProd1   dw  1
    coluProd1   dw  1
    filaProd2   dw  1
    coluProd2   dw  1
    celdasLlenas    dq  0
    contador    dw  0
    elementoProducto    dw  0
    
    ;   ----------------------
        ;***Cosas usadas para la pantalla------------------------------------------------------------------------------------------
    matrizMostrada  dw  1
    
section .bss
    filadimensionNumTras    resw    1
    coludimensionNumTras    resw    1
    cantidadMatricesNum     resw    1
    cantidadStr             resw    1
    desplaz                 resw    1
    desplazAlterno          resw    1
    desplazTrasp            resw    1
    dimensionStr            resb    10
    dimensionBytes          resw    1
    filadimensionNum        resw    1
    coludimensionNum        resw    1
    dimensionMatriz         resw    1
    auxiliarColumna         resw    1
    opcionElegida           resb    1
    opcionElegidaTexto      resb    100
    matricesElegidasStr     resw    10
    matrizElegidaStr        resw    10
    matrizEleg1             resw    10
    matrizEleg2             resw    10
    posicionCambiarStr      resw    10
    filaCambio              resw    1
    columnaCambio           resw    1
    nuevoElem               resw    10
    nuevoElementoNum        resw    10
    desplazProducto         resw    1
;-------------------------------------------------------------------------------------------------------------------------
    matrizA     times   64  resw    1
    matrizB     times   64  resw    1
    matrizC     times   64  resw    1
    matrizD     times   64  resw    1
    matrizE     times   64  resw    1
    matrizR     times   64  resw    1
    elemento    resw    10
    elementoNum resw    10
    finColumna  resw    1
    
    ;***Seccion para validaciones-------------------------------------------------------------------------------------------
    dimensionEsValida   resb    1
    ingresoEsValido     resb    1
    cantidadEsValida    resb    1
    opcionEsValida      resb    1
    estaEnVector        resb    1
    posicionEsValida    resb    1
    nuevoIngresoEsValido resb   1
    sonCuadradas        resb    1
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
    imul    ax,2
    mov     [dimensionBytes],ax
;mov     rcx,debug
;mov     rdx,[dimensionBytes]
;sub     rsp,23
;call    printf
;add     rsp,32

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
    je      almacenoMatrices            
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
errorOpcion:
    mov     rcx,msjErrorOpcion
    sub     rsp,32
    call    puts    
    add     rsp,32
    jmp     pidoOpcion
almacenoMatrices:
    sub     rax,rax

    cmp     word[matricesArmadas],1
    je      almacenoMatr1
    cmp     word[matricesArmadas],2
    je      almacenoMatr2
    cmp     word[matricesArmadas],3
    je      almacenoMatr3
    cmp     word[matricesArmadas],4
    je      almacenoMatr4
    cmp     word[matricesArmadas],5
    je      almacenoMatr5
sigMatriz:
    inc     word[matricesArmadas]
    mov     ax,word[cantidadMatricesNum]
    inc     ax
    cmp     word[matricesArmadas],ax
    je      finArmado

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


finArmado:
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
    repe    cmpsb   

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
    cmp     word[matrizMostrada],6  
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
    ;call    almacenarMatrices   ;---> guarda las matrices en el vector

;mov     rbx,[vectorMatrices + 0]

;mov     rcx,debug2
;mov     rdx,rbx
;sub     rsp,32
;call    printf
;add     rsp,32
;mov     rbx,[vectorMatrices + 8]

;mov     rcx,debug2
;mov     rdx,rbx
;sub     rsp,32
;call    printf
;add     rsp,32
;mov     rbx,[vectorMatrices + 16]

;mov     rcx,debug2
;mov     rdx,rbx
;sub     rsp,32
;call    printf
;add     rsp,32
;mov     rbx,[vectorMatrices + 24]

;mov     rcx,debug2
;mov     rdx,rbx
;sub     rsp,32
;call    printf
;add     rsp,32
;mov     rbx,[vectorMatrices + 32]

;mov     rcx,debug2
;mov     rdx,rbx
;sub     rsp,32
;call    printf
;add     rsp,32

    mov     rcx,msjOpciones
    sub     rsp,32
    call    puts
    add     rsp,32
pidoOpcion:
    mov     rcx,mensajeOpcion
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,opcionElegida
    sub     rsp,32
    call    gets
    add     rsp,32

    cmp     byte[opcionElegida],'1'
    je      sumarMatrices
    cmp     byte[opcionElegida],'2'
    je      productoDosMatrices
    cmp     byte[opcionElegida],'3'
    je      hallarTraspuesta
    cmp     byte[opcionElegida],'4'
    je      modificarElemento
    cmp     byte[opcionElegida],'5'
    je      consultarValor
    cmp     byte[opcionElegida],'6'
    je      endProg
    jmp     errorOpcion

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

almacenoMatr1:
    sub     rax,rax
    lea     rax,[matrizA]
    mov     [vectorMatrices + 0],rax
    jmp     sigMatriz
almacenoMatr2:
    sub     rax,rax
    lea     rax,[matrizB]
    mov     [vectorMatrices + 8],rax
    jmp     sigMatriz

almacenoMatr3:
    sub     rax,rax
    lea     rax,[matrizC]
    mov     [vectorMatrices + 16],rax
    jmp     sigMatriz

almacenoMatr4:
    sub     rax,rax
    lea     rax,[matrizD]
    mov     [vectorMatrices + 24],rax
    jmp     sigMatriz

almacenoMatr5:
    sub     rax,rax
    lea     rax,[matrizE]
    mov     [vectorMatrices + 32],rax
    jmp     sigMatriz

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
    
sumarMatrices:
    sub     rax,rax
    mov     rdx,tituloSumaMatrices
    call    printf_Titulo_Opcion
pedidoDeMatrices:
    mov     rdi,0

    mov     rcx,mensajeElegMatrices
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,matricesElegidasStr
    sub     rsp,32
    call    gets
    add     rsp,32

    call    validarMatricesEnVector
    cmp     byte[estaEnVector],'N'
    je      errorEleccionMatrices
    mov     rbx,[vectorMatrices + rax]
    mov     rdx,[vectorMatrices + rsi]
realizoSuma:

    cmp     di,[dimensionBytes]
    je      finSuma

    push    rax
    mov     rax,[rbx + rdi]
    add     rax,[rdx + rdi]
    mov     [matrizR + rdi],rax
    pop     rax
    add     rdi,2
    jmp     realizoSuma
finSuma:
    mov     rsi,0
    mov     word[pivote],0
    sub     rbx,rbx
    mov     bx,2
    imul    bx,word[dimensionMatriz]

    mov     rcx,mensajeMatrizResult
    sub     rsp,32
    call    printf
    add     rsp,32

muestroResultado:
    push    rsi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb   

    pop     rsi
    je      printf_newLine_Resultado

    cmp     rsi,rbx 
    je      gg

    mov     rcx,debug
    mov     rdx,[matrizR + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rsi,2
    add     word[pivote],1
    jmp     muestroResultado


hallarTraspuesta:
    mov     rdx,tituloHallarTransp
    call    printf_Titulo_Opcion

pedidoDeMatrizTransp:
    mov     rcx,mensajeElegirTransp
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,matrizElegidaStr
    sub     rsp,32
    call    gets
    add     rsp,32

    call    validarMatrizEnVector
    cmp     byte[estaEnVector],'N'
    je      errorEleccionMatriz

    sub     rax,rax
    sub     rbx,rbx
    sub     rcx,rcx
    mov     word[fila],1
    mov     word[columna],1

cambioFila:
    mov     bx,[filadimensionNum]
    inc     bx
    cmp     word[fila],bx
    je      cambioColumna

    mov     bx,[fila]
    dec     bx
    imul    bx,2
    imul    bx,[coludimensionNum]

    mov     [desplazTrasp],bx

    mov     bx,[columna]
    dec     bx
    imul    bx,2
    add     bx,[desplazTrasp]

    mov     ax,[matrizEleg1]
    dec     ax
    imul    ax,8
    mov     rsi,[vectorMatrices + rax]  

    mov     ax,[rsi + rbx]
    mov     [traspuesta + rcx],ax
    inc     word[fila]
    add     rcx,2    
    jmp     cambioFila
cambioColumna:
    mov     ax,2
    imul    ax,word[dimensionMatriz]
    cmp     cx,ax
    je      finArmadoTraspuesta
    inc     word[columna]
    mov     word[fila],1
    jmp     cambioFila
finArmadoTraspuesta:
    mov     rdi,0
    sub     rbx,rbx
    mov     bx,2
    imul    bx,word[dimensionMatriz]
 
    cmp     byte[opcionElegida],'6'
    je      terminarElPrograma

    mov     rcx,mensajeMatrizTraspu
    mov     rdx,[matrizEleg1]
    sub     rsp,32
    call    printf
    add     rsp,32
muestroTraspuesta:
    push    rdi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[filadimensionNum]
    repe    cmpsb   
    
    pop     rdi
    
    je      printf_newLine_Resultado

    cmp     rdi,rbx 
    je      gg

    mov     rcx,debug
    mov     rdx,[traspuesta + rdi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rdi,2
    add     word[pivote],1
    jmp     muestroTraspuesta

modificarElemento:
    mov     rdx,tituloModificarElem
    call    printf_Titulo_Opcion
pedirMatrizParaModificar:
    mov     rcx,mensajeCambiarElem
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,matrizElegidaStr
    sub     rsp,32
    call    gets
    add     rsp,32
    call    validarMatrizEnVector
    cmp     byte[estaEnVector],'N'
    je      errorEleccionMatriz
pedirPosicion:
    cmp     byte[opcionElegida],'6'
    je      terminarElPrograma
    mov     rcx,mensajeIngPosicion
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,posicionCambiarStr
    sub     rsp,32
    call    gets
    add     rsp,32

    call    validarPosicion
    cmp     byte[posicionEsValida],'N'
    je      errorPosicion
    cmp     byte[opcionElegida],'5'
    je      mostrarConsulta
pidoNuevoIngreso:
    sub     rsi,rsi
    mov     rcx,mensajeIngresoNuevoValor
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,elemento
    sub     rsp,32
    call    gets
    add     rsp,32
    
    call    validarIngreso
    cmp     byte[ingresoEsValido],'N'
    je      errorNuevoIngreso
    cmp     byte[opcionElegida],'6'
    je      terminarElPrograma
    sub     rbx,rbx
    sub     rcx,rcx
    mov     cx,[elementoNum]
    call    calculoDesplazAlterno
    sub     rax,rax
    mov     ax,[matrizEleg1]
    dec     ax
    imul    ax,8
    mov     rsi,[vectorMatrices + rax]  
    mov     [rsi + rbx],cx

    mov     rdi,0
    sub     rbx,rbx
    mov     bx,2
    imul    bx,word[dimensionMatriz]
    
    mov     rcx,mensajeMatrizChange
    mov     rdx,[matrizEleg1]
    sub     rsp,32
    call    printf
    add     rsp,32

muestroCambio:
    push    rsi
    push    rdi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb   
    
    pop     rdi
    pop     rsi
    
    je      printf_newLine_Resultado

    cmp     rdi,rbx 
    je      gg

    mov     rcx,debug
    mov     rdx,[rsi + rdi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rdi,2
    add     word[pivote],1
    jmp     muestroCambio

errorNuevoIngreso:
    mov     rcx,msjErrorIngreso
    sub     rsp,32
    call    puts
    add     rsp,32
    jmp     pidoNuevoIngreso

errorPosicion:
    mov     rcx,msjErrorPosicion
    sub     rsp,32
    call    puts
    add     rsp,32
    jmp     pedirPosicion

consultarValor:
    mov     rdx,tituloConsultarElem
    call    printf_Titulo_Opcion
pedirMatrizParaConsultar:
    mov     rcx,mensajeConsultElem
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,matrizElegidaStr
    sub     rsp,32
    call    gets
    add     rsp,32
    call    validarMatrizEnVector
    cmp     byte[estaEnVector],'N'
    je      errorEleccionMatriz
pidoPosicionConsulta:
    cmp     byte[opcionElegida],'6'
    je      terminarElPrograma
    mov     rcx,mensajeIngPosicion
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,posicionCambiarStr
    sub     rsp,32
    call    gets
    add     rsp,32

    call    validarPosicion
    cmp     byte[posicionEsValida],'N'
    je      errorPosicion
    cmp     byte[opcionElegida],'6'
    je      terminarElPrograma
    sub     rax,rax
    sub     rbx,rbx
    mov     ax,[filaCambio]
    mov     bx,[columnaCambio]
    mov     word[fila],ax
    mov     word[columna],bx
    call    calculoDesplaz
mostrarConsulta:
    sub     rax,rax
    mov     ax,[matrizEleg1]
    dec     ax
    imul    ax,8
    mov     rsi,[vectorMatrices + rax] 

    mov     rcx,mensajeMatrizConsul
    mov     rdx,[filaCambio]
    mov     r8,[columnaCambio]
    mov     r9,[rsi + rbx]
    push    r9
    mov     r9,[matrizEleg1]
    sub     rsp,32
    call    printf
    add     rsp,32
    pop     r9
    jmp     gg
;ACA
    ret

printf_Titulo_Opcion:
    mov     rcx,msjeTitutloOpcion
    mov     rdx,rdx
    sub     rsp,32
    call    printf
    add     rsp,32
ret
endProg:
    mov     rcx,MENSAJEFINPROGRAMA
    sub     rsp,32
    call    puts
    add     rsp,32
terminarElPrograma:
ret
validarMatricesEnVector:
    sub     rsi,rsi
    sub     rax,rax
    mov     byte[estaEnVector],'N'
    
    mov     rcx,matricesElegidasStr
    mov     rdx,format
    mov     r8,matrizEleg1
    mov     r9,matrizEleg2
    sub     rsp,32
    call    sscanf
    add     rsp,32

    cmp     rax,2
    jl      errorEleccionMatrices

    cmp     word[matrizEleg1],1
    jl      finValidarEnVector
    cmp     word[matrizEleg1],5
    jg      finValidarEnVector

    cmp     word[matrizEleg2],1
    jl      finValidarEnVector
    cmp     word[matrizEleg2],5
    jg      finValidarEnVector

    mov     ax,[matrizEleg1]
    dec     ax
    imul    ax,8
    cmp     qword[vectorMatrices + rax],0
    je      errorMatrizNoEsta

    mov     si,[matrizEleg2]
    dec     si
    imul    si,8
    cmp     qword[vectorMatrices + rsi],0
    je      errorMatrizNoEsta
    
    mov     byte[estaEnVector],'S'
    jmp     finValidarEnVector

validarMatrizEnVector:
    sub     rsi,rsi
    sub     rax,rax
    mov     byte[estaEnVector],'N'

    mov     rcx,matrizElegidaStr
    mov     rdx,format1
    mov     r8,matrizEleg1
    sub     rsp,32
    call    sscanf
    add     rsp,32

    cmp     rax,1
    jl      errorEleccionMatriz

    cmp     word[matrizEleg1],1
    jl      finValidarEnVector
    cmp     word[matrizEleg1],5
    jg      finValidarEnVector
    sub     rax,rax
    mov     ax,[matrizEleg1]
    dec     ax
    imul    ax,8
    cmp     qword[vectorMatrices + rax],0
    je      errorMatrizNoEsta2
    mov     byte[estaEnVector],'S'
    
finValidarEnVector:
ret
errorEleccionMatrices:
    mov     rcx,msjErrorCantidad
    sub     rsp,32
    call    puts
    add     rsp,32

    cmp     byte[opcionElegida],'2'
    je      pedidoMatricesProducto
    jmp     pedidoDeMatrices

errorEleccionMatriz:
    mov     rcx,msjErrorCantidad
    sub     rsp,32
    call    printf
    add     rsp,32
    cmp     byte[opcionElegida],'3'
    je      pedidoDeMatrizTransp
    cmp     byte[opcionElegida],'4'
    je      pedirMatrizParaModificar
    cmp     byte[opcionElegida],'5'
    je      pedirMatrizParaConsultar
    
errorMatrizNoEsta:
    mov     rcx,msjErrorMatNoExiste
    mov     rdx,[cantidadMatricesNum]
    sub     rsp,32
    call    printf
    add     rsp,32
    cmp     byte[opcionElegida],'2'
    je      pedidoMatricesProducto
    jmp     pedidoDeMatrices

printf_newLine_Resultado:
    mov     rcx,newLine
    sub     rsp,32
    call    printf
    add     rsp,32
    mov     word[pivote],0
    cmp     byte[opcionElegida],'1'
    je      muestroResultado
    cmp     byte[opcionElegida],'2'
    je      muestroMatrizResultadoProd
    cmp     byte[opcionElegida],'3'
    je      muestroTraspuesta
    cmp     byte[opcionElegida],'4'
    je      muestroCambio
    ret

errorMatrizNoEsta2:
    mov     rcx,msjErrorTrasp
    mov     rdx,[cantidadMatricesNum]
    sub     rsp,32
    call    printf
    add     rsp,32
    cmp     byte[opcionElegida],'3'
    je      pedidoDeMatrizTransp
    cmp     byte[opcionElegida],'4'
    je      pedirMatrizParaModificar
    cmp     byte[opcionElegida],'5'
    je      pedirMatrizParaConsultar
    
validarPosicion:
    mov     byte[posicionEsValida],'N'

    mov     rcx,posicionCambiarStr
    mov     rdx,format
    mov     r8,filaCambio
    mov     r9,columnaCambio
    sub     rsp,32
    call    sscanf
    add     rsp,32

    cmp     rax,2
    jl      posicionInvalida

    sub     rax,rax
    mov     ax,[filadimensionNum]
    cmp     word[filaCambio],1
    jl      posicionInvalida
    cmp     word[filaCambio],ax
    jg      posicionInvalida      

    mov     ax,[coludimensionNum]
    cmp     word[columnaCambio],1
    jl      posicionInvalida
    cmp     word[columnaCambio],ax
    jg      posicionInvalida  
    mov     byte[posicionEsValida],'S'

posicionInvalida:
    ret
calculoDesplazAlterno:
    sub     rbx,rbx
    mov     bx,[filaCambio]
    dec     bx
    imul    bx,2
    imul    bx,[coludimensionNum]
    mov     [desplazAlterno],bx

    mov     bx,[columnaCambio]
    dec     bx
    imul    bx,2
    add     bx,[desplazAlterno]
    ret
productoDosMatrices:
    mov     rdx,tituloProducMatces
    call    printf_Titulo_Opcion
    call    evaluarCuadradas
    cmp     byte[sonCuadradas],'N'
    je      errorNoSonCuadradas
    mov     rdi,0

pedidoMatricesProducto:
   ; mov     rdi,0

    mov     rcx,mensajeElegMatricesProducto
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,matricesElegidasStr
    sub     rsp,32
    call    gets
    add     rsp,32

    call    validarMatricesEnVector
    cmp     byte[estaEnVector],'N'
    je      errorEleccionMatrices
realizoProducto:
    mov     qword[elementoProducto],0
    sub     rbx,rbx
    sub     rdx,rdx

    mov     rdx,[vectorMatrices + rax]  ;tratar de usar rbx y rdx como en la suma
    mov     r8,[vectorMatrices + rsi]   ;posible bug por estar usando el r8

CalcDesplazamientoProd:

    sub     rax,rax
    mov     ax,[coludimensionNum]
    inc     ax
    cmp     word[coluProd1],ax   
    je      copioCeldaEnMatrizResultado

    mov     ax,[coludimensionNum]
    cmp     qword[celdasLlenas],rax
    je      bajoFilaProducto

    mov     ax,[dimensionBytes]
    cmp     rdi,rax      
    je      muestroResultadoProducto

    mov     bx,[filaProd1]
    dec     bx
    imul    bx,[coludimensionNum]
    imul    bx,2
    mov     [desplazProducto],bx

    mov     bx,[coluProd1]
    dec     bx
    imul    bx,2
    add     bx,[desplazProducto]

    mov     ax,[filaProd2]
    dec     ax
    imul    ax,[coludimensionNum]
    imul    ax,2
    mov     [desplazAlterno],ax

    mov     ax,[coluProd2]
    dec     ax
    imul    ax,2
    add     ax,[desplazAlterno]

;mov     rcx,debug
;mov     rdx,[r8 + rax]
;sub     rsp,32
;call    printf
;add     rsp,32
    mov     rcx,[rdx + rbx]
    imul    rcx,[r8 + rax]
    add     [elementoProducto],rcx

    inc     word[coluProd1]
    inc     word[filaProd2]
    pop     rcx
    jmp     CalcDesplazamientoProd
copioCeldaEnMatrizResultado:
    mov     ax,[elementoProducto]
    mov     [matrizR + rdi],ax
    add     rdi,2   ;por la word
    inc     qword[celdasLlenas]
    mov     word[coluProd1],1
    mov     word[filaProd2],1
    inc     word[coluProd2]
    mov     word[elementoProducto],0
    jmp     CalcDesplazamientoProd
bajoFilaProducto:
    mov     word[elementoProducto],0

    inc     word[filaProd1]
    mov     word[coluProd1],1
    mov     word[coluProd2],1
    mov     word[filaProd2],1
    mov     rsi,0
    mov     qword[celdasLlenas],0
    jmp     CalcDesplazamientoProd
muestroResultadoProducto:
    cmp     byte[opcionElegida],'6'
    je      terminarElPrograma
    mov     rcx,mensajeMatrizResult
    sub     rsp,32
    call    printf
    add     rsp,32
;esto esta bien, ver que onda que solo acepta 2 o 3 pasadas 
    mov     word[coluProd1],1
    mov     word[coluProd2],1
    mov     word[filaProd1],1
    mov     word[filaProd2],1
    
    
muestroMatrizResultadoProd:
    push    rsi
    mov     rcx,2
    lea     rsi,[pivote]
    lea     rdi,[coludimensionNum]
    repe    cmpsb   

    pop     rsi
    je      printf_newLine_Resultado

    cmp     si, [dimensionBytes]
    je      gg

    mov     rcx,debug
    mov     rdx,[matrizR + rsi]
    sub     rsp,32
    call    printf
    add     rsp,32

    add     rsi,2
    add     word[pivote],1
    jmp     muestroMatrizResultadoProd

evaluarCuadradas:
    mov     byte[sonCuadradas],'S'
    mov     ax,[coludimensionNum]
    mov     bx,[filadimensionNum]
    cmp     ax,bx
    je      cuadradasOk
    mov     byte[sonCuadradas],'N'

cuadradasOk:
    ret
errorNoSonCuadradas:
    mov     rcx,mensajeNoCuadradas
    sub     rsp,32
    call    puts
    add     rsp,32
    jmp     gg