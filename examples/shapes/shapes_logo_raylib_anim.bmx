SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - raylib logo animation")

Local logoPositionX:Int = screenWidth/2 - 128
Local logoPositionY:Int = screenHeight/2 - 128

Local framesCounter:Int = 0
Local lettersCount:Int = 0

Local topSideRecWidth:Int = 16
Local leftSideRecHeight:Int = 16

Local bottomSideRecWidth:Int = 16
Local rightSideRecHeight:Int = 16

Local state:Int = 0                  ' Tracking animation states (State Machine)
Local alpha:Float = 1.0              ' Useful for fading

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If state = 0 Then                 ' State 0: Small box blinking
		framesCounter:+ 1

		If framesCounter = 120 Then
			state = 1
			framesCounter = 0      ' Reset counter... will be used later...
		End If
	Else If state = 1 Then           ' State 1: Top and left bars growing
		topSideRecWidth :+ 4
		leftSideRecHeight :+ 4

		If topSideRecWidth = 256
			state = 2
		End If
	Else If state = 2 Then            ' State 2: Bottom and right bars growing
		bottomSideRecWidth :+ 4
		rightSideRecHeight :+ 4

		If bottomSideRecWidth = 256 Then
			state = 3
		End If
		
	Else If state = 3 Then            ' State 3: Letters appearing (one by one)
		framesCounter :+ 1

		If framesCounter/12 Then       ' Every 12 frames, one more letter!
			lettersCount :+ 1
			framesCounter = 0
		End If

		If lettersCount >= 10 Then     ' When all letters have appeared, just fade out everything
			alpha :- 0.02

			If alpha <= 0.0 Then
				alpha = 0.0
				state = 4
			End If
		End If
	Else If state = 4            ' State 4: Reset and Replay
		If IsKeyPressed(Asc("R"))
			framesCounter = 0
			lettersCount = 0

			topSideRecWidth = 16
			leftSideRecHeight = 16

			bottomSideRecWidth = 16
			rightSideRecHeight = 16

			alpha = 1.0
			state = 0          ' Return to State 0
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		If state = 0 Then
			If (framesCounter / 15) Mod 2 Then
				DrawRectangle(logoPositionX, logoPositionY, 16, 16, BLACK)
			End If
		Else If state = 1 Then
			DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
			DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)
		Else If state = 2 Then
			DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
			DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)

			DrawRectangle(logoPositionX + 240, logoPositionY, 16, rightSideRecHeight, BLACK)
			DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16, BLACK)
		Else If state = 3 Then
			DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, Fade(BLACK, alpha))
			DrawRectangle(logoPositionX, logoPositionY + 16, 16, leftSideRecHeight - 32, Fade(BLACK, alpha))

			DrawRectangle(logoPositionX + 240, logoPositionY + 16, 16, rightSideRecHeight - 32, Fade(BLACK, alpha))
			DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16, Fade(BLACK, alpha))

			DrawRectangle(screenWidth/2 - 112, screenHeight/2 - 112, 224, 224, Fade(RAYWHITE, alpha))

			DrawText("raylib"[..lettersCount], screenWidth/2 - 44, screenHeight/2 + 8, 50, Fade(BLACK, alpha))
			DrawText("blitzmax"[..lettersCount], screenWidth/2 - 94, screenHeight/2 + 48, 50, Fade(BLACK, alpha))

		Else If state = 4 Then
			DrawText("[R] REPLAY", 340, 200, 20, GRAY)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
