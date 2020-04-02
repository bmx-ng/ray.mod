SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - image drawing")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)

Local cat:RImage = LoadImage("../../lib.mod/raylib/examples/textures/resources/cat.png")             ' Load image in CPU memory (RAM)
ImageCrop(cat, New RRectangle(100, 10, 280, 380))      ' Crop an image piece
ImageFlipHorizontal(cat)                              ' Flip cropped image horizontally
ImageResize(cat, 150, 200)                            ' Resize flipped-cropped image

Local parrots:RImage = LoadImage("../../lib.mod/raylib/examples/textures/resources/parrots.png")     ' Load image in CPU memory (RAM)

' Draw one image over the other with a scaling of 1.5f
ImageDraw(parrots, cat, New RRectangle(0, 0, cat.width, cat.height), New RRectangle(30, 40, cat.width*1.5, cat.height*1.5), WHITE)
ImageCrop(parrots, New RRectangle(0, 50, parrots.width, parrots.height - 100)) ' Crop resulting image

' Draw on the image with a few image draw methods
ImageDrawPixel(parrots, 10, 10, RAYWHITE)
ImageDrawCircle(parrots, 10, 10, 5, RAYWHITE)
ImageDrawRectangle(parrots, 5, 20, 10, 10, RAYWHITE)

UnloadImage(cat)       ' Unload image from RAM

' Load custom font for frawing on image
Local font:RFont = LoadFont("../../lib.mod/raylib/examples/textures/resources/custom_jupiter_crash.png")

' Draw over image using custom font
ImageDrawTextEx(parrots, New RVector2(300, 230), font, "PARROTS & CAT", font.baseSize, -2, WHITE)

UnloadFont(font) ' Unload custom spritefont (already drawn used on image)

Local texture:RTexture2D = LoadTextureFromImage(parrots)      ' Image converted to texture, uploaded to GPU memory (VRAM)
UnloadImage(parrots)   ' Once image has been converted to texture and uploaded to VRAM, it can be unloaded from RAM

SetTargetFPS(60)
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

		DrawTexture(texture, screenWidth/2 - texture.width/2, screenHeight/2 - texture.height/2 - 40, WHITE)
		DrawRectangleLines(screenWidth/2 - texture.width/2, screenHeight/2 - texture.height/2 - 40, texture.width, texture.height, DARKGRAY)

		DrawText("We are drawing only one texture from various images composed!", 240, 350, 10, DARKGRAY)
		DrawText("Source images have been cropped, scaled, flipped and copied one over the other.", 190, 370, 10, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture)       ' Texture unloading

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
