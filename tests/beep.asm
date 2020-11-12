BEEP_PORT: equ 0
BEEP_LD_BIT: equ 4
BEEP_QT_BIT: equ 5


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

; pitch LOOP values
org 0x0000
start:
        ; initialize output mode for IO port A
        ld A, 0x0f
        out (2), A

    phase:
        ; pitch 1
        ld B, FIS4
        ld D, PT_FIS4
        call playfreq

        jp phase

        halt

; play a WAIT value for a number of cycles
; - pass WAIT value in B
; - pass number of cycles in D
playfreq:
        ld A, 0x00
    beep_loop:
        res BEEP_QT_BIT, A
        out (0), A
        ld C, B
    delay1:
        nop
        dec C
        jr nz, delay1
        set BEEP_QT_BIT, A
        out (0), A
        ld C, B
    delay2:
        nop
        dec C
        jr nz, delay2

        dec D
        jr nz, beep_loop

        ret
