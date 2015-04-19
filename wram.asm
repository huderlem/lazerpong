
SECTION "WRAM Bank 0", WRAM0

wc000::
    ds $1

SECTION "WRAM Bank 1", WRAMX, BANK[1]

wOAMBuffer:: ; d000
    ; buffer for OAM data. Copied to OAM by DMA
    ds 4 * 40

wPlayerY:: ; d0a0
    ds 2
wPlayerHeight:: ; 0xd0a1
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

