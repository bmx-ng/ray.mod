SuperStrict

Framework Ray.Lib
Import BRL.Math

Const RAD2DEG:Float = 57.2958

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - waving cubes")

' Initialize the camera
Local camera:RCamera
camera.position = New RVector3(30.0, 20.0, 30.0)
camera.target = New RVector3(0.0, 0.0, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 70.0
camera.cameraType = CAMERA_PERSPECTIVE

' Specify the amount of blocks in each direction
Const numBlocks:Int = 15

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	Local time:Double = GetTime()

	' Calculate time scale for cube position and size
	Local scale:Float = (2.0 + Float(Sin(time * RAD2DEG)))*0.7

	' Move camera around the scene
	Local cameraTime:Double = time * 0.3
	camera.position.x = Float(Cos(cameraTime * RAD2DEG))*40.0
	camera.position.z = Float(Sin(cameraTime * RAD2DEG))*40.0
	'----------------------------------------------------------------------------------
	
	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			DrawGrid(10, 5.0)

			For Local x:Int = 0 Until numBlocks
			
				For Local y:Int = 0 Until numBlocks
				
					For Local z:Int = 0 Until numBlocks

						' Scale of the blocks depends on x/y/z positions
						Local blockScale:Float = (x + y + z)/30.0

						' Scatter makes the waving effect by adding blockScale over time
						Local scatter:Float = Sin((blockScale * 20.0 + Float(time*4.0)) * RAD2DEG)

						' Calculate the cube position
						Local cubePos:RVector3 = New RVector3( ..
							Float(x - numBlocks/2)*(scale*3.0) + scatter, ..
							Float(y - numBlocks/2)*(scale*2.0) + scatter, ..
							Float(z - numBlocks/2)*(scale*3.0) + scatter ..
						)

						' Pick a color with a hue depending on cube position for the rainbow color effect
						Local cubeColor:RColor = ColorFromHSV(New RVector3(Float(((x + y + z)*18) Mod 360), 0.75, 0.9))

						' Calculate cube size
						Local cubeSize:Float = (2.4 - scale) * blockScale

						' And finally, draw the cube!
						DrawCube(cubePos, cubeSize, cubeSize, cubeSize, cubeColor)
					Next
				Next
			Next
			
		EndMode3D()
		
		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
