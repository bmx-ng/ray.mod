SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - generate random values")

Local framesCounter:Int = 0          ' Variable used to count frames

Local randValue:Int = GetRandomValue(-8, 5)   ' Get a random integer number between -8 and 5 (both included)

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	framesCounter :+ 1

	' Every two seconds (120 frames) a new random value is generated
	If ((framesCounter/120) Mod 2) = 1 Then
		randValue = GetRandomValue(-8, 5)
		framesCounter = 0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("Every 2 seconds a new random value is generated:", 130, 100, 20, MAROON)

		DrawText(randValue, 360, 180, 80, LIGHTGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
