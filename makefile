all: boot.bin

kmain.obj:
	gcc kmain.c -o kmain.obj -c -std=c11

boot.obj:
	nasm -f bin -o boot.bin boot.s

boot.bin: boot.obj
	dd conv=notrunc bs=512 count=1 if=boot.bin of=boot.flp
	"C:\Program Files\qemu\qemu-system-x86_64.exe" -fda boot.flp


clean:
	rm *.obj *.flp
