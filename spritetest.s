                .import         arrow,arrow_color,CINT
                .import         sprite0,color0,pos0x,pos0y,msbx

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
                jsr             delay
                iny
                bne             end
                lda             msbx
                eor             #$01
                sta             msbx
end:            jmp             loop
                .endscope

delay:          .scope
                ldx             #$ff
                dex
                beq             end
                jmp             delay
end:            rts
                .endscope
