ROM  = rom.bin # final ROM image
LBL  = rom.lbl # includes for ROM definitions

SRCS = $(wildcard *.jc)
OBJS = $(SRCS:.jc=.jsm)
ASMS = $(wildcard *.asm)

$(ROM): $(ASMS) $(OBJS)
	@echo "assembling rom..."
	z80asm -L $(ASMS) $(OBJS) -o /tmp/$@.raw &> $(LBL)
	@echo "making rom image..."
	python ../makerom.py /tmp/$@.raw $@ && rm /tmp/$@.raw

upload: $(ROM)
	@echo "uploading rom image..."
	minipro -p AT28C256 -w $(ROM)

%.jsm: %.jc
	jal $< $@

clean:
	rm -f *.jsm *.bin $(LBL)

.PHONY: clean upload
