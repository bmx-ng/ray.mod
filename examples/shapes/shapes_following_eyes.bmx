SuperStrict

Framework Ray.Lib
Import BRL.Math

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - following eyes")

Local scleraLeftPosition:RVector2 = New RVector2(GetScreenWidth()/2 - 100, GetScreenHeight()/2)
Local scleraRightPosition:RVector2 = New RVector2(GetScreenWidth()/2 + 100, GetScreenHeight()/2)
Local scleraRadius:Float = 80

Local irisLeftPosition:RVector2 = New RVector2(GetScreenWidth()/2 - 100, GetScreenHeight()/2)
Local irisRightPosition:RVector2 = New RVector2(GetScreenWidth()/2 + 100, GetScreenHeight()/2)
Local irisRadius:Float = 24

Local angle:Float = 0.0
Local dx:Float = 0.0, dy:Float = 0.0, dxx:Float = 0.0, dyy:Float = 0.0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	irisLeftPosition = GetMousePosition()
	irisRightPosition = GetMousePosition()

	' Check not inside the left eye sclera
	If Not CheckCollisionPointCircle(irisLeftPosition, scleraLeftPosition, scleraRadius - 20) Then
		dx = irisLeftPosition.x - scleraLeftPosition.x
		dy = irisLeftPosition.y - scleraLeftPosition.y

		angle = ATan2(dy, dx)

		dxx = (scleraRadius - irisRadius) * Cos(angle)
		dyy = (scleraRadius - irisRadius) * Sin(angle)

		irisLeftPosition.x = scleraLeftPosition.x + dxx
		irisLeftPosition.y = scleraLeftPosition.y + dyy
	End If

	' Check not inside the right eye sclera
	If Not CheckCollisionPointCircle(irisRightPosition, scleraRightPosition, scleraRadius - 20)
		dx = irisRightPosition.x - scleraRightPosition.x
		dy = irisRightPosition.y - scleraRightPosition.y

		angle = atan2f(dy, dx)

		dxx = (scleraRadius - irisRadius)*cosf(angle)
		dyy = (scleraRadius - irisRadius)*sinf(angle)

		irisRightPosition.x = scleraRightPosition.x + dxx
		irisRightPosition.y = scleraRightPosition.y + dyy
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawCircleV(scleraLeftPosition, scleraRadius, LIGHTGRAY)
		DrawCircleV(irisLeftPosition, irisRadius, BROWN)
		DrawCircleV(irisLeftPosition, 10, BLACK)

		DrawCircleV(scleraRightPosition, scleraRadius, LIGHTGRAY)
		DrawCircleV(irisRightPosition, irisRadius, DARKGREEN)
		DrawCircleV(irisRightPosition, 10, BLACK)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
