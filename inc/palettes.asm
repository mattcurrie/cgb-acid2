
BackgroundPalette::
    ; palette 0
    rgb 31, 31, 31
    rgb 21, 21, 21
    rgb 11, 11, 11
    rgb 0, 0, 0    

    ; palette 1
    rgb 0, 0, 31        ; 0 = blue
    rgb 0, 31, 00       ; 1 = green
    rgb 31, 0, 0        ; 2 = red
    rgb 0, 0, 0         ; 3 = black

    ; palette 2
    rgb 0, 19, 00       ; 0 = mid-green
    rgb 31, 31, 00      ; 1 = yellow
    rgb 31, 31, 31      ; 2 = white
    rgb 0, 0, 0         ; 3 = black

    ; palette 3
    rgb 31, 0, 00       ; 0 = red
    rgb 31, 31, 00      ; 1 = yellow
    rgb 31, 31, 31      ; 2 = white
    rgb 0, 0, 0         ; 3 = black
    
    ; palette 4  - "!" in "hello world!" text
    rgb 31, 31, 31      ; 0 = white
    rgb 0, 0, 31        ; 1 = blue
    rgb 31, 0, 31       ; 2 = purple
    rgb 13, 23, 31      ; 3 = light blue
.end:

ObjectPalette::
    ; palette 0
    rgb 31, 0, 31       ; 0 = purple (unused)
    rgb 31, 31, 0       ; 1 = yellow
    rgb 31, 31, 31      ; 2 = white
    rgb 0, 0, 0         ; 3 = black

    ; palette 1
    rgb 31, 31, 31      ; 0 = white (unused)
    rgb 31, 31, 31      ; 1 = white
    rgb 31, 0, 0        ; 2 = red
    rgb 31, 0, 0        ; 3 = red

    ; palette 2
    rgb 31, 31, 31      ; 0 = white (unused)
    rgb 31, 31, 31      ; 1 = white
    rgb 31, 0, 0        ; 2 = white
    rgb 0, 19, 0        ; 3 = red

    ; palette 3 - "hello world!" text
    rgb 31, 0, 31       ; 0 = purple (unused)
    rgb 0, 0, 31        ; 1 = blue
    rgb 31, 0, 31       ; 2 = purple
    rgb 13, 23, 31      ; 3 = light blue

    ; palette 4 - cover for the "!" in "hello world!" text - 
    ; if the sprite limit doesn't kick in this will overlap the "!" from the background
    rgb 31, 31, 31      ; 0 = white
    rgb 31, 31, 31      ; 1 = white
    rgb 31, 31, 31      ; 2 = white
    rgb 31, 31, 31      ; 3 = white

    ; palette 5 - eye lash
    rgb 31, 0, 31       ; 0 = purple (unused)
    rgb 21, 21, 0       ; 1 = mid yellow
    rgb 14, 14, 0       ; 2 = dark yellow
    rgb 0, 0, 0         ; 3 = black
.end: