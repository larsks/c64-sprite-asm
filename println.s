                .export         println
                .exportzp       strbase
                .import         CHROUT
                .segment        "ZEROPAGE"
strbase:        .word           0

                .segment        "CODE"
println:        .scope
                ldy             #0              ; loop over string pointed to by
loop:           lda             (strbase),y     ; strbase
                beq             end             ; exit on terminal 0
                jsr             CHROUT
                iny
                jmp             loop

end:            lda             #$0d            ; send <cr>
                jsr             CHROUT
                lda             #$0a            ; send <lf>
                jsr             CHROUT
                lda             #0
                rts
                .endscope
