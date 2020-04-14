SECTION "mgblib", ROMX
INCLUDE "mgblib/src/hardware.inc"
INCLUDE "mgblib/src/macros.asm"
    enable_cgb_mode   
INCLUDE "mgblib/src/old_skool_outline_thick.asm"
INCLUDE "mgblib/src/display.asm"


SECTION "stat_int", ROM0[$48]
    jp hl


SECTION "boot", ROM0[$100]
    nop                                       
    jp Main         


SECTION "main", ROM0[$150]
Main::
    di
    ld sp, $cfff

    call ResetDisplay
    call LoadFont8000

    ld hl, BackgroundPalette
    xor a
    ld b, BackgroundPalette.end - BackgroundPalette
    call LoadBackgroundPalette

    ld hl, ObjectPalette
    xor a
    ld b, ObjectPalette.end - ObjectPalette
    call LoadObjectPalette

    ld hl, OAMData
    ld de, _OAMRAM
    ld bc, OAMData.end - OAMData
    call MemCopy

    ; select vram bank 1
    ld a, 1
    ldh [rVBK], a

    ld hl, BackgroundMapAttributes
    ld de, $9880
    ld bc, BackgroundMapAttributes.end - BackgroundMapAttributes
    call MemCopy

    ld hl, WindowMapAttributes
    ld de, $9c00
    ld bc, WindowMapAttributes.end - WindowMapAttributes
    call MemCopy

    ld hl, WindowMapAttributes9840
    ld de, $9840
    ld bc, WindowMapAttributes9840.end - WindowMapAttributes9840
    call MemCopy

    ld hl, TileDataBank1
    ld de, $8000
    ld bc, TileDataBank1.end - TileDataBank1
    call MemCopy

    ; select vram bank 0
    xor a
    ldh [rVBK], a

    ; set the footer tile map
    ld hl, $9e80
    xor a
    ld c, 20
.loop:
    ld [hl+], a
    inc a
    dec c
    jr nz, .loop
    ld l, $a0

    ld c, 20
.loop2:
    ld [hl+], a
    inc a
    dec c
    jr nz, .loop2

    ld hl, BackgroundMap
    ld de, $9880
    ld bc, BackgroundMap.end - BackgroundMap
    call MemCopy

    ld hl, WindowMap
    ld de, $9c00
    ld bc, WindowMap.end - WindowMap
    call MemCopy

    ld hl, WindowMap9840
    ld de, $9840
    ld bc, WindowMap9840.end - WindowMap9840
    call MemCopy

    ld hl, TileData
    ld de, $8000
    ld bc, TileData.end - TileData
    call MemCopy

    ld hl, FooterTiles
    ld de, $9000
    ld bc, FooterTiles.end - FooterTiles
    call MemCopy


    ; enable interrupt for ly=lyc
    ld a, $40
    ldh [rSTAT], a
    ld a, $57
    ldh [rLYC], a
    ld a, 2
    ldh [rIE], a

    ld a, $20
    ldh [rSCY], a
    ld a, $28
    ldh [rWY], a
    ld a, $58 + 7
    ldh [rWX], a

    win_map_9c00
    enable_sprites
    bg_tile_data_8000
    lcd_on

    xor a
    ldh [rIF], a

    ; schedule first job
    ld a, $10
    ldh [rLYC], a
    ld hl, LY_10

    ; initialise the frame counter
    ; a source code breakpoint will be triggered after 10 frames
    ld b, 10

    ei

.forever
    halt
    jr .forever

LY_10:
    ld hl, rLCDC
    set 5, [hl] ; enable window

    ld a, $38
    ldh [rLYC], a
    ld hl, LY_38
    reti

LY_38:
    ; disable window by setting WX off-screen
    ld a, 240
    ld [rWX], a

    ld hl, rLCDC
    res 0, [hl]     ; objects always on top - displays the nose

    ld a, $58
    ldh [rLYC], a
    ld hl, LY_58
    reti

LY_58:
    ld hl, rLCDC
    set 2, [hl]     ; object size 8x16
    set 0, [hl]     ; allow bg map attributes/oam to specify object priority

    ld a, $68
    ldh [rLYC], a
    ld hl, LY_68
    reti

LY_68:
    ld hl, rLCDC
    res 2, [hl]     ; object size 8x8
    res 1, [hl]     ; objects disabled - hides the tongue

    ld a, $70
    ldh [rLYC], a
    ld hl, LY_70
    reti


LY_70:
    ; enable window by positioning WX on-screen
    ld a, $58 + 7
    ld [rWX], a

    ld hl, rLCDC
    res 6, [hl] ; window map $9800

    ld a, $80
    ldh [rLYC], a
    ld hl, LY_80
    reti


LY_80:
    ld hl, rLCDC
    set 3, [hl] ; bg map $9c00
    res 4, [hl] ; bg tiles at $8800-97ff

    ld a, $81
    ldh [rLYC], a
    ld hl, LY_81
    reti


LY_81:
    ld hl, rLCDC
    res 5, [hl] ; disable window
    set 6, [hl] ; window map $9c00

    ld a, $8f
    ldh [rLYC], a
    ld hl, LY_8F
    reti


LY_8F:
    ; bg uses $9800 tile map and $8000 tile data
    ld hl, rLCDC
    res 3, [hl]
    set 4, [hl]

    ld a, $90
    ldh [rLYC], a
    ld hl, LY_90
    reti

LY_90:
    ld hl, rLCDC
    set 1, [hl] ; enable objects

    ; decrease the frame counter
    dec b
    jr nz, .skip

    ; source code breakpoint - good time to take a 
    ; screenshot to compare to reference image
    ld b, b

.skip:
    ld a, $10
    ldh [rLYC], a
    ld hl, LY_10
    reti

INCLUDE "inc/background.asm"
INCLUDE "inc/window.asm"
INCLUDE "inc/tiles.asm"
INCLUDE "inc/oam.asm"
INCLUDE "inc/palettes.asm"
FooterTiles::
    INCBIN "img/footer.2bpp"
.end: