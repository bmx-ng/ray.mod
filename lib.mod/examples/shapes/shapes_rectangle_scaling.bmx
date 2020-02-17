SuperStrict

Framework Ray.Lib

Const MOUSE_SCALE_MARK_SIZE:Int = 12

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - rectangle scaling mouse")

Local rec:RRectangle = New RRectangle(100, 100, 200, 80)

Local mousePosition:RVector2

Local mouseScaleReady:Int = False
Local mouseScaleMode:Int = False

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	mousePosition = GetMousePosition()

	If CheckCollisionPointRec(mousePosition, rec) And ..
			CheckCollisionPointRec(mousePosition, New RRectangle(rec.x + rec.width - MOUSE_SCALE_MARK_SIZE, rec.y + rec.height - MOUSE_SCALE_MARK_SIZE, MOUSE_SCALE_MARK_SIZE, MOUSE_SCALE_MARK_SIZE)) Then
		mouseScaleReady = True
		If IsMouseButtonPressed(MOUSE_LEFT_BUTTON) Then
			mouseScaleMode = True
		End If
	Else
		mouseScaleReady = False
	End If

	If mouseScaleMode Then
		mouseScaleReady = True

		rec.width = (mousePosition.x - rec.x)
		rec.height = (mousePosition.y - rec.y)

		If rec.width < MOUSE_SCALE_MARK_SIZE Then
			rec.width = MOUSE_SCALE_MARK_SIZE
		End If
		If rec.height < MOUSE_SCALE_MARK_SIZE Then
			rec.height = MOUSE_SCALE_MARK_SIZE
		End If

		If IsMouseButtonReleased(MOUSE_LEFT_BUTTON) Then
			mouseScaleMode = False
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("Scale rectangle dragging from bottom-right corner!", 10, 10, 20, GRAY)

		DrawRectangleRec(rec, Fade(GREEN, 0.5))

		If mouseScaleReady Then
			DrawRectangleLinesEx(rec, 1, RED)
			DrawTriangle(New RVector2(rec.x + rec.width - MOUSE_SCALE_MARK_SIZE, rec.y + rec.height), ..
						 New RVector2(rec.x + rec.width, rec.y + rec.height), ..
						 New RVector2(rec.x + rec.width, rec.y + rec.height - MOUSE_SCALE_MARK_SIZE), RED)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
