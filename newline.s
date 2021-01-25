                .export         newline
                .import         CHROUT

                .segment        "CODE"
newline:        .scope
                lda             #$0d            ; send <cr>
                jsr             CHROUT
                lda             #$0a            ; send <lf>
                jsr             CHROUT
                lda             #0
                rts
                .endscope
