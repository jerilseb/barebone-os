#include "../drivers/screen.h"
#include "util.h"

void main() {
    clear_screen();

    /* Fill up the screen */
    int i = 0;
    for (i = 0; i < 10; i++) {
        char str[255];
        int_to_ascii(i, str);
        kprint_at(str, 0, i);
    }

    kprint("\nThis is a line\n");
    kprint("\nThis is another line!\n\n");

    isr_install();
    /* Test the interrupts */
    __asm__ __volatile__("int $2");
    __asm__ __volatile__("int $3");
}
