

OAMData::
    ; nose - all tile data from vram bank 1
    db $50, $50, $4, $08
    db $50, $58, $4, $28
    db $58, $50, $4, $48
    db $58, $58, $4, $68

    ; left eye - overlapping background color 0 only
    db $38, $40, $1, $82    ; uses green palette with priority so should show through color 0 bg, replacing the red top left corner of eye
    db $38, $48, $1, $02    ; green square. should show through color 0 because tile has set background to always have priority set

    ; right eye - overlapping window color 0 only
    db $38, $60, $1, $82    ; uses green palette with priority so should show through color 0 bg, replacing the red top left corner of eye
    db $38, $68, $1, $02    ; green square. should show through color 0 because tile has set background to always have priority set

    db $10, $28, "H", 3
    db $10, $30, "e", 3
    db $10, $38, "l", 3
    db $10, $40, "l", 3
    db $10, $48, "o", 3

    db $10, $58, "W", 3
    db $10, $60, "o", 3
    db $10, $68, "r", 3
    db $10, $70, "l", 3
    db $10, $78, "d", 3
    db $10, $80, 1, 4       ; this solid white box shouldn't display - 10 sprite limit per line

    ; mouth
    db $68, $38, 6, $00     ; sprite size is 8x16 when these sprites are rendered
    db $68, $40, 6, $40     ; y-flipped 8x16 sprite
    db $68, $48, 6, $40
    db $68, $50, 6, $40
    db $68, $58, 7, $40     ; specify tile 7, but bit 0 of tile index is ignored in 8x16 tile mode
    db $68, $60, 7, $40
    db $68, $68, 7, $40
    db $68, $70, 7, $00


    db $52, $3d, 10, $00    ; yellow square - higher x-coordinate, but lower index in OAM
                            ; so appears on top of the mole
    db $52, $3b, 9, $00     ; mole

    
    db $38, $3a, 5, $0d     ; left eyelash top
    db $40, $3a, 6, $0d     ; left eyelash bottom
    
    db $38, $6e, 5, $2d     ; right eyelash top
    db $40, $6e, 6, $2d     ; right eyelash bottom

    db $78, $54, 1, $01     ; tongue
.end:
