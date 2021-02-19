CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

MACH=cortex-m3
CFLAGS= -c -mcpu=$(MACH) -mthumb -std=gnu11 -Wall -g -O0
LDFLAGS= -T stm32_ls.ld -nostdlib -Wl,-Map=blinky.map

all: blinky.bin

blinky.bin: blinky.elf
	$(OBJCOPY) -O binary $^ $@

blinky.elf: blinky.o delay.o led.o stm32_startup.o
	$(CC) $(LDFLAGS) -o $@ $^

flash: all
	#st-flash write blinky.bin 0x08000000
	$(HOME)/.arduino15/packages/stm32duino/tools/stm32tools/2021.2.9/linux/stm32flash/stm32flash -g 0x8000000 -b 19200 -w blinky.bin /dev/ttyUSB0

reset:
	st-flash reset

clean:
	rm -f *.o *.elf *.bin *.map
