SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - draw text inside a rectangle")

Const Text:String = "Text cannot escape~tthis container~t...word wrap also works when active so here's " + ..
	"a long text for testing.~n~nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod " + ..
	"tempor incididunt ut labore et dolore magna aliqua. Nec ullamcorper sit amet risus nullam eget felis eget."

Local resizing:Int = False
Local wordWrap:Int = True

Local container:RRectangle = New RRectangle(25, 25, screenWidth - 50, screenHeight - 250)
Local resizer:RRectangle = New RRectangle(container.x + container.width - 17, container.y + container.height - 17, 14, 14)

' Minimum width and heigh for the container rectangle
Const minWidth:Int = 60
Const minHeight:Int = 60
Const maxWidth:Int = screenWidth - 50
Const maxHeight:Int = screenHeight - 160

Local lastMouse:RVector2  = New RVector2(0.0, 0.0) ' Stores last mouse coordinates
Local borderColor:RColor = MAROON         ' Container border color
Local font:RFont = GetFontDefault()       ' Get default system font

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyPressed(KEY_SPACE) Then
		wordWrap = Not wordWrap
	End If

	Local mouse:RVector2 = GetMousePosition()

	' Check if the mouse is inside the container and toggle border color
	If CheckCollisionPointRec(mouse, container) Then
		borderColor = Fade(MAROON, 0.4)
	Else If Not resizing Then
		borderColor = MAROON
	End If

	' Container resizing logic
	If resizing Then
		If IsMouseButtonReleased(MOUSE_LEFT_BUTTON) Then
			resizing = False
		End If

		Local width:Int = container.width + (mouse.x - lastMouse.x)
		If width > minWidth Then
			If width < maxWidth Then
				container.width = width
			Else
				container.width = maxWidth
			End If
		Else
			container.width = minWidth
		End If

		Local height:Int = container.height + (mouse.y - lastMouse.y)
		If height > minHeight Then
			If height < maxHeight Then
				container.height = height
			Else
				container.height = maxHeight
			End If
		Else
			container.height = minHeight
		End If
	Else
		' Check if we're resizing
		If IsMouseButtonDown(MOUSE_LEFT_BUTTON) And CheckCollisionPointRec(mouse, resizer) Then
			resizing = True
		End If
	End If

	' Move resizer rectangle properly
	resizer.x = container.x + container.width - 17
	resizer.y = container.y + container.height - 17

	lastMouse = mouse ' Update mouse
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawRectangleLinesEx(container, 3, borderColor) ' Draw container border

		' Draw text in container (add some padding)
		DrawTextRec(font, Text, New RRectangle(container.x + 4, container.y + 4, container.width - 4, container.height - 4), 20.0, 2.0, wordWrap, GRAY)

		DrawRectangleRec(resizer, borderColor)         ' Draw the resize box

		' Draw bottom info
		DrawRectangle(0, screenHeight - 54, screenWidth, 54, GRAY)
		DrawRectangleRec(New RRectangle(382, screenHeight - 34, 12, 12), MAROON)
		
		DrawText("Word Wrap: ", 313, screenHeight-115, 20, BLACK)
		If wordWrap Then
			DrawText("ON", 447, screenHeight - 115, 20, RED)
		Else
			DrawText("OFF", 447, screenHeight - 115, 20, BLACK)
		End If
		
		DrawText("Press [SPACE] to toggle word wrap", 218, screenHeight - 86, 20, GRAY)

		DrawText("Click hold & drag the    to resize the container", 155, screenHeight - 38, 20, RAYWHITE)
		
	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
