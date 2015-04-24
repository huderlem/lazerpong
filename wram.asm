INCLUDE "constants/movement_constants.asm"

SECTION "WRAM Bank 0", WRAM0

VBlankFlag::
; Set to non-zero if VBlank happened
    ds $1

SECTION "WRAM Bank 1", WRAMX, BANK[1]

wOAMBuffer:: ; d000
    ; buffer for OAM data. Copied to OAM by DMA
wBallSprite::
    ds 4  ; Pong ball's OAM data is the first entry
wLaserSprites::
    ds 4 * MAX_LASERS
    ds 4 * (39 - MAX_LASERS)

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

wLasers::
wPlayerLasers::
; isActive   [1 byte]
; y position [2 bytes]
; x position [2 bytes]
    ds 5 * MAX_LASERS
wComputerLasers::
    ds 5 * MAX_LASERS

wPlayerLaserCooldown::
; Must be 0 for player to shoot a laser. Counts down every frame.
    ds 1
wComputerLaserCooldown::
    ds 1


wPlayerScore::
    ds 1
wComputerScore::
    ds 1

wStartPlayTimer::
; Counts down to zero before a new ball is started.
    ds 1
