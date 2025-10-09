; Author: Donaven Bruce
; CS118 x86 MASM
; Read a line, null-terminate; flip case; count words and vowels.

.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc

ExitProcess PROTO STDCALL :DWORD

.data
msg_prompt         BYTE "Enter a sentence: ",0
msg_word_count     BYTE 0Dh,0Ah,"The number of words in the input string is: ",0
msg_output_str     BYTE 0Dh,0Ah,"The output string is: ",0
msg_vowel_count    BYTE 0Dh,0Ah,"The number of vowels is: ",0

input_buf          BYTE 256 DUP(?)
input_len          DWORD ?
word_count         DWORD ?
vowel_count        DWORD ?
in_word_flag       DWORD ?

.code
main PROC
    ; prompt + read
    mov edx, OFFSET msg_prompt
    call WriteString
    mov edx, OFFSET input_buf
    mov ecx, SIZEOF input_buf
    call ReadString
    mov input_len, eax

    ; null-terminate
    mov ecx, input_len
    mov BYTE PTR input_buf[ecx], 0

    ; init
    mov word_count, 0
    mov vowel_count, 0
    mov in_word_flag, 0
    mov esi, OFFSET input_buf

char_loop:
    mov al, [esi]
    cmp al, 0
    je done_loop

    ; lower -> upper
    cmp al, 'a'
    jb check_upper
    cmp al, 'z'
    ja check_upper
    sub al, 32
    mov [esi], al
    jmp vowel_check

check_upper:
    ; upper -> lower
    cmp al, 'A'
    jb skip_flip
    cmp al, 'Z'
    ja skip_flip
    add al, 32
    mov [esi], al

skip_flip:

vowel_check:
    mov al, [esi]
    or  al, 00100000b
    cmp al, 'a'
    je  found_vowel
    cmp al, 'e'
    je  found_vowel
    cmp al, 'i'
    je  found_vowel
    cmp al, 'o'
    je  found_vowel
    cmp al, 'u'
    jne check_delim

found_vowel:
    mov eax, vowel_count
    inc eax
    mov vowel_count, eax

check_delim:
    mov al, [esi]
    cmp al, ' '
    je  is_delim
    cmp al, 9
    je  is_delim
    cmp al, 0Dh
    je  is_delim
    cmp al, 0Ah
    je  is_delim

    ; start of a new word
    mov eax, in_word_flag
    cmp eax, 1
    je  next_char
    mov eax, word_count
    inc eax
    mov word_count, eax
    mov in_word_flag, 1
    jmp next_char

is_delim:
    mov in_word_flag, 0

next_char:
    inc esi
    jmp char_loop

done_loop:
    mov edx, OFFSET msg_word_count
    call WriteString
    mov eax, word_count
    call WriteDec

    mov edx, OFFSET msg_output_str
    call WriteString
    mov edx, OFFSET input_buf
    call WriteString

    mov edx, OFFSET msg_vowel_count
    call WriteString
    mov eax, vowel_count
    call WriteDec
    call Crlf

    INVOKE ExitProcess, 0
main ENDP

END main
