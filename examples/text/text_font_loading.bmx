SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - font loading")

' Define characters to draw
' NOTE: raylib supports UTF-8 encoding, following list is actually codified as UTF8 internally
Const msg:String = "!~q#$%&'()*+,-./0123456789:<=>?@ABCDEFGHI~nJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmn~nopqrstuvwxyz{|}~~¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓ~nÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷~nøùúûüýþÿ"

' NOTE: Textures/Fonts MUST be loaded after Window initialization (OpenGL context is required)

' BMFont (AngelCode) : Font data and image atlas have been generated using external program
Local fontBm:RFont = LoadFont("../../lib.mod/raylib/examples/text/resources/pixantiqua.fnt")

' TTF font : Font data and atlas are generated directly from TTF
' NOTE: We define a font base size of 32 pixels tall and up-to 250 characters
Local fontTtf:RFont = LoadFontEx("../../lib.mod/raylib/examples/text/resources/pixantiqua.ttf", 32, 0, 250)

Local useTtf:Int = False

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyDown(KEY_SPACE) Then
		useTtf = True
	Else
		useTtf = False
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("Hold SPACE to use TTF generated font", 20, 20, 20, LIGHTGRAY)

		If Not useTtf Then
			DrawTextEx(fontBm, msg, New RVector2(20.0, 100.0), fontBm.baseSize, 2, MAROON)
			DrawText("Using BMFont (Angelcode) imported", 20, GetScreenHeight() - 30, 20, GRAY)
		Else
			DrawTextEx(fontTtf, msg, New RVector2(20.0, 100.0), fontTtf.baseSize, 2, LIME)
			DrawText("Using TTF font generated", 20, GetScreenHeight() - 30, 20, GRAY)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadFont(fontBm)     ' AngelCode Font unloading
UnloadFont(fontTtf)    ' TTF Font unloading

CloseWindow()          ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
