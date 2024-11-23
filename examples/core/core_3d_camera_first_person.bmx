SuperStrict

Framework Ray.Lib
Import BRL.Math

Const MAX_COLUMNS:Int = 20

Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera first person")

' Define the camera to look into our 3d world (position, target, up vector)
Local camera:RCamera = New RCamera()
camera.position = New RVector3(0.0, 2.0, 4.0)     ' Camera position
camera.target = New RVector3(0.0, 2.0, 0.0)       ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0)           ' Camera up vector (rotation towards target)
camera.fovy = 60.0                                ' Camera field-of-view Y
camera.projection = CAMERA_PERSPECTIVE            ' Camera projection type

Local cameraMode:Int = CAMERA_FIRST_PERSON

' Generates some random columns
Local heights:Float[MAX_COLUMNS]
Local positions:RVector3[MAX_COLUMNS]
Local colors:RColor[MAX_COLUMNS]

For Local i:Int = 0 Until MAX_COLUMNS
	heights[i] = Float(GetRandomValue(1, 12))
	positions[i] = New RVector3(GetRandomValue(-15, 15), heights[i]/2, GetRandomValue(-15, 15))
	colors[i] = New RColor(GetRandomValue(20, 255), GetRandomValue(10, 55), 30, 255)
Next

DisableCursor()                            ' Limit cursor to relative movement inside the window

SetTargetFPS(60)                           ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()                ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' Switch camera mode
	If IsKeyPressed(KEY_ONE) Then
		cameraMode = CAMERA_FREE
		camera.up = New RVector3(0.0, 1.0, 0.0) ' Reset roll
	End If

	If IsKeyPressed(KEY_TWO) Then
		cameraMode = CAMERA_FIRST_PERSON
		camera.up = New RVector3(0.0, 1.0, 0.0) ' Reset roll
	End If

	If IsKeyPressed(KEY_THREE) Then
		cameraMode = CAMERA_THIRD_PERSON
		camera.up = New RVector3(0.0, 1.0, 0.0) ' Reset roll
	End If

	If IsKeyPressed(KEY_FOUR) Then
		cameraMode = CAMERA_ORBITAL
		camera.up = New RVector3(0.0, 1.0, 0.0) ' Reset roll
	End If

	' Switch camera projection
	If IsKeyPressed(KEY_P) Then
		if camera.projection = CAMERA_PERSPECTIVE Then
			' Create isometric view
			cameraMode = CAMERA_THIRD_PERSON
			' Note: The target distance is related to the render distance in the orthographic projection
			camera.position = New RVector3(0.0, 2.0, -100.0)
			camera.target = New RVector3(0.0, 2.0, 0.0)
			camera.up = New RVector3(0.0, 1.0, 0.0)
			camera.projection = CAMERA_ORTHOGRAPHIC
			camera.fovy = 20.0 ' near plane width in CAMERA_ORTHOGRAPHIC
			CameraYaw(camera, Deg2RadF(-135), True)
			CameraPitch(camera, Deg2RadF(-45), True, True, False)
		Else
			' Reset to default view
			cameraMode = CAMERA_THIRD_PERSON
			camera.position = New RVector3(0.0, 2.0, 10.0)
			camera.target = New RVector3(0.0, 2.0, 0.0)
			camera.up = New RVector3(0.0, 1.0, 0.0)
			camera.projection = CAMERA_PERSPECTIVE
			camera.fovy = 60.0
		End If
	End If

	' Update camera computes movement internally depending on the camera mode
	' Some default standard keyboard/mouse inputs are hardcoded to simplify use
	' For advance camera controls, it's reecommended to compute camera movement manually
	UpdateCamera(camera, cameraMode)                  ' Update camera
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

			' Draw player cube
			If cameraMode = CAMERA_THIRD_PERSON Then
				DrawCube(camera.target, 0.5, 0.5, 0.5, PURPLE)
				DrawCubeWires(camera.target, 0.5, 0.5, 0.5, DARKPURPLE)
			End If

		EndMode3D()

		DrawRectangle( 5, 5, 330, 100, Fade(SKYBLUE, 0.5))
		DrawRectangleLines( 5, 5, 330, 100, BLUE)

		DrawText("Camera controls:", 15, 15, 10, BLACK)
		DrawText("- Move keys: W, A, S, D, Space, Left-Ctrl", 15, 30, 10, BLACK)
		DrawText("- Look around: arrow keys or mouse", 15, 45, 10, BLACK)
		DrawText("- Camera mode keys: 1, 2, 3, 4", 15, 60, 10, BLACK)
		DrawText("- Zoom keys: num-plus, num-minus or mouse scroll", 15, 75, 10, BLACK)
		DrawText("- Camera projection key: P", 15, 90, 10, BLACK)

		DrawRectangle(600, 5, 195, 100, Fade(SKYBLUE, 0.5))
		DrawRectangleLines(600, 5, 195, 100, BLUE)

		DrawText("Camera status:", 610, 15, 10, BLACK)

		Local mode:String
		Select cameraMode
			Case CAMERA_FREE
				mode = "FREE"
			Case CAMERA_FIRST_PERSON
				mode = "FIRST_PERSON"
			Case CAMERA_THIRD_PERSON
				mode = "THIRD_PERSON"
			Case CAMERA_ORBITAL
				mode = "ORBITAL"
			Default
				mode = "CUSTOM"
		End Select

		DrawText("- Mode: " + mode, 610, 30, 10, BLACK)

		Local projection:String

		Select camera.projection
			Case CAMERA_PERSPECTIVE
				projection = "PERSPECTIVE"
			Case CAMERA_ORTHOGRAPHIC
				projection = "ORTHOGRAPHIC"
			Default
				projection = "CUSTOM"
		End Select

		DrawText("- Projection: " + projection, 610, 45, 10, BLACK)
		DrawText("- Position: (" + camera.position.x + ", " + camera.position.y + ", " + camera.position.z + ")", 610, 60, 10, BLACK)
		DrawText("- Target: (" + camera.target.x + ", " + camera.target.y + ", " + camera.target.z + ")", 610, 75, 10, BLACK)
		DrawText("- Up: (" + camera.up.x + ", " + camera.up.y + ", " + camera.up.z + ")", 610, 90, 10, BLACK)


	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
