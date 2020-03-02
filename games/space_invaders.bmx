SuperStrict

Framework Ray.Lib
Import Text.Format


New TSpaceInvadersGame.Run()


Type TSpaceInvadersGame

	Const NUM_SHOOTS:Int = 50
	Const NUM_MAX_ENEMIES:Int = 50
	Const FIRST_WAVE:Int = 10
	Const SECOND_WAVE:Int = 20
	Const THIRD_WAVE:Int = 50

	Const screenWidth:Int = 800
	Const screenHeight:Int = 450

	Field gameOver:Int = False
	Field pause:Int =  False
	Field score:Int = 0
	Field victory:Int = False

	Field player:SPlayer
	Field enemy:SEnemy[NUM_MAX_ENEMIES]
	Field shoot:SShoot[NUM_SHOOTS]
	Field wave:EEnemyWave

	Field shootRate:Int = 0
	Field alpha:Float = 0.0

	Field activeEnemies:Int = 0
	Field enemiesKill:Int = 0
	Field smooth:Int = False

	Field scoreFormat:TFormatter = TFormatter.Create("%04i")

	Method Run()
		' Initialization (Note windowTitle is unused on Android)
		'---------------------------------------------------------
		InitWindow(screenWidth, screenHeight, "sample game: space invaders")

		InitGame()

		SetTargetFPS(60)
		'--------------------------------------------------------------------------------------

		' Main game loop
		While Not WindowShouldClose()    ' Detect window close button or ESC key
			' Update and Draw
			'----------------------------------------------------------------------------------
			UpdateDrawFrame()
			'----------------------------------------------------------------------------------
		Wend

		' De-Initialization
		'--------------------------------------------------------------------------------------
		UnloadGame()         ' Unload loaded data (textures, sounds, models...)

		CloseWindow()        ' Close window and OpenGL context
		'--------------------------------------------------------------------------------------
	End Method
	
	' Initialize game variables
	Method InitGame()
		' Initialize game variables
		shootRate = 0
		pause = False
		gameOver = False
		victory = False
		smooth = False
		wave = EEnemyWave.First
		activeEnemies = FIRST_WAVE
		enemiesKill = 0
		score = 0
		alpha = 0

		' Initialize player
		player.rec.x =  20
		player.rec.y = 50
		player.rec.width = 20
		player.rec.height = 20
		player.speed.x = 5
		player.speed.y = 5
		player.color = BLACK

		' Initialize enemies
		For Local i:Int = 0 Until NUM_MAX_ENEMIES
			enemy[i].rec.width = 10
			enemy[i].rec.height = 10
			enemy[i].rec.x = GetRandomValue(screenWidth, screenWidth + 1000)
			enemy[i].rec.y = GetRandomValue(0, screenHeight - enemy[i].rec.height)
			enemy[i].speed.x = 5
			enemy[i].speed.y = 5
			enemy[i].active = True
			enemy[i].color = GRAY
		Next

		' Initialize shoots
		For Local i:Int = 0 Until NUM_SHOOTS
			shoot[i].rec.x = player.rec.x
			shoot[i].rec.y = player.rec.y + player.rec.height/4
			shoot[i].rec.width = 10
			shoot[i].rec.height = 5
			shoot[i].speed.x = 7
			shoot[i].speed.y = 0
			shoot[i].active = False
			shoot[i].color = MAROON
		Next

	End Method
	
	' Update game (one frame)
	Method UpdateGame()
		If Not gameOver Then

			If IsKeyPressed(KEY_P) Then
				pause = Not pause
			End If

			If Not pause Then
				Select wave

					Case EEnemyWave.First

						If Not smooth Then
							alpha :+ 0.02
							
							If alpha >= 1.0 Then
								smooth = True
							End If
						End If
						
						If smooth Then
							alpha :- 0.02
						End If
						
						If enemiesKill = activeEnemies Then

							enemiesKill = 0

							For Local i:Int = 0 Until activeEnemies
								If Not enemy[i].active Then
									enemy[i].active = True
								End If
							Next
							
							activeEnemies = SECOND_WAVE
							wave = EEnemyWave.Second
							smooth = False
							alpha = 0.0
						End If
					Case EEnemyWave.Second
						If Not smooth Then
							alpha :+ 0.02
							
							If alpha >= 1.0 Then
								smooth = True
							End If
						End If
						
						If smooth Then
							alpha :- 0.02
						End If
						
						If enemiesKill = activeEnemies Then
							enemiesKill = 0

							For Local i:Int = 0 Until activeEnemies
								If Not enemy[i].active Then
									enemy[i].active = True
								End If
							Next
							
							activeEnemies = THIRD_WAVE
							wave = EEnemyWave.Third
							smooth = False
							alpha = 0.0
						End If
					Case EEnemyWave.Third
						If Not smooth Then
							alpha :+ 0.02
							
							If alpha >= 1.0 Then
								smooth = True
							End If
						End If
						
						If smooth Then
							alpha :- 0.02
						End If
						
						If enemiesKill = activeEnemies Then
							victory = True
						End If
							
				End Select

				' Player movement
				If IsKeyDown(KEY_RIGHT) Then
					player.rec.x :+ player.speed.x
				End If
				If IsKeyDown(KEY_LEFT) Then
					player.rec.x :- player.speed.x
				End If
				If IsKeyDown(KEY_UP) Then
					player.rec.y :- player.speed.y
				End If
				If IsKeyDown(KEY_DOWN) Then
					player.rec.y :+ player.speed.y
				End If

				' Player collision with enemy
				For Local i:Int = 0 Until activeEnemies
					If CheckCollisionRecs(player.rec, enemy[i].rec) Then
						gameOver = True
					End If
				Next

				 ' Enemy behaviour
				For Local i:Int = 0 Until activeEnemies
					If enemy[i].active Then
						enemy[i].rec.x :- enemy[i].speed.x

						If enemy[i].rec.x < 0 Then
							enemy[i].rec.x = GetRandomValue(screenWidth, screenWidth + 1000)
							enemy[i].rec.y = GetRandomValue(0, screenHeight - enemy[i].rec.height)
						End If
					End If
				Next

				' Wall behaviour
				If player.rec.x <= 0 Then
					player.rec.x = 0
				End If
				If player.rec.x + player.rec.width >= screenWidth Then
					player.rec.x = screenWidth - player.rec.width
				End If
				If player.rec.y <= 0 Then
					player.rec.y = 0
				End If
				If player.rec.y + player.rec.height >= screenHeight Then
					player.rec.y = screenHeight - player.rec.height
				End If

				' Shoot initialization
				If IsKeyDown(KEY_SPACE) Then
					shootRate :+ 5

					For Local i:Int = 0 Until NUM_SHOOTS
						If Not shoot[i].active And shootRate Mod 20 = 0 Then
							shoot[i].rec.x = player.rec.x
							shoot[i].rec.y = player.rec.y + player.rec.height/4
							shoot[i].active = True
							Exit
						End If
					Next
				End If

				' Shoot logic
				For Local i:Int = 0 Until NUM_SHOOTS
					If shoot[i].active Then
						' Movement
						shoot[i].rec.x :+ shoot[i].speed.x

						' Collision with enemy
						For Local j:Int = 0 Until activeEnemies

							If enemy[j].active Then
								If CheckCollisionRecs(shoot[i].rec, enemy[j].rec) Then
									shoot[i].active = False
									enemy[j].rec.x = GetRandomValue(screenWidth, screenWidth + 1000)
									enemy[j].rec.y = GetRandomValue(0, screenHeight - enemy[j].rec.height)
									shootRate = 0
									enemiesKill :+ 1
									score :+ 100
								End If
								
								If shoot[i].rec.x + shoot[i].rec.width >= screenWidth Then
									shoot[i].active = False
									shootRate = 0
								End If
							End If
						Next
					End If
				Next
			End If
		Else
			If IsKeyPressed(KEY_ENTER) Then
				InitGame()
				gameOver = False
			End If
		End If
	End Method

	' Draw game (one frame)
	Method DrawGame()
		BeginDrawing()

			ClearBackground(RAYWHITE)
			
			If Not gameOver Then
				DrawRectangleRec(player.rec, player.color)

				If wave = EEnemyWave.First Then
					DrawText("FIRST WAVE", screenWidth/2 - MeasureText("FIRST WAVE", 40)/2, screenHeight/2 - 40, 40, Fade(BLACK, alpha))
				Else If wave = EEnemyWave.Second Then
					DrawText("SECOND WAVE", screenWidth/2 - MeasureText("SECOND WAVE", 40)/2, screenHeight/2 - 40, 40, Fade(BLACK, alpha))
				Else If wave = EEnemyWave.Third Then
					DrawText("THIRD WAVE", screenWidth/2 - MeasureText("THIRD WAVE", 40)/2, screenHeight/2 - 40, 40, Fade(BLACK, alpha))
				End If
				
				For Local i:Int = 0 Until activeEnemies
					If enemy[i].active Then
						DrawRectangleRec(enemy[i].rec, enemy[i].color)
					End If
				Next

				For Local i:Int = 0 Until NUM_SHOOTS
					If shoot[i].active Then
						DrawRectangleRec(shoot[i].rec, shoot[i].color)
					End If
				Next
				
				DrawText(scoreFormat.Clear().Arg(score).Format(), 20, 20, 40, GRAY)
			
				If victory Then
					DrawText("YOU WIN", screenWidth/2 - MeasureText("YOU WIN", 40)/2, screenHeight/2 - 40, 40, BLACK)
				End If
			
				If pause Then
					DrawText("GAME PAUSED", screenWidth/2 - MeasureText("GAME PAUSED", 40)/2, screenHeight/2 - 40, 40, GRAY)
				End If
			Else
				DrawText("PRESS [ENTER] TO PLAY AGAIN", GetScreenWidth()/2 - MeasureText("PRESS [ENTER] TO PLAY AGAIN", 20)/2, GetScreenHeight()/2 - 50, 20, GRAY)
			End If

		EndDrawing()
	End Method
	
	Method UnloadGame()
		' TODO: Unload all dynamic loaded data (textures, sounds, models...)
	End Method

	' Update and Draw (one frame)
	Method UpdateDrawFrame()
		UpdateGame()
		DrawGame()
	End Method
End Type

Enum EEnemyWave
	First = 0
	Second
	Third
End Enum

Struct SPlayer
    Field rec:RRectangle
    Field speed:RVector2
    Field color:RColor
End Struct

Struct SEnemy
    Field rec:RRectangle
    Field speed:RVector2
    Field active:Int
    Field color:RColor
End Struct

Struct SShoot
    Field rec:RRectangle
    Field speed:RVector2
    Field active:Int
    Field color:RColor
End Struct
