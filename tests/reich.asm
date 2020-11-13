BEEP_PORT: equ 0
BEEP_BIT:  equ 5


; PITCH FREQUENCY VALUES:
; ======================
; 'tuned' values based on square wave implementation
E4:   equ 74
FIS4: equ 65
B4:   equ 49
CIS5: equ 43
D5:   equ 41

; PITCH TIMING LOOP VALUES
; ========================
; timed relative to the highest frequency (D5).
; based on rouneded equal-tempered A440, not the approximated tuning above
; - good: poorly done tuning doesn't affect timing too much
; - bad: timing will never be perfect, can't approximate these frequencies well
PT_MAX: equ 90
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
        ld B, E4 ; pitch 1
        ld D, PT_E4
        call playfreq

        ld B, FIS4 ; pitch 2
        ld D, PT_FIS4
        call playfreq

        ld B, B4 ; pitch 3
        ld D, PT_B4
        call playfreq

        ld B, CIS5 ; pitch 4
        ld D, PT_CIS5
        call playfreq

        ld B, D5 ; pitch 5
        ld D, PT_D5
        call playfreq

        ld B, E4 ; pitch 6
        ld D, PT_E4
        call playfreq

        ld B, FIS4 ; pitch 7
        ld D, PT_FIS4
        call playfreq

        ld B, CIS5 ; pitch 8
        ld D, PT_CIS5
        call playfreq

        ld B, B4 ; pitch 9
        ld D, PT_B4
        call playfreq

        ld B, E4 ; pitch 10
        ld D, PT_E4
        call playfreq

        ld B, D5 ; pitch 11
        ld D, PT_D5
        call playfreq

        ld B, CIS5 ; pitch 12
        ld D, PT_CIS5
        call playfreq

        jp phase

        halt ; ...how did you get here?

; play a WAIT value for a number of cycles
; - pass WAIT value in B
; - pass number of cycles in D
playfreq:
        ld A, 0x00
    beep_loop:
        res BEEP_BIT, A
        out (BEEP_PORT), A
        ld C, B
    delay1:
        nop
        dec C
        jr nz, delay1
        set BEEP_BIT, A
        out (BEEP_PORT), A
        ld C, B
    delay2:
        nop
        dec C
        jr nz, delay2

        dec D
        jr nz, beep_loop

        ret
