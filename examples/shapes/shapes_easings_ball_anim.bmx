SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - easings ball anim")

' Ball variable value to be animated with easings
Local ballPositionX:Int = -100
Local ballRadius:Int = 20
Local ballAlpha:Float = 0.0

Local state:Int = 0
Local framesCounter:Int = 0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If state = 0 Then             ' Move ball position X with easing
		framesCounter :+ 1
		ballPositionX = EaseElasticOut(framesCounter, -100, screenWidth/2 + 100, 120)

		If framesCounter >= 120 Then
			framesCounter = 0
			state = 1
		End If
	Else If state = 1 Then        ' Increase ball radius with easing
		framesCounter :+ 1
		ballRadius = EaseElasticIn(framesCounter, 20, 500, 200)

		If framesCounter >= 200 Then
			framesCounter = 0
			state = 2
		End If
	Else If state = 2 Then        ' Change ball alpha with easing (background color blending)
		framesCounter :+ 1
		ballAlpha = EaseCubicOut(framesCounter, 0.0, 1.0, 200)

		If framesCounter >= 200 Then
			framesCounter = 0
			state = 3
		End If
	Else If state = 3 Then        ' Reset state to play again
		If IsKeyPressed(KEY_ENTER) Then
			' Reset required variables to play again
			ballPositionX = -100
			ballRadius = 20
			ballAlpha = 0.0
			state = 0
		End If
	End If

	If IsKeyPressed(KEY_R) Then
		framesCounter = 0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		If state >= 2 Then
			DrawRectangle(0, 0, screenWidth, screenHeight, GREEN)
		End If
		DrawCircle(ballPositionX, 200, ballRadius, Fade(RED, 1.0 - ballAlpha))

		If state = 3 Then
			DrawText("PRESS [ENTER] TO PLAY AGAIN!", 240, 200, 20, BLACK)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
