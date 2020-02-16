SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - scissor test")

Local scissorArea:RRectangle = New RRectangle(0, 0, 300, 300)
Local scissorMode:Int = True

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyPressed(KEY_S) Then
		scissorMode = Not scissorMode
	End If

	' Centre the scissor area around the mouse position
	scissorArea.x = GetMouseX() - scissorArea.width / 2
	scissorArea.y = GetMouseY() - scissorArea.height / 2
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		If scissorMode Then
			BeginScissorMode(scissorArea.x, scissorArea.y, scissorArea.width, scissorArea.height)
		End If

		' Draw full screen rectangle and some text
		' NOTE: Only part defined by scissor area will be rendered
		DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), RED)
		DrawText("Move the mouse around to reveal this text!", 190, 200, 20, LIGHTGRAY)

		If scissorMode Then
			EndScissorMode()
		End If

		DrawRectangleLinesEx(scissorArea, 1, BLACK)
		DrawText("Press S to toggle scissor test", 10, 10, 20, BLACK)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
