SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - model animation")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(10.0, 10.0, 10.0) ' Camera position
camera.target = New RVector3(0.0, 0.0, 0.0)      ' Camera looking at point
camera.up = New RVector3(0.0, 1.0, 0.0)          ' Camera up vector (rotation towards target)
camera.fovy = 45.0                                ' Camera field-of-view Y
camera.cameraType = CAMERA_PERSPECTIVE                   ' Camera mode type


Local model:RModel = LoadModel("../../raylib/examples/models/resources/guy/guy.iqm")               ' Load the animated model mesh and basic data
Local texture:RTexture2D = LoadTexture("../../raylib/examples/models/resources/guy/guytex.png")    ' Load model texture and set material
SetMaterialTexture(model.materials[0], MAP_DIFFUSE, texture)  ' Set model material map texture

Local position:RVector3            ' Set model position

' Load animation data
Local animsCount:Int = 0
Local anims:RModelAnimation Ptr = LoadModelAnimations("../../raylib/examples/models/resources/guy/guyanim.iqm", animsCount)
Local animFrameCounter:Int = 0

SetCameraMode(camera, CAMERA_FREE) ' Set free camera mode

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera)

	' Play animation when spacebar is held down
	If IsKeyDown(KEY_SPACE) Then
		animFrameCounter :+ 1
		UpdateModelAnimation(model, anims[0], animFrameCounter)
		If animFrameCounter >= anims[0].frameCount Then
			animFrameCounter = 0
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			DrawModelEx(model, position, New RVector3(1.0, 0.0, 0.0), -90.0, New RVector3(1.0, 1.0, 1.0), WHITE)

			For Local i:Int = 0 Until model.boneCount
				DrawCube(anims[0].framePoses[animFrameCounter][i].Translation, 0.2, 0.2, 0.2, RED)
			Next

			DrawGrid(10, 1.0)         ' Draw a grid

		EndMode3D()

		DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, MAROON)
		DrawText("(c) Guy IQM 3D model by @culacant", screenWidth - 200, screenHeight - 20, 10, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture)     ' Unload texture

' Unload model animations data
For Local i:Int = 0 Until animsCount
	UnloadModelAnimation(anims[i])
Next
RlFree(anims)

UnloadModel(model)         ' Unload model

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
