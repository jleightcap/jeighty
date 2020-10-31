%.bin: %.asm
	z80asm $< -o /tmp/$@.raw
	python makerom.py /tmp/$@.raw $@
	rm /tmp/$@.raw

# F=[rom file] make upload
upload:
	minipro -p AT28C256 -w $(F)

clean:
	rm -f *.bin*

.PHONY: upload clean
