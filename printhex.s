                .export         printhex
                .import         CHROUT
                .segment        "ZEROPAGE"
hexval:         .byte           0               ; temporary storage for the
                                                ; printhex routine

                .segment        "CODE"
printhex:       .scope
                pha
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
                pla
                rts
                .endscope

                .segment        "RODATA"
hexdigits:
                .byte           "0123456789ABCDEF"
