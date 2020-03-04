SuperStrict

Framework Ray.Lib

Const NUM_TEXTURES:Int = 7      ' Currently we have 7 generation algorithms

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - procedural images generation")

Local verticalGradient:RImage = GenImageGradientV(screenWidth, screenHeight, RED, BLUE)
Local horizontalGradient:RImage = GenImageGradientH(screenWidth, screenHeight, RED, BLUE)
Local radialGradient:RImage = GenImageGradientRadial(screenWidth, screenHeight, 0.0, WHITE, BLACK)
Local checked:RImage = GenImageChecked(screenWidth, screenHeight, 32, 32, RED, BLUE)
Local whiteNoise:RImage = GenImageWhiteNoise(screenWidth, screenHeight, 0.5)
Local perlinNoise:RImage = GenImagePerlinNoise(screenWidth, screenHeight, 50, 50, 4.0)
Local cellular:RImage = GenImageCellular(screenWidth, screenHeight, 32)

Local textures:RTexture2D[NUM_TEXTURES]

textures[0] = LoadTextureFromImage(verticalGradient)
textures[1] = LoadTextureFromImage(horizontalGradient)
textures[2] = LoadTextureFromImage(radialGradient)
textures[3] = LoadTextureFromImage(checked)
textures[4] = LoadTextureFromImage(whiteNoise)
textures[5] = LoadTextureFromImage(perlinNoise)
textures[6] = LoadTextureFromImage(cellular)

' Unload image data (CPU RAM)
UnloadImage(verticalGradient)
UnloadImage(horizontalGradient)
UnloadImage(radialGradient)
UnloadImage(checked)
UnloadImage(whiteNoise)
UnloadImage(perlinNoise)
UnloadImage(cellular)

Local currentTexture:Int = 0

SetTargetFPS(60)
'---------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()
	' Update
	'----------------------------------------------------------------------------------
	If IsMouseButtonPressed(MOUSE_LEFT_BUTTON) Or IsKeyPressed(KEY_RIGHT) Then
		currentTexture = (currentTexture + 1) Mod NUM_TEXTURES ' Cycle between the textures
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawTexture(textures[currentTexture], 0, 0, WHITE)

		DrawRectangle(30, 400, 325, 30, Fade(SKYBLUE, 0.5))
		DrawRectangleLines(30, 400, 325, 30, Fade(WHITE, 0.5))
		DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL TEXTURES", 40, 410, 10, WHITE)

		Select currentTexture
			Case 0
				DrawText("VERTICAL GRADIENT", 560, 10, 20, RAYWHITE)
			Case 1
				DrawText("HORIZONTAL GRADIENT", 540, 10, 20, RAYWHITE)
			Case 2
				DrawText("RADIAL GRADIENT", 580, 10, 20, LIGHTGRAY)
			Case 3
				DrawText("CHECKED", 680, 10, 20, RAYWHITE)
			Case 4
				DrawText("WHITE NOISE", 640, 10, 20, RED)
			Case 5
				DrawText("PERLIN NOISE", 630, 10, 20, RAYWHITE)
			Case 6
				DrawText("CELLULAR", 670, 10, 20, RAYWHITE)
		End Select

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------

' Unload textures data (GPU VRAM)
For Local i:Int = 0 Until NUM_TEXTURES
	UnloadTexture(textures[i])
Next

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
