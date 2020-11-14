ROM  = rom.bin # final ROM image
LBL  = rom.lbl # includes for ROM definitions

SRCS = $(wildcard *.jc)
OBJS = $(SRCS:.jc=.jsm)
# order matters!
ASMS = blink.asm lcd.asm beep.asm
# function name entry point, called from BIOS
ENTR = helloworld

$(ROM): bios.jsm $(ASMS) $(OBJS)
	@echo "assembling rom..."
	z80asm bios.jsm $(ASMS) $(OBJS) -o /tmp/$@.raw
	@echo "making rom image..."
	python ../makerom.py /tmp/$@.raw $@ && rm /tmp/$@.raw

%.jsm: %.jc
	jal $< $@

bios.jsm: bios.asm
	@echo "generating rom labels..."
	z80asm -L $^ $(ASMS) $(OBJS) -o /dev/null 2> $(LBL)
	sed 's/; ENTRYPOINT/call $(shell awk '/$(ENTR)/ {print $$3}' $(LBL))/g' \
		$^ > $@

upload: $(ROM)
	@echo "uploading rom image..."
	minipro -p AT28C256 -w $(ROM)

clean:
	rm -f *.jsm *.bin $(LBL)

.PHONY: clean upload enter
