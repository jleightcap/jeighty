start:
        ; initialize output mode for both registers
        ld A, 0x0f ; output mode, 00xx1111 p 209
        out (2), A ; lowest two bits are {D/C} {A/B}, bit 2 == control register
        out (3), A ; lowest two bits are {D/C} {A/B}, bit 2 == control register
        ; flash A
        ld A, 1
        out (0), A ; 0 == data A register
        ld A, 0
        out (0), A ; 0 == data A register
        ; flash B
        ld A, 1
        out (1), A ; 0 == data A register
        ld A, 0
        out (1), A ; 0 == data A register
        ; jump to start
        jp start
