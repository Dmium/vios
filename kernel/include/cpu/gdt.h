#ifndef _CPU_GDT_H
#define _CPU_GDT_H

#include <stddef.h>
#include <stdint.h>

void gdt_setup(uint64_t *nullentry, uint64_t *codeentry, uint64_t *dataentry, uint64_t *usercodeentry, uint64_t *userdataentry);

#endif
