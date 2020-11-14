ledon:
        ld A, 0x00
        set LED_BIT, A
        out (LED_PORT), A
        ret
