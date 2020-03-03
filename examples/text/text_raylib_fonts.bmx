SuperStrict

Framework Ray.Lib

Const MAX_FONTS:Int = 8

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - raylib fonts")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
Local fonts:RFont[MAX_FONTS]

fonts[0] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/alagard.png")
fonts[1] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/pixelplay.png")
fonts[2] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/mecha.png")
fonts[3] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/setback.png")
fonts[4] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/romulus.png")
fonts[5] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/pixantiqua.png")
fonts[6] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/alpha_beta.png")
fonts[7] = LoadFont("../../lib.mod/raylib/examples/text/resources/fonts/jupiter_crash.png")

Local messages:String[] = ["ALAGARD FONT designed by Hewett Tsoi", ..
							"PIXELPLAY FONT designed by Aleksander Shevchuk", ..
							"MECHA FONT designed by Captain Falcon", ..
							"SETBACK FONT designed by Brian Kent (AEnigma)", ..
							"ROMULUS FONT designed by Hewett Tsoi", ..
							"PIXANTIQUA FONT designed by Gerhard Grossmann", ..
							"ALPHA_BETA FONT designed by Brian Kent (AEnigma)", ..
							"JUPITER_CRASH FONT designed by Brian Kent (AEnigma)"]

Local spacings:Int[] = [2, 4, 8, 4, 3, 4, 4, 1]

Local positions:RVector2[MAX_FONTS]

For Local i:Int = 0 Until MAX_FONTS
	positions[i].x = screenWidth/2 - MeasureTextEx(fonts[i], messages[i], fonts[i].baseSize*2, spacings[i]).x/2
	positions[i].y = 60 + fonts[i].baseSize + 45*i
Next

' Small Y position corrections
positions[3].y :+ 8
positions[4].y :+ 2
positions[7].y :- 8

Local colors:RColor[] = [MAROON, ORANGE, DARKGREEN, DARKBLUE, DARKPURPLE, LIME, GOLD, RED]

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' TODO: Update your variables here
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("free fonts included with raylib", 250, 20, 20, DARKGRAY)
		DrawLine(220, 50, 590, 50, DARKGRAY)

		For Local i:Int = 0 Until MAX_FONTS
			DrawTextEx(fonts[i], messages[i], positions[i], fonts[i].baseSize*2, spacings[i], colors[i])
		Next

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------

' Fonts unloading
For Local i:Int = 0 Until MAX_FONTS
	UnloadFont(fonts[i])
Next

CloseWindow()                 ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
