## Barebone OS

A bare bone operating system written in C and Assemlby following the great book https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf

Build the disk image

```
make os-image.bin
```

Load the image into qemu and start the kernel

```
qemu-system-i386.exe -fda os-image.bin
```
