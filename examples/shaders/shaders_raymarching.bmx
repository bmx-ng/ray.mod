SuperStrict

Framework Ray.Lib

?win32
Const GLSL_VERSION:Int = 330
?raspberrypi
Const GLSL_VERSION:Int = 100
?

' Initialization
'--------------------------------------------------------------------------------------
Local screenWidth:Int = 800
Local screenHeight:Int = 450

SetConfigFlags(FLAG_WINDOW_RESIZABLE)
InitWindow(screenWidth, screenHeight, "raylib [shaders] example - raymarching shapes")

Local camera:RCamera
camera.position = New RVector3(2.5, 2.5, 3.0)    ' Camera position
camera.target = New RVector3(0.0, 0.0, 0.7)      ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0 )          ' Camera up vector (rotation towards target)
camera.fovy = 65.0                               ' Camera field-of-view Y

SetCameraMode(camera, CAMERA_FREE)                 ' Set camera mode

' Load raymarching shader
' NOTE: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
Local shader:RShader = LoadShader(0, "../../raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/raymarching.fs")

' Get shader locations for required uniforms
Local viewEyeLoc:Int = GetShaderLocation(shader, "viewEye")
Local viewCenterLoc:Int = GetShaderLocation(shader, "viewCenter")
Local runTimeLoc:Int = GetShaderLocation(shader, "runTime")
Local resolutionLoc:Int = GetShaderLocation(shader, "resolution")

Local resolution:Float[] = [Float(screenWidth), Float(screenHeight)]
SetShaderValue(shader, resolutionLoc, resolution, UNIFORM_VEC2)

Local runTime:Float = 0.0

SetTargetFPS(60)                       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()            ' Detect window close button or ESC key
	' Check if screen is resized
	'----------------------------------------------------------------------------------
	If IsWindowResized() Then
		screenWidth = GetScreenWidth()
		screenHeight = GetScreenHeight()
		Local resolution:Float[] = [Float(screenWidth), Float(screenHeight)]
		SetShaderValue(shader, resolutionLoc, resolution, UNIFORM_VEC2)
	End If

	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera)              ' Update camera

	Local cameraPos:Float[] = [ camera.position.x, camera.position.y, camera.position.z ]
	Local cameraTarget:Float[] = [ camera.target.x, camera.target.y, camera.target.z ]

	Local deltaTime:Float = GetFrameTime()
	runTime :+ deltaTime

	' Set shader required uniform values
	SetShaderValue(shader, viewEyeLoc, cameraPos, UNIFORM_VEC3)
	SetShaderValue(shader, viewCenterLoc, cameraTarget, UNIFORM_VEC3)
	SetShaderValue(shader, runTimeLoc, Varptr runTime, UNIFORM_FLOAT)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' We only draw a white full-screen rectangle,
		' frame is generated in shader using raymarching
		BeginShaderMode(shader)
			DrawRectangle(0, 0, screenWidth, screenHeight, WHITE)
		EndShaderMode()

		DrawText("(c) Raymarching shader by Iñigo Quilez. MIT License.", screenWidth - 280, screenHeight - 20, 10, BLACK)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)           ' Unload shader

CloseWindow()                  ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
