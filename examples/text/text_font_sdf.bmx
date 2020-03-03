SuperStrict

Framework Ray.Lib
Import Text.Format

?win32
Const GLSL_VERSION:Int = 330
?raspberrypi
Const GLSL_VERSION:Int = 100
?

Local formatter:TFormatter = TFormatter.Create("RENDER SIZE: %02.02f")

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - SDF fonts")

' NOTE: Textures/Fonts MUST be loaded after Window initialization (OpenGL context is required)

Local msg:String = "Signed Distance Fields"

' Default font generation from TTF font
Local fontDefault:RFont
fontDefault.baseSize = 16
fontDefault.charsCount = 95
' Parameters > font size: 16, no chars array provided (0), chars count: 95 (autogenerate chars array)
fontDefault.chars = LoadFontData("../../lib.mod/raylib/examples/text/resources/AnonymousPro-Bold.ttf", 16, 0, 95, FONT_DEFAULT)
' Parameters > chars count: 95, font size: 16, chars padding in image: 4 px, pack method: 0 (default)
Local atlas:RImage  = GenImageFontAtlas(fontDefault.chars, Varptr fontDefault.recs, 95, 16, 4, 0)
fontDefault.texture = LoadTextureFromImage(atlas)
UnloadImage(atlas)

' SDF font generation from TTF font
Local fontSDF:RFont
fontSDF.baseSize = 16
fontSDF.charsCount = 95
' Parameters > font size: 16, no chars array provided (0), chars count: 0 (defaults to 95)
fontSDF.chars = LoadFontData("../../lib.mod/raylib/examples/text/resources/AnonymousPro-Bold.ttf", 16, 0, 0, FONT_SDF)
' Parameters > chars count: 95, font size: 16, chars padding in image: 0 px, pack method: 1 (Skyline algorythm)
atlas = GenImageFontAtlas(fontSDF.chars, Varptr fontSDF.recs, 95, 16, 0, 1)
fontSDF.texture = LoadTextureFromImage(atlas)
UnloadImage(atlas)

' Load SDF required shader (we use default vertex shader)
Local shader:RShader = LoadShader(0, "../../lib.mod/raylib/examples/text/resources/shaders/glsl" + GLSL_VERSION + "/sdf.fs")
SetTextureFilter(fontSDF.texture, FILTER_BILINEAR)    ' Required for SDF font

Local fontPosition:RVector2 = New RVector2(40, screenHeight/2 - 50)
Local textSize:RVector2 = New RVector2(0.0, 0.0)
Local FontSize:Float = 16.0
Local currentFont:Int = 0            ' 0 - fontDefault, 1 - fontSDF

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	FontSize :+ GetMouseWheelMove() * 8.0

	If FontSize < 6 Then
		FontSize = 6
	End If

	If IsKeyDown(KEY_SPACE) Then
		currentFont = 1
	Else
		currentFont = 0
	End If
	
	If currentFont = 0 Then
		textSize = MeasureTextEx(fontDefault, msg, FontSize, 0)
	Else
		textSize = MeasureTextEx(fontSDF, msg, FontSize, 0)
	End If

	fontPosition.x = GetScreenWidth()/2 - textSize.x/2
	fontPosition.y = GetScreenHeight()/2 - textSize.y/2 + 80
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		If currentFont = 1 Then
			' NOTE: SDF fonts require a custom SDf shader to compute fragment color
			BeginShaderMode(shader)    ' Activate SDF font shader
				DrawTextEx(fontSDF, msg, fontPosition, FontSize, 0, BLACK)
			EndShaderMode()            ' Activate our default shader for next drawings

			DrawTexture(fontSDF.texture, 10, 10, BLACK)
		Else
			DrawTextEx(fontDefault, msg, fontPosition, FontSize, 0, BLACK)
			DrawTexture(fontDefault.texture, 10, 10, BLACK)
		End If

		If currentFont = 1 Then
			DrawText("SDF!", 320, 20, 80, RED)
		Else
			DrawText("default font", 315, 40, 30, GRAY)
		End If
		
		DrawText("FONT SIZE: 16.0", GetScreenWidth() - 240, 20, 20, DARKGRAY)
		DrawText(formatter.Clear().Arg(FontSize).Format(), GetScreenWidth() - 240, 50, 20, DARKGRAY)
		DrawText("Use MOUSE WHEEL to SCALE TEXT!", GetScreenWidth() - 240, 90, 10, DARKGRAY)

		DrawText("HOLD SPACE to USE SDF FONT VERSION!", 340, GetScreenHeight() - 30, 20, MAROON)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadFont(fontDefault)    ' Default font unloading
UnloadFont(fontSDF)        ' SDF font unloading

UnloadShader(shader)       ' Unload SDF shader

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
