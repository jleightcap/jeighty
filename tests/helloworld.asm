org 0x0000
start:
        ; initialize output mode for IO port A
        ld A, 0x0f
        out (2), A

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

        ; print "Hello, world!"
        ld A, 'H'
        call _LCD_send_char
        ld A, 'e'
        call _LCD_send_char
        ld A, 'l'
        call _LCD_send_char
        ld A, 'l'
        call _LCD_send_char
        ld A, 'o'
        call _LCD_send_char
        ld A, ','
        call _LCD_send_char
        ld A, ' '
        call _LCD_send_char
        ld A, 'w'
        call _LCD_send_char
        ld A, 'o'
        call _LCD_send_char
        ld A, 'r'
        call _LCD_send_char
        ld A, 'l'
        call _LCD_send_char
        ld A, 'd'
        call _LCD_send_char
        ld A, '!'
        call _LCD_send_char

        halt

LCD_PORT: equ 0

; send byte in register A to LCD
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

; send char in register A to LCD
_LCD_send_char:
        ; B stores lower nibble, A stores upper nibble
        ld B, A
        and A, 0x0f
        srl B ; shift over upper nibble
        srl B
        srl B
        srl B
        set 6, A ; select LCD data register
        set 6, B
        ; send upper nibble
        ld C, LCD_PORT ; IO port immediates only supported for A register
        out (C), B
        set 7, B
        out (C), B
        res 7, B
        out (C), B
        ; send lower nibble
        out (LCD_PORT), A
        set 7, A
        out (LCD_PORT), A
        res 7, A
        out (LCD_PORT), A
        ret
