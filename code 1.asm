;---------------------------------------------------
; Name:
;
; Equation:
; result = (var1 + 2) / (var3 - var2)
;
; var1 = 8
; var2 = 2
; var3 = 7
; result = 2
;---------------------------------------------------

section .data
    var1    dd 8
    var2    dd 2
    var3    dd 7
    result  dd 0

    msg db "Result = "
    len equ $-msg

    nl db 10

section .bss
    digit resb 1

section .text
global _start

_start:

    ; numerator
    mov eax,[var1]
    add eax,2

    ; denominator
    mov ebx,[var3]
    sub ebx,[var2]

    ; prepare for division
    cdq

    ; EDX:EAX / EBX
    idiv ebx

    ; save quotient
    mov [result],eax

    ; print "Result = "
    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,len
    int 80h

    ; convert quotient to ASCII
    add byte [result],'0'

    mov eax,4
    mov ebx,1
    mov ecx,result
    mov edx,1
    int 80h

    ; newline
    mov eax,4
    mov ebx,1
    mov ecx,nl
    mov edx,1
    int 80h

    ; exit
    mov eax,1
    xor ebx,ebx
    int 80h
