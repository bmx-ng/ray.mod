SuperStrict

Framework Ray.GUI

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - draw rectangle rounded")

Local roundness:Float = 0.2
Local width:Int = 200
Local height:Int = 100
Local segments:Int = 0
Local lineThick:Int = 1

Local DrawRect:Int = False
Local drawRoundedRect:Int = True
Local drawRoundedLines:Int = False

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	Local rec:RRectangle = New RRectangle((GetScreenWidth() - width - 250)/2, (GetScreenHeight() - height)/2, width, height)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawLine(560, 0, 560, GetScreenHeight(), Fade(LIGHTGRAY, 0.6))
		DrawRectangle(560, 0, GetScreenWidth() - 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.3))

		If DrawRect Then
			DrawRectangleRec(rec, Fade(GOLD, 0.6))
		End If
		If drawRoundedRect Then
			DrawRectangleRounded(rec, roundness, segments, Fade(MAROON, 0.2))
		End If
		If drawRoundedLines Then
			DrawRectangleRoundedLines(rec, roundness, segments, lineThick, Fade(MAROON, 0.4))
		End If

		' Draw GUI controls
		'------------------------------------------------------------------------------
		width = GuiSliderBar(New RRectangle(640, 40, 105, 20), "Width", "", width, 0, GetScreenWidth() - 300 )
		height = GuiSliderBar(New RRectangle(640, 70, 105, 20), "Height", "", height, 0, GetScreenHeight() - 50)
		roundness = GuiSliderBar(New RRectangle(640, 140, 105, 20), "Roundness", "", roundness, 0.0, 1.0)
		lineThick = GuiSliderBar(New RRectangle(640, 170, 105, 20), "Thickness", "", lineThick, 0, 20)
		segments = GuiSliderBar(New RRectangle(640, 240, 105, 20), "Segments", "", segments, 0, 60)

		drawRoundedRect = GuiCheckBox(New RRectangle(640, 320, 20, 20), "DrawRoundedRect", drawRoundedRect)
		drawRoundedLines = GuiCheckBox(New RRectangle(640, 350, 20, 20), "DrawRoundedLines", drawRoundedLines)
		DrawRect = GuiCheckBox(New RRectangle(640, 380, 20, 20), "DrawRect", DrawRect)
		'------------------------------------------------------------------------------

		Local txt:String
		Local col:RColor
		If segments >= 4 Then
			txt = "MODE: MANUAL"
			col = MAROON
		Else
			txt = "MODE: AUTO"
			col = DARKGRAY
		End If
		
		DrawText(txt, 640, 280, 10, col)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
