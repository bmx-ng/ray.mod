SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d picking")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(10.0, 10.0, 10.0) ' Camera position
camera.target = New RVector3(0.0, 0.0, 0.0)      ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0)          ' Camera up vector (rotation towards target)
camera.fovy = 45.0                                ' Camera field-of-view Y
camera.projection = CAMERA_PERSPECTIVE                   ' Camera mode type

Local cubePosition:RVector3 = New RVector3(0.0, 1.0, 0.0)
Local cubeSize:RVector3 = New RVector3(2.0, 2.0, 2.0)

Local ray:RRay                    ' Picking line ray
Local collision:RRayCollision ' Ray collision hit info

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsCursorHidden() Then
		UpdateCamera(camera, CAMERA_FIRST_PERSON)
	End If

	' Toggle camera controls
	If IsMouseButtonPressed(MOUSE_BUTTON_RIGHT) Then
		If IsCursorHidden() Then
			EnableCursor()
		Else
			DisableCursor()
		End If
	End If

	If IsMouseButtonPressed(MOUSE_LEFT_BUTTON) Then
		If Not collision.hit Then
			ray = GetScreenToWorldRay(GetMousePosition(), camera)

			' Check collision between ray and box
			collision = GetRayCollisionBox(ray, ..
						New RBoundingBox(New RVector3(cubePosition.x - cubeSize.x/2, cubePosition.y - cubeSize.y/2, cubePosition.z - cubeSize.z/2), ..
									     New RVector3(cubePosition.x + cubeSize.x/2, cubePosition.y + cubeSize.y/2, cubePosition.z + cubeSize.z/2)))
		Else
			collision.hit = False
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			If collision.hit Then
				DrawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, RED)
				DrawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, MAROON)

				DrawCubeWires(cubePosition, cubeSize.x + 0.2, cubeSize.y + 0.2, cubeSize.z + 0.2, GREEN)
			Else
				DrawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, GRAY)
				DrawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, DARKGRAY)
			End If

			DrawRay(ray, MAROON)
			DrawGrid(10, 1.0)

		EndMode3D()

		DrawText("Try selecting the box with mouse!", 240, 10, 20, DARKGRAY)

		If collision.hit Then
			DrawText("BOX SELECTED", (screenWidth - MeasureText("BOX SELECTED", 30)) / 2, Int(screenHeight * 0.1), 30, GREEN)
		End If

		DrawText("Right click mouse to toggle camera controls", 10, 430, 10, GRAY)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
