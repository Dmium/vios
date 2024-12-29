#include <stdio.h>

#include <kernel/tty.h>
#include <kernel/serial.h>

void kernel_main(void)
{
	terminal_initialize();
	serial_initialize();
	printf("Hello, kernel World!\n");
	serial_writeline("Serial hello world!");
}
