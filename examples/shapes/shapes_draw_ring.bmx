SuperStrict

Framework Ray.GUI

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - draw ring")

Local center:RVector2 = New RVector2((GetScreenWidth() - 300)/2, GetScreenHeight()/2)

Local innerRadius:Float = 80.0
Local outerRadius:Float = 190.0

Local startAngle:Float = 0
Local endAngle:Float = 360
Local segments:Float = 0

Local shouldDrawRing:Int = True
Local shouldDrawRingLines:Int = False
Local shouldDrawCircleLines:Int = False

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' NOTE: All variables update happens inside GUI control functions
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawLine(500, 0, 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.6))
		DrawRectangle(500, 0, GetScreenWidth() - 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.3))

		If shouldDrawRing Then
			DrawRing(center, innerRadius, outerRadius, startAngle, endAngle, Int(segments), Fade(MAROON, 0.3))
		End If
		If shouldDrawRingLines Then
			DrawRingLines(center, innerRadius, outerRadius, startAngle, endAngle, Int(segments), Fade(BLACK, 0.4))
		End If
		If shouldDrawCircleLines Then
			DrawCircleSectorLines(center, outerRadius, startAngle, endAngle, Int(segments), Fade(BLACK, 0.4))
		End If

		' Draw GUI controls
		'------------------------------------------------------------------------------
		GuiSliderBar(New RRectangle(600, 40, 120, 20), "StartAngle", "", startAngle, -450, 450)
		GuiSliderBar(New RRectangle(600, 70, 120, 20), "EndAngle", "", endAngle, -450, 450)

		GuiSliderBar(New RRectangle(600, 140, 120, 20), "InnerRadius", "", innerRadius, 0, 100)
		GuiSliderBar(New RRectangle(600, 170, 120, 20), "OuterRadius", "", outerRadius, 0, 200)

		GuiSliderBar(New RRectangle(600, 240, 120, 20), "Segments", "", segments, 0, 100)

		GuiCheckBox(New RRectangle(600, 320, 20, 20), "Draw Ring", shouldDrawRing)
		GuiCheckBox(New RRectangle(600, 350, 20, 20), "Draw RingLines", shouldDrawRingLines)
		GuiCheckBox(New RRectangle(600, 380, 20, 20), "Draw CircleLines", shouldDrawCircleLines)
		'------------------------------------------------------------------------------

		Local col:RColor
		Local txt:String
		If segments >= 4 Then
			txt = "MODE: MANUAL"
			col = MAROON
		Else
			txt = "MODE: AUTO"
			col = DARKGRAY
		End If
		
		DrawText(txt, 600, 270, 10, col)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
