SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - basic shapes drawing")

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' TODO: Update your variables here
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("some basic shapes available on raylib", 20, 20, 20, DARKGRAY)

		DrawCircle(screenWidth/4, 120, 35, DARKBLUE)

		DrawRectangle(screenWidth/4*2 - 60, 100, 120, 60, RED)
		DrawRectangleLines(screenWidth/4*2 - 40, 320, 80, 60, ORANGE)  ' NOTE: Uses QUADS internally, not lines
		DrawRectangleGradientH(screenWidth/4*2 - 90, 170, 180, 130, MAROON, GOLD)

		DrawTriangle(New RVector2(screenWidth/4*3, 80), ..
					 New RVector2(screenWidth/4*3 - 60, 150), ..
					 New RVector2(screenWidth/4*3 + 60, 150), VIOLET)

		DrawPoly(New RVector2(screenWidth/4*3, 320), 6, 80, 0, BROWN)

		DrawCircleGradient(screenWidth/4, 220, 60, GREEN, SKYBLUE)

		' NOTE: We draw all LINES based shapes together to optimize internal drawing,
		' this way, all LINES are rendered in a single draw pass
		DrawLine(18, 42, screenWidth - 18, 42, BLACK)
		DrawCircleLines(screenWidth/4, 340, 80, DARKBLUE)
		DrawTriangleLines(New RVector2(screenWidth/4*3, 160), ..
						  New RVector2(screenWidth/4*3 - 20, 230), ..
						  New RVector2(screenWidth/4*3 + 20, 230), DARKBLUE)
	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
