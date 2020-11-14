; PITCH FREQUENCY VALUES
; ======================
E4:   equ 74
FIS4: equ 65
B4:   equ 49
CIS5: equ 43
D5:   equ 41

; PITCH TIMING LOOP VALUES
; ========================
; timed relative to the highest frequency (D5).
PT_MAX: equ 160
PT_FRQ: equ 587
PT_E4:   equ 330 * PT_MAX / PT_FRQ
PT_FIS4: equ 370 * PT_MAX / PT_FRQ
PT_B4:   equ 493 * PT_MAX / PT_FRQ
PT_CIS5: equ 554 * PT_MAX / PT_FRQ
PT_D5:   equ 587 * PT_MAX / PT_FRQ

; play a WAIT value for a number of cycles
; - pass WAIT value in B
; - pass number of cycles in D
playfreq:
        ld A, 0x00
    beep_loop:
        res BEEP_BIT, A
        out (0), A
        ld C, B
    delay1:
        nop
        dec C
        jr nz, delay1
        set BEEP_BIT, A
        out (0), A
        ld C, B
    delay2:
        nop
        dec C
        jr nz, delay2

        dec D
        jr nz, beep_loop

        ret
