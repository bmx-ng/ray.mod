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

SetConfigFlags(FLAG_MSAA_4X_HINT)      ' Enable Multi Sampling Anti Aliasing 4x (if available)

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - custom uniform variable")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(8.0, 8.0, 8.0)
camera.target = New RVector3(0.0, 1.5, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 45.0
camera.projection = CAMERA_PERSPECTIVE

Local model:RModel = LoadModel("../../lib.mod/raylib/examples/shaders/resources/models/barracks.obj")                   ' Load OBJ model
Local texture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/shaders/resources/models/barracks_diffuse.png")   ' Load model texture (diffuse map)
model.materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = texture                     ' Set model diffuse texture

Local position:RVector3                                    ' Set model position

' Load postprocessing shader
' NOTE: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
Local shader:RShader = LoadShader(0, "../../lib.mod/raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/swirl.fs")

' Get variable (uniform) location on the shader to connect with the program
' NOTE: If uniform variable could not be found in the shader, function returns -1
Local swirlCenterLoc:Int = GetShaderLocation(shader, "center")

Local swirlCenter:Float[] = [Float(screenWidth/2), Float(screenHeight/2)]

' Create a RenderTexture2D to be used for render to texture
Local target:RRenderTexture2D = LoadRenderTexture(screenWidth, screenHeight)

SetTargetFPS(60)                       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()            ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera, CAMERA_ORBITAL)              ' Update camera

	Local mousePosition:RVector2 = GetMousePosition()

	swirlCenter[0] = mousePosition.x
	swirlCenter[1] = screenHeight - mousePosition.y

	' Send new value to the shader to be used on drawing
	SetShaderValue(shader, swirlCenterLoc, swirlCenter, SHADER_UNIFORM_VEC2)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginTextureMode(target)       ' Enable drawing to texture

		ClearBackground(RAYWHITE)  ' Clear texture background

		BeginMode3D(camera)        ' Begin 3d mode drawing
			DrawModel(model, position, 0.5, WHITE)   ' Draw 3d model with texture
			DrawGrid(10, 1.0)     ' Draw a grid
		EndMode3D()                ' End 3d mode drawing, returns to orthographic 2d mode

		DrawText("TEXT DRAWN IN RENDER TEXTURE", 200, 10, 30, RED)
	EndTextureMode()               ' End drawing to texture (now we have a texture available for next passes)

	BeginDrawing()
		ClearBackground(RAYWHITE)

		BeginShaderMode(shader)
			' NOTE: Render texture must be y-flipped due to default OpenGL coordinates (left-bottom)
		 	DrawTextureRec(target.texture, New RRectangle(0, 0, target.texture.width, -target.texture.height), New RVector2( 0, 0 ), WHITE)
		EndShaderMode()

		' Draw some 2d text over drawn texture
		DrawText("(c) Barracks 3D model by Alberto Cano", screenWidth - 220, screenHeight - 20, 10, GRAY)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)           ' Unload shader
UnloadTexture(texture)         ' Unload texture
UnloadModel(model)             ' Unload model
UnloadRenderTexture(target)    ' Unload render texture

CloseWindow()                  ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
