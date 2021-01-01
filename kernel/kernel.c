#include "../drivers/screen.h"
#include "util.h"
#include "../cpu/timer.h"

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

    asm volatile("sti");
    // init_timer(10);
    /* Comment out the timer IRQ handler to read
     * the keyboard IRQs easier */
    init_keyboard();
}
