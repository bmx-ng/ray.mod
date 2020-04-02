SuperStrict

Framework Ray.Lib
Import Text.Format

Local defFormatter:TFormatter = TFormatter.Create("Default Mouse: [%i , %i]")
Local virFormatter:TFormatter = TFormatter.Create("Virtual Mouse: [%i , %i]")

Const windowWidth:Int = 800
Const windowHeight:Int = 450

' Enable config flags for resizable window and vertical synchro
SetConfigFlags(FLAG_WINDOW_RESIZABLE | FLAG_VSYNC_HINT)
InitWindow(windowWidth, windowHeight, "raylib [core] example - window scale letterbox")
SetWindowMinSize(320, 240)

Local gameScreenWidth:Int = 640
Local gameScreenHeight:Int = 480

' Render texture initialization, used to hold the rendering result so we can easily resize it
Local target:RRenderTexture2D = LoadRenderTexture(gameScreenWidth, gameScreenHeight)
SetTextureFilter(target.texture, FILTER_BILINEAR)  ' Texture scale filter to use

Local colors:RColor[10]
For Local i:Int = 0 Until 10
	colors[i] = New RColor(GetRandomValue(100, 250), GetRandomValue(50, 150), GetRandomValue(10, 100), 255)
Next

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' Compute required framebuffer scaling
	Local scale:Float = Min(GetScreenWidth()/Float(gameScreenWidth), GetScreenHeight()/Float(gameScreenHeight))

	If IsKeyPressed(KEY_SPACE) Then
		' Recalculate random colors for the bars
		For Local i:Int = 0 Until 10
			colors[i] = New RColor(GetRandomValue(100, 250), GetRandomValue(50, 150), GetRandomValue(10, 100), 255)
		Next
	End If
	'----------------------------------------------------------------------------------

	' Update virtual mouse (clamped mouse value behind game screen)
	Local mouse:RVector2 = GetMousePosition()
	Local virtualMouse:RVector2
	virtualMouse.x = (mouse.x - (GetScreenWidth() - (gameScreenWidth * scale)) * 0.5) / scale
	virtualMouse.y = (mouse.y - (GetScreenHeight() - (gameScreenHeight * scale)) * 0.5) / scale
	virtualMouse = ClampValue(virtualMouse, New RVector2(0, 0), New RVector2(gameScreenWidth, gameScreenHeight)) 
	
	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()
		ClearBackground(BLACK)

		' Draw everything in the render texture, note this will not be rendered on screen, yet
		BeginTextureMode(target)

			ClearBackground(RAYWHITE)         ' Clear render texture background color

			For Local i:Int = 0 Until 10
				DrawRectangle(0, (gameScreenHeight / 10) * i, gameScreenWidth, gameScreenHeight / 10, colors[i])
			Next

			DrawText("If executed inside a window,~nyou can resize the window,~nand see the screen scaling!", 10, 25, 20, WHITE)

			DrawText(defFormatter.Clear().Arg(Int(mouse.x)).Arg(Int(mouse.y)).Format(), 350, 25, 20, GREEN)
			DrawText(virFormatter.Clear().Arg(Int(virtualMouse.x)).Arg(Int(virtualMouse.y)).Format(), 350, 55, 20, YELLOW)

		EndTextureMode()

		' Draw RenderTexture2D to window, properly scaled
		DrawTexturePro(target.texture, ..
			New RRectangle(0.0, 0.0, Float(target.texture.width), Float(-target.texture.height)), ..
			New RRectangle((GetScreenWidth() - Float(gameScreenWidth*scale))*0.5, (GetScreenHeight() - Float(gameScreenHeight*scale))*0.5, Float(gameScreenWidth*scale), Float(gameScreenHeight*scale)), ..
			New RVector2(0, 0), 0.0, WHITE)

	EndDrawing()
	'--------------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadRenderTexture(target)    ' Unload render texture

CloseWindow()                  ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

' Clamp Vector2 value with min and max and return a new vector2
' NOTE: Required for virtual mouse, to clamp inside virtual game size
Function ClampValue:RVector2(value:RVector2, minimum:RVector2, maximum:RVector2)
	Local result:RVector2 = value

	If result.x > maximum.x Then
		result.x = maximum.x
	End If
	
	If result.x < minimum.x Then
		result.x = minimum.x
	End If
	
	If result.y > maximum.y Then
		result.y = maximum.y
	End If
	
	If result.y < minimum.y Then
		result.y = minimum.y
	End If

	Return result
End Function
