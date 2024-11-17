SuperStrict

Framework Ray.Lib
Import Ray.Audio

Const NUM_FRAMES_PER_LINE:Int = 5
Const NUM_LINES:Int = 5

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - sprite explosion")

InitAudioDevice()

' Load explosion sound
Local fxBoom:RSound = LoadSound("../../lib.mod/raylib/examples/textures/resources/boom.wav")

' Load explosion texture
Local explosion:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/explosion.png")

' Init variables for animation
Local frameWidth:Int = explosion.width/NUM_FRAMES_PER_LINE    ' Sprite one frame rectangle width
Local frameHeight:Int = explosion.height/NUM_LINES            ' Sprite one frame rectangle height
Local currentFrame:Int = 0
Local currentLine:Int = 0

Local frameRec:RRectangle = New RRectangle(0, 0, frameWidth, frameHeight)
Local position:RVector2 = New RVector2(0.0, 0.0)

Local active:Int = False
Local framesCounter:Int = 0

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------

	' Check for mouse button pressed and activate explosion (if not active)
	If IsMouseButtonPressed(MOUSE_LEFT_BUTTON) And Not active Then
		position = GetMousePosition()
		active = True

		position.x :- frameWidth/2
		position.y :- frameHeight/2

		PlaySound(fxBoom)
	End If

	' Compute explosion animation frames
	If active Then
		framesCounter :+ 1

		If framesCounter > 2 Then
			currentFrame :+ 1

			If currentFrame >= NUM_FRAMES_PER_LINE Then
				currentFrame = 0
				currentLine :+ 1

				If currentLine >= NUM_LINES Then
					currentLine = 0
					active = False
				End If
			End If

			framesCounter = 0
		End If
	End If

	frameRec.x = frameWidth*currentFrame
	frameRec.y = frameHeight*currentLine
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' Draw explosion required frame rectangle
		If active Then
			DrawTextureRec(explosion, frameRec, position, WHITE)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(explosion)   ' Unload texture
UnloadSound(fxBoom)        ' Unload sound

CloseAudioDevice()

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
