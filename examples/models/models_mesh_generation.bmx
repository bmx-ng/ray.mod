SuperStrict

Framework Ray.Lib

Const NUM_MODELS:Int = 9      ' Parametric 3d shapes to generate

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - mesh generation")

' We generate a checked image for texturing
Local checked:RImage = GenImageChecked(2, 2, 1, 1, RED, GREEN)
Local texture:RTexture2D = LoadTextureFromImage(checked)
UnloadImage(checked)

Local models:RModel[NUM_MODELS]

models[0] = LoadModelFromMesh(GenMeshPlane(2, 2, 4, 3))
models[1] = LoadModelFromMesh(GenMeshCube(2.0, 1.0, 2.0))
models[2] = LoadModelFromMesh(GenMeshSphere(2, 32, 32))
models[3] = LoadModelFromMesh(GenMeshHemiSphere(2, 16, 16))
models[4] = LoadModelFromMesh(GenMeshCylinder(1, 2, 16))
models[5] = LoadModelFromMesh(GenMeshTorus(0.25, 4.0, 16, 32))
models[6] = LoadModelFromMesh(GenMeshKnot(1.0, 2.0, 16, 128))
models[7] = LoadModelFromMesh(GenMeshPoly(5, 2.0))
models[8] = LoadModelFromMesh(GenMeshCustom())

' Set checked texture as default diffuse component for all models material
For Local i:Int = 0 Until NUM_MODELS
	models[i].materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = texture
Next

' Define the camera to look into our 3d world
Local camera:RCamera = New RCamera( New RVector3(5.0, 5.0, 5.0), New RVector3(0.0, 0.0, 0.0), New RVector3(0.0, 1.0, 0.0), 45.0, 0)

' Model drawing position
Local position:RVector3 = New RVector3(0.0, 0.0, 0.0)

Local currentModel:Int = 0

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera, CAMERA_ORBITAL)      ' Update internal camera and our camera

	If IsMouseButtonPressed(MOUSE_LEFT_BUTTON) Then
		currentModel = (currentModel + 1) Mod NUM_MODELS ' Cycle between the textures
	End If

	If IsKeyPressed(KEY_RIGHT) Then
		currentModel :+ 1
		If currentModel >= NUM_MODELS Then
			currentModel = 0
		End If
	Else If IsKeyPressed(KEY_LEFT) Then
		currentModel :- 1
		If currentModel < 0 Then
			currentModel = NUM_MODELS - 1
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		BeginMode3D(camera)

			DrawModel(models[currentModel], position, 1.0, WHITE)

			DrawGrid(10, 1.0)

		EndMode3D()

		DrawRectangle(30, 400, 310, 30, Fade(SKYBLUE, 0.5))
		DrawRectangleLines(30, 400, 310, 30, Fade(DARKBLUE, 0.5))
		DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL MODELS", 40, 410, 10, BLUE)

		Select currentModel
			Case 0
				DrawText("PLANE", 680, 10, 20, DARKBLUE)
			Case 1
				DrawText("CUBE", 680, 10, 20, DARKBLUE)
			Case 2
				DrawText("SPHERE", 680, 10, 20, DARKBLUE)
			Case 3
				DrawText("HEMISPHERE", 640, 10, 20, DARKBLUE)
			Case 4
				DrawText("CYLINDER", 680, 10, 20, DARKBLUE)
			Case 5
				DrawText("TORUS", 680, 10, 20, DARKBLUE)
			Case 6
				DrawText("KNOT", 680, 10, 20, DARKBLUE)
			Case 7
				DrawText("POLY", 680, 10, 20, DARKBLUE)
			Case 8
				DrawText("Custom (triangle)", 580, 10, 20, DARKBLUE)
		End Select

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture) ' Unload texture

' Unload models data (GPU VRAM)
For Local i:Int = 0 Until NUM_MODELS
	UnloadModel(models[i])
Next

CloseWindow()          ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

' Generate a simple triangle mesh from code
Function GenMeshCustom:RMesh()
	Local mesh:RMesh = New RMesh()
	mesh.triangleCount = 1
	mesh.vertexCount = mesh.triangleCount*3
	mesh.vertices = RMemAlloc(UInt(mesh.vertexCount*3*4))    ' 3 vertices, 3 coordinates each (x, y, z)
	mesh.texcoords = RMemAlloc(UInt(mesh.vertexCount*2*4))   ' 3 vertices, 2 coordinates each (x, y)
	mesh.normals = RMemAlloc(UInt(mesh.vertexCount*3*4))     ' 3 vertices, 3 coordinates each (x, y, z)

	' Vertex at (0, 0, 0)
	mesh.vertices[0] = 0
	mesh.vertices[1] = 0
	mesh.vertices[2] = 0
	mesh.normals[0] = 0
	mesh.normals[1] = 1
	mesh.normals[2] = 0
	mesh.texcoords[0] = 0
	mesh.texcoords[1] = 0

	' Vertex at (1, 0, 2)
	mesh.vertices[3] = 1
	mesh.vertices[4] = 0
	mesh.vertices[5] = 2
	mesh.normals[3] = 0
	mesh.normals[4] = 1
	mesh.normals[5] = 0
	mesh.texcoords[2] = 0.5
	mesh.texcoords[3] = 1.0

	' Vertex at (2, 0, 0)
	mesh.vertices[6] = 2
	mesh.vertices[7] = 0
	mesh.vertices[8] = 0
	mesh.normals[6] = 0
	mesh.normals[7] = 1
	mesh.normals[8] = 0
	mesh.texcoords[4] = 1
	mesh.texcoords[5] = 0

	UploadMesh(mesh, False)

	Return mesh
End Function