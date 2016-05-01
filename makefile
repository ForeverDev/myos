all: boot.flp

kmain.bin:
	nasm -f bin -o kmain.bin kmain.s

boot.bin:
	nasm -f bin -o boot.bin boot.s

boot.flp: boot.bin kmain.bin
	dd conv=notrunc bs=512 if=boot.bin of=boot.flp
	dd conv=notrunc bs=512 seek=1 if=kmain.bin of=boot.flp
	"C:\Program Files\qemu\qemu-system-x86_64.exe" -fda boot.flp


clean:
	rm *.obj *.flp *.bin
