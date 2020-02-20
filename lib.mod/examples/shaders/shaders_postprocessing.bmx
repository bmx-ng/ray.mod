SuperStrict

Framework Ray.Lib

?win32
Const GLSL_VERSION:Int = 330
?raspberrypi
Const GLSL_VERSION:Int = 100
?

Const MAX_POSTPRO_SHADERS:Int = 12

Const FX_GRAYSCALE:Int = 0
Const FX_POSTERIZATION:Int = 1
Const FX_DREAM_VISION:Int = 2
Const FX_PIXELIZER:Int = 3
Const FX_CROSS_HATCHING:Int = 4
Const FX_CROSS_STITCHING:Int = 5
Const FX_PREDATOR_VIEW:Int = 6
Const FX_SCANLINES:Int = 7
Const FX_FISHEYE:Int = 8
Const FX_SOBEL:Int = 9
Const FX_BLOOM:Int = 10
Const FX_BLUR:Int = 11

Local postproShaderText:String[] = [ ..
	"GRAYSCALE", "POSTERIZATION", "DREAM_VISION", "PIXELIZER", "CROSS_HATCHING", "CROSS_STITCHING", ..
	"PREDATOR_VIEW", "SCANLINES", "FISHEYE", "SOBEL", "BLOOM", "BLUR"]

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)      ' Enable Multi Sampling Anti Aliasing 4x (if available)

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - postprocessing shader")

' Define the camera to look into our 3d world
Local camera:RCamera = New RCamera(New RVector3(2.0, 3.0, 2.0), New RVector3(0.0, 1.0, 0.0), New RVector3(0.0, 1.0, 0.0), 45.0, 0)

Local model:RModel = LoadModel("../../raylib/examples/shaders/resources/models/church.obj")                 ' Load OBJ model
Local texture:RTexture2D = LoadTexture("../../raylib/examples/shaders/resources/models/church_diffuse.png") ' Load model texture (diffuse map)
model.materials[0].maps[MAP_DIFFUSE].texture = texture                     ' Set model diffuse texture

Local position:RVector3 = New RVector3(0.0, 0.0, 0.0)                             ' Set model position

' Load all postpro shaders
' NOTE 1: All postpro shader use the base vertex shader (DEFAULT_VERTEX_SHADER)
' NOTE 2: We load the correct shader depending on GLSL version
Local shaders:RShader[MAX_POSTPRO_SHADERS]

' NOTE: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
shaders[FX_GRAYSCALE] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/grayscale.fs")
shaders[FX_POSTERIZATION] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/posterization.fs")
shaders[FX_DREAM_VISION] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/dream_vision.fs")
shaders[FX_PIXELIZER] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/pixelizer.fs")
shaders[FX_CROSS_HATCHING] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/cross_hatching.fs")
shaders[FX_CROSS_STITCHING] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/cross_stitching.fs")
shaders[FX_PREDATOR_VIEW] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/predator.fs")
shaders[FX_SCANLINES] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/scanlines.fs")
shaders[FX_FISHEYE] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/fisheye.fs")
shaders[FX_SOBEL] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/sobel.fs")
shaders[FX_BLOOM] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/bloom.fs")
shaders[FX_BLUR] = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/blur.fs")

Local currentShader:Int = FX_GRAYSCALE

' Create a RenderTexture2D to be used for render to texture
Local target:RRenderTexture2D = LoadRenderTexture(screenWidth, screenHeight)

' Setup orbital camera
SetCameraMode(camera, CAMERA_ORBITAL)  ' Set an orbital camera mode

SetTargetFPS(60)                       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()            ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera)              ' Update camera

	If IsKeyPressed(KEY_RIGHT) Then
		currentShader :+ 1
	Else If IsKeyPressed(KEY_LEFT) Then
		currentShader :- 1
	End If

	If currentShader >= MAX_POSTPRO_SHADERS Then
		currentShader = 0
	Else If currentShader < 0 Then
		currentShader = MAX_POSTPRO_SHADERS - 1
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginTextureMode(target)       ' Enable drawing to texture

			ClearBackground(RAYWHITE)  ' Clear texture background

			BeginMode3D(camera)        ' Begin 3d mode drawing

				DrawModel(model, position, 0.1, WHITE)   ' Draw 3d model with texture

				DrawGrid(10, 1.0)     ' Draw a grid

			EndMode3D()                ' End 3d mode drawing, returns to orthographic 2d mode

		EndTextureMode()               ' End drawing to texture (now we have a texture available for next passes)

		' Render previously generated texture using selected postpro shader
		BeginShaderMode(shaders[currentShader])

			' NOTE: Render texture must be y-flipped due to default OpenGL coordinates (left-bottom)
			DrawTextureRec(target.texture, New RRectangle(0, 0, target.texture.width, -target.texture.height), New RVector2(0, 0), WHITE)

		EndShaderMode()

		' Draw 2d shapes and text over drawn texture
		DrawRectangle(0, 9, 580, 30, Fade(LIGHTGRAY, 0.7))

		DrawText("(c) Church 3D model by Alberto Cano", screenWidth - 200, screenHeight - 20, 10, GRAY)

		DrawText("CURRENT POSTPRO SHADER:", 10, 15, 20, BLACK)
		DrawText(postproShaderText[currentShader], 330, 15, 20, RED)
		DrawText("< >", 540, 10, 30, DARKBLUE)

		DrawFPS(700, 15)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------

' Unload all postpro shaders
For Local i:Int = 0 Until MAX_POSTPRO_SHADERS
	UnloadShader(shaders[i])
Next

UnloadTexture(texture)         ' Unload texture
UnloadModel(model)             ' Unload model
UnloadRenderTexture(target)    ' Unload render texture

CloseWindow()                  ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
