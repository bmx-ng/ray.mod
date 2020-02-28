SuperStrict

Framework Ray.Lib
Import Ray.Audio

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [audio] example - sound loading and playing")

InitAudioDevice()      ' Initialize audio device

Local fxWav:RSound = LoadSound("../../lib.mod/raylib/examples/audio/resources/sound.wav")         ' Load WAV audio file
Local fxOgg:RSound = LoadSound("../../lib.mod/raylib/examples/audio/resources/tanatana.ogg")      ' Load OGG audio file

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyPressed(KEY_SPACE) Then
		PlaySound(fxWav)      ' Play WAV sound
	End If
	If IsKeyPressed(KEY_ENTER) Then
		PlaySound(fxOgg)      ' Play OGG sound
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("Press SPACE to PLAY the WAV sound!", 200, 180, 20, LIGHTGRAY)
		DrawText("Press ENTER to PLAY the OGG sound!", 200, 220, 20, LIGHTGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadSound(fxWav)     ' Unload sound data
UnloadSound(fxOgg)     ' Unload sound data

CloseAudioDevice()     ' Close audio device

CloseWindow()          ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
