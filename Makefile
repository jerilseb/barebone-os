C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)

OBJ = $(C_SOURCES:.c=.o cpu/interrupt.o)

CC = @gcc
CFLAGS = -g -m32 -fno-pie

.PHONY: build clean debug

build: os-image.bin
	@cp $< /mnt/c/Users/Jeril/Desktop

# For debugging, launch qemu before running this
debug: kernel.elf
	gdb -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

os-image.bin: boot/bootsect.bin kernel.bin
	@cat $^ > $@

kernel.bin: boot/kernel-entry.o $(OBJ)
	@ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# For debugging
kernel.elf: boot/kernel-entry.o $(OBJ)
	@ld -o $@ -Ttext 0x1000 $^

%.o: %.c
	$(CC) $(CFLAGS) -ffreestanding -c $< -o $@

%.o: %.asm
	@nasm $< -f elf32 -o $@

%.bin: %.asm
	@nasm $< -f bin -o $@

clean:
	@rm -rf *.o *.bin *.elf
	@rm -rf boot/*.o boot/*.bin kernel/*.o drivers/*.o cpu/*.o libc/*.o

