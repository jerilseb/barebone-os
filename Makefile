build: os-image.bin
	@cp os-image.bin /mnt/c/Users/Jeril/Desktop

clean:
	@rm *.o *.bin

kernel.bin: kernel_entry.o kernel.o
	@ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel_entry.o: kernel-entry.asm
	@nasm $< -f elf64 -o $@

kernel.o: kernel.c
	@gcc -ffreestanding -c $< -o $@

bootsect.bin: main.asm
	@nasm $< -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	@cat $^ > $@
