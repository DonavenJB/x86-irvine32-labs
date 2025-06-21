TITLE Subtract Three Integers         ; Prog title shown in debugger or list file

INCLUDE Irvine32.inc                  ; Incl Irvine32 lib for macros and procs

.data                                 ; Start data seg

    num1    WORD    07D0h             ; First int val 07D0h = 2000 dec
    num2    WORD    0320h             ; Second int val 0320h = 800 dec
    num3    WORD    0190h             ; Third int val 0190h = 400 dec

.code                                 ; Start code seg

main PROC                             ; Main proc entry

    xor  eax, eax                     ; Clear EAX reg (init to 0)

    mov  ax, num1                     ; Load AX with num1 val

    sub  ax, num2                     ; Sub num2 from AX → AX = num1 - num2

    sub  ax, num3                     ; Sub num3 from AX → AX = result - num3

    call DumpRegs                     ; Show all CPU reg vals for debug

    invoke ExitProcess, 0            ; Term prog and return 0 status to OS

main ENDP                             ; End of main proc

END main                              ; Set prog entry point for linker
