helloworld:
        ; print "Hello world!"
        ld A, 'H'
        call putc
        ld A, 'e'
        call putc
        ld A, 'l'
        call putc
        ld A, 'l'
        call putc
        ld A, 'o'
        call putc
        ld A, ','
        call putc
        ld A, ' '
        call putc
        ld A, 'w'
        call putc
        ld A, 'o'
        call putc
        ld A, 'r'
        call putc
        ld A, 'l'
        call putc
        ld A, 'd'
        call putc
        ld A, '!'
        call putc


        halt
