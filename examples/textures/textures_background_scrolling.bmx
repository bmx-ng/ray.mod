SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - background scrolling")

' NOTE: Be careful, background width must be equal or bigger than screen width
' if not, texture should be draw more than two times for scrolling effect
Local background:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/cyberpunk_street_background.png")
Local midground:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/cyberpunk_street_midground.png")
Local foreground:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/cyberpunk_street_foreground.png")

Local scrollingBack:Float = 0.0
Local scrollingMid:Float = 0.0
Local scrollingFore:Float = 0.0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	scrollingBack :- 0.1
	scrollingMid :- 0.5
	scrollingFore :- 1.0

	' NOTE: Texture is scaled twice its size, so it sould be considered on scrolling
	If scrollingBack <= -background.width*2 Then
		scrollingBack = 0
	End If
	If scrollingMid <= -midground.width*2 Then
		scrollingMid = 0
	End If
	If scrollingFore <= -foreground.width*2 Then
		scrollingFore = 0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(GetColor($052c46ff))

		' Draw background image twice
		' NOTE: Texture is scaled twice its size
		DrawTextureEx(background, New RVector2(scrollingBack, 20), 0.0, 2.0, WHITE)
		DrawTextureEx(background, New RVector2(background.width*2 + scrollingBack, 20), 0.0, 2.0, WHITE)

		' Draw midground image twice
		DrawTextureEx(midground, New RVector2(scrollingMid, 20), 0.0, 2.0, WHITE)
		DrawTextureEx(midground, New RVector2(midground.width*2 + scrollingMid, 20), 0.0, 2.0, WHITE)

		' Draw foreground image twice
		DrawTextureEx(foreground, New RVector2(scrollingFore, 70), 0.0, 2.0, WHITE)
		DrawTextureEx(foreground, New RVector2(foreground.width*2 + scrollingFore, 70), 0.0, 2.0, WHITE)

		DrawText("BACKGROUND SCROLLING & PARALLAX", 10, 10, 20, RED)
		DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", screenWidth - 330, screenHeight - 20, 10, RAYWHITE)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(background)  ' Unload background texture
UnloadTexture(midground)   ' Unload midground texture
UnloadTexture(foreground)  ' Unload foreground texture

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
