SuperStrict

Framework Ray.Lib
Import Ray.Math

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - drawing billboards")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(5.0, 4.0, 5.0)
camera.target = New RVector3(0.0, 2.0, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 45.0
camera.projection = CAMERA_PERSPECTIVE

Local bill:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/billboard.png")     ' Our texture billboard
Local billPositionStatic:RVector3 = New RVector3(0.0, 2.0, 0.0)                 ' Position of static billboard
Local billPositionRotating:RVector3 = New RVector3(1.0, 2.0, 1.0)               ' Position of rotating billboard

' Entire billboard texture, source is used to take a segment from a larger texture.
Local source:RRectangle = New RRectangle(0.0, 0.0, Float(bill.width), Float(bill.height))

' NOTE: Billboard locked on axis-Y
Local billUp:RVector3 = New RVector3(0.0, 1.0, 0.0)

' Set the height of the rotating billboard to 1.0 with the aspect ratio fixed
Local size:RVector2 = New RVector2(source.width/source.height, 1.0)

' Rotate around origin
' Here we choose to rotate around the image center
Local origin:RVector2 = Vector2Scale(size, 0.5)

' Distance is needed for the correct billboard draw order
' Larger distance (further away from the camera) should be drawn prior to smaller distance.
Local distanceStatic:Float
Local distanceRotating:Float
Local rotation:Float = 0.0

SetTargetFPS(60)                       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()            ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera, CAMERA_ORBITAL)              ' Update camera

	rotation :+ 0.4
	distanceStatic = Vector3Distance(camera.position, billPositionStatic)
	distanceRotating = Vector3Distance(camera.position, billPositionRotating)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			DrawGrid(10, 1.0)        ' Draw a grid

			' Draw order matters!
			If distanceStatic > distanceRotating Then
				DrawBillboard(camera, bill, billPositionStatic, 2.0, WHITE)
				DrawBillboardPro(camera, bill, source, billPositionRotating, billUp, size, origin, rotation, WHITE)
			Else
				DrawBillboardPro(camera, bill, source, billPositionRotating, billUp, size, origin, rotation, WHITE)
				DrawBillboard(camera, bill, billPositionStatic, 2.0, WHITE)
			End If

		EndMode3D()

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(bill)        ' Unload texture

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
