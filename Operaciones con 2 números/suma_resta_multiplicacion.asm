global main
extern puts
extern printf
extern sscanf
extern gets

section .data
    mensajePrimerIngreso   db  "Ingrese el primer numero: ",0
    mensajeSegundoIngreso  db  "Ingrese el segundo numero: ",0
    numFormat              db   "%lli",0
    msjResultadoSuma       db   "La suma de %lli y %lli = %lli",0
    msjResultadoResta      db   "La resta de %lli y %lli = %lli",0
    msjResultadoMultiplicacion  db  "La multiplicacion de %lli y %lli = %lli",0
    saltoDeLinea           db    " ",0

section .bss
    string  resb 100
    numero1  resq 1
    numero2  resq 1
    resultadoSuma  resq 1
    resultadoResta resq 1
    resultadoMultiplicacion resq 1
    
section .text
main:
;Pedido numero 1
    mov rcx,mensajePrimerIngreso
    sub rsp,32
    call puts
    add rsp,32

;Obtencion numero 1
    mov rcx,string
    sub rsp,32
    call gets
    add rsp,32

;pasaje numero 1
    mov rcx, string
    mov rdx, numFormat
    mov r8, numero1
    sub rsp,32
    call sscanf
    add rsp,32

;Pedido numero 2
    mov rcx,mensajeSegundoIngreso
    sub rsp,32
    call   puts
    add    rsp,32

;Obtencion numero 2
    mov rcx,string
    sub rsp,32
    call gets
    add rsp,32

;pasaje numero 2
    mov rcx, string
    mov rdx, numFormat
    mov r8, numero2
    sub rsp,32
    call sscanf
    add rsp,32

;suma numero 1 con numero 2
    mov rax, [numero1]
    mov rbx, [numero2]
    add rax,rbx
    mov [resultadoSuma],rax

;resto numero 1 con numero 2
    mov rax, [numero1]
    mov rbx, [numero2]
    sub rax,rbx
    mov [resultadoResta],rax

;multiplico numero 1 con numero 2
    mov rax, [numero1]
    mov rbx, [numero2]
    imul rax,rbx
    mov [resultadoMultiplicacion],rax


;imprimo suma
    mov rcx,msjResultadoSuma
    mov rdx, [numero1]
    mov r8,[numero2]
    mov r9, [resultadoSuma]
    sub rsp,32
    call printf
    add rsp,32
    
    ;tratar de reemplazar esto
    mov rcx,saltoDeLinea
    sub rsp,32
    call puts
    add rsp,32

;imprimo resta
    mov rcx,msjResultadoResta
    mov rdx, [numero1]
    mov r8,[numero2]
    mov r9, [resultadoResta]
    sub rsp,32
    call printf
    add rsp,32

;tratar de reemplazar esto
    mov rcx,saltoDeLinea
    sub rsp,32
    call puts
    add rsp,32

;imprimo multiplicacion
    mov rcx, msjResultadoMultiplicacion
    mov rdx, [numero1]
    mov r8, [numero2]
    mov r9, [resultadoMultiplicacion]
    sub rsp,32
    call printf
    add rsp,32
    ret
