; from: https://www.pagetable.com/c64ref/kernal/
; on:   2021-01-22 10:15:13
CINT            =               $FF81            ; Initialize screen editor & 6567 video chip
IOINIT          =               $FF84            ; Initialize I/O devices
RAMTAS          =               $FF87            ; Perform RAM test
RESTOR          =               $FF8A            ; Restore default system and interrupt vectors
VECTOR          =               $FF8D            ; Manage RAM vectors
SETMSG          =               $FF90            ; Control system message output
SECOND          =               $FF93            ; Send secondary address for LISTEN
TKSA            =               $FF96            ; Send a secondary address to a device commanded to TALK
MEMTOP          =               $FF99            ; Set the top of RAM
MEMBOT          =               $FF9C            ; Set bottom of memory
SCNKEY          =               $FF9F            ; Scan the keyboard
SETTMO          =               $FFA2            ; Set IEEE bus card timeout flag
ACPTR           =               $FFA5            ; Get data from the serial bus
CIOUT           =               $FFA8            ; Transmit a byte over the serial bus
UNTLK           =               $FFAB            ; Send an UNTALK command
UNLSN           =               $FFAE            ; Send an UNLISTEN command
LISTEN          =               $FFB1            ; Command a device on the serial bus to listen
TALK            =               $FFB4            ; Command a device on the serial bus to TALK
READST          =               $FFB7            ; Read status word
SETLFS          =               $FFBA            ; Set up a logical file
SETNAM          =               $FFBD            ; Set file name
OPEN            =               $FFC0            ; Open a logical file
CLOSE           =               $FFC3            ; Close a logical file
CHKIN           =               $FFC6            ; Open a channel for input
CHKOUT          =               $FFC9            ; Open a channel for output
CLRCHN          =               $FFCC            ; Clear I/O channels
CHRIN           =               $FFCF            ; Get a character from the input channel
CHROUT          =               $FFD2            ; Output a character
LOAD            =               $FFD5            ; Load RAM from device
SAVE            =               $FFD8            ; Save memory to a device
SETTIM          =               $FFDB            ; Set the system clock
RDTIM           =               $FFDE            ; Read system clock
STOP            =               $FFE1            ; Check if  key is pressed
GETIN           =               $FFE4            ; Get a character
CLALL           =               $FFE7            ; Close all files
UDTIM           =               $FFEA            ; Update the system clock
SCREEN          =               $FFED            ; Return screen format
PLOT            =               $FFF0            ; Set cursor location
IOBASE          =               $FFF3            ; Define I/O memory page

                .export         CINT,IOINIT,RAMTAS,RESTOR,VECTOR
                .export         SETMSG,SECOND,TKSA,MEMTOP,MEMBOT
                .export         SCNKEY,SETTMO,ACPTR,CIOUT,UNTLK
                .export         UNLSN,LISTEN,TALK,READST,SETLFS
                .export         SETNAM,OPEN,CLOSE,CHKIN,CHKOUT
                .export         CLRCHN,CHRIN,CHROUT,LOAD,SAVE
                .export         SETTIM,RDTIM,STOP,GETIN,CLALL
