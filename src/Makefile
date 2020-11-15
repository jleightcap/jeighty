ifeq (, $(shell which jal))
$(error "No jal executable! See https://github.com/jleightcap/jal")
endif

ROM = rom.bin # final ROM image
LBL = rom.lbl # includes for ROM definitions

# assembles in order, so make order explicit
SRCS = hi.jc
ASMS = blink.asm lcd.asm beep.asm
OBJS = $(SRCS:.jc=.jsm)

# function name entry point, called from BIOS
ENTR = helloworld

# colored messages
ALRT = \033[93m
ENDC = \033[0m\n

$(ROM): bios.jsm $(ASMS) $(OBJS)
	@printf "$(ALRT)assembling rom...$(ENDC)"
	z80asm $< $(ASMS) $(OBJS) -o /tmp/$@.raw
	@printf "$(ALRT)making rom image...$(ENDC)"
	python3 ../makerom.py /tmp/$@.raw $@ && rm /tmp/$@.raw

%.jsm: %.jc
	jal $< $@

$(LBL): bios.asm $(ASMS) $(OBJS)
	@printf "$(ALRT)generating rom label...$(ENDC)"
	z80asm -L $< $(ASMS) $(OBJS) -o /dev/null &> $(LBL)

bios.jsm: bios.asm $(LBL)
	@printf "$(ALRT)setting up BIOS entrypoint...$(ENDC)"
	sed 's/call 0/call $(shell awk '/$(ENTR)/ {print $$3}' $(LBL))/g' \
		$< > $@

upload: $(ROM)
	@printf "$(ALRT)uploading rom image...$(ENDC)"
	minipro -p AT28C256 -w $(ROM)

clean:
	rm -f *.jsm *.bin $(LBL)

.PHONY: clean upload
