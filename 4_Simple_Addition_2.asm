; 4. Simple Addition (2)
; Author: Donaven Bruce

.386
.model flat,stdcall
.stack 4096

; Including the Irvine32 library for I/O operations and utilities
include Irvine32.inc

.data
    first_integer_prompt BYTE "Enter the first integer: ",0
    second_integer_prompt BYTE "Enter the second integer: ",0
    sum_result_message  BYTE "Sum: ",0
    first_user_input_integer DWORD ?
    second_user_input_integer DWORD ?
    sum_of_user_input_integers DWORD ?
    loop_counter DWORD 3  ; Set loop counter to 3

.code
main PROC

    ; ClrScr from Irvine library to clear screen
    call ClrScr

    ; Reset cursor position using Gotoxy
    mov eax, 12  ; row
    mov ecx, 30  ; col
    call Gotoxy

start_loop:

    ; Prompt for the first integer
    mov edx, OFFSET first_integer_prompt
    call WriteString
    call ReadInt
    mov first_user_input_integer, eax

    ; New line
    call Crlf

    ; Prompt for the second integer
    mov edx, OFFSET second_integer_prompt
    call WriteString
    call ReadInt
    mov second_user_input_integer, eax

    ; Addition
    mov eax, first_user_input_integer
    add eax, second_user_input_integer
    mov sum_of_user_input_integers, eax

    ; New line
    call Crlf

    ; Display result
    mov edx, OFFSET sum_result_message
    call WriteString
    mov eax, sum_of_user_input_integers
    call WriteInt

    ; New line before wait
    call Crlf

    ; Pause, then clear and reset cursor for next iteration
    call WaitMsg
    call ClrScr
    mov eax, 12
    mov ecx, 30
    call Gotoxy

    ; Decrement loop counter and repeat if not zero
    dec loop_counter
    jnz start_loop

    ; Exit
    invoke ExitProcess, 0

main ENDP
END main
