#ifndef _KERNEL_SERIAL_H
#define _KERNEL_SERIAL_H

#include <stddef.h>
#include <sys/io.h>
#include <stdint.h>

int serial_initialize(void);
void serial_putchar(char c);
void serial_write(const char *data, size_t size);
void serial_writeline(const char *data);

#endif
