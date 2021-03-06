SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - raylib logo using shapes")

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

		DrawRectangle(screenWidth/2 - 128, screenHeight/2 - 128, 256, 256, BLACK)
		DrawRectangle(screenWidth/2 - 112, screenHeight/2 - 112, 224, 224, RAYWHITE)
		DrawText("raylib", screenWidth/2 - 44, screenHeight/2 + 8, 50, BLACK)
		DrawText("blitzmax", screenWidth/2 - 94, screenHeight/2 + 48, 50, BLACK)
'		DrawText("raylib", screenWidth/2 - 44, screenHeight/2 + 48, 50, BLACK)

		DrawText("this is NOT a texture!", 350, 370, 10, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
