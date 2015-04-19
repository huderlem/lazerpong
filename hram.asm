; Can't use $ff80 - $ff89 because that's where the DMA routine is

hJoypadState      EQU $FF90  ; See joy_constants.asm

hCurrentROMBank   EQU $FFF8  ; This is updated whenever switching ROM Banks.
hNextROMBank      EQU $FFF9  ; The bank being switched to.
