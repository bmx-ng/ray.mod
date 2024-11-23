SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera free")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(10.0, 10.0, 10.0) ' Camera position
camera.target = New RVector3(0.0, 0.0, 0.0)      ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0)          ' Camera up vector (rotation towards target)
camera.fovy = 45.0                               ' Camera field-of-view Y
camera.projection = CAMERA_PERSPECTIVE           ' Camera mode type

Local cubePosition:RVector3 = New RVector3(0.0, 0.0, 0.0)

DisableCursor()                    ' Limit cursor to relative movement inside the window

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera, CAMERA_FREE)          ' Update camera

	If IsKeyDown(Asc("Z")) Then
		camera.target = New RVector3(0.0, 0.0, 0.0)
	End If
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

		DrawRectangle( 10, 10, 320, 93, Fade(SKYBLUE, 0.5))
		DrawRectangleLines( 10, 10, 320, 93, BLUE)

		DrawText("Free camera default controls:", 20, 20, 10, BLACK)
		DrawText("- Mouse Wheel to Zoom in-out", 40, 40, 10, DARKGRAY)
		DrawText("- Mouse Wheel Pressed to Pan", 40, 60, 10, DARKGRAY)
		DrawText("- Z to zoom to (0, 0, 0)", 40, 80, 10, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
