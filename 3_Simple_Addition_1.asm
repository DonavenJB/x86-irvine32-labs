; 3. Simple Addition (1)
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

.code
main PROC

    ; ClrScr from Irvine library to clear screen
    call ClrScr

    ; Resetting cursor position to the middle of the screen using Gotoxy from Irvine library
    mov eax, 12  ; row
    mov ecx, 30  ; col
    call Gotoxy

    ; Prompting for the first integer
    mov edx, OFFSET first_integer_prompt
    call WriteString
    call ReadInt
    mov first_user_input_integer, eax

    ; New line
    call Crlf

    ; Prompting for the second integer
    mov edx, OFFSET second_integer_prompt
    call WriteString
    call ReadInt
    mov second_user_input_integer, eax

    ; Addition operation
    mov eax, first_user_input_integer
    add eax, second_user_input_integer
    mov sum_of_user_input_integers, eax

    ; New line
    call Crlf

    ; Displaying the result
    mov edx, OFFSET sum_result_message
    call WriteString
    mov eax, sum_of_user_input_integers
    call WriteInt

    ; Wait for a key press before exiting
    call WaitMsg

    ; Exit
    invoke ExitProcess, 0

main ENDP
END main
