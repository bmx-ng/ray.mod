SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - drawing billboards")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(5.0, 4.0, 5.0)
camera.target = New RVector3(0.0, 2.0, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 45.0
camera.cameraType = CAMERA_PERSPECTIVE

Local bill:RTexture2D = LoadTexture("../../raylib/examples/models/resources/billboard.png")     ' Our texture billboard
Local billPosition:RVector3 = New RVector3(0.0, 2.0, 0.0)                 ' Position where draw billboard

SetCameraMode(camera, CAMERA_ORBITAL)  ' Set an orbital camera mode

SetTargetFPS(60)                       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()            ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera)              ' Update camera
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			DrawGrid(10, 1.0)        ' Draw a grid

			DrawBillboard(camera, bill, billPosition, 2.0, WHITE)

		EndMode3D()

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(bill)        ' Unload texture

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
