SuperStrict

Framework Ray.Lib

Const RECS_WIDTH:Int =              50
Const RECS_HEIGHT:Int =             50

Const MAX_RECS_X:Int =              800/RECS_WIDTH
Const MAX_RECS_Y:Int =              450/RECS_HEIGHT

Const PLAY_TIME_IN_FRAMES:Int =     240                 ' At 60 fps = 4 seconds

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - easings rectangle array")

Local recs:RRectangle[MAX_RECS_X*MAX_RECS_Y]

For Local y:Int = 0 Until MAX_RECS_Y
	For Local x:Int = 0 Until MAX_RECS_X
		recs[y*MAX_RECS_X + x].x = RECS_WIDTH/2 + RECS_WIDTH*x
		recs[y*MAX_RECS_X + x].y = RECS_HEIGHT/2 + RECS_HEIGHT*y
		recs[y*MAX_RECS_X + x].width = RECS_WIDTH
		recs[y*MAX_RECS_X + x].height = RECS_HEIGHT
	Next
Next

Local Rotation:Float = 0.0
Local framesCounter:Int = 0
Local state:Int = 0            ' Rectangles animation state: 0-Playing, 1-Finished

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If state = 0 Then
		framesCounter :+ 1

		For Local i:Int = 0 Until MAX_RECS_X*MAX_RECS_Y
			recs[i].height = EaseCircOut(framesCounter, RECS_HEIGHT, -RECS_HEIGHT, PLAY_TIME_IN_FRAMES)
			recs[i].width = EaseCircOut(framesCounter, RECS_WIDTH, -RECS_WIDTH, PLAY_TIME_IN_FRAMES)

			If recs[i].height < 0 Then
				recs[i].height = 0
			End If
			If recs[i].width < 0 Then
				recs[i].width = 0
			End If

			If (recs[i].height = 0) And (recs[i].width = 0) Then
				state = 1   ' Finish playing
			End If

			Rotation = EaseLinearIn(framesCounter, 0.0, 360.0, PLAY_TIME_IN_FRAMES)
		Next
	Else If (state = 1) And IsKeyPressed(KEY_SPACE) Then
		' When animation has finished, press space to restart
		framesCounter = 0

		For Local i:Int = 0 Until MAX_RECS_X*MAX_RECS_Y
			recs[i].height = RECS_HEIGHT
			recs[i].width = RECS_WIDTH
		Next

		state = 0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		If state = 0 Then
			For Local i:Int = 0 Until MAX_RECS_X*MAX_RECS_Y
				DrawRectanglePro(recs[i], New RVector2(recs[i].width/2, recs[i].height/2), Rotation, RED)
			Next
		Else If state = 1 Then
			DrawText("PRESS [SPACE] TO PLAY AGAIN!", 240, 200, 20, GRAY)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
