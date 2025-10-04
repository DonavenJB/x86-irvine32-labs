

Paper View
; 3.Simple Addition (1)
;Author: Donaven Bruce

.386
.model flat,stdcall
.stack 4096

; Including the Irvine32 library for I/O operations and utilities
include Irvine32.inc

.data
    first_integer_prompt BYTE "Enter the first integer: ",0
    second_integer_prompt BYTE "Enter the second integer: ",0
    sum_result_message BYTE "Sum: ",0
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
    ; Using WriteString from Irvine library to output first_integer_prompt
    mov edx, OFFSET first_integer_prompt  ; EDX is the designated register for passing string address to WriteString
    call WriteString
    call ReadInt  ; Using ReadInt from Irvine library to obtain user input, value is returned in EAX
    mov first_user_input_integer, eax  ; Storing the value

    ; Outputting a new line using Crlf from Irvine library
    call Crlf

    ; Prompting for the second integer
    ; Using WriteString from Irvine library to output second_integer_prompt
    mov edx, OFFSET second_integer_prompt  ; EDX for the address of string
    call WriteString
    call ReadInt  ; Reading integer, value in EAX
    mov second_user_input_integer, eax  ; Storing the value

    ; Addition operation
    mov eax, first_user_input_integer
    add eax, second_user_input_integer
    mov sum_of_user_input_integers, eax  ; Storing the sum

    ; Outputting a new line using Crlf from Irvine library
    call Crlf

    ; Displaying the result
    ; Using WriteString from Irvine library to output sum_result_message
    mov edx, OFFSET sum_result_message  ; EDX is the designated register for passing string address to WriteString
    call WriteString
    mov eax, sum_of_user_input_integers  ; EAX is the designated register for passing integer value to WriteInt
    call WriteInt  ; Using WriteInt from Irvine library to output sum

    ; Wait for a key press before exiting, to view result before exiting
    call WaitMsg

    ; Invoking ExitProcess for program termination
    invoke ExitProcess, 0

main ENDP
END main



; 4.  Simple Addition (2)

; Author: Donaven Bruce

.386
.model flat,stdcall
.stack 4096

; Including the Irvine32 library for I/O operations and utilities
include Irvine32.inc

.data
    first_integer_prompt BYTE "Enter the first integer: ",0
    second_integer_prompt BYTE "Enter the second integer: ",0
    sum_result_message BYTE "Sum: ",0
    first_user_input_integer DWORD ?
    second_user_input_integer DWORD ?
    sum_of_user_input_integers DWORD ?
    loop_counter DWORD 3  ; Set loop counter to 3 

.code
main PROC

    ; ClrScr from Irvine library to clear screen
    call ClrScr

    ; Resetting cursor position to the middle of the screen using Gotoxy from Irvine library
    mov eax, 12  ; row
    mov ecx, 30  ; col
    call Gotoxy

    start_loop:  

    ; Prompting for the first integer
    ; Using WriteString from Irvine library to output first_integer_prompt
    mov edx, OFFSET first_integer_prompt  ; EDX is the designated register for passing string address to WriteString
    call WriteString
    call ReadInt  ; Using ReadInt from Irvine library to obtain user input, value is returned in EAX
    mov first_user_input_integer, eax  ; Storing the value

    ; Outputting a new line using Crlf from Irvine library
    call Crlf

    ; Prompting for the second integer
    ; Using WriteString from Irvine library to output second_integer_prompt
    mov edx, OFFSET second_integer_prompt  ; EDX for the address of string
    call WriteString
    call ReadInt  ; Reading integer, value in EAX
    mov second_user_input_integer, eax  ; Storing the value

    ; Addition operation
    mov eax, first_user_input_integer
    add eax, second_user_input_integer
    mov sum_of_user_input_integers, eax  ; Storing the sum

    ; Outputting a new line using Crlf from Irvine library
    call Crlf

    ; Displaying the result
    ; Using WriteString from Irvine library to output sum_result_message
    mov edx, OFFSET sum_result_message  ; EDX is the designated register for passing string address to WriteString
    call WriteString
    mov eax, sum_of_user_input_integers  ; EAX is the designated register for passing integer value to WriteInt
    call WriteInt  ; Using WriteInt from Irvine library to output sum

    ; Outputting a new line using Crlf from Irvine library - to move to next line before WaitMsg
    call Crlf

    ; Wait for a key press before continuing, to view result before screen clears for next iteration
    call WaitMsg

    ; ClrScr from Irvine library to clear screen before next loop iteration
    call ClrScr

    ; Resetting cursor position to the middle of the screen using Gotoxy from Irvine library
    mov eax, 12  ; row
    mov ecx, 30  ; col
    call Gotoxy

    ; Reduce the loop counter by 1
    dec loop_counter
    jnz start_loop  ; If loop_counter is not zero, go back to start_loop

    ; Invoking ExitProcess for program termination
    invoke ExitProcess, 0

main ENDP
END main

