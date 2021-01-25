; mouse manual:
; https://www.commodore.ca/manuals/funet/cbm/manuals/1351-mouse.txt

                .import         CHROUT,PLOT,CINT
                .import         joyport1,potx,poty
                .import         println
                .import         printhex
                .import         newline
                .importzp       strbase

                .segment        "CODE"
                .scope

; ======================================================================
;
                ; print the label, noise bit, and position from a pot register
                ; at the current screen position
                .macro          printpot label,addr
                lda             #label
                jsr             CHROUT
                lda             #' '
                jsr             CHROUT

                lda             addr
                and             #%00000001              ; mask out everything but noise bit
                jsr             printhex
                lda             #' '
                jsr             CHROUT

                lda             addr                    ; print position
                ror                                     ; discard noise bit
                and             #%00111111
                jsr             printhex
                jsr             newline
                .endmacro

                ; wrapper for println routine that takes care of setup
                .macro          _println addr
                lda             #<addr
                sta             strbase
                lda             #>addr
                sta             strbase+1
                jsr             println
                .endmacro

                ; move cursor to given screen position
                .macro          setpos row,col
                clc                                     ; request set position
                ldx             #row
                ldy             #col
                jsr             PLOT
                .endmacro

; ======================================================================

main:           jsr             CINT                    ; clear the screen

loop:           setpos          0,0                     ; set cursor position to top left

                printpot        'X',potx
                printpot        'Y',poty

checkleft:      setpos          2,0

                lda             #%00010000              ; check if left button is down
                bit             joyport1
                bne             leftup

leftdown:       _println        msg_leftdown            ; print "LEFT!" message
                jmp             checkright

leftup:         _println        msg_leftup              ; erase "LEFT!" message

checkright:     setpos          3,0
                lda             #1
                bit             joyport1
                bne             rightup

rightdown:      _println        msg_rightdown           ; print "RIGHT!" message
                jmp             end

rightup:        _println        msg_rightup             ; erase "RIGHT!" message

end:            jmp loop

; ======================================================================

                .endscope

                .segment        "RODATA"

msg_leftdown:   .asciiz         "LEFT!"
msg_leftup:     .asciiz         "     "
msg_rightdown:  .asciiz         "RIGHT!"
msg_rightup:    .asciiz         "      "
