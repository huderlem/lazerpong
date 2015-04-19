INCLUDE "macros.asm"
INCLUDE "constants.asm"

SECTION "rst 00", ROM0 [$00]
    ret

SECTION "rst 08", ROM0 [$08]
    ret

SECTION "rst 10", ROM0 [$10]
    ret

SECTION "rst 18", ROM0 [$18]
    ret

SECTION "rst 20", ROM0 [$20]
    ret

SECTION "rst 28", ROM0 [$28]
    ret

SECTION "rst 30", ROM0 [$30]
    ret

SECTION "rst 38", ROM0 [$38]
    ret

SECTION "VBlank", ROM0 [$40]
    jp VBlankInterruptHandler

SECTION "LCDC",ROM0[$48]
    reti

SECTION "Timer", ROM0 [$50]
    jp TimerInterruptHandler

SECTION "Serial",ROM0[$58]
    jp SerialInterruptHandler

SECTION "Joypad", ROM0 [$60]
    reti


SECTION "Entry", ROM0 [$100]

Entry: ; 0x100
	nop
	jp Start

SECTION "Header", ROM0 [$104]
	; The header is generated by rgbfix.
	; The space here is allocated to prevent code from being overwritten.
	ds $150 - $104

SECTION "Main", ROM0 [$150]

Start: ; 0x150
    di
    ld sp, $ffff
    xor a
    ld [rLCDC], a  ; Disable LCD Display
    ld hl, $c000
    ld bc, $2000
    call ClearData  ; Clear working RAM
    ld hl, vTiles0
    ld bc, $2000
    call ClearData  ; Clear VRAM
    ld hl, $fe00
    ld bc, $a0
    call ClearData  ; Clear OAM
    ld hl, $ff80
    ld bc, $7d  ; Clear HRAM
    call ClearData
    ld hl, GameGfx
    ld bc, $800
    ld de, vTiles0
    call LoadTiles
    ld a, %11100100
    ld [rBGP], a  ; Set Background palette

    ld sp, $dfff  ; Initialize stack pointer to end of working RAM

    call InitPlayerPaddle

    ld a, $91
    ld [rLCDC], a   ; Enable LCD Display
    ld a,%00000001  ; Enable V-blank interrupt
    ld [rIE], a
    ei
    jp RunGame

VBlankInterruptHandler:
    call ReadJoypad
    call DrawPlayerPaddle
    reti

TimerInterruptHandler:
    reti

SerialInterruptHandler:
    reti

ClearData:
; Clears bc bytes starting at hl.
; bc can be a maximum of $7fff, since it checks bit 7 of b when looping.
    xor a
    dec bc
.clearLoop
    ld [hli], a
    dec bc
    bit 7, b
    jr z, .clearLoop
    ret

ClearOAMBuffer::
; Fills OAM buffer memory with $0.
    ld hl, wOAMBuffer
    ld bc, $a0  ; size of OAM buffer
    jp ClearData

ClearBackground::
; Fills Background memory with $0.
    xor a
    ld hl,wOAMBuffer
    ld b,$a0  ; size of OAM memory
.loop
    ld [hli],a
    dec b
    jr nz,.loop
    ret

LoadTiles:
; This loads tile data into VRAM. It waits for the LCD H-Blank to copy the data 4 bytes at a time.
; input:  hl = source of tile data
;         de = destination for tile data
;         bc = number of bytes to copy
.waitForHBlank
    ld a, [$ff41] ; LCDC Status
    and $3
    jr nz, .waitForHBlank
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c  ; have we copied all of the data?
    jr nz, .waitForHBlank
    ret

ReadJoypad:
; Reads the current state of the joypad and saves the state into
; some registers the game uses during gameplay.
    ld a, $20
    ld [rJOYP], a
    ld a, [rJOYP]
    ld a, [rJOYP]
    and $f
    swap a
    ld b, a
    ld a, $30
    ld [rJOYP], a
    ld a, $10
    ld [rJOYP], a
    ld a, [rJOYP]
    ld a, [rJOYP]
    ld a, [rJOYP]
    ld a, [rJOYP]
    ld a, [rJOYP]
    ld a, [rJOYP]
    and $f
    or b
    cpl  ; a contains currently-pressed buttons
    ld [hJoypadState], a
    ret

InitPlayerPaddle:
; Initializes the player's paddle.
    ld hl, wPlayerY
    ld a, $00
    ld [hli], a
    ld a, $17
    ld [hl], a
    ld a, $3
    ld [wPlayerHeight], a
    ret

DrawPlayerPaddle:
; Draws the player's paddle to the screen.
; This also fills in blank tiles along the column where the player's paddle doesn't overlap.
    ld a, [wPlayerY + 1]
    push af
    srl a
    srl a
    srl a  ; Divide by 8 to get the tile index we need to start drawing at.
    hlCoord 0, 0, vBGMap0
    ld bc, $0020
    ld d, $00  ; Count which tile row we're on.
.addLoop
    ld [hl], $01
    and a
    jr z, .gotHLCoord
    inc d
    add hl, bc  ; Move the HL Coord down one row of tiles.
    dec a
    jr .addLoop
.gotHLCoord
    pop af  ; Reload player's paddle Y position
    and $7  ; Get the pixel offset in the tile. (Tiles are 8 pixels wide)
    jr z, .save8
    push af
    ld e, a
    ld a, 8
    sub e
    ld e, a
    pop af
    jr .drawTile
.save8
    ld e, 8
.drawTile
    add $10  ; a now contains tile id for the top tile
    ld [hl], a  ; Draw the top tile
    inc d
    ld a, [wPlayerHeight]
    sub e
.drawMiddleTiles
    add hl, bc
    cp a, 8
    jr c, .drawBottomTile
    sub 8
    ld [hl], $10  ; Tile id of the solid paddle tile.
    inc d
    jr .drawMiddleTiles
.drawBottomTile
    and a
    jr z, .clearRemainingTiles
    add $18
    ld [hl], a
    inc d
    ld a, d
.clearRemainingTiles
    cp 18 ; number of rows in the display
    jr z, .done
    add hl, bc
    ld [hl], $01  ; blank tile
    inc a
    jr .clearRemainingTiles
.done
    ret

RunGame:
; Main game loop.
    jr RunGame


SECTION "Bank 1",ROMX,BANK[$1]

GameGfx:
    INCBIN "gfx/game.2bpp"
