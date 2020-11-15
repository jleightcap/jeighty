LCD_PORT:  equ 0
BEEP_PORT: equ 0
LED_PORT:  equ 0
LED_BIT:   equ 4
BEEP_BIT:  equ 5

org 0x0000
start:
        ; initialize PIO port A as output only
        ld A, 0x0f
        out (2), A
        call _LCD_init

        call 0
        halt

_LCD_init:
        ; LCD_PORT: {E, RS, x, x, data nibble}
        ; LCD function set: 4-bit mode
        ld A, %00000010
        call _LCD_send_byte
        ; LCD function set: 2 rows, 5x8 characters
        ld A, %00000010 ; 8b0010_10xx upper nibble (instruction select)
        call _LCD_send_byte
        ld A, %00001000 ; lower nibble
        call _LCD_send_byte
        ; LCD display control: turn on, blink, etc.
        ld A, %00000000 ; 8b0000_1111 upper nibble (insruction select)
        call _LCD_send_byte
        ld A, %00001111 ; lower nibble
        call _LCD_send_byte
        ret

; send byte (a control word) in register A to LCD
_LCD_send_byte:
        ; LCD register writes latch on rising edge of E (bit 7)
        ; load data with E low -> same data with E high -> same data with E low
        out (LCD_PORT), A
        ; bit 6 contains LCD register select
        set 7, A
        out (LCD_PORT), A
        res 7, A
        out (LCD_PORT), A
        ret
