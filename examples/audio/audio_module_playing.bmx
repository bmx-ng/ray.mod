SuperStrict

Framework Ray.Lib
Import Ray.Audio

Const MAX_CIRCLES:Int = 64

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)  ' NOTE: Try to enable MSAA 4X

InitWindow(screenWidth, screenHeight, "raylib [audio] example - module playing (streaming)")

InitAudioDevice()                  ' Initialize audio device

Local colors:RColor[] = [ORANGE, RED, GOLD, LIME, BLUE, VIOLET, BROWN, LIGHTGRAY, PINK, ..
					 YELLOW, GREEN, SKYBLUE, PURPLE, BEIGE ]

' Creates ome circles for visual effect
Local circles:TCircleWave[MAX_CIRCLES]

Local i:Int = MAX_CIRCLES - 1
While i >= 0
	circles[i] = New TCircleWave
	circles[i].alpha = 0.0
	circles[i].radius = GetRandomValue(10, 40)
	circles[i].position.x = GetRandomValue(circles[i].radius, screenWidth - circles[i].radius)
	circles[i].position.y = GetRandomValue(circles[i].radius, screenHeight - circles[i].radius)
	circles[i].speed = GetRandomValue(1, 100)/2000.0
	circles[i].color = colors[GetRandomValue(0, 13)]
	i :- 1
Wend

Local music:RMusic = LoadMusicStream("../../lib.mod/raylib/examples/audio/resources/mini1111.xm")

PlayMusicStream(music)

Local timePlayed:Float = 0.0
Local pause:Int = False

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateMusicStream(music)      ' Update music buffer with new stream data

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

	' Get timePlayed scaled to bar dimensions
	timePlayed = GetMusicTimePlayed(music)/GetMusicTimeLength(music)*(screenWidth - 40)

	' Color circles animation
	i = MAX_CIRCLES - 1
	While i >= 0 And Not pause
		circles[i].alpha :+ circles[i].speed
		circles[i].radius :+ circles[i].speed * 10.0

		If circles[i].alpha > 1.0 Then
			circles[i].speed :* -1
		End If

		If circles[i].alpha <= 0.0 Then
			circles[i].alpha = 0.0
			circles[i].radius = GetRandomValue(10, 40)
			circles[i].position.x = GetRandomValue(circles[i].radius, screenWidth - circles[i].radius)
			circles[i].position.y = GetRandomValue(circles[i].radius, screenHeight - circles[i].radius)
			circles[i].color = colors[GetRandomValue(0, 13)]
			circles[i].speed = GetRandomValue(1, 100)/2000.0
		End If
		i :- 1
	Wend
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		i = MAX_CIRCLES - 1
		While i >= 0
			DrawCircleV(circles[i].position, circles[i].radius, Fade(circles[i].color, circles[i].alpha))
			i :- 1
		Wend

		' Draw time bar
		DrawRectangle(20, screenHeight - 20 - 12, screenWidth - 40, 12, LIGHTGRAY)
		DrawRectangle(20, screenHeight - 20 - 12, Int(timePlayed), 12, MAROON)
		DrawRectangleLines(20, screenHeight - 20 - 12, screenWidth - 40, 12, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadMusicStream(music)          ' Unload music stream buffers from RAM

CloseAudioDevice()     ' Close audio device (music streaming is automatically stopped)

CloseWindow()          ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

Type TCircleWave
	Field position:RVector2
	Field radius:Float
	Field alpha:Float
	Field speed:Float
	Field color:RColor
End Type
