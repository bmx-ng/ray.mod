SuperStrict

Framework Ray.Lib
Import Text.Format
Import BRL.FileSystem

Local fontSizeFormat:TFormatter = TFormatter.Create("Font size: %02.02f")
Local textSizeFormat:TFormatter = TFormatter.Create("Text size: [%02.02f, %02.02f]")


' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - font filters")

Local msg:String = "Loaded Font"

' NOTE: Textures/Fonts MUST be loaded after Window initialization (OpenGL context is required)

' TTF Font loading with custom generation parameters
Local font:RFont = LoadFontEx("../../lib.mod/raylib/examples/text/resources/KAISG.ttf", 96, 0, 0)

' Generate mipmap levels to use trilinear filtering
' NOTE: On 2D drawing it won't be noticeable, it looks like FILTER_BILINEAR
GenTextureMipmaps(font.texture)

Local FontSize:Float = font.baseSize
Local fontPosition:RVector2 = New RVector2(40, screenHeight/2 - 80)
Local textSize:RVector2 = New RVector2(0.0, 0.0)

' Setup texture scaling filter
SetTextureFilter(font.texture, TEXTURE_FILTER_POINT)
Local currentFontFilter:Int = 0      ' TEXTURE_FILTER_POINT

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	FontSize :+ GetMouseWheelMove() * 4.0

	' Choose font texture filter method
	If IsKeyPressed(KEY_ONE) Then
		SetTextureFilter(font.texture, TEXTURE_FILTER_POINT)
		currentFontFilter = 0
	Else If IsKeyPressed(KEY_TWO) Then
		SetTextureFilter(font.texture, TEXTURE_FILTER_BILINEAR)
		currentFontFilter = 1
	Else If IsKeyPressed(KEY_THREE) Then
		' NOTE: Trilinear filter won't be noticed on 2D drawing
		SetTextureFilter(font.texture, TEXTURE_FILTER_TRILINEAR)
		currentFontFilter = 2
	End If

	textSize = MeasureTextEx(font, msg, FontSize, 0)

	If IsKeyDown(KEY_LEFT) Then
		fontPosition.x :- 10
	Else If IsKeyDown(KEY_RIGHT) Then
		fontPosition.x :+ 10
	End If

	' Load a dropped TTF file dynamically (at current fontSize)
	If IsFileDropped() Then
		Local droppedFiles:String[] = LoadDroppedFiles()

		' NOTE: We only support first ttf file dropped
		If ExtractExt(droppedFiles[0]) = "ttf" Then
			UnloadFont(font)
			font = LoadFontEx(droppedFiles[0], Int(fontSize), 0, 0)
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("Use mouse wheel to change font size", 20, 20, 10, GRAY)
		DrawText("Use KEY_RIGHT and KEY_LEFT to move text", 20, 40, 10, GRAY)
		DrawText("Use 1, 2, 3 to change texture filter", 20, 60, 10, GRAY)
		DrawText("Drop a new TTF font for dynamic loading", 20, 80, 10, DARKGRAY)

		DrawTextEx(font, msg, fontPosition, FontSize, 0, BLACK)

		' TODO: It seems texSize measurement is not accurate due to chars offsets...
		'DrawRectangleLines(fontPosition.x, fontPosition.y, textSize.x, textSize.y, RED)

		DrawRectangle(0, screenHeight - 80, screenWidth, 80, LIGHTGRAY)
		DrawText(fontSizeFormat.Clear().Arg(FontSize).Format(), 20, screenHeight - 50, 10, DARKGRAY)
		DrawText(textSizeFormat.Clear().Arg(textSize.x).Arg(textSize.y).Format(), 20, screenHeight - 30, 10, DARKGRAY)
		DrawText("CURRENT TEXTURE FILTER:", 250, 400, 20, GRAY)

		If currentFontFilter = 0 Then
			DrawText("POINT", 570, 400, 20, BLACK)
		Else If currentFontFilter = 1 Then
			DrawText("BILINEAR", 570, 400, 20, BLACK)
		Else If currentFontFilter = 2 Then
			DrawText("TRILINEAR", 570, 400, 20, BLACK)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadFont(font)           ' Font unloading

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
