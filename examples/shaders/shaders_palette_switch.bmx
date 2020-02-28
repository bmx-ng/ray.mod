SuperStrict

Framework Ray.Lib

?win32
Const GLSL_VERSION:Int = 330
?raspberrypi
Const GLSL_VERSION:Int = 100
?

Const MAX_PALETTES:Int =           3
Const COLORS_PER_PALETTE:Int =     8
Const VALUES_PER_COLOR:Int =       3

Local palettes:Int[][] = [ ..
    [   .. ' 3-BIT RGB
        0, 0, 0, ..
        255, 0, 0, ..
        0, 255, 0, ..
        0, 0, 255, ..
        0, 255, 255, ..
        255, 0, 255, ..
        255, 255, 0, ..
        255, 255, 255 ..
    ], ..
    [  .. ' AMMO-8 (GameBoy-like)
        4, 12, 6, ..
        17, 35, 24, ..
        30, 58, 41, ..
        48, 93, 66, ..
        77, 128, 97, ..
        137, 162, 87, ..
        190, 220, 127, ..
        238, 255, 204 ..
    ],..
    [   ..' RKBV (2-strip film)
        21, 25, 26, ..
        138, 76, 88, ..
        217, 98, 117, ..
        230, 184, 193, ..
        69, 107, 115, ..
        75, 151, 166, ..
        165, 189, 194, ..
        255, 245, 247 ..
    ] ..
]

Local paletteText:String[] = [..
    "3-BIT RGB", ..
    "AMMO-8 (GameBoy-like)",..
    "RKBV (2-strip film)"..
]


' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - color palette switch")

' Load shader to be used on some parts drawing
' NOTE 1: Using GLSL 330 shader version, on OpenGL ES 2.0 use GLSL 100 shader version
' NOTE 2: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
Local shader:RShader = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/palette_switch.fs")

' Get variable (uniform) location on the shader to connect with the program
' NOTE: If uniform variable could not be found in the shader, function returns -1
Local paletteLoc:Int = GetShaderLocation(shader, "palette")

Local currentPalette:Int = 0
Local lineHeight:Int = screenHeight/COLORS_PER_PALETTE

SetTargetFPS(60)                       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()            ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyPressed(KEY_RIGHT) Then
		currentPalette :+ 1
	Else If IsKeyPressed(KEY_LEFT) Then
		currentPalette :- 1
	End If

	If currentPalette >= MAX_PALETTES Then
		currentPalette = 0
	Else If currentPalette < 0 Then
		currentPalette = MAX_PALETTES - 1
	End If

	' Send new value to the shader to be used on drawing.
	' NOTE: We are sending RGB triplets w/o the alpha channel
	SetShaderValueV(shader, paletteLoc, palettes[currentPalette], UNIFORM_IVEC3, COLORS_PER_PALETTE)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginShaderMode(shader)

			For Local i:Int = 0 Until COLORS_PER_PALETTE
				' Draw horizontal screen-wide rectangles with increasing "palette index"
				' The used palette index is encoded in the RGB components of the pixel
				DrawRectangle(0, lineHeight*i, GetScreenWidth(), lineHeight, New RColor(i, i, i, 255))
			Next

		EndShaderMode()

		DrawText("< >", 10, 10, 30, DARKBLUE)
		DrawText("CURRENT PALETTE:", 60, 15, 20, RAYWHITE)
		DrawText(paletteText[currentPalette], 300, 15, 20, RED)

		DrawFPS(700, 15)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend
' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)       ' Unload shader

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
