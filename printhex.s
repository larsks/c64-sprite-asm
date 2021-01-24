                .import         CHROUT

                .segment        "ZEROPAGE"

hexval:         .byte           0

                .segment        "CODE"

                ldx             #0
loop:           lda             example,x
                jsr             printhex
                inx
                cpx             #4
                bne loop

end:            rts

example:        .byte           $CA,$FE,$BA,$BE

printhex:       .scope
                sta             hexval          ; preserve value in a

                txa                             ; save x to stack, since we're
                pha                             ; going to use it in this routine

                lda             hexval          ; retrieve saved value
                ror                             ; shift the high nybble down
                ror
                ror
                ror
                and             #%00001111      ; mask out the high nubble
                tax
                lda             hexdigits,x     ; get char from hexdigits cable
                jsr             CHROUT          ; and print it

                lda             hexval          ; repeat for low nybble
                and             #%00001111
                tax
                lda             hexdigits,x
                jsr             CHROUT

                pla
                tax
                rts
                .endscope

                .segment        "RODATA"
hexdigits:
                .byte           "0123456789ABCDEF"
