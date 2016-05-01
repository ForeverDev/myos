void kmain() {
	for (int i = 0; i < 100; i++) {
		*((char *)0xb8000 + i) = 0;
	}
}
