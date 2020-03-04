SuperStrict

Framework Ray.Lib
Import brl.standardio

Const MAX_COLORS_COUNT:Int = 23 ' Number of colors available

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - mouse painting")

' Colours to choose from
Local colors:RColor[] = [ ..
	RAYWHITE, YELLOW, GOLD, ORANGE, PINK, RED, MAROON, GREEN, LIME, DARKGREEN, ..
	SKYBLUE, BLUE, DARKBLUE, PURPLE, VIOLET, DARKPURPLE, BEIGE, BROWN, DARKBROWN, ..
	LIGHTGRAY, GRAY, DARKGRAY, BLACK]
	
' Define colorsRecs data (for every rectangle)
Local colorsRecs:RRectangle[MAX_COLORS_COUNT]

For Local i:Int = 0 Until MAX_COLORS_COUNT
	colorsRecs[i].x = 10 + 30*i + 2*i
	colorsRecs[i].y = 10
	colorsRecs[i].width = 30
	colorsRecs[i].height = 30
Next

Local colorSelected:Int = 0
Local colorSelectedPrev:Int = colorSelected
Local colorMouseHover:Int = 0
Local brushSize:Int = 20

Local btnSaveRec:RRectangle = New RRectangle(750, 10, 40, 30)
Local btnSaveMouseHover:Int = False
Local showSaveMessage:Int = False
Local saveMessageCounter:Int = 0

' Create a RenderTexture2D to use as a canvas
Local target:RRenderTexture2D = LoadRenderTexture(screenWidth, screenHeight)

' Clear render texture before entering the game loop
BeginTextureMode(target)
ClearBackground(colors[0])
EndTextureMode()

SetTargetFPS(120)              ' Set our game to run at 120 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	Local mousePos:RVector2 = GetMousePosition()
	
	' Move between colors with keys
	If IsKeyPressed(KEY_RIGHT) Then
		colorSelected :+ 1
	Else If IsKeyPressed(KEY_LEFT) Then
		colorSelected :- 1
	End If
	
	If colorSelected >= MAX_COLORS_COUNT Then
		colorSelected = MAX_COLORS_COUNT - 1
	Else If colorSelected < 0 Then
		colorSelected = 0
	End If

	' Choose color with mouse
	For Local i:Int = 0 Until MAX_COLORS_COUNT
		If CheckCollisionPointRec(mousePos, colorsRecs[i]) Then
			colorMouseHover = i
			Exit
		Else
			colorMouseHover = -1
		End If
	Next
	
	If (colorMouseHover >= 0) And IsMouseButtonPressed(MOUSE_LEFT_BUTTON) Then
		colorSelected = colorMouseHover
		colorSelectedPrev = colorSelected
	End If

	' Change brush size
	brushSize :+ GetMouseWheelMove()*5
	If brushSize < 2 Then
		brushSize = 2
	End If
	If brushSize > 50 Then
		brushSize = 50
	End If

	If IsKeyPressed(KEY_C) Then
		' Clear render texture to clear color
		BeginTextureMode(target)
		ClearBackground(colors[0])
		EndTextureMode()
	End If

	If IsMouseButtonDown(MOUSE_LEFT_BUTTON) Or (GetGestureDetected() = GESTURE_DRAG) Then
		' Paint circle into render texture
		' NOTE: To avoid discontinuous circles, we could store
		' previous-next mouse points and just draw a line using brush size
		BeginTextureMode(target)
		If mousePos.y > 50 Then
			DrawCircle(mousePos.x, mousePos.y, brushSize, colors[colorSelected])
		End If
		EndTextureMode()
	End If

	If IsMouseButtonDown(MOUSE_RIGHT_BUTTON) Then
		colorSelected = 0
		
		' Erase circle from render texture
		BeginTextureMode(target)
		If mousePos.y > 50 Then
			DrawCircle(mousePos.x, mousePos.y, brushSize, colors[0])
		End If
		EndTextureMode()
	Else
		colorSelected = colorSelectedPrev
	End If
	
	' Check mouse hover save button
	If CheckCollisionPointRec(mousePos, btnSaveRec) Then
		btnSaveMouseHover = True
	Else
		btnSaveMouseHover = False
	End If
	
	' Image saving logic
	' NOTE: Saving painted texture to a default named image
	If (btnSaveMouseHover And IsMouseButtonReleased(MOUSE_LEFT_BUTTON)) Or IsKeyPressed(KEY_S) Then
		Local image:RImage = GetTextureData(target.texture)
		ImageFlipVertical(image)
		ExportImage(image, "my_amazing_texture_painting.png")
		UnloadImage(image)
		showSaveMessage = True
	End If
	
	If showSaveMessage Then
		' On saving, show a full screen message for 2 seconds
		saveMessageCounter :+ 1
		If saveMessageCounter > 240 Then
			showSaveMessage = False
			saveMessageCounter = 0
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' NOTE: Render texture must be y-flipped due to default OpenGL coordinates (left-bottom)
		DrawTextureRec(target.texture, New RRectangle(0, 0, target.texture.width, -target.texture.height), New RVector2(0, 0), WHITE)

		' Draw drawing circle for reference
		If mousePos.y > 50 Then
			If IsMouseButtonDown(MOUSE_RIGHT_BUTTON) Then
				DrawCircleLines(mousePos.x, mousePos.y, brushSize, GRAY)
			Else
				DrawCircle(GetMouseX(), GetMouseY(), brushSize, colors[colorSelected])
			End If
		End If
		
		' Draw top panel
		DrawRectangle(0, 0, GetScreenWidth(), 50, RAYWHITE)
		DrawLine(0, 50, GetScreenWidth(), 50, LIGHTGRAY)

		' Draw color selection rectangles
		For Local i:Int = 0 Until MAX_COLORS_COUNT
			DrawRectangleRec(colorsRecs[i], colors[i])
		Next
		DrawRectangleLines(10, 10, 30, 30, LIGHTGRAY)

		If colorMouseHover >= 0 Then
			DrawRectangleRec(colorsRecs[colorMouseHover], Fade(WHITE, 0.6))
		End If

		DrawRectangleLinesEx(New RRectangle(colorsRecs[colorSelected].x - 2, colorsRecs[colorSelected].y - 2, ..
							 colorsRecs[colorSelected].width + 4, colorsRecs[colorSelected].height + 4), 2, BLACK)

		' Draw save image button
		Local buttonCol:RColor = BLACK
		If btnSaveMouseHover Then
			buttonCol = RED
		End If
		DrawRectangleLinesEx(btnSaveRec, 2, buttonCol)
		DrawText("SAVE!", 755, 20, 10, buttonCol)
		
		' Draw save image message
		If showSaveMessage Then
			DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
			DrawRectangle(0, 150, GetScreenWidth(), 80, BLACK)
			DrawText("IMAGE SAVED:  my_amazing_texture_painting.png", 150, 180, 20, RAYWHITE)
		End If
		
	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadRenderTexture(target)    ' Unload render texture

CloseWindow()                  ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
