SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - blend modes")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)

Local bgImage:RImage = LoadImage("../../lib.mod/raylib/examples/textures/resources/cyberpunk_street_background.png") ' Loaded in CPU memory (RAM)
Local bgTexture:RTexture2D = LoadTextureFromImage(bgImage) ' Image converted to texture, GPU memory (VRAM)

Local fgImage:RImage = LoadImage("../../lib.mod/raylib/examples/textures/resources/cyberpunk_street_foreground.png") ' Loaded in CPU memory (RAM)
Local fgTexture:RTexture2D = LoadTextureFromImage(fgImage) ' Image converted to texture, GPU memory (VRAM)

' Once image has been converted to texture and uploaded to VRAM, it can be unloaded from RAM
UnloadImage(bgImage)
UnloadImage(fgImage)

Const blendCountMax:Int = 4
Local blendMode:Int = 0

SetTargetFPS(60) ' Set our game to run at 60 frames-per-second

'---------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose() ' Detect window close button or ESC key
	' Update

	If IsKeyPressed(KEY_SPACE) Then
		If blendMode >= (blendCountMax - 1) Then
			blendMode = 0
		Else
			blendMode :+ 1
		End If
	End If


	' Draw
	'----------------------------------------------------------------------------------

	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawTexture(bgTexture, screenWidth/2 - bgTexture.width/2, screenHeight/2 - bgTexture.height/2, WHITE)

		' Apply the blend mode and then draw the foreground texture
		BeginBlendMode(blendMode)
			DrawTexture(fgTexture, screenWidth/2 - fgTexture.width/2, screenHeight/2 - fgTexture.height/2, WHITE)
		EndBlendMode()

		' Draw the texts
		DrawText("Press SPACE to change blend modes.", 310, 350, 10, GRAY)

		Select blendMode
			Case BLEND_ALPHA
				DrawText("Current: BLEND_ALPHA", (screenWidth / 2) - 60, 370, 10, GRAY)
			Case BLEND_ADDITIVE
				DrawText("Current: BLEND_ADDITIVE", (screenWidth / 2) - 60, 370, 10, GRAY)
			Case BLEND_MULTIPLIED
				DrawText("Current: BLEND_MULTIPLIED", (screenWidth / 2) - 60, 370, 10, GRAY)
			Case BLEND_ADD_COLORS
				DrawText("Current: BLEND_ADD_COLORS", (screenWidth / 2) - 60, 370, 10, GRAY)
		End Select

		DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", screenWidth - 330, screenHeight - 20, 10, GRAY)

	EndDrawing()

Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(fgTexture)  ' Unload foreground texture
UnloadTexture(bgTexture)  ' Unload background texture

CloseWindow()             ' Close window and OpenGL context
