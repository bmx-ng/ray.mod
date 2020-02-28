SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - box collisions")

' Define the camera to look into our 3d world
Local camera:RCamera = New RCamera(New RVector3(0.0, 10.0, 10.0), New RVector3(0.0, 0.0, 0.0), New RVector3(0.0, 1.0, 0.0), 45.0, 0)

Local playerPosition:RVector3 = New RVector3(0.0, 1.0, 2.0)
Local playerSize:RVector3 = New RVector3(1.0, 2.0, 1.0)
Local playerColor:RColor = GREEN

Local enemyBoxPos:RVector3 = New RVector3(-4.0, 1.0, 0.0)
Local enemyBoxSize:RVector3 = New RVector3(2.0, 2.0, 2.0)

Local enemySpherePos:RVector3 = New RVector3(4.0, 0.0, 0.0)
Local enemySphereSize:Float = 1.5

Local collision:Int = False

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------

	' Move player
	If IsKeyDown(KEY_RIGHT) Then
		playerPosition.x :+ 0.2
	Else If IsKeyDown(KEY_LEFT) Then
		playerPosition.x :- 0.2
	Else If IsKeyDown(KEY_DOWN) Then
		playerPosition.z :+ 0.2
	Else If IsKeyDown(KEY_UP) Then
		playerPosition.z :- 0.2
	End If

	collision = False

	' Check collisions player vs enemy-box
	If CheckCollisionBoxes( ..
			New RBoundingBox(New RVector3(playerPosition.x - playerSize.x/2, playerPosition.y - playerSize.y/2, playerPosition.z - playerSize.z/2), ..
						New RVector3(playerPosition.x + playerSize.x/2, playerPosition.y + playerSize.y/2, playerPosition.z + playerSize.z/2) ), ..
			New RBoundingBox(New RVector3(enemyBoxPos.x - enemyBoxSize.x/2, enemyBoxPos.y - enemyBoxSize.y/2, enemyBoxPos.z - enemyBoxSize.z/2), ..
						New RVector3(enemyBoxPos.x + enemyBoxSize.x/2, enemyBoxPos.y + enemyBoxSize.y/2, enemyBoxPos.z + enemyBoxSize.z/2) ) ) Then
		collision = True
	End If

	' Check collisions player vs enemy-sphere
	If CheckCollisionBoxSphere( ..
				New RBoundingBox(New RVector3(playerPosition.x - playerSize.x/2, playerPosition.y - playerSize.y/2, playerPosition.z - playerSize.z/2),
					  New RVector3(playerPosition.x + playerSize.x/2, playerPosition.y + playerSize.y/2, playerPosition.z + playerSize.z/2) ), ..
				enemySpherePos, enemySphereSize) Then
		collision = True
	End If

	If collision Then
		playerColor = RED
	Else
		playerColor = GREEN
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			' Draw enemy-box
			DrawCube(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, GRAY)
			DrawCubeWires(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, DARKGRAY)

			' Draw enemy-sphere
			DrawSphere(enemySpherePos, enemySphereSize, GRAY)
			DrawSphereWires(enemySpherePos, enemySphereSize, 16, 16, DARKGRAY)

			' Draw player
			DrawCubeV(playerPosition, playerSize, playerColor)

			DrawGrid(10, 1.0)        ' Draw a grid

		EndMode3D()

		DrawText("Move player with cursors to collide", 220, 40, 20, GRAY)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
