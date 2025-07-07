; Author: Donaven Bruce
; Purpose:
;   Collect N (5) temperatures from the user, validate each (0–100),
;   track min, max, count > 50, and compute/display the average.

.386
.model flat,stdcall
.stack 4096
include Irvine32.inc

.data
    ; ---- Messages ----
    msg_prompt_temp               BYTE "Enter temperature number ",0
    temp_entry_index              BYTE "1",0               ; (unused in logic, preserved)
    msg_invalid_range             BYTE "Invalid entry. Temperature must be within the range of 0 to 100 degrees.",0
    msg_avg                       BYTE "Average temperature is: ",0
    msg_min                       BYTE "The minimum recorded temperature is: ",0
    msg_max                       BYTE "The maximum recorded temperature is: ",0
    msg_over_50_count             BYTE "Number of recorded temperatures exceeding fifty degrees: ",0

    ; ---- Data ----
    temps                         DWORD 5 DUP(?)           ; stores the 5 inputs
    sum_temps                     DWORD 0
    count_over_50                 DWORD 0
    avg_temp                      DWORD 0
    min_temp                      DWORD 100
    max_temp                      DWORD 0
    input_count                   DWORD 5                  ; total inputs to collect

.code
main PROC
    ; ECX: remaining inputs
    ; ESI: index into temps[]
    mov ecx, input_count
    mov esi, 0

InputLoop:
    ; Show ordinal (as in original code: writes AL, not a printable digit)
    mov eax, esi
    add eax, 1
    call WriteChar

    ; Prompt for temperature
    mov edx, OFFSET msg_prompt_temp
    call WriteString

    ; Read and validate input: 0..100
    call ReadInt
    cmp eax, 0
    jl  InvalidInput
    cmp eax, 100
    jg  InvalidInput

    ; Store valid value and update aggregates
    mov [temps + esi*4], eax
    add sum_temps, eax

    ; Count temps strictly over 50
    cmp eax, 50
    jle NotOverFifty
    inc count_over_50

NotOverFifty:
    ; Track min
    cmp eax, min_temp
    jge NotNewMin
    mov min_temp, eax
NotNewMin:
    ; Track max
    cmp eax, max_temp
    jle NotNewMax
    mov max_temp, eax
NotNewMax:

    ; Next slot
    inc esi
    loop InputLoop

    ; Done reading -> compute/display results
    jmp CalculateAverage

InvalidInput:
    ; Display invalid entry message and retry same index
    mov edx, OFFSET msg_invalid_range
    call WriteString
    jmp InputLoop

CalculateAverage:
    ; avg_temp = sum_temps / input_count
    mov eax, sum_temps
    cdq
    div input_count
    mov avg_temp, eax

    ; Output metrics
    mov edx, OFFSET msg_avg
    call WriteString
    mov eax, avg_temp
    call WriteInt
    call Crlf

    mov edx, OFFSET msg_min
    call WriteString
    mov eax, min_temp
    call WriteInt
    call Crlf

    mov edx, OFFSET msg_max
    call WriteString
    mov eax, max_temp
    call WriteInt
    call Crlf

    mov edx, OFFSET msg_over_50_count
    call WriteString
    mov eax, count_over_50
    call WriteInt
    call Crlf

    invoke ExitProcess, 0
main ENDP
END main
