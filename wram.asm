
SECTION "WRAM Bank 0", WRAM0

VBlankFlag::
; Set to non-zero if VBlank happened
    ds $1

SECTION "WRAM Bank 1", WRAMX, BANK[1]

wOAMBuffer:: ; d000
    ; buffer for OAM data. Copied to OAM by DMA
    ds 4 * 40

wPlayerY::
    ds 2
wPlayerHeight::
    ds 1


wComputerY::
    ds 2
wComputerHeight::
    ds 1


wBallY::
    ds 2
wBallX::
    ds 2
wBallYSpeed::
    ds 2
wBallXSpeed::
    ds 2

