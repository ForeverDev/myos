BITS 16 

global start
start:
	; initialize bootloader and stack
	mov		ax, 0x07C0
	add		ax, 288
	mov		ss, ax
	mov		sp, 0x1000
	mov		ax, 0x07C0
	mov		ds, ax

	jmp 	kernel_load

kernel_load:
	mov		si, k_load
	call	print
	
	mov		ax, 0x07C0
	mov		ds, ax
	mov		ah, 2
	mov		al, 1
	push	word 0x1000
	pop		es
	xor		bx, bx
	mov		cx, 2
	mov		dx, 0
	int		0x13

	jnc		.kjump
	mov		si, k_fail
	call	print
	hlt

.kjump:
	mov		si, k_succ
	call	print
	jmp		0x1000:0
	
	hlt

data:
	k_load	db "Initializing Kernel...", 10, 0
	k_succ	db "Kernel loaded successfully!", 10, 0
	k_fail	db "Kernel failed to load!", 10, 0

print:
	mov		ah, 0x0E
.printchar:
	lodsb
	cmp		al, 0
	je		.done
	int		0x10
	jmp		.printchar
.done:
	ret

times 510-($-$$) db 0
dw 0xAA55
