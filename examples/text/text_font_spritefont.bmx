SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - sprite font loading")

Const msg1:String = "THIS IS A custom SPRITE FONT..."
Const msg2:String = "...and this is ANOTHER CUSTOM font..."
Const msg3:String = "...and a THIRD one! GREAT! :D"

' NOTE: Textures/Fonts MUST be loaded after Window initialization (OpenGL context is required)
Local font1:RFont = LoadFont("../../lib.mod/raylib/examples/text/resources/custom_mecha.png")          ' Font loading
Local font2:RFont = LoadFont("../../lib.mod/raylib/examples/text/resources/custom_alagard.png")        ' Font loading
Local font3:RFont = LoadFont("../../lib.mod/raylib/examples/text/resources/custom_jupiter_crash.png")  ' Font loading

Local fontPosition1:RVector2 = New RVector2(screenWidth/2 - MeasureTextEx(font1, msg1, font1.baseSize, -3).x/2, screenHeight/2 - font1.baseSize/2 - 80)

Local fontPosition2:RVector2 = New RVector2(screenWidth/2 - MeasureTextEx(font2, msg2, font2.baseSize, -2).x/2, screenHeight/2 - font2.baseSize/2 - 10)

Local fontPosition3:RVector2 = New RVector2(screenWidth/2 - MeasureTextEx(font3, msg3, font3.baseSize, 2).x/2, screenHeight/2 - font3.baseSize/2 + 50)

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' TODO: Update variables here...
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawTextEx(font1, msg1, fontPosition1, font1.baseSize, -3, WHITE)
		DrawTextEx(font2, msg2, fontPosition2, font2.baseSize, -2, WHITE)
		DrawTextEx(font3, msg3, fontPosition3, font3.baseSize, 2, WHITE)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadFont(font1)      ' Font unloading
UnloadFont(font2)      ' Font unloading
UnloadFont(font3)      ' Font unloading

CloseWindow()          ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
