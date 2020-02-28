SuperStrict

Framework Ray.Lib

?win32
Const GLSL_VERSION:Int = 330
?raspberrypi
Const GLSL_VERSION:Int = 100
?

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - shapes and texture shaders")

Local fudesumi:RTexture2D = LoadTexture("../../raylib/examples/shaders/resources/fudesumi.png")

' Load shader to be used on some parts drawing
' NOTE 1: Using GLSL 330 shader version, on OpenGL ES 2.0 use GLSL 100 shader version
' NOTE 2: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
Local shader:RShader = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/grayscale.fs")

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' TODO: Update your variables here
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' Start drawing with default shader

		DrawText("USING DEFAULT SHADER", 20, 40, 10, RED)

		DrawCircle(80, 120, 35, DARKBLUE)
		DrawCircleGradient(80, 220, 60, GREEN, SKYBLUE)
		DrawCircleLines(80, 340, 80, DARKBLUE)


		' Activate our custom shader to be applied on next shapes/textures drawings
		BeginShaderMode(shader)

			DrawText("USING CUSTOM SHADER", 190, 40, 10, RED)

			DrawRectangle(250 - 60, 90, 120, 60, RED)
			DrawRectangleGradientH(250 - 90, 170, 180, 130, MAROON, GOLD)
			DrawRectangleLines(250 - 40, 320, 80, 60, ORANGE)

		' Activate our default shader for next drawings
		EndShaderMode()

		DrawText("USING DEFAULT SHADER", 370, 40, 10, RED)

		DrawTriangle(New RVector2(430, 80), ..
					 New RVector2(430 - 60, 150), ..
					 New RVector2(430 + 60, 150), VIOLET)

		DrawTriangleLines(New RVector2(430, 160), ..
						  New RVector2(430 - 20, 230), ..
						  New RVector2(430 + 20, 230), DARKBLUE)

		DrawPoly(New RVector2(430, 320), 6, 80, 0, BROWN)

		' Activate our custom shader to be applied on next shapes/textures drawings
		BeginShaderMode(shader)

			DrawTexture(fudesumi, 500, -30, WHITE)    ' Using custom shader

		' Activate our default shader for next drawings
		EndShaderMode()

		DrawText("(c) Fudesumi sprite by Eiden Marsal", 380, screenHeight - 20, 10, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)       ' Unload shader
UnloadTexture(fudesumi)    ' Unload texture

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
