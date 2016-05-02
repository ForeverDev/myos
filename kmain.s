BITS 16

mov	ax, 0xb800
mov	es, ax

mov [es:0x0], byte 'A'
mov [es:0x1], byte 0x07
