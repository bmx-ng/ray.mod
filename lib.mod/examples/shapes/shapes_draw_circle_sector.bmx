SuperStrict

Framework Ray.GUI

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - draw circle sector")

Local center:RVector2 = New RVector2((GetScreenWidth() - 300)/2, GetScreenHeight()/2)

Local outerRadius:Float = 180
Local startAngle:Int = 0
Local endAngle:Int = 180
Local segments:Int = 0

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

		DrawCircleSector(center, outerRadius, startAngle, endAngle, segments, Fade(MAROON, 0.3))
		DrawCircleSectorLines(center, outerRadius, startAngle, endAngle, segments, Fade(MAROON, 0.6))
		
		' Draw GUI controls
		'------------------------------------------------------------------------------
		startAngle = GuiSliderBar(New RRectangle(600, 40, 120, 20), "StartAngle", "", startAngle, 0, 720)
		endAngle = GuiSliderBar(New RRectangle(600, 70, 120, 20), "EndAngle", "", endAngle, 0, 720)
		
		outerRadius = GuiSliderBar(New RRectangle( 600, 140, 120, 20), "Radius", "", outerRadius, 0, 200)
		segments = GuiSliderBar(New RRectangle(600, 170, 120, 20), "Segments", "", segments, 0, 100)
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
		DrawText(txt, 600, 200, 10, col)
		
		DrawFPS(10, 10)
		
	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------  
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
