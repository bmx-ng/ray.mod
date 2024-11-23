SuperStrict

Framework Ray.Lib
Import Ray.Math
Import Text.Format

Global formatter:TFormatter = TFormatter.Create("%5.1f")

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - plane rotations (yaw, pitch, roll)")

Local camera:RCamera
camera.position = New RVector3(0.0, 50.0, -120.0)  ' Camera position perspective
camera.target = New RVector3(0.0, 0.0, 0.0)        ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0)            ' Camera up vector (rotation towards target)
camera.fovy = 30.0                                 ' Camera field-of-view Y
camera.projection = CAMERA_PERSPECTIVE             ' Camera type

Local model:RModel = LoadModel("../../lib.mod/raylib/examples/models/resources/models/obj/plane.obj")     ' Load OBJ model
Local texture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/models/obj/plane_diffuse.png") ' Load model texture
model.materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = texture ' Set map diffuse texture

Local pitch:Float = 0.0
Local roll:Float = 0.0
Local yaw:Float = 0.0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------

	' Plane pitch (x-axis) controls
	If IsKeyDown(KEY_DOWN) Then
		pitch :+ 0.6
	Else If IsKeyDown(KEY_UP) Then
		pitch :- 0.6
	Else
		If pitch > 0.3 Then
			pitch :- 0.3
		Else If pitch < -0.3 Then
			pitch :+ 0.3
		End If
	End If

	' Plane yaw (y-axis) controls
	If IsKeyDown(KEY_S) Then
		yaw :- 1.0
	Else If IsKeyDown(KEY_A) Then
		yaw :+ 1.0
	Else
		If yaw > 0.0 Then
			yaw :- 0.5
		Else If yaw < 0.0 Then
			yaw :+ 0.5
		End If
	End If

	' Plane roll (z-axis) controls
	If IsKeyDown(KEY_LEFT) Then
		roll :- 1.0
	Else If IsKeyDown(KEY_RIGHT) Then
		roll :+1.0
	Else
		If roll > 0.0 Then
			roll :- 0.5
		Else If roll < 0.0 Then
			roll :+ 0.5
		End If
	End If

	' Tranformation matrix for rotations
	model.transform = MatrixRotateXYZ(New RVector3(pitch, yaw, roll))

	'----------------------------------------------------------------------------------
	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' Draw 3D model (recomended to draw 3D always before 2D)
		BeginMode3D(camera)

			DrawModel(model, New RVector3(0.0, -8.0, 0.0), 1.0, WHITE)   ' Draw 3d model with texture
			DrawGrid(10, 10.0)

		EndMode3D()

		' Draw controls info
		DrawRectangle(30, 370, 260, 70, Fade(GREEN, 0.5))
		DrawRectangleLines(30, 370, 260, 70, Fade(DARKGREEN, 0.5))
		DrawText("Pitch controlled with: KEY_UP / KEY_DOWN", 40, 380, 10, DARKGRAY)
		DrawText("Roll controlled with: KEY_LEFT / KEY_RIGHT", 40, 400, 10, DARKGRAY)
		DrawText("Yaw controlled with: KEY_A / KEY_S", 40, 420, 10, DARKGRAY)

		DrawText("(c) WWI Plane Model created by GiaHanLam", screenWidth - 240, screenHeight - 20, 10, DARKGRAY)


	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------

' Unload all loaded data
UnloadModel(model)     ' Unload model data
UnloadTexture(texture) ' Unload texture data

CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
