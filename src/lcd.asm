; send char in register A to LCD
putc:
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
