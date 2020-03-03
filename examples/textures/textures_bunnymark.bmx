SuperStrict

Framework Ray.Lib


Const MAX_BUNNIES:Int = 50000    ' 50K bunnies limit

' This is the maximum amount of elements (quads) per batch
' NOTE: This value is defined in [rlgl] module and can be changed there
Const MAX_BATCH_ELEMENTS:Int = 8192

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - bunnymark")

' Load bunny texture
Local texBunny:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/wabbit_alpha.png")

Local bunnies:SBunny[MAX_BUNNIES]    ' Bunnies array
Local bunniesCount:Int = 0           ' Bunnies counter

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsMouseButtonDown(MOUSE_LEFT_BUTTON) Then
		' Create more bunnies
		For Local i:Int = 0 Until 100
			If bunniesCount < MAX_BUNNIES Then
				bunnies[bunniesCount].position = GetMousePosition()
				bunnies[bunniesCount].speed.x = GetRandomValue(-250, 250)/60.0
				bunnies[bunniesCount].speed.y = GetRandomValue(-250, 250)/60.0
				bunnies[bunniesCount].color = New RColor(GetRandomValue(50, 240), GetRandomValue(80, 240), GetRandomValue(100, 240), 255)
				bunniesCount :+ 1
			End If
		Next
	End If

	' Update bunnies
	For Local i:Int = 0 Until bunniesCount
		bunnies[i].position.x :+ bunnies[i].speed.x
		bunnies[i].position.y :+ bunnies[i].speed.y

		If ((bunnies[i].position.x + texBunny.width/2) > GetScreenWidth()) Or ((bunnies[i].position.x + texBunny.width/2) < 0) Then
			bunnies[i].speed.x :* -1
		End If
		If ((bunnies[i].position.y + texBunny.height/2) > GetScreenHeight()) Or ((bunnies[i].position.y + texBunny.height/2 - 40) < 0) Then
			bunnies[i].speed.y :* -1
		End If
	Next
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		For Local i:Int = 0 Until bunniesCount
			' NOTE: When internal batch buffer limit is reached (MAX_BATCH_ELEMENTS),
			' a draw call is launched and buffer starts being filled again
			' before issuing a draw call, updated vertex data from internal CPU buffer is send to GPU...
			' Process of sending data is costly and it could happen that GPU data has not been completely
			' processed for drawing while new data is tried to be sent (updating current in-use buffers)
			' it could generates a stall and consequently a frame drop, limiting the number of drawn bunnies
			DrawTexture(texBunny, Int(bunnies[i].position.x), Int(bunnies[i].position.y), bunnies[i].color)
		Next

		DrawRectangle(0, 0, screenWidth, 40, BLACK)
		DrawText("bunnies: " + bunniesCount, 120, 10, 20, GREEN)
		DrawText("batched draw calls: " + (1 + bunniesCount/MAX_BATCH_ELEMENTS), 320, 10, 20, MAROON)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texBunny)    ' Unload bunny texture

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

Struct SBunny
	Field position:RVector2
	Field speed:RVector2
	Field color:RColor
End Struct
