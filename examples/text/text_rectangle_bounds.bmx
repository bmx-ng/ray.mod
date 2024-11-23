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
		DrawTextBoxed(font, Text, New RRectangle(container.x + 4, container.y + 4, container.width - 4, container.height - 4), 20.0, 2.0, wordWrap, GRAY)

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

' Draw text using font inside rectangle limits
Function DrawTextBoxed(font:RFont, text:String, rec:RRectangle, fontSize:Float, spacing:Float, wordWrap:Int, tint:RColor)   ' Draw text using font inside rectangle limits
	DrawTextBoxedSelectable(font, text, rec, fontSize, spacing, wordWrap, tint, 0, 0, WHITE, WHITE)
End Function

' Draw text using font inside rectangle limits with support for text selection
Function DrawTextBoxedSelectable(font:RFont, text:String, rec:RRectangle, fontSize:Float, spacing:Float, wordWrap:Int, tint:RColor, selectStart:Int, selectLength:Int, selectTint:RColor, selectBackTint:RColor);    ' Draw text using font inside rectangle limits with support for text selection
	
	Local length:Int = text.Length ' Total length in bytes of the text, scanned by codepoints in loop

	Local textOffsetY:Float = 0.0 ' Offset between lines (on line break '\n')
	Local textOffsetX:Float = 0.0 ' Offset X to next character to draw

	Local scaleFactor:Float = fontSize/font.baseSize ' Character rectangle scaling factor

	' Word/character wrapping mechanism variables
	Const MEASURE_STATE:Int = 0
	Const DRAW_STATE:Int = 1

	Local state:Int
	If wordWrap Then
		state = MEASURE_STATE
	Else
		state = DRAW_STATE
	End If

	Local startLine:Int = -1 ' Index where to begin drawing (where a line begins)
	Local endLine:Int = -1 ' Index where to stop drawing (where a line ends)
	Local lastk:Int = -1 ' Holds last value of the character position

	Local k:Int = 0
	For Local i:Int = 0 Until length
		k :+ 1

		' Get next codepoint from byte string and glyph index in font
		'Local codepointByteCount:Int = 0
		Local codepoint:Int = text[i]
		Local index:Int = GetGlyphIndex(font, codepoint)

		' NOTE: Normally we exit the decoding sequence as soon as a bad byte is found (and return 0x3f)
		' but we need to draw all of the bad bytes using the '?' symbol moving one byte
		'If codepoint = $3f Then
		'	codepointByteCount = 1
		'End IF

		'i :+ (codepointByteCount - 1)

		Local glyphWidth:Float = 0.0
		If codepoint <> Asc("~n") Then
			
			If font.glyphs[index].advanceX = 0 Then
				glyphWidth = font.recs[index].width*scaleFactor
			Else
				glyphWidth = font.glyphs[index].advanceX*scaleFactor
			End If

			If i + 1 < length Then
				glyphWidth :+ glyphWidth + spacing
			End If
		End If

		' NOTE: When wordWrap is ON we first measure how much of the text we can draw before going outside of the rec container
		' We store this info in startLine and endLine, then we change states, draw the text between those two variables
		' and change states again and again recursively until the end of the text (or until we get outside of the container).
		' When wordWrap is OFF we don't need the measure state so we go to the drawing state immediately
		' and begin drawing on the next line before we can get outside the container.
		If state = MEASURE_STATE Then
			If codepoint = Asc(" ") Or codepoint = Asc("~t") Or codepoint = Asc("~n") Then
				endLine = i
			End If

			If textOffsetX + glyphWidth > rec.width Then
				If endLine < 1 Then
					endLine = i
				End If
				If i = endLine Then
					endLine :- 1
				End If
				If startLine + 1 = endLine Then
					endLine = i - 1
				End IF

				state = Not state
			Else If i + 1 = length Then
				endLine = i
				state = Not state
			Else If codepoint = Asc("~n") Then
				state = Not state
			End If

			If state = DRAW_STATE Then
				textOffsetX = 0
				i = startLine
				glyphWidth = 0

				' Save character position when we switch states
				Local tmp:Int = lastk
				lastk = k - 1
				k = tmp
			End If
		Else
			If codepoint = Asc("~n") Then
				If Not wordWrap Then
					textOffsetY :+ (font.baseSize + font.baseSize/2)*scaleFactor
					textOffsetX = 0
				End If
			Else
				If Not wordWrap And textOffsetX + glyphWidth > rec.width Then
					textOffsetY :+ (font.baseSize + font.baseSize/2)*scaleFactor
					textOffsetX = 0
				End If

				' When text overflows rectangle height limit, just stop drawing
				If textOffsetY + font.baseSize*scaleFactor > rec.height Then
					Exit
				End If

				' Draw selection background
				Local isGlyphSelected:Int = False
				If selectStart >= 0 And k >= selectStart And k < selectStart + selectLength Then
					DrawRectangleRec(New RRectangle(rec.x + textOffsetX - 1, rec.y + textOffsetY, glyphWidth, font.baseSize*scaleFactor), selectBackTint)
					isGlyphSelected = True
				End If

				' Draw current character glyph
				If codepoint <> Asc(" ") And codepoint <> Asc("~t") Then
					Local t:RColor
					If isGlyphSelected Then
						t = selectTint
					Else
						t = tint
					End If
					DrawTextCodepoint(font, codepoint, New RVector2(rec.x + textOffsetX, rec.y + textOffsetY), fontSize, t)
				End If
			End If

			If wordWrap And i = endLine Then
				textOffsetY :+ (font.baseSize + font.baseSize/2)*scaleFactor
				textOffsetX = 0
				startLine = endLine
				endLine = -1
				glyphWidth = 0
				selectStart :+ lastk - k
				k = lastk

				state = Not state
			End If
		End If

		if (textOffsetX <> 0) Or (codepoint <> Asc(" ")) Then
			textOffsetX :+ glyphWidth;  ' avoid leading spaces
		End If
	Next
End Function
