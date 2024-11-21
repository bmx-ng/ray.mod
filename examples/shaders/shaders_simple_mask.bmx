SuperStrict

Framework Ray.Lib
Import Ray.Math

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib - simple shader mask")

' Define the camera to look into our 3d world
Local camera:RCamera
camera.position = New RVector3(0.0, 1.0, 2.0)
camera.target = New RVector3(0.0, 0.0, 0.0)
camera.up = New RVector3(0.0, 1.0, 0.0)
camera.fovy = 45.0
camera.projection = CAMERA_PERSPECTIVE

' Define our three models to show the shader on
Local torus:RMesh = GenMeshTorus(0.3, 1, 16, 32)
Local model1:RModel = LoadModelFromMesh(torus)

Local cube:RMesh = GenMeshCube(0.8,0.8,0.8)
Local model2:RModel = LoadModelFromMesh(cube)

' Generate model to be shaded just to see the gaps in the other two
Local sphere:RMesh = GenMeshSphere(1, 16, 16)
Local model3:RModel = LoadModelFromMesh(sphere)

' Load the shader
Local shader:RShader = LoadShader(0, "../../lib.mod/raylib/examples/shaders/resources/shaders/glsl330/mask.fs")

' Load and apply the diffuse texture (colour map)
Local texDiffuse:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/shaders/resources/plasma.png")
model1.materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = texDiffuse
model2.materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = texDiffuse

' Using MAP_EMISSION as a spare slot to use for 2nd texture
' NOTE: Don't use MAP_IRRADIANCE, MAP_PREFILTER or  MAP_CUBEMAP
' as they are bound as cube maps
Local texMask:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/shaders/resources/mask.png")
model1.materials[0].maps[MATERIAL_MAP_EMISSION].texture = texMask
model2.materials[0].maps[MATERIAL_MAP_EMISSION].texture = texMask
shader.locs[SHADER_LOC_MAP_EMISSION] = GetShaderLocation(shader, "mask")

' Frame is incremented each frame to animate the shader
Local shaderFrame:Int = GetShaderLocation(shader, "frame")

' Apply the shader to the two models
model1.materials[0].shader = shader
model2.materials[0].shader = shader

Local framesCounter:Int = 0
Local Rotation:RVector3        ' Model rotation angles

DisableCursor()                ' Limit cursor to relative movement inside the window
SetTargetFPS(60)               ' Set  to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	UpdateCamera(camera, CAMERA_FIRST_PERSON)

	framesCounter :+ 1
	rotation.x :+ 0.01
	rotation.y :+ 0.005
	rotation.z :- 0.0025

	' Send frames counter to shader for animation
	SetShaderValue(shader, shaderFrame, Varptr framesCounter, SHADER_UNIFORM_INT)

	' Rotate one of the models
	model1.transform = MatrixRotateXYZ(rotation)
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(DARKBLUE)

		BeginMode3D(camera)

			DrawModel(model1, New RVector3(0.5,0,0), 1, WHITE)
			DrawModelEx(model2, New RVector3(-0.5,0,0), New RVector3(1,1,0), 50, New RVector3(1,1,1), WHITE)
			DrawModel(model3, New RVector3(0,0,-1.5), 1, WHITE)
			DrawGrid(10, 1.0)        ' Draw a grid

		EndMode3D()

		DrawRectangle(16, 420, MeasureText("Frame: " + framesCounter, 20) + 8, 22, BLUE)
		DrawText("Frame: " + framesCounter, 20, 422, 20, WHITE)

		DrawFPS(10, 10)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadModel(model1)
UnloadModel(model2)
UnloadModel(model3)

UnloadTexture(texDiffuse)  ' Unload default diffuse texture
UnloadTexture(texMask)     ' Unload texture mask

UnloadShader(shader)       ' Unload shader

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
