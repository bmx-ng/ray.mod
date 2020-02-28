SuperStrict

Framework Ray.Lib

Const MAX_BUILDINGS:Int = 100

Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 2d camera")

Local player:RRectangle = New RRectangle(400, 280, 40, 40)
Local buildings:RRectangle[MAX_BUILDINGS]
Local buildColors:RColor[MAX_BUILDINGS]

Local spacing:Int = 0

For Local i:Int = 0 Until MAX_BUILDINGS
	buildings[i].width = GetRandomValue(50, 200)
	buildings[i].height = GetRandomValue(100, 800)
	buildings[i].y = screenHeight - 130 - buildings[i].height
	buildings[i].x = -6000 + spacing

	spacing :+ buildings[i].width

	buildColors[i] = New RColor(GetRandomValue(200, 240), GetRandomValue(200, 240), GetRandomValue(200, 250), 255)
Next

Local camera:RCamera2D = New RCamera2D()
camera.target = New RVector2(player.x + 20, player.y + 20)
camera.offset = New RVector2(screenWidth/2, screenHeight/2)
camera.Rotation = 0.0
camera.zoom = 1.0

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------

	' Player movement
	If IsKeyDown(KEY_RIGHT) Then
		player.x :+ 2
	Else If IsKeyDown(KEY_LEFT) Then
		player.x :- 2
	End If

	' Camera target follows player
	camera.target = New RVector2(player.x + 20, player.y + 20)

	' Camera rotation controls
	If IsKeyDown(KEY_A) Then
		camera.Rotation :- 1
	Else If IsKeyDown(KEY_S) Then
		camera.Rotation :+ 1
	End If

	' Limit camera rotation to 80 degrees (-40 to 40)
	If camera.Rotation > 40 Then
		camera.Rotation = 40
	Else If camera.Rotation < -40 Then
		camera.Rotation = -40
	End If

	' Camera zoom controls
	camera.zoom :+ Float(GetMouseWheelMove() * 0.05)

	If camera.zoom > 3.0 Then
		camera.zoom = 3.0
	Else If camera.zoom < 0.1 Then
		camera.zoom = 0.1
	End If

	' Camera reset (zoom and rotation)
	If IsKeyPressed(KEY_R) Then
		camera.zoom = 1.0
		camera.Rotation = 0.0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode2D(camera)

			DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY)

			For Local i:Int = 0 Until MAX_BUILDINGS
				DrawRectangleRec(buildings[i], buildColors[i])
			Next

			DrawRectangleRec(player, RED)

			DrawLine(camera.target.x, -screenHeight * 10, camera.target.x, screenHeight * 10, GREEN)
			DrawLine(-screenWidth * 10, camera.target.y, screenWidth * 10, camera.target.y, GREEN)

		EndMode2D()

		DrawText("SCREEN AREA", 640, 10, 20, RED)

		DrawRectangle(0, 0, screenWidth, 5, RED)
		DrawRectangle(0, 5, 5, screenHeight - 10, RED)
		DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, RED)
		DrawRectangle(0, screenHeight - 5, screenWidth, 5, RED)

		DrawRectangle( 10, 10, 250, 113, Fade(SKYBLUE, 0.5))
		DrawRectangleLines( 10, 10, 250, 113, BLUE)

		DrawText("Free 2d camera controls:", 20, 20, 10, BLACK)
		DrawText("- Right/Left to move Offset", 40, 40, 10, DARKGRAY)
		DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY)
		DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY)
		DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
