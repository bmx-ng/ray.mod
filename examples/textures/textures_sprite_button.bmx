SuperStrict

Framework Ray.Lib
Import Ray.Audio

Const NUM_FRAMES:Int = 3       ' Number of frames (rectangles) for the button sprite texture

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - sprite button")

InitAudioDevice()      ' Initialize audio device

Local fxButton:RSound = LoadSound("../../lib.mod/raylib/examples/textures/resources/buttonfx.wav")   ' Load button sound
Local button:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/button.png") ' Load button texture

' Define frame rectangle for drawing
Local frameHeight:Int = button.height/NUM_FRAMES
Local sourceRec:RRectangle = New RRectangle(0, 0, button.width, frameHeight)

' Define button bounds on screen
Local btnBounds:RRectangle = New RRectangle(screenWidth/2 - button.width/2, screenHeight/2 - button.height/NUM_FRAMES/2, button.width, frameHeight)

Local btnState:Int = 0               ' Button state: 0-NORMAL, 1-MOUSE_HOVER, 2-PRESSED
Local btnAction:Int = False         ' Button action should be activated

Local mousePoint:RVector2 = New RVector2(0.0, 0.0)

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	mousePoint = GetMousePosition()
	btnAction = False

	' Check button state
	If CheckCollisionPointRec(mousePoint, btnBounds) Then
		If IsMouseButtonDown(MOUSE_LEFT_BUTTON) Then
			btnState = 2
		Else
			btnState = 1
		End If

		If IsMouseButtonReleased(MOUSE_LEFT_BUTTON) Then
			btnAction = True
		End If
	Else
		btnState = 0
	End If

	If btnAction Then
		PlaySound(fxButton)

		' TODO: Any desired action
	End If

	' Calculate button frame rectangle to draw depending on button state
	sourceRec.y = btnState*frameHeight
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawTextureRec(button, sourceRec, New RVector2(btnBounds.x, btnBounds.y), WHITE) ' Draw button frame

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(button)  ' Unload button texture
UnloadSound(fxButton)  ' Unload sound

CloseAudioDevice()     ' Close audio device

CloseWindow()          ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
