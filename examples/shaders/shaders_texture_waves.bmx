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

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - texture waves")

' Load texture texture to apply shaders
Local texture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/shaders/resources/space.png")

' Load shader and setup location points and values
Local shader:RShader = LoadShader(0, "../../lib.mod/raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/wave.fs")

Local secondsLoc:Int = GetShaderLocation(shader, "seconds")
Local freqXLoc:Int = GetShaderLocation(shader, "freqX")
Local freqYLoc:Int = GetShaderLocation(shader, "freqY")
Local ampXLoc:Int = GetShaderLocation(shader, "ampX")
Local ampYLoc:Int = GetShaderLocation(shader, "ampY")
Local speedXLoc:Int = GetShaderLocation(shader, "speedX")
Local speedYLoc:Int = GetShaderLocation(shader, "speedY")

' Shader uniform values that can be updated at any time
Local freqX:Float = 25.0
Local freqY:Float = 25.0
Local ampX:Float = 5.0
Local ampY:Float = 5.0
Local speedX:Float = 8.0
Local speedY:Float = 8.0

Local screenSize:Float[] = [Float(GetScreenWidth()), Float(GetScreenHeight())]
SetShaderValue(shader, GetShaderLocation(shader, "size"), Varptr screenSize, SHADER_UNIFORM_VEC2)
SetShaderValue(shader, freqXLoc, Varptr freqX, SHADER_UNIFORM_FLOAT)
SetShaderValue(shader, freqYLoc, Varptr freqY, SHADER_UNIFORM_FLOAT)
SetShaderValue(shader, ampXLoc, Varptr ampX, SHADER_UNIFORM_FLOAT)
SetShaderValue(shader, ampYLoc, Varptr ampY, SHADER_UNIFORM_FLOAT)
SetShaderValue(shader, speedXLoc, Varptr speedX, SHADER_UNIFORM_FLOAT)
SetShaderValue(shader, speedYLoc, Varptr speedY, SHADER_UNIFORM_FLOAT)

Local seconds:Float = 0.0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
' -------------------------------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	seconds :+ GetFrameTime()
	
	SetShaderValue(shader, secondsLoc, Varptr seconds, SHADER_UNIFORM_FLOAT)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginShaderMode(shader)
		
			DrawTexture(texture, 0, 0, WHITE)
			DrawTexture(texture, texture.width, 0, WHITE)
			
		EndShaderMode()

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)         ' Unload shader
UnloadTexture(texture)       ' Unload texture

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
