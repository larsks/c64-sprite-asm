                .import         arrow,arrow_color,CINT
                .import         sprite0,color0,pos0x,pos0y,msbx,spenable

                .segment        "ZEROPAGE"
delayval:       .word           0

                .segment        "CODE"

main:           .scope
                jsr             CINT            ; clear the screen

                lda             #<(arrow/$40)   ; set sprite base address
                sta             sprite0

                lda             arrow_color     ; set sprite color
                sta             color0

                lda             #$01            ; enable sprite 1
                sta             spenable

                lda             #$80            ; set initial position
                sta             pos0x
                sta             pos0y

                ldy             #0
loop:           sty             pos0x

                lda             #$0f            ; delay between sprite movements
                sta             delayval        ; otherwise it zips by too quickly
                lda             #$ff
                sta             delayval+1
                jsr             delay

                iny
                bne             end
                lda             msbx
                eor             #$01
                sta             msbx
end:            jmp             loop
                .endscope

; @name delay
;
; generic delay loop. load iteration count into delayval.
delay:          .scope
                pha
                txa
                pha
                tya
                pha

                ldx             delayval+1
                ldy             delayval

loopx:          txa
                beq loopy
                dex
                jmp loopx

loopy:          tya
                beq end
                dey
                jmp             loopx

end:            pla
                tay
                pla
                tax
                pla
                rts
                .endscope
