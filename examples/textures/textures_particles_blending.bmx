SuperStrict

Framework Ray.Lib

Const MAX_PARTICLES:Int = 200

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - particles blending")

' Particles pool, reuse them!
Local mouseTail:SParticle[MAX_PARTICLES]

' Initialize particles
For Local i:Int = 0 Until MAX_PARTICLES
	mouseTail[i].position = New RVector2(0, 0)
	mouseTail[i].color = New RColor(GetRandomValue(0, 255), GetRandomValue(0, 255), GetRandomValue(0, 255), 255)
	mouseTail[i].alpha = 1.0
	mouseTail[i].size = GetRandomValue(1, 30)/20.0
	mouseTail[i].Rotation = GetRandomValue(0, 360)
	mouseTail[i].active = False
Next

Local gravity:Float = 3.0

Local smoke:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/spark_flame.png")

Local blending:Int = BLEND_ALPHA

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------

	' Activate one particle every frame and Update active particles
	' NOTE: Particles initial position should be mouse position when activated
	' NOTE: Particles fall down with gravity and rotation... and disappear after 2 seconds (alpha = 0)
	' NOTE: When a particle disappears, active = false and it can be reused.
	For Local i:Int = 0 Until MAX_PARTICLES
		If Not mouseTail[i].active Then
			mouseTail[i].active = True
			mouseTail[i].alpha = 1.0
			mouseTail[i].position = GetMousePosition()
			i = MAX_PARTICLES
		End If
	Next

	For Local i:Int = 0 Until MAX_PARTICLES
		If mouseTail[i].active Then
			mouseTail[i].position.y :+ gravity/2
			mouseTail[i].alpha :- 0.005

			If mouseTail[i].alpha <= 0.0 Then
				mouseTail[i].active = False
			End If

			mouseTail[i].Rotation :+ 2.0
		End If
	Next

	If IsKeyPressed(KEY_SPACE) Then
		If blending = BLEND_ALPHA Then
			blending = BLEND_ADDITIVE
		Else
			blending = BLEND_ALPHA
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(DARKGRAY)

		BeginBlendMode(blending)

			' Draw active particles
			For Local i:Int = 0 Until MAX_PARTICLES
				If mouseTail[i].active Then
					DrawTexturePro(smoke, New RRectangle(0.0, 0.0, Float(smoke.width), Float(smoke.height)), ..
							New RRectangle(mouseTail[i].position.x, mouseTail[i].position.y, smoke.width*mouseTail[i].size, smoke.height*mouseTail[i].size), ..
							New RVector2(smoke.width*mouseTail[i].size/2.0, smoke.height*mouseTail[i].size/2.0), mouseTail[i].Rotation, ..
							Fade(mouseTail[i].color, mouseTail[i].alpha))
				End If
			Next

		EndBlendMode()

		DrawText("PRESS SPACE to CHANGE BLENDING MODE", 180, 20, 20, BLACK)

		If blending = BLEND_ALPHA Then
			DrawText("ALPHA BLENDING", 290, screenHeight - 40, 20, BLACK)
		Else
			DrawText("ADDITIVE BLENDING", 280, screenHeight - 40, 20, RAYWHITE)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(smoke)

CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

Struct SParticle
    Field position:RVector2
    Field color:RColor
    Field alpha:Float
    Field size:Float
    Field Rotation:Float
    Field active:Int        ' NOTE: Use it to activate/deactive particle
End Struct
