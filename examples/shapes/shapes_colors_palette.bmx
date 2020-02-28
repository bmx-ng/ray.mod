SuperStrict

Framework Ray.Lib

Const MAX_COLORS_COUNT:Int = 21

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - colors palette")

Local colors:RColor[] = [ ..
	DARKGRAY, MAROON, ORANGE, DARKGREEN, DARKBLUE, DARKPURPLE, DARKBROWN, ..
	GRAY, RED, GOLD, LIME, BLUE, VIOLET, BROWN, LIGHTGRAY, PINK, YELLOW, ..
	GREEN, SKYBLUE, PURPLE, BEIGE]

Local colorNames:String[] = [ ..
	"DARKGRAY", "MAROON", "ORANGE", "DARKGREEN", "DARKBLUE", "DARKPURPLE", ..
	"DARKBROWN", "GRAY", "RED", "GOLD", "LIME", "BLUE", "VIOLET", "BROWN", ..
	"LIGHTGRAY", "PINK", "YELLOW", "GREEN", "SKYBLUE", "PURPLE", "BEIGE" ]

Local colorsRecs:RRectangle[MAX_COLORS_COUNT]     ' Rectangles array

' Fills colorsRecs data (for every rectangle)
For Local i:Int = 0 Until MAX_COLORS_COUNT
	colorsRecs[i].x = 20 + 100 * (i Mod 7) + 10 * (i Mod 7)
	colorsRecs[i].y = 80 + 100 * (i / 7) + 10 * (i / 7)
	colorsRecs[i].width = 100
	colorsRecs[i].height = 100
Next

Local colorState:Int[MAX_COLORS_COUNT]           ' Color state: 0-DEFAULT, 1-MOUSE_HOVER

Local mousePoint:RVector2 = New RVector2(0.0, 0.0)

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	mousePoint = GetMousePosition()
	For Local i:Int = 0 Until MAX_COLORS_COUNT
		If CheckCollisionPointRec(mousePoint, colorsRecs[i]) Then
			colorState[i] = 1
		Else
			colorState[i] = 0
		End If
	Next
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("raylib colors palette", 28, 42, 20, BLACK)
		DrawText("press SPACE to see all colors", GetScreenWidth() - 180, GetScreenHeight() - 40, 10, GRAY)

		For Local i:Int = 0 Until MAX_COLORS_COUNT    ' Draw all rectangles
			Local f:Float
			If colorState[i] Then
				f = 0.6
			Else
				f = 1.0
			End If
			DrawRectangleRec(colorsRecs[i], Fade(colors[i], f))

			If IsKeyDown(KEY_SPACE) Or colorState[i] Then
				DrawRectangle(Int(colorsRecs[i].x), Int(colorsRecs[i].y + colorsRecs[i].height - 26), Int(colorsRecs[i].width), 20, BLACK)
				DrawRectangleLinesEx(colorsRecs[i], 6, Fade(BLACK, 0.3))
				DrawText(colorNames[i], Int(colorsRecs[i].x + colorsRecs[i].width - MeasureText(colorNames[i], 10) - 12), Int(colorsRecs[i].y + colorsRecs[i].height - 20), 10, colors[i])
			End If
		Next

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
