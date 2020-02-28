SuperStrict

Framework Ray.Lib

Const MAX_COLUMNS:Int = 20

Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera first person")

' Define the camera to look into our 3d world (position, target, up vector)
Local camera:RCamera = New RCamera()
camera.position = New RVector3(4.0, 2.0, 4.0)
camera.target = New RVector3(0.0, 1.8, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 60.0
camera.cameraType = CAMERA_PERSPECTIVE

' Generates some random columns
Local heights:Float[MAX_COLUMNS]
Local positions:RVector3[MAX_COLUMNS]
Local colors:RColor[MAX_COLUMNS]

For Local i:Int = 0 Until MAX_COLUMNS
	heights[i] = Float(GetRandomValue(1, 12))
	positions[i] = New RVector3(GetRandomValue(-15, 15), heights[i]/2, GetRandomValue(-15, 15))
	colors[i] = New RColor(GetRandomValue(20, 255), GetRandomValue(10, 55), 30, 255)
Next

SetCameraMode(camera, CAMERA_FIRST_PERSON) ' Set a first person camera mode

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

			DrawPlane(New RVector3(0.0, 0.0, 0.0), New RVector2(32.0, 32.0), LIGHTGRAY) ' Draw ground
			DrawCube(New RVector3(-16.0, 2.5, 0.0), 1.0, 5.0, 32.0, BLUE)     ' Draw a blue wall
			DrawCube(New RVector3(16.0, 2.5, 0.0), 1.0, 5.0, 32.0, LIME)      ' Draw a green wall
			DrawCube(New RVector3(0.0, 2.5, 16.0), 32.0, 5.0, 1.0, GOLD)      ' Draw a yellow wall

			' Draw some cubes around
			For Local i:Int = 0 Until MAX_COLUMNS
				DrawCube(positions[i], 2.0, heights[i], 2.0, colors[i])
				DrawCubeWires(positions[i], 2.0, heights[i], 2.0, MAROON)
			Next

		EndMode3D()

		DrawRectangle( 10, 10, 220, 70, Fade(SKYBLUE, 0.5))
		DrawRectangleLines( 10, 10, 220, 70, BLUE)

		DrawText("First person camera default controls:", 20, 20, 10, BLACK)
		DrawText("- Move with keys: W, A, S, D", 40, 40, 10, DARKGRAY)
		DrawText("- Mouse move to look around", 40, 60, 10, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
