SuperStrict

Framework Ray.Lib

' Initialization
'---------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - collision area")

' Box A: Moving box
Local boxA:RRectangle = New RRectangle(10, GetScreenHeight()/2 - 50, 200, 100)
Local boxASpeedX:Int = 4

' Box B: Mouse moved box
Local boxB:RRectangle = New RRectangle(GetScreenWidth()/2 - 30, GetScreenHeight()/2 - 30, 60, 60)

Local boxCollision:RRectangle ' Collision rectangle

Local screenUpperLimit:Int = 40      ' Top menu limits

Local pause:Int = False             ' Movement pause
Local collision:Int = False         ' Collision detection

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'----------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'-----------------------------------------------------
	' Move box if not paused
	If Not pause Then
		boxA.x :+ boxASpeedX
	End If

	' Bounce box on x screen limits
	If ((boxA.x + boxA.width) >= GetScreenWidth()) Or (boxA.x <= 0) Then
		boxASpeedX :* -1
	End If

	' Update player-controlled-box (box02)
	boxB.x = GetMouseX() - boxB.width/2
	boxB.y = GetMouseY() - boxB.height/2

	' Make sure Box B does not go out of move area limits
	If (boxB.x + boxB.width) >= GetScreenWidth() Then
		boxB.x = GetScreenWidth() - boxB.width
	Else If boxB.x <= 0 Then
		boxB.x = 0
	End If

	If (boxB.y + boxB.height) >= GetScreenHeight() Then
		boxB.y = GetScreenHeight() - boxB.height
	Else If boxB.y <= screenUpperLimit Then
		boxB.y = screenUpperLimit
	End If

	' Check boxes collision
	collision = CheckCollisionRecs(boxA, boxB)

	' Get collision rectangle (only on collision)
	If collision Then
		boxCollision = GetCollisionRec(boxA, boxB)
	End If

	' Pause Box A movement
	If IsKeyPressed(KEY_SPACE) Then
		pause = Not pause
	End If
	'-----------------------------------------------------

	' Draw
	'-----------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		Local col:RColor
		If collision Then
			col = RED
		Else
			col = BLACK
		End If
		DrawRectangle(0, 0, screenWidth, screenUpperLimit, col)

		DrawRectangleRec(boxA, GOLD)
		DrawRectangleRec(boxB, BLUE)

		If collision Then
			' Draw collision area
			DrawRectangleRec(boxCollision, LIME)

			' Draw collision message
			DrawText("COLLISION!", GetScreenWidth()/2 - MeasureText("COLLISION!", 20)/2, screenUpperLimit/2 - 10, 20, BLACK)

			' Draw collision area
			DrawText("Collision Area: " + Int(boxCollision.width)*Int(boxCollision.height), GetScreenWidth()/2 - 100, screenUpperLimit + 10, 20, BLACK)
		End If

		DrawFPS(10, 10)

	EndDrawing()
	'-----------------------------------------------------
Wend

' De-Initialization
'---------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'----------------------------------------------------------
