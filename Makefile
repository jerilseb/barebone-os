build:
	@nasm -o main.bin main.asm
	@gcc -ffreestanding -c kernel.c -o kernel.o
	@ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
	@cat main.bin kernel.bin > os-image.bin
	@cp os-image.bin /mnt/c/Users/Jeril/Desktop

clean:
	@rm *.o *.bin
