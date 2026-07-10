# midterm
Given
result=
(var3−var2)
(var1+2)
	​


Choose values that divide evenly.

var1 = 8
var2 = 2
var3 = 7

result = (8 + 2) / (7 - 2)
       = 10 / 5
       = 2
NASM x86 Assembly
; --------------------------------------------
; result = (var1 + 2) / (var3 - var2)
;
; var1 = 8
; var2 = 2
; var3 = 7
; result = 2
; --------------------------------------------

section .data
    var1    dd 8
    var2    dd 2
    var3    dd 7
    result  dd 0

    output  db "Result = "
    outlen  equ $-output

    newline db 10

section .bss
    digit resb 1

section .text
    global _start

_start:

    ; numerator = var1 + 2

    mov eax,[var1]
    add eax,2

    ; denominator = var3 - var2

    mov ebx,[var3]
    sub ebx,[var2]

    ; divide

    cdq
    idiv ebx

    ; quotient -> result

    mov [result],eax

    ; Display "Result = "

    mov eax,4
    mov ebx,1
    mov ecx,output
    mov edx,outlen
    int 80h

    ; Convert quotient to ASCII

    add byte [result],'0'

    mov eax,4
    mov ebx,1
    mov ecx,result
    mov edx,1
    int 80h

    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 80h

    mov eax,1
    xor ebx,ebx
    int 80h
Register Table

For the chosen values:

10 ÷ 5

Quotient = 2
Remainder = 0
Register	Value
EAX	2 (Quotient)
EDX	0 (Remainder)
GDB Verification

After the idiv ebx instruction:

(gdb) info registers eax edx

eax            0x2
edx            0x0

Take a screenshot showing those registers.

Question 2

Given

Y=a.b+a
′
.b+a.b
′
K-Map
a\b	0	1
0	0	1
1	1	1
Group 1
a'b
ab

Simplifies to

b
Group 2
ab'
ab

Therefore

Y=a+b

Question 3
Design

Goal:

Determine whether a number is odd or even without using AND or OR.

Thought Process

A number is:

Even if the remainder after division by 2 is 0.
Odd if the remainder after division by 2 is 1.

Since AND/OR cannot be used, divide the number by 2 using IDIV. The remainder is stored in EDX. Compare the remainder with 0:

EDX = 0 → even
EDX ≠ 0 → odd
Assembly Code
section .data
    number db 13

    evenMsg db "even number",10
    evenLen equ $-evenMsg

    oddMsg db "odd number",10
    oddLen equ $-oddMsg

section .text
    global _start

_start:

    mov al,[number]
    cbw
    cwd

    mov bl,2

    idiv bl

    cmp ah,0
    jne odd

even:

    mov eax,4
    mov ebx,1
    mov ecx,evenMsg
    mov edx,evenLen
    int 80h
    jmp finish

odd:

    mov eax,4
    mov ebx,1
    mov ecx,oddMsg
    mov edx,oddLen
    int 80h

finish:

    mov eax,1
    xor ebx,ebx
    int 80h
Example Output

If:

number db 13

Output:

odd number

If:

number db 20

Output:

even number
