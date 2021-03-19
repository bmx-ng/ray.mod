SuperStrict

Framework Ray.Lib

?Not opengles
Const GLSL_VERSION:Int = 330
?opengles
Const GLSL_VERSION:Int = 100
?

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - texture drawing")

Local imBlank:RImage = GenImageColor(1024, 1024, BLANK)
Local texture:RTexture2D = LoadTextureFromImage(imBlank)  ' Load blank texture to fill on shader
UnloadImage(imBlank)

' NOTE: Using GLSL 330 shader version, on OpenGL ES 2.0 use GLSL 100 shader version
Local shader:RShader = LoadShader(0,"../../lib.mod/raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/cubes_panning.fs")

Local time:Float = 0.0
Local timeLoc:Int = GetShaderLocation(shader, "uTime")
SetShaderValue(shader, timeLoc, Varptr time, UNIFORM_FLOAT)

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
' -------------------------------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	time = GetTime()
	SetShaderValue(shader, timeLoc, Varptr time, UNIFORM_FLOAT)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginShaderMode(shader)    ' Enable our custom shader for next shapes/textures drawings
			DrawTexture(texture, 0, 0, WHITE)  ' Drawing BLANK texture, all magic happens on shader
		EndShaderMode()            ' Disable our custom shader, return to default shader

		DrawText("BACKGROUND is PAINTED and ANIMATED on SHADER!", 10, 10, 20, MAROON)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)

CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
