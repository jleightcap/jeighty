ROM = rom.bin # final ROM image
LBL = rom.lbl # includes for ROM definitions

# assembles in order, so make order explicit
SRCS = hi.jc
ASMS = blink.asm lcd.asm beep.asm
OBJS = $(SRCS:.jc=.jsm)

# function name entry point, called from BIOS
ENTR = helloworld

$(ROM): bios.jsm $(ASMS) $(OBJS)
	@echo "assembling rom..."
	z80asm $< $(ASMS) $(OBJS) -o /tmp/$@.raw
	@echo "making rom image..."
	python ../makerom.py /tmp/$@.raw $@ && rm /tmp/$@.raw

%.jsm: %.jc
	jal $< $@

$(LBL): bios.asm $(ASMS) $(OBJS)
	@echo "generating rom labels..."
	z80asm -L $< $(ASMS) $(OBJS) -o /dev/null &> $(LBL)

bios.jsm: bios.asm $(LBL)
	@echo "setting up BIOS entrypoint..."
	sed 's/call 0/call $(shell awk '/$(ENTR)/ {print $$3}' $(LBL))/g' \
		$< > $@

upload: $(ROM)
	@echo "uploading rom image..."
	minipro -p AT28C256 -w $(ROM)

clean:
	rm -f *.jsm *.bin $(LBL)

.PHONY: clean upload
