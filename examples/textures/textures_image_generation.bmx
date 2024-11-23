SuperStrict

Framework Ray.Lib

Const NUM_TEXTURES:Int = 9      ' Currently we have 9 generation algorithms

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - procedural images generation")

Local verticalGradient:RImage = GenImageGradientLinear(screenWidth, screenHeight, 0, RED, BLUE)
Local horizontalGradient:RImage = GenImageGradientLinear(screenWidth, screenHeight, 90, RED, BLUE)
Local diagonalGradient:RImage = GenImageGradientLinear(screenWidth, screenHeight, 45, RED, BLUE)
Local radialGradient:RImage = GenImageGradientRadial(screenWidth, screenHeight, 0.0, WHITE, BLACK)
Local squareGradient:RImage = GenImageGradientSquare(screenWidth, screenHeight, 0.0, WHITE, BLACK)
Local checked:RImage = GenImageChecked(screenWidth, screenHeight, 32, 32, RED, BLUE)
Local whiteNoise:RImage = GenImageWhiteNoise(screenWidth, screenHeight, 0.5)
Local perlinNoise:RImage = GenImagePerlinNoise(screenWidth, screenHeight, 50, 50, 4.0)
Local cellular:RImage = GenImageCellular(screenWidth, screenHeight, 32)

Local textures:RTexture2D[NUM_TEXTURES]

textures[0] = LoadTextureFromImage(verticalGradient)
textures[1] = LoadTextureFromImage(horizontalGradient)
textures[2] = LoadTextureFromImage(diagonalGradient)
textures[3] = LoadTextureFromImage(radialGradient)
textures[4] = LoadTextureFromImage(squareGradient)
textures[5] = LoadTextureFromImage(checked)
textures[6] = LoadTextureFromImage(whiteNoise)
textures[7] = LoadTextureFromImage(perlinNoise)
textures[8] = LoadTextureFromImage(cellular)

' Unload image data (CPU RAM)
UnloadImage(verticalGradient)
UnloadImage(horizontalGradient)
UnloadImage(diagonalGradient)
UnloadImage(radialGradient)
UnloadImage(squareGradient)
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
				DrawText("DIAGONAL GRADIENT", 540, 10, 20, RAYWHITE)
			Case 3
				DrawText("RADIAL GRADIENT", 580, 10, 20, LIGHTGRAY)
			Case 4
				DrawText("SQUARE GRADIENT", 580, 10, 20, RAYWHITE)
			Case 5
				DrawText("CHECKED", 680, 10, 20, RAYWHITE)
			Case 6
				DrawText("WHITE NOISE", 640, 10, 20, RED)
			Case 7
				DrawText("PERLIN NOISE", 630, 10, 20, RAYWHITE)
			Case 8
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
