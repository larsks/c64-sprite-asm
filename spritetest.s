                .import sp_arrow,sp_arrow_color,CINT

sprite0         =       $07F8
sprite1         =       $07F9
sprite2         =       $07FA
sprite3         =       $07FB
sprite4         =       $07FC
sprite5         =       $07FD
sprite6         =       $07FE
sprite7         =       $07FF 

color0          =       $D027
color1          =       $D028
color2          =       $D029
color3          =       $D02A
color4          =       $D02B
color5          =       $D02C
color6          =       $D02D
color7          =       $D02E

pos0x           =       $D000
pos0y           =       $D001
pos1x           =       $D002
pos1y           =       $D003
pos2x           =       $D004
pos2y           =       $D005
pos3x           =       $D006
pos3y           =       $D007
pos4x           =       $D008
pos4y           =       $D009
pos5x           =       $D00A
pos5y           =       $D00B
pos6x           =       $D00C
pos6y           =       $D00D
pos7x           =       $D00E
pos7y           =       $D00F

msbx            =       $D010

potx            =       $d419
poty            =       $d41a

enable    =       $D015

                .segment        "CODE"

                jsr CINT

                lda #$80        ; can we calculate this?
                sta sprite0

                lda sp_arrow_color
                sta color0

                lda #$01
                sta enable

                lda #$80
                sta pos0x
                sta pos0y

                ldy #0
loop:           sty pos0x
                ldx #$ff
pause:          dex
                beq next
                jmp pause

next:           iny
                bne :+
                lda msbx
                eor #$01
                sta msbx
:               jmp loop
