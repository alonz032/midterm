section .data

number db 13

evenMsg db "even number",10
evenLen equ $-evenMsg

oddMsg db "odd number",10
oddLen equ $-oddMsg

section .text
global _start

_start:

    ; load number
    mov al,[number]

    ; prepare AX
    mov ah,0

    ; divide by 2
    mov bl,2
    div bl

    ; AH contains remainder
    cmp ah,0
    je EVEN

ODD:

    mov eax,4
    mov ebx,1
    mov ecx,oddMsg
    mov edx,oddLen
    int 80h
    jmp EXIT

EVEN:

    mov eax,4
    mov ebx,1
    mov ecx,evenMsg
    mov edx,evenLen
    int 80h

EXIT:

    mov eax,1
    xor ebx,ebx
    int 80h
