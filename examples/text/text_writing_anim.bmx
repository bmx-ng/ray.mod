SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - text writing anim")

Local message:String = "This sample illustrates a text writing~nanimation effect! Check it out! )"

Local framesCounter:Int = 0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyDown(KEY_SPACE) Then
		framesCounter :+ 8
	Else
		framesCounter :+ 1
	End If

	If IsKeyPressed(KEY_ENTER) Then
		framesCounter = 0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText(message[..framesCounter/10], 210, 160, 20, MAROON)

		DrawText("PRESS [ENTER] to RESTART!", 240, 260, 20, LIGHTGRAY)
		DrawText("PRESS [SPACE] to SPEED UP!", 239, 300, 20, LIGHTGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
