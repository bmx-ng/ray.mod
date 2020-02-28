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

Local texAngleGauge:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/angle_gauge.png")
Local texBackground:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/background.png")
Local texPitch:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/pitch.png")
Local texPlane:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/plane.png")

Local framebuffer:RRenderTexture2D = LoadRenderTexture(192, 192)

' Model loading
Local model:RModel = LoadModel("../../lib.mod/raylib/examples/models/resources/plane.obj")     ' Load OBJ model
model.materials[0].maps[MAP_DIFFUSE].texture = LoadTexture("../../lib.mod/raylib/examples/models/resources/plane_diffuse.png") ' Set map diffuse texture

GenTextureMipmaps(model.materials[0].maps[MAP_DIFFUSE].texture)

Local camera:RCamera
camera.position = New RVector3(0.0, 60.0, -120.0)  ' Camera position perspective
camera.target = New RVector3(0.0, 12.0, 0.0)       ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0)            ' Camera up vector (rotation towards target)
camera.fovy = 30.0                                 ' Camera field-of-view Y
camera.cameraType = CAMERA_PERSPECTIVE             ' Camera type

Local pitch:Float = 0.0
Local roll:Float = 0.0
Local yaw:Float = 0.0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------

	' Plane roll (x-axis) controls
	If IsKeyDown(KEY_LEFT) Then
		roll :+ 1.0
	Else If IsKeyDown(KEY_RIGHT) Then
		roll :- 1.0
	Else
		If roll > 0.0 Then
			roll :- 0.5
		Else If roll < 0.0 Then
			roll :+ 0.5
		End If
	End If

	' Plane yaw (y-axis) controls
	If IsKeyDown(KEY_S) Then
		yaw :+ 1.0
	Else If IsKeyDown(KEY_A) Then
		yaw :- 1.0
	Else
		If yaw > 0.0 Then
			yaw :- 0.5
		Else If yaw < 0.0 Then
			yaw :+ 0.5
		End If
	End If

	' Plane pitch (z-axis) controls
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

	' Wraps the phase of an angle to fit between -180 and +180 degrees
	Local pitchOffset:Int = pitch
	While pitchOffset > 180
		pitchOffset :- 360
	Wend
	While pitchOffset < -180
		pitchOffset :+ 360
	Wend
	pitchOffset :* 10

	Rem
	' matrix transform done with multiplication To combine rotations
	Local transform:RMatrix = MatrixIdentity()

	transform = MatrixMultiply(transform, MatrixRotateZ(roll))
	transform = MatrixMultiply(transform, MatrixRotateX(pitch))
	transform = MatrixMultiply(transform, MatrixRotateY(yaw))

	model.transform = transform
	End Rem
	' matrix created from multiple axes at once
	model.transform = MatrixRotateXYZ(New RVector3(pitch, yaw, roll))

	'----------------------------------------------------------------------------------
	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' Draw framebuffer texture (Ahrs Display)
		Local centerX:Int = framebuffer.texture.width/2
		Local centerY:Int = framebuffer.texture.height/2
		Local scaleFactor:Float = 0.5

		BeginTextureMode(framebuffer)

			BeginBlendMode(BLEND_ALPHA)

			DrawTexturePro(texBackground, New RRectangle(0, 0, texBackground.width, texBackground.height), ..
						   New RRectangle(centerX, centerY, texBackground.width*scaleFactor, texBackground.height*scaleFactor), ..
						   New RVector2(texBackground.width/2*scaleFactor, texBackground.height/2*scaleFactor + pitchOffset*scaleFactor), roll, WHITE)

			DrawTexturePro(texPitch, New RRectangle(0, 0, texPitch.width, texPitch.height), ..
						   New RRectangle(centerX, centerY, texPitch.width*scaleFactor, texPitch.height*scaleFactor), ..
						   New RVector2(texPitch.width/2*scaleFactor, texPitch.height/2*scaleFactor + pitchOffset*scaleFactor), roll, WHITE)

			DrawTexturePro(texPlane, New RRectangle(0, 0, texPlane.width, texPlane.height), ..
						   New RRectangle(centerX, centerY, texPlane.width*scaleFactor, texPlane.height*scaleFactor), ..
						   New RVector2(texPlane.width/2*scaleFactor, texPlane.height/2*scaleFactor), 0, WHITE)

			EndBlendMode()

		EndTextureMode()

		' Draw 3D model (recomended to draw 3D always before 2D)
		BeginMode3D(camera)

			DrawModel(model, New RVector3(0, 6.0, 0), 1.0, WHITE)   ' Draw 3d model with texture
			DrawGrid(10, 10.0)

		EndMode3D()

		' Draw 2D GUI stuff
		DrawAngleGauge(texAngleGauge, 80, 70, roll, "roll", RED)
		DrawAngleGauge(texAngleGauge, 190, 70, pitch, "pitch", GREEN)
		DrawAngleGauge(texAngleGauge, 300, 70, yaw, "yaw", SKYBLUE)

		DrawRectangle(30, 360, 260, 70, Fade(SKYBLUE, 0.5))
		DrawRectangleLines(30, 360, 260, 70, Fade(DARKBLUE, 0.5))
		DrawText("Pitch controlled with: KEY_UP / KEY_DOWN", 40, 370, 10, DARKGRAY)
		DrawText("Roll controlled with: KEY_LEFT / KEY_RIGHT", 40, 390, 10, DARKGRAY)
		DrawText("Yaw controlled with: KEY_A / KEY_S", 40, 410, 10, DARKGRAY)

		' Draw framebuffer texture
		DrawTextureRec(framebuffer.texture, New RRectangle(0, 0, framebuffer.texture.width, -framebuffer.texture.height), ..
					   New RVector2(screenWidth - framebuffer.texture.width - 20, 20), Fade(WHITE, 0.8))

		DrawRectangleLines(screenWidth - framebuffer.texture.width - 20, 20, framebuffer.texture.width, framebuffer.texture.height, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------

' Unload all loaded data
UnloadTexture(model.materials[0].maps[MAP_DIFFUSE].texture)
UnloadModel(model)

UnloadRenderTexture(framebuffer)

UnloadTexture(texAngleGauge)
UnloadTexture(texBackground)
UnloadTexture(texPitch)
UnloadTexture(texPlane)

CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------


' Draw angle gauge controls
Function DrawAngleGauge(angleGauge:RTexture2D, x:Int, y:Int, angle:Float, title:String, color:RColor)

	Local srcRec:RRectangle = New RRectangle(0, 0, angleGauge.width, angleGauge.height)
	Local dstRec:RRectangle = New RRectangle(x, y, angleGauge.width, angleGauge.height)
	Local origin:RVector2 = New RVector2(angleGauge.width/2, angleGauge.height/2)
	Local textSize:Int = 20

	DrawTexturePro(angleGauge, srcRec, dstRec, origin, angle, color)

	Local formatted:String = formatter.Arg(angle).Format()
	formatter.Clear()

	DrawText(formatted, x - MeasureText(formatted, textSize) / 2, y + 10, textSize, DARKGRAY)
	DrawText(title, x - MeasureText(title, textSize) / 2, y + 60, textSize, DARKGRAY)
End Function
