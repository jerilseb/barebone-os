#include "../drivers/screen.h"
#include "../drivers/ports.h"

void main() {
    clear_screen();

    print_char('Z', 4, 4, WHITE_ON_BLACK);
    kprint_at("This text spans multiple lines", 75, 10);
    // kprint_at("There is a line\nbreak", 0, 20);
    // kprint("There is a line\nbreak");
    // kprint_at("What happens when we run out of space?", 45, 24);
}
