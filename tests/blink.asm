BEEP_PORT: equ 0
LED_BIT:   equ 4

org 0x0000
start:
        ; initialize output mode for IO port A
        ld A, 0x0f
        out (2), A

        ld A, 0x00
        set LED_BIT, A
        out (BEEP_PORT), A

        halt
