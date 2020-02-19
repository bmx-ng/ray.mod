SuperStrict

Framework Ray.Lib
Import Ray.Audio

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [audio] example - Multichannel sound playing")

InitAudioDevice()      ' Initialize audio device

Local fxWav:RSound = LoadSound("../../raylib/examples/audio/resources/sound.wav")         ' Load WAV audio file
Local fxOgg:RSound = LoadSound("../../raylib/examples/audio/resources/tanatana.ogg")      ' Load OGG audio file

SetSoundVolume(fxWav, 0.2)

SetTargetFPS(60)       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyPressed(KEY_ENTER) Then
		PlaySoundMulti(fxWav)     ' Play a new wav sound instance
	End If
	If IsKeyPressed(KEY_SPACE) Then
		PlaySoundMulti(fxOgg)     ' Play a new ogg sound instance
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)
		
		DrawText("MULTICHANNEL SOUND PLAYING", 20, 20, 20, GRAY)
		DrawText("Press SPACE to play new ogg instance!", 200, 120, 20, LIGHTGRAY)
		DrawText("Press ENTER to play new wav instance!", 200, 180, 20, LIGHTGRAY)

		DrawText("CONCURRENT SOUNDS PLAYING: " + GetSoundsPlaying(), 220, 280, 20, RED)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
StopSoundMulti()       ' We must stop the buffer pool before unloading

UnloadSound(fxWav)     ' Unload sound data
UnloadSound(fxOgg)     ' Unload sound data

CloseAudioDevice()     ' Close audio device

CloseWindow()          ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
