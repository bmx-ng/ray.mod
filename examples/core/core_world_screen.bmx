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
camera.projection = CAMERA_PERSPECTIVE

Local cubePosition:RVector3 = New RVector3(0.0, 0.0, 0.0)
Local cubeScreenPosition:RVector2 = New RVector2(0.0, 0.0)

DisableCursor()                    ' Limit cursor to relative movement inside the window

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera, CAMERA_THIRD_PERSON)          ' Update camera

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

		DrawText("Cube position in screen space coordinates: [ " + Int(cubeScreenPosition.x) + ", " + Int(cubeScreenPosition.y) + "]", 10, 10, 20, LIME);
		DrawText("Text 2d should be always on top of the cube", 10, 40, 20, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
