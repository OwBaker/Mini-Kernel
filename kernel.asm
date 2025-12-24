bits 32                             ;sets nasm to 32 bit
section .text                       ;denotes start of code
    ;multiboot spec
    align 4                         ;
    ;dd defines a doubleword that's 4 bytes
    dd 0x1BADB002                   ;magic field which identifies the header
    dd 0x00                         ;flags field that we don't need (so its set to 0)
    dd - (0x1BADB002 + 0x00)        ;checksum field that when added to the other two fields must equal zero

global start                        ;sets symbols from source code as global
extern kmain

;define a function called "start"
start:
    cli                             ;disables interrupts for when we halt the cpu
    mov esp, stack_space            ;moves the stack pointer (esp) to point at the stack (uses the label created in line 16)
    call kmain                      ;call the kernel function
    hlt                            ;halts the cpu

section .bss
resb 8192                           ;reserves 8kb of memory for the stack
stack_space:                        ;sets a label which points to the edge of the reserved memory