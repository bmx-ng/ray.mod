SuperStrict

Framework Ray.GUI
Import BRL.FileSystem
Import Text.Format

Local formatter:TFormatter = TFormatter.Create("SCALE: %.2f%%")

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raygui - image exporter")

' GUI controls initialization
'----------------------------------------------------------------------------------
Local windowBoxRec:RRectangle = New RRectangle(screenWidth/2 - 110, screenHeight/2 - 100, 220, 190)
Local windowBoxActive:Int = False

Local fileFormatActive:Int = 0
Local fileFormatTextList:String[] = ["IMAGE (.png)", "DATA (.raw)", "CODE (.h)"]

Local pixelFormatActive:Int = 0
Local pixelFormatTextList:String[] = ["GRAYSCALE", "GRAY ALPHA", "R5G6B5", "R8G8B8", "R5G5B5A1", "R4G4B4A4", "R8G8B8A8"]

Local textBoxEditMode:Int = False
Local fileName:String = "untitled"
'-------------------------------------------------------------------------------------

Local image:RImage
Local texture:RTexture2D

Local imageLoaded:Int = False
Local imageScale:Float = 1.0
Local imageRec:RRectangle

Local btnExport:Int = False

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	If IsFileDropped() Then
		Local droppedFiles:String[] = GetDroppedFiles()

		If droppedFiles.length = 1 Then
			Local imTemp:RImage = LoadImage(droppedFiles[0])
			
			If imTemp.data <> Null Then
				UnloadImage(image)
				image = imTemp
				
				UnloadTexture(texture)
				texture = LoadTextureFromImage(image)
				
				imageLoaded = True
				pixelFormatActive = image.format - 1
				
				If texture.height > texture.width Then
					imageScale = screenHeight - 100/Float(texture.height)
				Else
					imageScale = screenWidth - 100/Float(texture.width)
				End If
			End If
		End If
	End If

	If btnExport Then
		If imageLoaded Then
			ImageFormat(image, pixelFormatActive + 1)
			
			If fileFormatActive = 0 Then        ' PNG
				Local ext:String = ExtractExt(fileName)
				If Not ext Or ext <> ".png" Then
					fileName = fileName + ".png"     ' No extension provided
				End If
				ExportImage(image, fileName)
			Else If fileFormatActive = 1 Then   ' RAW
				Local ext:String = ExtractExt(fileName)
				If Not ext Or ext <> ".raw" Then
					fileName = fileName + ".raw"     ' No extension provided
				End If
				
				Local dataSize:Int = GetPixelDataSize(image.width, image.height, image.format)
				
				
				Local rawFile:TStream = WriteStream(fileName)  
				rawFile.WriteBytes(image.data, dataSize)
				rawFile.Close()
			Else If fileFormatActive = 2 Then   ' CODE
				ExportImageAsCode(image, fileName)
			End If
		End If
		
		windowBoxActive = False
	End If
	
	If imageLoaded Then
		imageScale :+ GetMouseWheelMove()*0.05   ' Image scale control
		If imageScale <= 0.1 Then
			imageScale = 0.1
		Else If imageScale >= 5 Then
			imageScale = 5
		End If
		
		imageRec = New RRectangle(screenWidth/2 - image.width*imageScale/2.0, ..
								screenHeight/2 - image.height*imageScale/2.0, ..
								Float(image.width*imageScale), Float(image.height*imageScale))
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		If texture.id > 0 Then
			DrawTextureEx(texture, New RVector2(screenWidth/2 - texture.width*imageScale/2.0, screenHeight/2 - texture.height*imageScale/2.0), 0.0, imageScale, WHITE)
			
			Local col:RColor = DARKGRAY
			If CheckCollisionPointRec(GetMousePosition(), imageRec) Then
				col = RED
			End If
			DrawRectangleLinesEx(imageRec, 1, col) 
			DrawText(formatter.Clear().Arg(imageScale*100.0).Format(), 20, screenHeight - 40, 20, GetColor(GuiGetStyle(GUI_DEFAULT, LINE_COLOR)))
		Else
			DrawText("DRAG & DROP YOUR IMAGE!", 350, 200, 10, DARKGRAY)
			GuiDisable()
		End If
		
		If GuiButton(New RRectangle(screenWidth - 170, screenHeight - 50, 150, 30), "Image Export") Then
			windowBoxActive = True
		End If
		GuiEnable()
		
		' Draw window box: windowBoxName
		'-----------------------------------------------------------------------------
		If windowBoxActive Then
			DrawRectangle(0, 0, screenWidth, screenHeight, Fade(GetColor(GuiGetStyle(GUI_DEFAULT, BACKGROUND_COLOR)), 0.7))
			windowBoxActive = Not GuiWindowBox(New RRectangle(windowBoxRec.x, windowBoxRec.y, 220, 190), "Image Export Options")
		
			GuiLabel(New RRectangle(windowBoxRec.x + 10, windowBoxRec.y + 35, 60, 25), "File format:")
			fileFormatActive = GuiComboBox(New RRectangle(windowBoxRec.x + 80, windowBoxRec.y + 35, 130, 25), ";".Join(fileFormatTextList), fileFormatActive)
			GuiLabel(New RRectangle(windowBoxRec.x + 10, windowBoxRec.y + 70, 63, 25), "Pixel format:")
			pixelFormatActive = GuiComboBox(New RRectangle(windowBoxRec.x + 80, windowBoxRec.y + 70, 130, 25), ";".Join(pixelFormatTextList), pixelFormatActive) 
			GuiLabel(New RRectangle(windowBoxRec.x + 10, windowBoxRec.y + 105, 50, 25), "File name:")
			If GuiTextBox(New RRectangle(windowBoxRec.x + 80, windowBoxRec.y + 105, 130, 25), fileName, 64, textBoxEditMode) Then
				textBoxEditMode = Not textBoxEditMode
			End If

			btnExport = GuiButton(New RRectangle(windowBoxRec.x + 10, windowBoxRec.y + 145, 200, 30), "Export Image")
		Else
			btnExport = False
		End If
		
		If btnExport Then
			DrawText("Image exported!", 20, screenHeight - 20, 20, RED)
		End If
		'-----------------------------------------------------------------------------

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
UnloadImage(image)
UnloadTexture(texture)

CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
