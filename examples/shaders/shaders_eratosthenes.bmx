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

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - Sieve of Eratosthenes")

Local target:RRenderTexture2D = LoadRenderTexture(screenWidth, screenHeight)

' Load Eratosthenes shader
' NOTE: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
Local shader:RShader = LoadShader(0, "../../lib.mod/raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/eratosthenes.fs")

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' Nothing to do here, everything is happening in the shader
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginTextureMode(target)   ' Enable drawing to texture
			ClearBackground(BLACK) ' Clear the render texture

			' Draw a rectangle in shader mode to be used as shader canvas
			' NOTE: Rectangle uses font white character texture coordinates,
			' so shader can not be applied here directly because input vertexTexCoord
			' do not represent full screen coordinates (space where want to apply shader)
			DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), BLACK)
		EndTextureMode()           ' End drawing to texture (now we have a blank texture available for the shader)

		BeginShaderMode(shader)
			' NOTE: Render texture must be y-flipped due to default OpenGL coordinates (left-bottom)
			DrawTextureRec(target.texture, New RRectangle(0, 0, target.texture.width, -target.texture.height), New RVector2(0.0, 0.0), WHITE)
		EndShaderMode()

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)           ' Unload shader
UnloadRenderTexture(target)    ' Unload texture

CloseWindow()                  ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
