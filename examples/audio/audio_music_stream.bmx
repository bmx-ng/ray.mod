SuperStrict

Framework Ray.Lib
Import Ray.Audio

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [audio] example - music playing (streaming)")

InitAudioDevice()              ' Initialize audio device

Local music:RMusic = LoadMusicStream("../../lib.mod/raylib/examples/audio/resources/country.mp3")

PlayMusicStream(music)

Local timePlayed:Float = 0.0
Local pause:Int = False

SetTargetFPS(30)               ' Set our game to run at 30 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateMusicStream(music)   ' Update music buffer with new stream data

	' Restart music playing (stop and play)
	If IsKeyPressed(KEY_SPACE) Then
		StopMusicStream(music)
		PlayMusicStream(music)
	End If

	' Pause/Resume music playing
	If IsKeyPressed(KEY_P) Then
		pause = Not pause

		If pause Then
			PauseMusicStream(music)
		Else
			ResumeMusicStream(music)
		End If
	End If

	' Get normalized time played for current music stream
	timePlayed = GetMusicTimePlayed(music)/GetMusicTimeLength(music)

	If timePlayed > 1.0 Then ' Make sure time played is no longer than music
		timePlayed = 1.0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, LIGHTGRAY)

		DrawRectangle(200, 200, 400, 12, LIGHTGRAY)
		DrawRectangle(200, 200, Int(timePlayed * 400), 12, MAROON)
		DrawRectangleLines(200, 200, 400, 12, GRAY)

		DrawText("PRESS SPACE TO RESTART MUSIC", 215, 250, 20, LIGHTGRAY)
		DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 280, 20, LIGHTGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadMusicStream(music)   ' Unload music stream buffers from RAM

CloseAudioDevice()         ' Close audio device (music streaming is automatically stopped)

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
