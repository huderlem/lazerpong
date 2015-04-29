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

wCurrentScreen::
    ds 1
wScreenState::
    ds 1

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
wWinner::
; 1 = player won game
; 2 = computer won game
    ds 1

wStartPlayTimer::
; Counts down to zero before a new ball is started.
    ds 1

; Scratch registers
wScratch::
    ds 1
wScratch2::
    ds 1

; Music memory used by the pokemon music engine
; These names are copied from the pokered disassembly

wc000:: ds 1
wc001:: ds 1
wc002:: ds 1
wc003:: ds 1
wc004:: ds 1
wc005:: ds 1
wc006:: ds 8
wc00e:: ds 4
wc012:: ds 4
wc016:: ds 16
wc026:: ds 1
wc027:: ds 1
wc028:: ds 2
wc02a:: ds 1
wc02b:: ds 1
wc02c:: ds 1
wc02d:: ds 1
wc02e:: ds 8
wc036:: ds 8
wc03e:: ds 8
wc046:: ds 8
wc04e:: ds 8
wc056:: ds 8
wc05e:: ds 8
wc066:: ds 8
wc06e:: ds 8
wc076:: ds 8
wc07e:: ds 8
wc086:: ds 8
wc08e:: ds 8
wc096:: ds 8
wc09e:: ds 8
wc0a6:: ds 8
wc0ae:: ds 8
wc0b6:: ds 8
wc0be:: ds 8
wc0c6:: ds 8
wc0ce:: ds 1
wc0cf:: ds 1
wc0d0:: ds 1
wc0d1:: ds 1
wc0d2:: ds 1
wc0d3:: ds 1
wc0d4:: ds 1
wc0d5:: ds 1
wc0d6:: ds 8
wc0de:: ds 8
wc0e6:: ds 1
wc0e7:: ds 1
wc0e8:: ds 1
wc0e9:: ds 1
wc0ea:: ds 1
wc0eb:: ds 1
wc0ec:: ds 1
wc0ed:: ds 1
wc0ee:: ds 1
wc0ef:: ds 1
wc0f0:: ds 1
wc0f1:: ds 1
wc0f2:: ds 14

wMusicHeaderPointer::
    ds 1
wcfc8::
    ds 1
wcfc9::
    ds 1
wcfca::
    ds 1
