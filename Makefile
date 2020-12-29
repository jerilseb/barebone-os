C_SOURCES = $(wildcard kernel/*.c)

OBJ = $(C_SOURCES:.c=.o)

CC = gcc
CFLAGS = -g

.PHONY: build clean

build: os-image.bin
	@cp $< /mnt/c/Users/Jeril/Desktop

os-image.bin: boot/bootsect.bin kernel.bin
	@cat $^ > $@

kernel.bin: boot/kernel-entry.o $(OBJ)
	@ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c
	$(CC) -ffreestanding -c $< -o $@

%.o: %.asm
	@nasm $< -f elf64 -o $@

%.bin: %.asm
	@nasm $< -f bin -o $@

clean:
	@rm -rf *.o *.bin
	@rm -rf boot/*.o boot/*.bin kernel/*.o kernel/*.bin

