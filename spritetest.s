                .import sp_arrow,sp_arrow_color

SCINIT          =       $FF81

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

enable    =       $D015

                .segment        "CODE"

                jsr SCINIT

                lda #$80        ; can we calculate this?
                sta sprite0

                lda sp_arrow_color
                sta color0

                lda #$01
                sta enable

                lda #$80
                sta pos0x
                sta pos0y

loop:           jmp loop
