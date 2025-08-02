;author: Donaven Bruce

.386
.model flat,stdcall
.stack 4096
include Irvine32.inc

.data
    msg_first_int   BYTE "Enter the first integer: ",0
    msg_second_int  BYTE "Enter the second integer: ",0
    msg_gcd         BYTE "GCD: ",0
    num_first       DWORD ?
    num_second      DWORD ?
    gcd_value       DWORD ?

.code
main PROC
    call ClrScr
    mov  eax, 12
    mov  ecx, 30
    call Gotoxy

    ; first integer
    mov  edx, OFFSET msg_first_int
    call WriteString
    call ReadInt
    mov  num_first, eax

    call Crlf

    ; second integer
    mov  edx, OFFSET msg_second_int
    call WriteString
    call ReadInt
    mov  num_second, eax

    ; calc gcd
    mov  eax, num_first
    mov  ebx, num_second
    call gcd_proc
    mov  gcd_value, eax

    call Crlf

    ; show result
    mov  edx, OFFSET msg_gcd
    call WriteString
    mov  eax, gcd_value
    call WriteInt

    invoke ExitProcess, 0
main ENDP

; gcd (euclid)
gcd_proc PROC
    push ebp
    mov  ebp, esp

    ; make inputs positive
    mov  eax, num_first
    call abs_proc
    mov  num_first, eax

    mov  eax, num_second
    call abs_proc
    mov  num_second, eax

    ; run euclid
    mov  eax, num_first
    mov  ebx, num_second
gcd_loop:
    mov  edx, 0
    div  ebx
    mov  eax, ebx
    mov  ebx, edx
    test ebx, ebx
    jnz  gcd_loop

    pop  ebp
    ret
gcd_proc ENDP

; abs in eax
abs_proc PROC
    cmp eax, 0
    jge abs_done
    neg eax
abs_done:
    ret
abs_proc ENDP

END main
