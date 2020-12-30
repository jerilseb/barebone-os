[org 0x7c00] ; bootloader offset
    KERNEL_OFFSET equ 0x1000
    mov [BOOT_DRIVE], dl

    mov bp, 0x9000 ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print ; This will be written after the BIOS messages
    call print_nl

    call load_kernel

    call switch_to_pm
    jmp $ ; this will actually never be executed

%include "boot/16-bit-print.asm"
%include "boot/gdt.asm"
%include "boot/32-bit-print.asm"
%include "boot/32-bit-switch.asm"
%include "boot/disk-load.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; What address to load at
    mov dh, 4 ; how many sectors to read
    mov dl, [BOOT_DRIVE]

    call load_disk
    ret

[bits 32]
BEGIN_PM: ; after the switch we will get here
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Note that this will be written at the top left corner
    call KERNEL_OFFSET
    jmp $

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading the kernel", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55
