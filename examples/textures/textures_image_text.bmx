SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [texture] example - image text drawing")

Local parrots:RImage = LoadImage("../../lib.mod/raylib/examples/textures/resources/parrots.png") ' Load image in CPU memory (RAM)

' TTF Font loading with custom generation parameters
Local font:RFont = LoadFontEx("../../lib.mod/raylib/examples/textures/resources/KAISG.ttf", 64, 0, 0)

' Draw over image using custom font
ImageDrawTextEx(parrots, font, "[Parrots font drawing]", New RVector2(20.0, 20.0), Float(font.baseSize), 0.0, RED)

Local texture:RTexture2D  = LoadTextureFromImage(parrots)  ' Image converted to texture, uploaded to GPU memory (VRAM)
UnloadImage(parrots)   ' Once image has been converted to texture and uploaded to VRAM, it can be unloaded from RAM

Local position:RVector2 = New RVector2(Float(screenWidth/2 - texture.width/2), Float(screenHeight/2 - texture.height/2 - 20))

Local showFont:Int = False

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyDown(KEY_SPACE) Then
		showFont = True
	Else
		showFont = False
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		If Not showFont Then
			' Draw texture with text already drawn inside
			DrawTextureV(texture, position, WHITE)

			' Draw text directly using sprite font
			DrawTextEx(font, "[Parrots font drawing]", New RVector2(position.x + 20, position.y + 20 + 280), Float(font.baseSize), 0.0, WHITE)
		Else
			DrawTexture(font.texture, screenWidth/2 - font.texture.width/2, 50, BLACK)
		End If

		DrawText("PRESS SPACE to SEE USED SPRITEFONT ", 290, 420, 10, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture)     ' Texture unloading

UnloadFont(font)           ' Unload custom spritefont

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
