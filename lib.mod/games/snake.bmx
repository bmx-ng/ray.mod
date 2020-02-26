SuperStrict

Framework Ray.Lib

Const SNAKE_LENGTH:Int = 256
Const SQUARE_SIZE:Int = 31

New TSnakeGame.Run()


Type TSnakeGame

	Const screenWidth:Int = 800
	Const screenHeight:Int = 450

	Field framesCounter:Int = 0
	Field gameOver:Int = False
	Field pause:Int = False

	Field fruit:TFood = New TFood
	Field snake:SSnake[SNAKE_LENGTH]
	Field snakePosition:RVector2[SNAKE_LENGTH]
	Field allowMove:Int = False
	Field offset:RVector2
	Field counterTail:Int = 0

	Method Run()
		' Initialization (Note windowTitle is unused on Android)
		'---------------------------------------------------------
		InitWindow(screenWidth, screenHeight, "sample game: snake")

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


	Method InitGame()
		framesCounter = 0
		gameOver = False
		pause = False

		counterTail = 1
		allowMove = False

		offset.x = screenWidth Mod SQUARE_SIZE
		offset.y = screenHeight Mod SQUARE_SIZE

		For Local i:Int = 0 Until SNAKE_LENGTH
			snake[i].position = New RVector2(offset.x/2, offset.y/2)
			snake[i].size = New RVector2(SQUARE_SIZE, SQUARE_SIZE)
			snake[i].speed = New RVector2(SQUARE_SIZE, 0)

			If Not i Then
				snake[i].color = DARKBLUE
			Else
				snake[i].color = BLUE
			End If
		Next

		For Local i:Int = 0 Until SNAKE_LENGTH
			snakePosition[i] = New RVector2(0.0, 0.0)
		Next

		fruit.size = New RVector2(SQUARE_SIZE, SQUARE_SIZE)
		fruit.color = SKYBLUE
		fruit.active = False
	End Method


	Method UpdateGame()
		If Not gameOver Then

			If IsKeyPressed(KEY_P) Then
				pause = Not pause
			End If
			
			If Not pause Then
				' Player control
				If IsKeyPressed(KEY_RIGHT) And snake[0].speed.x = 0 And allowMove Then
					snake[0].speed = New RVector2(SQUARE_SIZE, 0)
					allowMove = False
				End If
				
				If IsKeyPressed(KEY_LEFT) And snake[0].speed.x = 0 And allowMove Then
					snake[0].speed = New RVector2(-SQUARE_SIZE, 0)
					allowMove = False
				End If
				
				If IsKeyPressed(KEY_UP) And snake[0].speed.y = 0 And allowMove Then
					snake[0].speed = New RVector2(0, -SQUARE_SIZE)
					allowMove = False
				End If
				
				If IsKeyPressed(KEY_DOWN) And snake[0].speed.y = 0 And allowMove Then
					snake[0].speed = New RVector2(0, SQUARE_SIZE)
					allowMove = False
				End If

				' Snake movement
				For Local i:Int = 0 Until counterTail
					snakePosition[i] = snake[i].position
				Next

				If (framesCounter Mod 5) = 0 Then
					For Local i:Int = 0 Until counterTail
						If Not i Then
							snake[0].position.x :+ snake[0].speed.x
							snake[0].position.y :+ snake[0].speed.y
							allowMove = True
						Else
							snake[i].position = snakePosition[i-1]
						End If
					Next
				End If

				' Wall behaviour
				If ((snake[0].position.x) > (screenWidth - offset.x)) Or ..
					((snake[0].position.y) > (screenHeight - offset.y)) Or ..
						(snake[0].position.x < 0) Or (snake[0].position.y < 0) Then
					gameOver = True
				End If

				' Collision with yourself
				For Local i:Int = 1 Until counterTail
					If (snake[0].position.x = snake[i].position.x) And (snake[0].position.y = snake[i].position.y) Then
						gameOver = True
					End If
				Next

				' Fruit position calculation
				If Not fruit.active Then
					fruit.active = True
					fruit.position = New RVector2(GetRandomValue(0, (screenWidth/SQUARE_SIZE) - 1)*SQUARE_SIZE + offset.x/2, GetRandomValue(0, (screenHeight/SQUARE_SIZE) - 1)*SQUARE_SIZE + offset.y/2)

					For Local i:Int = 0 Until counterTail
						While (fruit.position.x = snake[i].position.x) And (fruit.position.y = snake[i].position.y)
							fruit.position = New RVector2(GetRandomValue(0, (screenWidth/SQUARE_SIZE) - 1) * SQUARE_SIZE + offset.x/2, GetRandomValue(0, (screenHeight/SQUARE_SIZE) - 1)*SQUARE_SIZE + offset.y/2)
							i = 0
						Wend
					Next
				End If

				' Collision
				If (snake[0].position.x < (fruit.position.x + fruit.size.x) And (snake[0].position.x + snake[0].size.x) > fruit.position.x) And ..
						(snake[0].position.y < (fruit.position.y + fruit.size.y) And (snake[0].position.y + snake[0].size.y) > fruit.position.y) Then
					snake[counterTail].position = snakePosition[counterTail - 1]
					counterTail :+ 1
					fruit.active = False
				End If

				framesCounter :+ 1
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
				' Draw grid lines
				For Local i:Int = 0 Until screenWidth/SQUARE_SIZE + 1
					DrawLineV(New RVector2(SQUARE_SIZE*i + offset.x/2, offset.y/2), New RVector2(SQUARE_SIZE*i + offset.x/2, screenHeight - offset.y/2), LIGHTGRAY)
				Next
				
				For Local i:Int = 0 Until screenHeight/SQUARE_SIZE + 1
					DrawLineV(New RVector2(offset.x/2, SQUARE_SIZE*i + offset.y/2), New RVector2(screenWidth - offset.x/2, SQUARE_SIZE*i + offset.y/2), LIGHTGRAY)
				Next

				' Draw snake
				For Local i:Int = 0 Until counterTail
					DrawRectangleV(snake[i].position, snake[i].size, snake[i].color)
				Next

				' Draw fruit to pick
				DrawRectangleV(fruit.position, fruit.size, fruit.color)

				If pause Then
					DrawText("GAME PAUSED", screenWidth/2 - MeasureText("GAME PAUSED", 40)/2, screenHeight/2 - 40, 40, GRAY)
				End If

			Else
				DrawText("PRESS [ENTER] TO PLAY AGAIN", GetScreenWidth()/2 - MeasureText("PRESS [ENTER] TO PLAY AGAIN", 20)/2, GetScreenHeight()/2 - 50, 20, GRAY)
			End If

		EndDrawing()
	End Method

	' Unload game variables
	Method UnloadGame()
		' TODO: Unload all dynamic loaded data (textures, sounds, models...)
	End Method

	' Update and Draw (one frame)
	Method UpdateDrawFrame()
		UpdateGame()
		DrawGame()
	End Method
End Type

Struct SSnake
    Field position:RVector2
    Field size:RVector2
    Field speed:RVector2
    Field color:RColor
End Struct

Type TFood
    Field position:RVector2
    Field size:RVector2
    Field active:Int
    Field color:RColor
End Type
