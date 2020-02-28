SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - cubesmap loading and drawing")

' Define the camera to look into our 3d world
Local camera:RCamera = New RCamera(New RVector3(16.0, 14.0, 16.0), New RVector3(0.0, 0.0, 0.0), New RVector3(0.0, 1.0, 0.0), 45.0, 0)

Local image:RImage = LoadImage("../../lib.mod/raylib/examples/models/resources/cubicmap.png")      ' Load cubicmap image (RAM)
Local cubicmap:RTexture2D = LoadTextureFromImage(image)       ' Convert image to texture to display (VRAM)

Local mesh:RMesh = GenMeshCubicmap(image, New RVector3(1.0, 1.0, 1.0))
Local model:RModel = LoadModelFromMesh(mesh)

' NOTE: By default each cube is mapped to one part of texture atlas
Local texture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/models/resources/cubicmap_atlas.png")    ' Load map texture
model.materials[0].maps[MAP_DIFFUSE].texture = texture             ' Set map diffuse texture

Local mapPosition:RVector3 = New RVector3(-16.0, 0.0, -8.0)          ' Set model position

UnloadImage(image)     ' Unload cubesmap image from RAM, already uploaded to VRAM

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

			DrawModel(model, mapPosition, 1.0, WHITE)

		EndMode3D()

		DrawTextureEx(cubicmap, New RVector2(screenWidth - cubicmap.width*4 - 20, 20), 0.0, 4.0, WHITE)
		DrawRectangleLines(screenWidth - cubicmap.width*4 - 20, 20, cubicmap.width*4, cubicmap.height*4, GREEN)

		DrawText("cubicmap image used to", 658, 90, 10, GRAY)
		DrawText("generate map 3d model", 658, 104, 10, GRAY)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(cubicmap)    ' Unload cubicmap texture
UnloadTexture(texture)     ' Unload map texture
UnloadModel(model)         ' Unload map model

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
