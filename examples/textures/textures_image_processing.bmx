SuperStrict

Framework Ray.Lib

Const NUM_PROCESSES:Int = 8

Local processText:String[] = [ ..
    "NO PROCESSING", ..
    "COLOR GRAYSCALE", ..
    "COLOR TINT", ..
    "COLOR INVERT", ..
    "COLOR CONTRAST", ..
    "COLOR BRIGHTNESS", ..
    "FLIP VERTICAL", ..
    "FLIP HORIZONTAL"]

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - image processing")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)

Local image:RImage = LoadImage("../../lib.mod/raylib/examples/textures/resources/parrots.png")   ' Loaded in CPU memory (RAM)
ImageFormat(image, UNCOMPRESSED_R8G8B8A8)         ' Format image to RGBA 32bit (required for texture update) <-- ISSUE
Local texture:RTexture2D = LoadTextureFromImage(image)    ' Image converted to texture, GPU memory (VRAM)

Local currentProcess:Int = NONE
Local textureReload:Int = False

Local selectRecs:RRectangle[NUM_PROCESSES]

For Local i:Int = 0 Until NUM_PROCESSES
	selectRecs[i] = New RRectangle(40.0, Float(50 + 32*i), 150.0, 30.0)
Next

SetTargetFPS(60)
'---------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsKeyPressed(KEY_DOWN) Then
		currentProcess :+ 1
		If currentProcess > 7 Then
			currentProcess = 0
		End If
		textureReload = True
	Else If IsKeyPressed(KEY_UP) Then
		currentProcess :- 1
		If currentProcess < 0 Then
			currentProcess = 7
		End If
		textureReload = True
	End If

	If textureReload Then
		UnloadImage(image)                         ' Unload current image data
		image = LoadImage("../../lib.mod/raylib/examples/textures/resources/parrots.png") ' Re-load image data

		' NOTE: Image processing is a costly CPU process to be done every frame,
		' If image processing is required in a frame-basis, it should be done
		' with a texture and by shaders
		Select currentProcess
			Case COLOR_GRAYSCALE
				ImageColorGrayscale(image)
			Case COLOR_TINT
				ImageColorTint(image, GREEN)
			Case COLOR_INVERT
				ImageColorInvert(image)
			Case COLOR_CONTRAST
				ImageColorContrast(image, -40)
			Case COLOR_BRIGHTNESS
				ImageColorBrightness(image, -80)
			Case FLIP_VERTICAL
				ImageFlipVertical(image)
			Case FLIP_HORIZONTAL
				ImageFlipHorizontal(image)
		End Select

		Local pixels:RColor Ptr = GetImageData(image)        ' Get pixel data from image (RGBA 32bit)
		UpdateTexture(texture, pixels)             ' Update texture with new image data
		RLFree(pixels)                               ' Unload pixels data from RAM

		textureReload = False
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("IMAGE PROCESSING:", 40, 30, 10, DARKGRAY)

		' Draw rectangles
		For Local i:Int = 0 Until NUM_PROCESSES
			Local recCol:RColor = LIGHTGRAY
			Local lineCol:RColor = GRAY
			Local txtCol:RColor = DARKGRAY
			
			If i = currentProcess Then
				recCol = SKYBLUE
				lineCol = BLUE
				txtCol = DARKBLUE
			End If
			
			DrawRectangleRec(selectRecs[i], recCol)
			DrawRectangleLines(Int(selectRecs[i].x), Int(selectRecs[i].y), Int(selectRecs[i].width), Int(selectRecs[i].height), lineCol)
			DrawText( processText[i], Int( selectRecs[i].x + selectRecs[i].width/2 - MeasureText(processText[i], 10)/2), Int(selectRecs[i].y + 11), 10, txtCol)
		Next

		DrawTexture(texture, screenWidth - texture.width - 60, screenHeight/2 - texture.height/2, WHITE)
		DrawRectangleLines(screenWidth - texture.width - 60, screenHeight/2 - texture.height/2, texture.width, texture.height, BLACK)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(texture)       ' Unload texture from VRAM
UnloadImage(image)           ' Unload image from RAM

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

Const NONE:Int = 0
Const COLOR_GRAYSCALE:Int = 1
Const COLOR_TINT:Int = 2
Const COLOR_INVERT:Int = 3
Const COLOR_CONTRAST:Int = 4
Const COLOR_BRIGHTNESS:Int = 5
Const FLIP_VERTICAL:Int = 6
Const FLIP_HORIZONTAL:Int = 7
