SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] examples - texture source and destination rectangles")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)

Local scarfy:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/scarfy.png")        ' Texture loading

Local frameWidth:Int = scarfy.width/6
Local frameHeight:Int = scarfy.height

' Source rectangle (part of the texture to use for drawing)
Local sourceRec:RRectangle = New RRectangle(0.0, 0.0, frameWidth, frameHeight)

' Destination rectangle (screen rectangle where drawing part of texture)
Local destRec:RRectangle = New RRectangle(screenWidth/2, screenHeight/2, frameWidth*2, frameHeight*2)

' Origin of the texture (rotation/scale point), it's relative to destination rectangle size
Local origin:RVector2 = New RVector2(frameWidth, frameHeight)

Local Rotation:Int = 0

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	Rotation :+ 1
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' NOTE: Using DrawTexturePro() we can easily rotate and scale the part of the texture we draw
		' sourceRec defines the part of the texture we use for drawing
		' destRec defines the rectangle where our texture part will fit (scaling it to fit)
		' origin defines the point of the texture used as reference for rotation and scaling
		' rotation defines the texture rotation (using origin as rotation point)
		DrawTexturePro(scarfy, sourceRec, destRec, origin, Float(Rotation), WHITE)

		DrawLine(Int(destRec.x), 0, Int(destRec.x), screenHeight, GRAY)
		DrawLine(0, Int(destRec.y), screenWidth, Int(destRec.y), GRAY)

		DrawText("(c) Scarfy sprite by Eiden Marsal", screenWidth - 200, screenHeight - 20, 10, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(scarfy)        ' Texture unloading

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
