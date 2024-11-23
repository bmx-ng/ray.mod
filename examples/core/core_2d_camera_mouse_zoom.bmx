SuperStrict

Framework Ray.Lib
Import Ray.Math
Import Ray.rlgl

Const MAX_BUILDINGS:Int = 100

Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - 2d camera mouse zoom")

Local camera:RCamera2D = New RCamera2D()
camera.zoom = 1.0

Local zoomMode:Int = 0 ' 0-Mouse Wheel, 1-Mouse Move

SetTargetFPS(60)                   ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()        ' Detect window close button or ESC key

	' Update
	'----------------------------------------------------------------------------------
	If IsKeyPressed(KEY_ONE) Then
		zoomMode = 0
	Else If IsKeyPressed(KEY_TWO) Then
		zoomMode = 1
	End If
	
	' Translate based on mouse right click
	If IsMouseButtonDown(MOUSE_BUTTON_LEFT) Then
		Local delta:RVector2 = GetMouseDelta()
		delta = Vector2Scale(delta, -1.0/camera.zoom)
		camera.target = Vector2Add(camera.target, delta)
	End If

	if zoomMode = 0 Then
		' Zoom based on mouse wheel
		Local wheel:Float = GetMouseWheelMove()
		If wheel <> 0 Then
		
			' Get the world point that is under the mouse
			Local mouseWorldPos:RVector2 = GetScreenToWorld2D(GetMousePosition(), camera)

			' Set the offset to where the mouse is
			camera.offset = GetMousePosition()

			' Set the target to match, so that the camera maps the world space point 
			' under the cursor to the screen space point under the cursor at any zoom
			camera.target = mouseWorldPos

			' Zoom increment
			Local scaleFactor:Float = 1.0 + (0.25 * Abs(wheel))
			If wheel < 0 Then
				scaleFactor = 1.0/scaleFactor
			End If
			camera.zoom = Clamp(camera.zoom*scaleFactor, 0.125, 64.0)
		End If
	Else
		' Zoom based on mouse right click
		If IsMouseButtonPressed(MOUSE_BUTTON_RIGHT) Then
			' Get the world point that is under the mouse
			Local mouseWorldPos:RVector2 = GetScreenToWorld2D(GetMousePosition(), camera)

			' Set the offset to where the mouse is
			camera.offset = GetMousePosition()

			' Set the target to match, so that the camera maps the world space point 
			' under the cursor to the screen space point under the cursor at any zoom
			camera.target = mouseWorldPos
		End If
		If IsMouseButtonDown(MOUSE_BUTTON_RIGHT) Then
			' Zoom increment
			Local deltaX:Float = GetMouseDelta().x
			Local scaleFactor:Float = 1.0 + (0.01 * Abs(deltaX))
			If deltaX < 0 Then
				scaleFactor = 1.0/scaleFactor
			End If
			camera.zoom = Clamp(camera.zoom*scaleFactor, 0.125, 64.0)
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()
		ClearBackground(RAYWHITE)

		BeginMode2D(camera)

			' Draw the 3d grid, rotated 90 degrees and centered around 0,0 
			' just so we have something in the XY plane
			rlPushMatrix()
				rlTranslatef(0, 25*50, 0)
				rlRotatef(90, 1, 0, 0)
				DrawGrid(100, 50)
			rlPopMatrix()

			' Draw a reference circle
			DrawCircle(GetScreenWidth()/2, GetScreenHeight()/2, 50, MAROON)
			
		EndMode2D()
		
		' Draw mouse reference
		'Vector2 mousePos = GetWorldToScreen2D(GetMousePosition(), camera)
		DrawCircleV(GetMousePosition(), 4, DARKGRAY)
		DrawTextEx(GetFontDefault(), "[" + GetMouseX() +", " + GetMouseY() + "]", ..
			Vector2Add(GetMousePosition(), New RVector2(-44, -24)), 20, 2, BLACK)

		DrawText("[1][2] Select mouse zoom mode (Wheel or Move)", 20, 20, 20, DARKGRAY)
		If zoomMode = 0 Then
			DrawText("Mouse left button drag to move, mouse wheel to zoom", 20, 50, 20, DARKGRAY)
		Else
			DrawText("Mouse left button drag to move, mouse press and move to zoom", 20, 50, 20, DARKGRAY)
		End If
	
	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
