SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - first person maze")

' Define the camera to look into our 3d world
Local camera:RCamera = New RCamera( New RVector3(0.2, 0.4, 0.2), New RVector3(0.185, 0.0, 0.0), New RVector3(0.0, 1.0, 0.0), 45.0, CAMERA_PERSPECTIVE )

Local imMap:RImage = LoadImage("../../lib.mod/raylib/examples/models/resources/cubicmap.png")      ' Load cubicmap image (RAM)
Local cubicmap:RTexture2D = LoadTextureFromImage(imMap)       ' Convert image to texture to display (VRAM)
Local mesh:RMesh = GenMeshCubicmap(imMap, New RVector3(1.0, 1.0, 1.0))
Local model:RModel = LoadModelFromMesh(mesh)

' NOTE: By default each cube is mapped to one part of texture atlas
Local texture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/cubicmap_atlas.png")    ' Load map texture
model.materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = texture             ' Set map diffuse texture

' Get map image data to be used for collision detection
Local mapPixels:RColor Ptr = LoadImageColors(imMap)
UnloadImage(imMap)             ' Unload image from RAM

Local mapPosition:RVector3 = New RVector3(-16.0, 0.0, -8.0)  ' Set model position

DisableCursor()                ' Limit cursor to relative movement inside the window

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	Local oldCamPos:RVector3 = camera.position    ' Store old camera position

	UpdateCamera(camera, CAMERA_FIRST_PERSON)      ' Update camera

	' Check player collision (we simplify to 2D collision detection)
	Local playerPos:RVector2 = New RVector2(camera.position.x, camera.position.z)
	Local playerRadius:Float = 0.1  ' Collision radius (player is modelled as a cilinder for collision)

	Local playerCellX:Int = playerPos.x - mapPosition.x + 0.5
	Local playerCellY:Int = playerPos.y - mapPosition.z + 0.5

	' Out-of-limits security check
	If playerCellX < 0 Then
		playerCellX = 0
	Else If playerCellX >= cubicmap.width Then
		playerCellX = cubicmap.width - 1
	End If

	If playerCellY < 0 Then
		playerCellY = 0
	Else If playerCellY >= cubicmap.height Then
		playerCellY = cubicmap.height - 1
	End If

	' Check map collisions using image data and player position
	' TODO: Improvement: Just check player surrounding cells for collision
	For Local y:Int = 0 Until cubicmap.height
		For Local x:Int = 0 Until cubicmap.width
			If (mapPixels[y*cubicmap.width + x].r = 255) And ..      ' Collision: white pixel, only check R channel
				(CheckCollisionCircleRec(playerPos, playerRadius, New RRectangle(mapPosition.x - 0.5 + x*1.0, mapPosition.z - 0.5 + y*1.0, 1.0, 1.0))) Then
					' Collision detected, reset camera position
					camera.position = oldCamPos
			End If
		Next
	Next
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)
			DrawModel(model, mapPosition, 1.0, WHITE)                     ' Draw maze map
		EndMode3D()

		DrawTextureEx(cubicmap, New RVector2(GetScreenWidth() - cubicmap.width*4 - 20, 20), 0.0, 4.0, WHITE)
		DrawRectangleLines(GetScreenWidth() - cubicmap.width*4 - 20, 20, cubicmap.width*4, cubicmap.height*4, GREEN)

		' Draw player position radar
		DrawRectangle(GetScreenWidth() - cubicmap.width*4 - 20 + playerCellX*4, 20 + playerCellY*4, 4, 4, RED)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadImageColors(mapPixels)            ' Unload color array

UnloadTexture(cubicmap)    ' Unload cubicmap texture
UnloadTexture(texture)     ' Unload map texture
UnloadModel(model)         ' Unload map model

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
