                .import         CHROUT
                .import         joyport1,potx,poty
                .import         println
                .import         printhex
                .import         newline
                .importzp       strbase

                .segment        "CODE"
                .scope
                ;
                ; mouse manual:
                ; https://www.commodore.ca/manuals/funet/cbm/manuals/1351-mouse.txt
                ; via https://www.c64-wiki.com/wiki/BIT_$hhll#Example_1
main:
                lda             potx
                jsr             printhex
                lda             #' '
                jsr             CHROUT
                lda             poty
                jsr             printhex
                jsr             newline

                lda             #%00010000
                bit             joyport1
                bne             main

                lda             #<msg_fire
                sta             strbase
                lda             #>msg_fire
                sta             strbase+1
                jsr             println

                jmp             main

                .endscope

msg_fire:       .asciiz         "FIRE!"
