; This code uses the TIMER variable at $A2, which is increments 60 times
; per second.

CHROUT          =               $FFD2           ; Output a character
TIMER           =               $A2

                .segment        "ZEROPAGE"

strbase:        .word           0

                .segment        "CODE"

                .macro          println addr    ; macro that handles necesary
                lda             #<addr          ; setup for the _println
                sta             strbase         ; subroutine
                lda             #>addr
                sta             strbase+1
                jsr             _println
                .endmacro

start:          println         s_start
                
                lda             #$01            ; TIMER increments every 1/60th of
                sta             TIMER           ; a second, so set it to
                                                ; ($FF - delay). This means the
                                                ; max value is $01.

loop:           lda             TIMER           ; check timer value
                beq             end             ; go to end if timer == 0
                jmp             loop

end:            println         s_end
                jmp             start

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

                .segment        "RODATA"

s_start:        .asciiz         "STARTING TIMER TEST"
s_end:          .asciiz         "TIMER EXPIRED"
