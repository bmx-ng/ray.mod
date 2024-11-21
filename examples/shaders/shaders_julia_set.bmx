SuperStrict

Framework Ray.Lib

?Not opengles
Const GLSL_VERSION:Int = 330
?opengles
Const GLSL_VERSION:Int = 100
?

' A few good julia sets
Local POINTS_OF_INTEREST:Float[] = [ ..
    -0.348827, 0.607167, ..
    -0.786268, 0.169728, ..
    -0.8, 0.156, ..
    0.285, 0.0, ..
    -0.835, -0.2321, ..
    -0.70176, -0.3842]

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450
Const zoomSpeed:Float = 1.01
Const offsetSpeedMul:Float = 2.0

Const startingZoom:Float = 0.75

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - julia sets")

' Load julia set shader
' NOTE: Defining 0 (NULL) for vertex shader forces usage of internal default vertex shader
Local shader:RShader = LoadShader(0, "../../lib.mod/raylib/examples/shaders/resources/shaders/glsl" + GLSL_VERSION + "/julia_set.fs")

' Create a RenderTexture2D to be used for render to texture
Local target:RRenderTexture2D = LoadRenderTexture(GetScreenWidth(), GetScreenHeight())

' c constant to use in z^2 + c
Local c:Float[] = [POINTS_OF_INTEREST[0], POINTS_OF_INTEREST[1]]

' Offset and zoom to draw the julia set at. (centered on screen and default size)
Local offset:Float[] = [0, 0]
Local zoom:Float = startingZoom

Local offsetSpeed:RVector2

' Get variable (uniform) locations on the shader to connect with the program
' NOTE: If uniform variable could not be found in the shader, function returns -1
Local cLoc:Int = GetShaderLocation(shader, "c")
Local zoomLoc:Int = GetShaderLocation(shader, "zoom")
Local offsetLoc:Int = GetShaderLocation(shader, "offset")

' Upload the shader uniform values!
SetShaderValue(shader, cLoc, c, SHADER_UNIFORM_VEC2)
SetShaderValue(shader, zoomLoc, Varptr zoom, SHADER_UNIFORM_FLOAT)
SetShaderValue(shader, offsetLoc, offset, SHADER_UNIFORM_VEC2)

Local incrementSpeed:Int = 0         ' Multiplier of speed to change c value
Local showControls:Int = True       ' Show controls

SetTargetFPS(60)               ' Set our game to run at 60 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not windowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' Press [1 - 6] to reset c to a point of interest
	If IsKeyPressed(KEY_ONE) Or ..
			IsKeyPressed(KEY_TWO) Or ..
			IsKeyPressed(KEY_THREE) Or ..
			IsKeyPressed(KEY_FOUR) Or ..
			IsKeyPressed(KEY_FIVE) Or ..
			IsKeyPressed(KEY_SIX) Then

		If IsKeyPressed(KEY_ONE) Then
			c[0] = POINTS_OF_INTEREST[0]
			c[1] = POINTS_OF_INTEREST[1]
		Else If IsKeyPressed(KEY_TWO) Then
			c[0] = POINTS_OF_INTEREST[2]
			c[1] = POINTS_OF_INTEREST[3]
		Else If IsKeyPressed(KEY_THREE) Then
			c[0] = POINTS_OF_INTEREST[4]
			c[1] = POINTS_OF_INTEREST[5]
		Else If IsKeyPressed(KEY_FOUR) Then
			c[0] = POINTS_OF_INTEREST[6]
			c[1] = POINTS_OF_INTEREST[7]
		Else If IsKeyPressed(KEY_FIVE) Then
			c[0] = POINTS_OF_INTEREST[8]
			c[1] = POINTS_OF_INTEREST[9]
		Else If IsKeyPressed(KEY_SIX) Then
			c[0] = POINTS_OF_INTEREST[10]
			c[1] = POINTS_OF_INTEREST[11]
		End If

		SetShaderValue(shader, cLoc, c, SHADER_UNIFORM_VEC2)
	End If

	' If "R" is pressed, reset zoom and offset.
	if IsKeyPressed(KEY_R) Then
		zoom = startingZoom
		offset[0] = 0.0
		offset[1] = 0.0
		SetShaderValue(shader, zoomLoc, VarPtr zoom, SHADER_UNIFORM_FLOAT)
		SetShaderValue(shader, offsetLoc, offset, SHADER_UNIFORM_VEC2)
	End If

	If IsKeyPressed(KEY_SPACE) Then
		incrementSpeed = 0
	End If
	
	If IsKeyPressed(KEY_F1) Then
		showControls = Not showControls  ' Toggle whether or not to show controls
	End If

	If IsKeyPressed(KEY_RIGHT) Then
		incrementSpeed :+ 1
	Else If IsKeyPressed(KEY_LEFT) Then
		incrementSpeed :- 1
	End If

	' If either left or right button is pressed, zoom in/out.
	If IsMouseButtonDown(MOUSE_LEFT_BUTTON) Or IsMouseButtonDown(MOUSE_RIGHT_BUTTON) Then	
		' Change zoom. If Mouse left -> zoom in. Mouse right -> zoom out.
		If IsMouseButtonDown(MOUSE_BUTTON_LEFT) Then
			zoom :* zoomSpeed
		Else
			zoom :* 1.0/zoomSpeed
		End IF

		Local  mousePos:RVector2 = GetMousePosition()
		Local offsetVelocity:RVector2

		' Find the velocity at which to change the camera. Take the distance of the mouse
		' from the center of the screen as the direction, and adjust magnitude based on
		' the current zoom.
		offsetVelocity.x = (mousePos.x/Float(screenWidth) - 0.5)*offsetSpeedMul/zoom
		offsetVelocity.y = (mousePos.y/Float(screenHeight) - 0.5)*offsetSpeedMul/zoom

		' Apply move velocity to camera
		offset[0] :+ GetFrameTime()*offsetVelocity.x
		offset[1] :+ GetFrameTime()*offsetVelocity.y

		' Update the shader uniform values!
		SetShaderValue(shader, zoomLoc, VarPtr zoom, SHADER_UNIFORM_FLOAT)
		SetShaderValue(shader, offsetLoc, offset, SHADER_UNIFORM_VEC2)
	End If

	' Increment c value with time
	Local  dc:Float = GetFrameTime() * Float(incrementSpeed) * 0.0005
	c[0] :+ dc
	c[1] :+ dc
	SetShaderValue(shader, cLoc, c, SHADER_UNIFORM_VEC2)

	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	' Using a render texture to draw Julia set
	BeginTextureMode(target)       ' Enable drawing to texture
		ClearBackground(BLACK)     ' Clear the render texture

		' Draw a rectangle in shader mode to be used as shader canvas
		' NOTE: Rectangle uses font white character texture coordinates,
		' so shader can not be applied here directly because input vertexTexCoord
		' do not represent full screen coordinates (space where want to apply shader)
		DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), BLACK)
	EndTextureMode()

	BeginDrawing()
		ClearBackground(BLACK)         ' Clear the screen of the previous frame.

		' Draw the saved texture and rendered julia set with shader
		' NOTE: We do not invert texture on Y, already considered inside shader
		BeginShaderMode(shader)
			DrawTextureEx(target.texture, New RVector2, 0, 1, WHITE)
		EndShaderMode()

		If showControls Then
			DrawText("Press Mouse buttons right/left to zoom in/out and move", 10, 15, 10, RAYWHITE)
			DrawText("Press KEY_F1 to toggle these controls", 10, 30, 10, RAYWHITE)
			DrawText("Press KEYS [1 - 6] to change point of interest", 10, 45, 10, RAYWHITE)
			DrawText("Press KEY_LEFT | KEY_RIGHT to change speed", 10, 60, 10, RAYWHITE)
			DrawText("Press KEY_SPACE to pause movement animation", 10, 75, 10, RAYWHITE)
			DrawText("Press KEY_R to recenter the camera", 10, 90, 10, RAYWHITE)
		End If

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadShader(shader)           ' Unload shader
UnloadRenderTexture(target)    ' Unload render texture

CloseWindow()                  ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
