bits 32                             ;sets nasm to 32 bit
section .text                       ;denotes start of code

global start                        ;sets symbols from source code as global
extern kmain

;define a function called "start"
start:
    cli                             ;disables interrupts for when we halt the cpu
    mov esp, stack_space            ;moves the stack pointer (esp) to point at the stack (uses the label created in line 16)
    call kmain                      ;call the kernel function
    halt                            ;halts the cpu

section .bss
resb 8192                           ;reserves 8kb of memory for the stack
stack_space:                        ;sets a label which points to the edge of the reserved memory