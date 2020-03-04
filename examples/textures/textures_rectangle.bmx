SuperStrict

Framework Ray.Lib
Import Text.Format


Const MAX_FRAME_SPEED:Int = 15
Const MIN_FRAME_SPEED:Int = 1

Local formatter:TFormatter = TFormatter.Create("%02i FPS")

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [texture] example - texture rectangle")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
Local scarfy:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/scarfy.png")        ' Texture loading

Local position:RVector2 = New RVector2(350.0, 280.0)
Local frameRec:RRectangle = New RRectangle(0.0, 0.0, scarfy.width/6.0, scarfy.height)
Local currentFrame:Int = 0

Local framesCounter:Int = 0
Local framesSpeed:Int = 8            ' Number of spritesheet frames shown by second

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	framesCounter :+ 1

	If framesCounter >= (60/framesSpeed) Then
		framesCounter = 0
		currentFrame :+ 1

		If currentFrame > 5 Then
			currentFrame = 0
		End If

		frameRec.x = currentFrame*scarfy.width/6.0
	End If

	If IsKeyPressed(KEY_RIGHT) Then
		framesSpeed :+ 1
	Else If IsKeyPressed(KEY_LEFT) Then
		framesSpeed :- 1
	End If

	If framesSpeed > MAX_FRAME_SPEED Then
		framesSpeed = MAX_FRAME_SPEED
	Else If framesSpeed < MIN_FRAME_SPEED Then
		framesSpeed = MIN_FRAME_SPEED
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawTexture(scarfy, 15, 40, WHITE)
		DrawRectangleLines(15, 40, scarfy.width, scarfy.height, LIME)
		DrawRectangleLines(Int(15 + frameRec.x), Int(40 + frameRec.y), Int(frameRec.width), Int(frameRec.height), RED)

		DrawText("FRAME SPEED: ", 165, 210, 10, DARKGRAY)
		DrawText(formatter.Clear().Arg(framesSpeed).Format(), 575, 210, 10, DARKGRAY)
		DrawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 240, 10, DARKGRAY)

		For Local i:Int = 0 Until MAX_FRAME_SPEED
			If i < framesSpeed Then
				DrawRectangle(250 + 21*i, 205, 20, 20, RED)
			End If
			DrawRectangleLines(250 + 21*i, 205, 20, 20, MAROON)
		Next

		DrawTextureRec(scarfy, frameRec, position, WHITE)  ' Draw part of the texture

		DrawText("(c) Scarfy sprite by Eiden Marsal", screenWidth - 200, screenHeight - 20, 10, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(scarfy)       ' Texture unloading

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
