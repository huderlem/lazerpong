;\1 = X
;\2 = Y
;\3 = Reference Background Map (e.g. vBGMap0 or vBGMap1)
hlCoord: MACRO
    ld hl, \3 + $20 * \2 + \1
    ENDM


; pokered music engine

;1_channel	EQU $00
;2_channels	EQU $40
;3_channels	EQU $80
;4_channels	EQU $C0

CH0		EQU 0
CH1		EQU 1
CH2		EQU 2
CH3		EQU 3
CH4		EQU 4
CH5		EQU 5
CH6		EQU 6
CH7		EQU 7

unknownsfx0x10: MACRO
	db $10
	db \1
ENDM

unknownsfx0x20: MACRO
	db $20 | \1
	db \2
	db \3
	db \4
ENDM

unknownnoise0x20: MACRO
	db $20 | \1
	db \2
	db \3
ENDM

;format: pitch length (in 16ths)
C_: MACRO
	db $00 | (\1 - 1)
ENDM

C#: MACRO
	db $10 | (\1 - 1)
ENDM

D_: MACRO
	db $20 | (\1 - 1)
ENDM

D#: MACRO
	db $30 | (\1 - 1)
ENDM

E_: MACRO
	db $40 | (\1 - 1)
ENDM

F_: MACRO
	db $50 | (\1 - 1)
ENDM

F#: MACRO
	db $60 | (\1 - 1)
ENDM

G_: MACRO
	db $70 | (\1 - 1)
ENDM

G#: MACRO
	db $80 | (\1 - 1)
ENDM

A_: MACRO
	db $90 | (\1 - 1)
ENDM

A#: MACRO
	db $A0 | (\1 - 1)
ENDM

B_: MACRO
	db $B0 | (\1 - 1)
ENDM

;format: instrument length (in 16ths)
snare1: MACRO
	db $B0 | (\1 - 1)
	db $01
ENDM

snare2: MACRO
	db $B0 | (\1 - 1)
	db $02
ENDM

snare3: MACRO
	db $B0 | (\1 - 1)
	db $03
ENDM

snare4: MACRO
	db $B0 | (\1 - 1)
	db $04
ENDM

snare5: MACRO
	db $B0 | (\1 - 1)
	db $05
ENDM

triangle1: MACRO
	db $B0 | (\1 - 1)
	db $06
ENDM

triangle2: MACRO
	db $B0 | (\1 - 1)
	db $07
ENDM

snare6: MACRO
	db $B0 | (\1 - 1)
	db $08
ENDM

snare7: MACRO
	db $B0 | (\1 - 1)
	db $09
ENDM

snare8: MACRO
	db $B0 | (\1 - 1)
	db $0A
ENDM

snare9: MACRO
	db $B0 | (\1 - 1)
	db $0B
ENDM

cymbal1: MACRO
	db $B0 | (\1 - 1)
	db $0C
ENDM

cymbal2: MACRO
	db $B0 | (\1 - 1)
	db $0D
ENDM

cymbal3: MACRO
	db $B0 | (\1 - 1)
	db $0E
ENDM

mutedsnare1: MACRO
	db $B0 | (\1 - 1)
	db $0F
ENDM

triangle3: MACRO
	db $B0 | (\1 - 1)
	db $10
ENDM

mutedsnare2: MACRO
	db $B0 | (\1 - 1)
	db $11
ENDM

mutedsnare3: MACRO
	db $B0 | (\1 - 1)
	db $12
ENDM

mutedsnare4: MACRO
	db $B0 | (\1 - 1)
	db $13
ENDM

;format: rest length (in 16ths)
rest: MACRO
	db $C0 | (\1 - 1)
ENDM

; format: notetype speed, volume, fade
notetype: MACRO
	db	$D0 | \1
	db	(\2 << 4) | \3
ENDM

dspeed: MACRO
	db $D0 | \1
ENDM

octave: MACRO
	db $E8 - \1
ENDM

toggleperfectpitch: MACRO
	db $E8
ENDM

;format: vibrato delay, rate, depth
vibrato: MACRO
	db $EA
	db \1
	db (\2 << 4) | \3
ENDM

pitchbend: MACRO
	db $EB
	db \1
	db \2
ENDM

duty: MACRO
	db $EC
	db \1
ENDM

tempo: MACRO
	db $ED
	db \1 / $100
	db \1 % $100
ENDM

stereopanning: MACRO
	db $EE
	db \1
ENDM

volume: MACRO
	db $F0
	db (\1 << 4) | \2
ENDM

executemusic: MACRO
	db $F8
ENDM

dutycycle: MACRO
	db $FC
	db \1
ENDM

;format: callchannel address
callchannel: MACRO
	db $FD
	dw \1
ENDM

;format: loopchannel count, address
loopchannel: MACRO
	db $FE
	db \1
	dw \2
ENDM

endchannel: MACRO
	db $FF
ENDM
