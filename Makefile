%.bin: %.asm
	z80asm $@ $<

upload:
	minipro -p AT28C256 -w rom.bin
