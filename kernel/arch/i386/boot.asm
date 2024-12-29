%include "arch/i386/constants.asm"
; Declare constants for the multiboot header.
MBALIGN  equ  1 << 0            ; align loaded modules on page boundaries
MEMINFO  equ  1 << 1            ; provide memory map
MBFLAGS  equ  MBALIGN | MEMINFO ; this is the Multiboot 'flag' field
MAGIC    equ  0x1BADB002        ; 'magic number' lets bootloader find the header
CHECKSUM equ -(MAGIC + MBFLAGS)   ; checksum of above, to prove we are multiboot

section .multiboot
align 4
	dd MAGIC
	dd MBFLAGS
	dd CHECKSUM
    
section .bss
align 16
stack_bottom:
resb 16384 ; 16 KiB
stack_top:
align 4096
gdt_null:
resb 8
gdt_code:
resb 8
gdt_data:
resb 8
gdt_user_code:
resb 8
gdt_user_data:
resb 8
gdt_end:

section .data
align 4096
gdt_desc:
    dw gdt_end - gdt_null ;for size
    dd gdt_null ;for offset

section .text
global _start:function (_start.end - _start)
_start:
	mov esp, stack_top

	extern _init
	call _init

	;;GDT Stuff
	extern gdt_setup
    cli ; No Interrupts during gdt things
    ;push gdt pointers to stack
    push gdt_user_data
    push gdt_user_code
    push gdt_data
    push gdt_code
    push gdt_null
	call gdt_setup
	lgdt [gdt_desc]
	call reload_segments

	extern kernel_main
	call kernel_main
	cli
.hang:	hlt
	jmp .hang
.end:

reload_segments:
	jmp KERNEL_CS:reload_CS;
reload_CS:
	; Reload data segment registers
		mov ax, KERNEL_DS ; 0x10 points at the new data selector
		mov ds, ax
		mov es, ax
		mov fs, ax
		mov gs, ax
		mov ss, ax
		ret
