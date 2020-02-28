SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - easings box anim")

' Box variables to be animated with easings
Local rec:RRectangle = New RRectangle(GetScreenWidth()/2, -100, 100, 100)
Local Rotation:Float = 0.0
Local alpha:Float = 1.0

Local state:Int = 0
Local framesCounter:Int = 0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	Select state
		Case 0     ' Move box down to center of screen
			framesCounter :+ 1

			' NOTE: Remember that 3rd parameter of easing function refers to
			' desired value variation, do not confuse it with expected final value!
			rec.y = EaseElasticOut(framesCounter, -100, GetScreenHeight()/2 + 100, 120)

			If framesCounter >= 120 Then
				framesCounter = 0
				state = 1
			End If
		Case 1     ' Scale box to an horizontal bar
			framesCounter :+ 1
			rec.height = EaseBounceOut(framesCounter, 100, -90, 120)
			rec.width = EaseBounceOut(framesCounter, 100, GetScreenWidth(), 120)

			If framesCounter >= 120 Then
				framesCounter = 0
				state = 2
			End If
		Case 2     ' Rotate horizontal bar rectangle
			framesCounter :+ 1
			Rotation = EaseQuadOut(framesCounter, 0.0, 270.0, 240)

			If framesCounter >= 240 Then
				framesCounter = 0
				state = 3
			End If
		Case 3     ' Increase bar size to fill all screen
			framesCounter :+ 1
			rec.height = EaseCircOut(framesCounter, 10, GetScreenWidth(), 120)

			If framesCounter >= 120 Then
				framesCounter = 0
				state = 4
			End If
		Case 4     ' Fade out animation
			framesCounter :+ 1
			alpha = EaseSineOut(framesCounter, 1.0, -1.0, 160)

			If framesCounter >= 160 Then
				framesCounter = 0
				state = 5
			End If
	End Select

	' Reset animation at any moment
	If IsKeyPressed(KEY_SPACE) Then
		rec = New RRectangle(GetScreenWidth()/2, -100, 100, 100)
		Rotation = 0.0
		alpha = 1.0
		state = 0
		framesCounter = 0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawRectanglePro(rec, New RVector2(rec.width/2, rec.height/2), Rotation, Fade(BLACK, alpha))

		DrawText("PRESS [SPACE] TO RESET BOX ANIMATION!", 10, GetScreenHeight() - 25, 20, LIGHTGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
