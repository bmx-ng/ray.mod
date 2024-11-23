SuperStrict

Framework Ray.Lib

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - N-patch drawing")

' NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
Local nPatchTexture:RTexture2D = LoadTexture("../../lib.mod/raylib/examples/textures/resources/ninepatch_button.png")

Local mousePosition:RVector2
Local origin:RVector2 = New RVector2(0.0, 0.0)

' Position and size of the n-patches
Local dstRec1:RRectangle = New RRectangle(480.0, 160.0, 32.0, 32.0)
Local dstRec2:RRectangle = New RRectangle(160.0, 160.0, 32.0, 32.0)
Local dstRecH:RRectangle = New RRectangle(160.0, 93.0, 32.0, 32.0)
Local dstRecV:RRectangle = New RRectangle(92.0, 160.0, 32.0, 32.0)

' A 9-patch (NPT_9PATCH) changes its sizes in both axis
Local ninePatchInfo1:RNPatchInfo = New RNPatchInfo(New RRectangle(0.0, 0.0, 64.0, 64.0), 12, 40, 12, 12, NPATCH_NINE_PATCH)
Local ninePatchInfo2:RNPatchInfo = New RNPatchInfo(New RRectangle(0.0, 128.0, 64.0, 64.0), 16, 16, 16, 16, NPATCH_NINE_PATCH)

' A horizontal 3-patch (NPT_3PATCH_HORIZONTAL) changes its sizes along the x axis only
Local h3PatchInfo:RNPatchInfo = New RNPatchInfo(New RRectangle(0.0, 64.0, 64.0, 64.0), 8, 8, 8, 8, NPATCH_THREE_PATCH_HORIZONTAL)

' A vertical 3-patch (NPT_3PATCH_VERTICAL) changes its sizes along the y axis only
Local v3PatchInfo:RNPatchInfo = New RNPatchInfo(New RRectangle(0.0, 192.0, 64.0, 64.0), 6, 6, 6, 6, NPATCH_THREE_PATCH_VERTICAL)

SetTargetFPS(60)
'---------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	mousePosition = GetMousePosition()

	' Resize the n-patches based on mouse position
	dstRec1.width = mousePosition.x - dstRec1.x
	dstRec1.height = mousePosition.y - dstRec1.y
	dstRec2.width = mousePosition.x - dstRec2.x
	dstRec2.height = mousePosition.y - dstRec2.y
	dstRecH.width = mousePosition.x - dstRecH.x
	dstRecV.height = mousePosition.y - dstRecV.y

	' Set a minimum width and/or height
	If dstRec1.width < 1.0 Then
		dstRec1.width = 1.0
	End If
	If dstRec1.width > 300.0 Then
		dstRec1.width = 300.0
	End If
	If dstRec1.height < 1.0 Then
		dstRec1.height = 1.0
	End If
	If dstRec2.width < 1.0 Then
		dstRec2.width = 1.0
	End If
	If dstRec2.width > 300.0 Then
		dstRec2.width = 300.0
	End If
	If dstRec2.height < 1.0 Then
		dstRec2.height = 1.0
	End If
	If dstRecH.width < 1.0 Then
		dstRecH.width = 1.0
	End If
	If dstRecV.height < 1.0 Then
		dstRecV.height = 1.0
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		' Draw the n-patches
		DrawTextureNPatch(nPatchTexture, ninePatchInfo2, dstRec2, origin, 0.0, WHITE)
		DrawTextureNPatch(nPatchTexture, ninePatchInfo1, dstRec1, origin, 0.0, WHITE)
		DrawTextureNPatch(nPatchTexture, h3PatchInfo, dstRecH, origin, 0.0, WHITE)
		DrawTextureNPatch(nPatchTexture, v3PatchInfo, dstRecV, origin, 0.0, WHITE)

		' Draw the source texture
		DrawRectangleLines(5, 88, 74, 266, BLUE)
		DrawTexture(nPatchTexture, 10, 93, WHITE)
		DrawText("TEXTURE", 15, 360, 10, DARKGRAY)

		DrawText("Move the mouse to stretch or shrink the n-patches", 10, 20, 20, DARKGRAY)

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadTexture(nPatchTexture)       ' Texture unloading

CloseWindow()                ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
