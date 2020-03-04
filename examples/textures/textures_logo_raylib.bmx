SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - texture loading and drawing")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
Local texture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/raylib_logo.png")        ' Texture loading
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

		DrawText("this IS a texture!", 360, 370, 10, GRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture)       ' Texture unloading

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
