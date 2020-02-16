SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - bouncing ball")

Local ballPosition:RVector2 = New RVector2(GetScreenWidth()/2, GetScreenHeight()/2)
Local ballSpeed:RVector2 = New RVector2(5.0, 4.0)
Local ballRadius:Int = 20

Local pause:Int = 0
Local framesCounter:Int = 0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'----------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'-----------------------------------------------------
	If IsKeyPressed(KEY_SPACE) Then
		pause = Not pause
	End If

	If Not pause Then
		ballPosition.x :+ ballSpeed.x
		ballPosition.y :+ ballSpeed.y

		' Check walls collision for bouncing
		If (ballPosition.x >= (GetScreenWidth() - ballRadius)) Or (ballPosition.x <= ballRadius) Then
			ballSpeed.x :* -1.0
		End If
		
		If (ballPosition.y >= (GetScreenHeight() - ballRadius)) Or (ballPosition.y <= ballRadius) Then
			ballSpeed.y :* -1.0
		End If
	Else
		framesCounter :+ 1
	End If
	'-----------------------------------------------------

	' Draw
	'-----------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawCircleV(ballPosition, ballRadius, MAROON)
		DrawText("PRESS SPACE to PAUSE BALL MOVEMENT", 10, GetScreenHeight() - 25, 20, LIGHTGRAY)

		' On pause, we draw a blinking message
		If pause And ((framesCounter/30) Mod 2) Then
			DrawText("PAUSED", 350, 200, 30, GRAY)
		End If

		DrawFPS(10, 10)

	EndDrawing()
	'-----------------------------------------------------
Wend

' De-Initialization
'---------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'----------------------------------------------------------
