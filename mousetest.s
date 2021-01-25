                .import         CHROUT,PLOT,CINT
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
main:           jsr             CINT                    ; clear the screen

loop:           ldx             #0                      ; set cursor position to top left
                ldy             #0
                jsr             PLOT
                lda             potx                    ; print out potx value
                jsr             printhex
                lda             #' '
                jsr             CHROUT
                lda             poty                    ; print out poty value
                jsr             printhex
                jsr             newline

                lda             #%00010000              ; check if fire button is down
                bit             joyport1
                bne             nofire

fire:           lda             #<msg_fire              ; print "FIRE!" message
                sta             strbase
                lda             #>msg_fire
                sta             strbase+1
                jsr             println
                jmp             loop

nofire:         lda             #<msg_nofire            ; erase "FIRE!" message
                sta             strbase
                lda             #>msg_nofire
                sta             strbase+1
                jsr             println
                jmp             loop

                .endscope

msg_fire:       .asciiz         "FIRE!"
msg_nofire:     .asciiz         "     "
