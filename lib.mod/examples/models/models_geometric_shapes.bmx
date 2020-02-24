SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - geometric shapes")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(0.0, 10.0, 10.0)
camera.target = New RVector3(0.0, 0.0, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 45.0
camera.cameraType = CAMERA_PERSPECTIVE

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

			DrawCube(New RVector3(-4.0, 0.0, 2.0), 2.0, 5.0, 2.0, RED)
			DrawCubeWires(New RVector3(-4.0, 0.0, 2.0), 2.0, 5.0, 2.0, GOLD)
			DrawCubeWires(New RVector3(-4.0, 0.0, -2.0), 3.0, 6.0, 2.0, MAROON)

			DrawSphere(New RVector3(-1.0, 0.0, -2.0), 1.0, GREEN)
			DrawSphereWires(New RVector3(1.0, 0.0, 2.0), 2.0, 16, 16, LIME)

			DrawCylinder(New RVector3(4.0, 0.0, -2.0), 1.0, 2.0, 3.0, 4, SKYBLUE)
			DrawCylinderWires(New RVector3(4.0, 0.0, -2.0), 1.0, 2.0, 3.0, 4, DARKBLUE)
			DrawCylinderWires(New RVector3(4.5, -1.0, 2.0), 1.0, 1.0, 2.0, 6, BROWN)

			DrawCylinder(New RVector3(1.0, 0.0, -4.0), 0.0, 1.5, 3.0, 8, GOLD)
			DrawCylinderWires(New RVector3(1.0, 0.0, -4.0), 0.0, 1.5, 3.0, 8, PINK)

			DrawGrid(10, 1.0)        ' Draw a grid

		EndMode3D()

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
