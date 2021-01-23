israddr         =               $0314


                .segment        "ZEROPAGE"

oldisr:         .addr           0               ; store address of original isr
counter:        .byte           0

                .segment        "CODE"

                sei                             ; disable interrupts

                lda             israddr         ; store address of original
                sta             oldisr          ; isr in oldisr
                lda             israddr+1
                sta             oldisr+1

                lda             #<myisr         ; load address of our isr routine
                sta             israddr         ; into israddr
                lda             #>myisr
                sta             israddr+1

                lda             $01
                sta             counter

                cli                             ; enable interrupts

end:            rts


myisr:          .scope
                pha                             ; preserve registers we modify
                txa
                pha

                ldx counter
                dex
                bne continue
                inc $D021
                ldx #$3C                        ; $3C = 60, so update background
                                                ; once every 60 seconds

continue:       stx counter
                pla
                tax
                pla
                jmp (oldisr)
                .endscope
