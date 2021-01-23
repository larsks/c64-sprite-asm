; Abuse macros to permit printing strings with a single statement.

CHROUT          =               $FFD2           ; Output a character
TIMER           =               $A2

                .segment        "ZEROPAGE"

strbase:        .word           0               ; stores base address of string
                                                ; for println routine

                .segment        "CODE"

                .macro          println string  ; take the string argument and
                                                ; create a label for it in
                                                ; RODATA section, then call
                                                ; println.
                .local          _str
                .local          _print

                .segment        "RODATA"
_str:           .asciiz         string

                .segment        "CODE"
_print:         lda             #<_str          ; setup for the _println
                sta             strbase         ; subroutine
                lda             #>_str
                sta             strbase+1
                jsr             _println
                .endmacro

start:          println         "THIS IS A TEST."
                println         "THANK YOU FOR PLAYING."

end:            jmp end

_println:       .scope
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
