start:
        ; initialize output mode for IO port A
        ld A, 0x0f
        out (2), A

        ; PORTA: {E, RS, x, x, data nibble}
        ; LCD functions latch on rising edge of E
        ; load data with E low -> same data with E high -> same data with E low

        ; LCD function set: 4-bit mode
        ld A, %00000010 ; 4b0010 (instruction select)
        out (0), A
        ld A, %10000010 ; toggle E on
        out (0), A
        ld A, %00000010 ; toggle E off
        out (0), A

        ; LCD function set: 2 rows, 5x8 characters
        ld A, %00000010 ; 8b0010_10xx upper nibble (instruction select)
        out (0), A
        ld A, %10000010 ; toggle E on
        out (0), A
        ld A, %00000010 ; toggle E off
        out (0), A
        ld A, %00001000 ; lower nibble
        out (0), A
        ld A, %10001000 ; toggle E on
        out (0), A
        ld A, %00001000 ; toggle E off
        out (0), A

        ; LCD display control: turn on, blink, etc.
        ld A, %00000000 ; 8b0000_1111 upper nibble (insruction select)
        out (0), A
        ld A, %10000000 ; toggle E on
        out (0), A
        ld A, %00000000 ; toggle E off
        out (0), A
        ld A, %00001111 ; lower nibble
        out (0), A
        ld A, %10001111 ; toggle E on
        out (0), A
        ld A, %00001111 ; toggle E off
        out (0), A

        ; LCD display an 'H'
        ld A, %01000100 ; 8b0100_1000 upper nibble (data select)
        out (0), A
        ld A, %11000100 ; toggle E on
        out (0), A
        ld A, %01000100 ; toggle E off
        out (0), A
        ld A, %01001000 ; lower nibble
        out (0), A
        ld A, %11001000 ; toggle E on
        out (0), A
        ld A, %01001000 ; toggle E off
        out (0), A

        ; LCD display an 'I'
        ld A, %01000100
        out (0), A
        ld A, %11000100
        out (0), A
        ld A, %01000100
        out (0), A
        ld A, %01001001
        out (0), A
        ld A, %11001001
        out (0), A
        ld A, %01001001
        out (0), A
