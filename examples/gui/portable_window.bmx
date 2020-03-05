SuperStrict

Framework Ray.GUI
Import Text.Format

Local formatter:TFormatter = TFormatter.Create("Mouse Position: [ %.0f, %.0f ]")

' Initialization
'---------------------------------------------------------------------------------------
Local screenWidth:Int = 800
Local screenHeight:Int = 600

SetConfigFlags(FLAG_WINDOW_UNDECORATED)
InitWindow(screenWidth, screenHeight, "raygui - portable window")

' General variables
Local mousePosition:RVector2
Local windowPosition:RVector2 = New RVector2(500, 200)
Local panOffset:RVector2 = mousePosition
Local dragWindow:Int = False

SetWindowPosition(windowPosition.x, windowPosition.y)

Local exitWindow:Int = False

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not exitWindow And Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	mousePosition = GetMousePosition()
	
	If IsMouseButtonPressed(MOUSE_LEFT_BUTTON) Then
		If CheckCollisionPointRec(mousePosition, New RRectangle(0, 0, screenWidth, 20)) Then
			dragWindow = True
			panOffset = mousePosition
		End If
	End If

	If dragWindow Then
		windowPosition.x :+ (mousePosition.x - panOffset.x)
		windowPosition.y :+ (mousePosition.y - panOffset.y)
		
		If IsMouseButtonReleased(MOUSE_LEFT_BUTTON) Then
			dragWindow = False
		End If

		SetWindowPosition(windowPosition.x, windowPosition.y)
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		exitWindow = GuiWindowBox(New RRectangle(0, 0, screenWidth, screenHeight), "PORTABLE WINDOW")
		
		DrawText(formatter.Clear().Arg(mousePosition.x).Arg(mousePosition.y).Format(), 10, 40, 10, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
