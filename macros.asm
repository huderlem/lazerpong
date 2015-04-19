;\1 = X
;\2 = Y
;\3 = Reference Background Map (e.g. vBGMap0 or vBGMap1)
hlCoord: MACRO
    ld hl, \3 + $20 * \2 + \1
    ENDM
