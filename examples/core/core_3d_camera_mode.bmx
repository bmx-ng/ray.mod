SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera mode")

' Define the camera to look into our 3d world
Local camera:RCamera = New RCamera
camera.position = New RVector3(0.0, 10.0, 10.0)  ' Camera position
camera.target = New RVector3(0.0, 0.0, 0.0)      ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0)          ' Camera up vector (rotation towards target)
camera.fovy = 45.0                               ' Camera field-of-view Y
camera.projection = CAMERA_PERSPECTIVE           ' Camera mode type

Local cubePosition:RVector3 = New RVector3(0.0, 0.0, 0.0)

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

		BeginMode3D(camera)

			DrawCube(cubePosition, 2.0, 2.0, 2.0, RED)
			DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON)

			DrawGrid(10, 1.0)

		EndMode3D()

		DrawText("Welcome to the third dimension!", 10, 40, 20, DARKGRAY)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
