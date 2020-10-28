%.bin: %.asm
	z80asm $< -o $@.raw
	python makerom.py $@.raw $@
	rm $@.raw

# F=[rom file] make upload
upload:
	minipro -p AT28C256 -w $(F)

clean:
	rm -f *.bin*

.PHONY: upload clean
