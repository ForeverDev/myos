all: boot.iso

kmain.bin:
	nasm -f bin -o kmain.bin kmain.s

boot.bin:
	nasm -f bin -o boot.bin boot.s

boot.iso: boot.bin kmain.bin
	dd conv=notrunc bs=512 if=boot.bin of=boot.iso
	dd conv=notrunc bs=512 seek=1 if=kmain.bin of=boot.iso
	qemu-system-i386 -fda boot.iso
	rm *.obj *.iso *.bin

clean:
	rm *obj *.iso *.bin

