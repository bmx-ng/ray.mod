SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - heightmap loading and drawing")

' Define our custom camera to look into our 3d world
Local camera:RCamera = New RCamera(New RVector3(18.0, 18.0, 18.0), New RVector3(0.0, 0.0, 0.0), New RVector3(0.0, 1.0, 0.0), 45.0, 0)

Local image:RImage = LoadImage("../../raylib/examples/models/resources/heightmap.png")             ' Load heightmap image (RAM)
Local texture:RTexture2D = LoadTextureFromImage(image)                ' Convert image to texture (VRAM)

Local mesh:RMesh = GenMeshHeightmap(image, New RVector3(16, 8, 16))    ' Generate heightmap mesh (RAM and VRAM)
Local model:RModel = LoadModelFromMesh(mesh)                          ' Load model from generated mesh

model.materials[0].maps[MAP_DIFFUSE].texture = texture         ' Set map diffuse texture
Local mapPosition:RVector3 = New RVector3(-8.0, 0.0, -8.0)                   ' Define model position

UnloadImage(image)                     ' Unload heightmap image from RAM, already uploaded to VRAM

SetCameraMode(camera, CAMERA_ORBITAL)  ' Set an orbital camera mode

SetTargetFPS(60)                       ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()            ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera)              ' Update camera
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			DrawModel(model, mapPosition, 1.0, RED)

			DrawGrid(20, 1.0)

		EndMode3D()

		DrawTexture(texture, screenWidth - texture.width - 20, 20, WHITE)
		DrawRectangleLines(screenWidth - texture.width - 20, 20, texture.width, texture.height, GREEN)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture)     ' Unload texture
UnloadModel(model)         ' Unload model

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
