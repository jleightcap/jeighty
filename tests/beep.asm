BEEP_PORT: equ 0
BEEP_LD_BIT: eq 4
BEEP_QT_BIT: eq 5

org 0x0000
start:
        ; initialize output mode for IO port A
        ld A, 0x0f
        out (2), A

        ; (BEEP_PORT) = {x, x, BEEP_QT_BIT, BEEP_LD_BIT, x, x, x, x}
        ; this port is shared with the LCD! have to be careful not to have
        ; a rising edge on bit 7, as this will latch data into LCD registers.

        ; in this example, all the bit sets/resets would be faster by and/or a
        ; mask however, this is only the case when both beepers need an update
        ; on the same `out` ; doesn't save many clock cycles to do 2 `set`s or
        ; `res`s so just save an edge case and don't bother.

        ld A, 0x00
    beep_loop:
        res BEEP_LD_BIT, A
        res BEEP_QT_BIT, A
        out (0), A
        ; delay for delay for B * sum[C(delay1)] clock cycles
        ld B, 0x4f
    delay1:
        nop
        djnz delay1
        set BEEP_LD_BIT, A
        set BEEP_QT_BIT, A
        out (BEEP_PORT), A
        ; delay for delay for B * sum[C(delay2)] clock cycles
        ld B, 0x4f
    delay2:
        nop
        djnz delay2
        jp beep_loop
        halt
