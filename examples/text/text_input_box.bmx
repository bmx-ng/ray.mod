SuperStrict

Framework Ray.Lib
Import Text.Format

Local MAX_INPUT_CHARS:Int = 9

Local formatter:TFormatter = TFormatter.Create("INPUT CHARS: %d/%d")

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - input box")

Local name:String
Local letterCount:Int = 0

Local textBox:RRectangle = New RRectangle(screenWidth/2 - 100, 180, 225, 50)
Local mouseOnText:Int = False

Local framesCounter:Int = 0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If CheckCollisionPointRec(GetMousePosition(), textBox) Then
		mouseOnText = True
	Else
		mouseOnText = False
	End If

	If mouseOnText Then
		' Set the window's cursor to the I-Beam
		SetMouseCursor(MOUSE_CURSOR_IBEAM)

		' Get pressed key (character) on the queue
		Local key:Int = GetKeyPressed()

		' Check if more characters have been pressed on the same frame
		While key > 0
			' NOTE: Only allow keys in range [32..125]
			If (key >= 32) And (key <= 125) And (letterCount < MAX_INPUT_CHARS) Then
				name :+ Chr(key)
				letterCount :+ 1
			End If
			
			key = GetKeyPressed()  ' Check next character in the queue
		Wend

		If IsKeyPressed(KEY_BACKSPACE) Then
			letterCount :- 1

			If letterCount < 0 Then
				letterCount = 0
			End If

			name = name[0..letterCount]
		End If
	Else
		SetMouseCursor(MOUSE_CURSOR_DEFAULT)
	End If

	If mouseOnText Then
		framesCounter :+ 1
	Else
		framesCounter = 0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("PLACE MOUSE OVER INPUT BOX!", 240, 140, 20, GRAY)

		DrawRectangleRec(textBox, LIGHTGRAY)
		If mouseOnText Then
			DrawRectangleLines(Int(textBox.x), Int(textBox.y), Int(textBox.width), Int(textBox.height), RED)
		Else
			DrawRectangleLines(Int(textBox.x), Int(textBox.y), Int(textBox.width), Int(textBox.height), DARKGRAY)
		End If

		DrawText(name, Int(textBox.x + 5), Int(textBox.y + 8), 40, MAROON)

		DrawText(formatter.Clear().Arg(letterCount).Arg(MAX_INPUT_CHARS).Format(), 315, 250, 20, DARKGRAY)

		If mouseOnText Then
			If letterCount < MAX_INPUT_CHARS Then
				' Draw blinking underscore char
				If ((framesCounter/20) Mod 2) = 0 Then
					DrawText("_", Int(textBox.x + 8 + MeasureText(name, 40)), Int(textBox.y + 12), 40, MAROON)
				End If
			Else
				DrawText("Press BACKSPACE to delete chars...", 230, 300, 20, GRAY)
			End If
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
