
;2.	Realizar un programa en assembler Intel x86 que imprima por pantalla la siguiente frase: “El alumno [Nombre] [Apellido] de Padrón N° [Padrón] tiene [Edad] años para esto se debe solicitar 
;previamente el ingreso por teclado de: 
;•	Nombre y Apellido
;•	N° de Padrón
;•	Fecha de nacimiento

global main
extern puts
extern gets
extern printf

section     .data
    msjIngNombre       db  "Ingrese su nombre: ",0
    msjIngApellido     db  "Ingrese su apellido: ",0
    msjIngPadron       db  "Ingrese su padron: ",0
    msjIngEdad         db  "Ingrese su edad: ",0
    
    msjMuestNombr      db   "El alumno es %s",0
    msjMuestApell      db   " %s",0
    msjMuestPadron     db   " de padron Num %s",0
    msjMuestEdad       db   " tiene %s anios",0
    
section     .bss
    nombre      resb    200
    apellido    resb    200
    padron      resb    100
    edad        resb    20
    

section     .text
main:
;   ingreso nombre
    mov     rcx,msjIngNombre
    sub     rsp,32
    call    puts
    add     rsp,32

    mov     rcx,nombre
    sub     rsp,32
    call    gets
    add     rsp,32

    

;ingreso apellido
    mov     rcx,msjIngApellido
    sub     rsp,32
    call    puts
    add     rsp,32

    mov     rcx,apellido
    sub     rsp,32
    call    gets
    add     rsp,32

;ingreso padron
    mov     rcx,msjIngPadron
    sub     rsp,32
    call    puts
    add     rsp,32

    mov     rcx,padron
    sub     rsp,32
    call    gets
    add     rsp,32

;ingreso edad
    mov     rcx,msjIngEdad
    sub     rsp,32
    call    puts
    add     rsp,32

    mov     rcx,edad
    sub     rsp,32
    call    gets
    add     rsp,32

;muestro nombre
    mov     rcx,msjMuestNombr
    mov     rdx,nombre
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,msjMuestApell
    mov     rdx,apellido
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,msjMuestPadron
    mov     rdx,padron
    sub     rsp,32
    call    printf
    add     rsp,32

    mov     rcx,msjMuestEdad
    mov     rdx,edad
    sub     rsp,32
    call    printf
    add     rsp,32
