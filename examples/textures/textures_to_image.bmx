SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - texture to image")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)

Local image:RImage = LoadImage("../../lib.mod/raylib/examples/textures/resources/raylib_logo.png")  ' Load image data into CPU memory (RAM)
Local texture:RTexture2D = LoadTextureFromImage(image)       ' Image converted to texture, GPU memory (RAM -> VRAM)
UnloadImage(image)                                    ' Unload image data from CPU memory (RAM)

image = LoadImageFromTexture(texture)                       ' Retrieve image data from GPU memory (VRAM -> RAM)
UnloadTexture(texture)                                ' Unload texture from GPU memory (VRAM)

texture = LoadTextureFromImage(image)                 ' Recreate texture from retrieved image data (RAM -> VRAM)
UnloadImage(image)                                    ' Unload retrieved image data from CPU memory (RAM)

SetTargetFPS(60)                 ' Set our game to run at 60 frames-per-second
'---------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' TODO: Update your variables here
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawTexture(texture, screenWidth/2 - texture.width/2, screenHeight/2 - texture.height/2, WHITE)

		DrawText("this IS a texture loaded from an image!", 300, 370, 10, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture)       ' Texture unloading

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
