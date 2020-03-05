SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera free")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(10.0, 10.0, 10.0)
camera.target = New RVector3(0.0, 0.0, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 45.0
camera.cameraType = CAMERA_PERSPECTIVE

Local cubePosition:RVector3 = New RVector3(0.0, 0.0, 0.0)
Local cubeScreenPosition:RVector2 = New RVector2(0.0, 0.0)

SetCameraMode(camera, CAMERA_FREE) ' Set a free camera mode

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera)          ' Update camera

	' Calculate cube screen space position (with a little offset to be in top)
	cubeScreenPosition = GetWorldToScreen(New RVector3(cubePosition.x, cubePosition.y + 2.5, cubePosition.z), camera)
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

		DrawText("Enemy: 100 / 100", Int(cubeScreenPosition.x - MeasureText("Enemy: 100/100", 20)/2), Int(cubeScreenPosition.y), 20, BLACK)
		DrawText("Text is always on top of the cube", (screenWidth - MeasureText("Text is always on top of the cube", 20))/2, 25, 20, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
