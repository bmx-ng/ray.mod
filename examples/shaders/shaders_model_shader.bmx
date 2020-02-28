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

SetConfigFlags(FLAG_MSAA_4X_HINT)      ' Enable Multi Sampling Anti Aliasing 4x (if available)

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - model shader")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(4.0, 4.0, 4.0)
camera.target = New RVector3(0.0, 1.0, -1.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 45.0
camera.cameraType = CAMERA_PERSPECTIVE

Local model:RModel = LoadModel("../../lib.mod/raylib/examples/shaders/resources/models/watermill.obj")                   ' Load OBJ model
Local texture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/shaders/resources/models/watermill_diffuse.png")   ' Load model texture

' Load shader for model
' NOTE: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
Local shader:RShader = LoadShader(0, "../../lib.mod/raylib/examples/shaders/resources/shaders/glsl"  + GLSL_VERSION + "/grayscale.fs")

model.materials[0].shader = shader                     ' Set shader effect to 3d model
model.materials[0].maps[MAP_DIFFUSE].texture = texture ' Bind texture to model

Local position:RVector3 = New RVector3(0.0, 0.0, 0.0)    ' Set model position

SetCameraMode(camera, CAMERA_FREE)         ' Set an orbital camera mode

SetTargetFPS(60)                           ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()                ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera)                  ' Update camera
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			DrawModel(model, position, 0.2, WHITE)   ' Draw 3d model with texture

			DrawGrid(10, 1.0)     ' Draw a grid

		EndMode3D()

		DrawText("(c) Watermill 3D model by Alberto Cano", screenWidth - 210, screenHeight - 20, 10, GRAY)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)       ' Unload shader
UnloadTexture(texture)     ' Unload texture
UnloadModel(model)         ' Unload model

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
