SuperStrict

Framework Ray.GUI
Import Text.Format
Import brl.standardio

Local formatter:TFormatter = TFormatter.Create("[%f, %f]")

' Initialization
'---------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raygui - GuiScrollPanel()")

Local panelRec:RRectangle = New RRectangle(20, 40, 200, 150)
Local panelContentRec:RRectangle = New RRectangle(0, 0, 340, 340)
Local panelScroll:RVector2 = New RVector2(99, -20)

Local showContentArea:Int = True

SetTargetFPS(60)
'---------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	' TODO: Implement required update logic
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()
		
		ClearBackground(RAYWHITE)
		
		DrawText(formatter.Clear().Arg(panelScroll.x).Arg(panelScroll.y).Format(), 4, 4, 20, RED)
		
		Local view:RRectangle = GuiScrollPanel(panelRec, panelContentRec, panelScroll)
		
		BeginScissorMode(view.x, view.y, view.width, view.height)
			GuiGrid(New RRectangle(panelRec.x + panelScroll.x, panelRec.y + panelScroll.y, panelContentRec.width, panelContentRec.height), 16, 3)
		EndScissorMode()
		
		If showContentArea Then
			DrawRectangle(panelRec.x + panelScroll.x, panelRec.y + panelScroll.y, panelContentRec.width, panelContentRec.height, Fade(RED, 0.1))
		End If
		
		DrawStyleEditControls()
		
		showContentArea = GuiCheckBox(New RRectangle(565, 80, 20, 20), "SHOW CONTENT AREA", showContentArea)
			
		panelContentRec.width = GuiSliderBar(New RRectangle(590, 385, 145, 15), "WIDTH", "", Int(panelContentRec.width), 1, 600)
		panelContentRec.height = GuiSliderBar(New RRectangle(590, 410, 145, 15), "HEIGHT", "", Int(panelContentRec.height), 1, 400)
		
	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

Function DrawStyleEditControls()
	' ScrollPanel style controls
	'----------------------------------------------------------
	GuiGroupBox(New RRectangle(550, 170, 220, 205), "SCROLLBAR STYLE")

	Local style:Int = GuiGetStyle(SCROLLBAR, BORDER_WIDTH)
	GuiLabel(New RRectangle(555, 195, 110, 10), "BORDER_WIDTH")
	GuiSpinner(New RRectangle(670, 190, 90, 20), Null, style, 0, 6, False)
	GuiSetStyle(SCROLLBAR, BORDER_WIDTH, style)

	style = GuiGetStyle(SCROLLBAR, ARROWS_SIZE)
	GuiLabel(New RRectangle(555, 220, 110, 10), "ARROWS_SIZE")
	GuiSpinner(New RRectangle(670, 215, 90, 20), Null, style, 4, 14, False)
	GuiSetStyle(SCROLLBAR, ARROWS_SIZE, style)

	style = GuiGetStyle(SCROLLBAR, SLIDER_PADDING)
	GuiLabel(New RRectangle(555, 245, 110, 10), "SLIDER_PADDING")
	GuiSpinner(New RRectangle(670, 240, 90, 20), Null, style, 0, 14, False)
	GuiSetStyle(SCROLLBAR, SLIDER_PADDING, style)

	style = GuiCheckBox(New RRectangle(565, 280, 20, 20), "ARROWS_VISIBLE", GuiGetStyle(SCROLLBAR, ARROWS_VISIBLE))
	GuiSetStyle(SCROLLBAR, ARROWS_VISIBLE, style)

	style = GuiGetStyle(SCROLLBAR, SLIDER_PADDING)
	GuiLabel(New RRectangle(555, 325, 110, 10), "SLIDER_PADDING")
	GuiSpinner(New RRectangle(670, 320, 90, 20), Null, style, 0, 14, False)
	GuiSetStyle(SCROLLBAR, SLIDER_PADDING, style)

	style = GuiGetStyle(SCROLLBAR, SLIDER_WIDTH)
	GuiLabel(New RRectangle(555, 350, 110, 10), "SLIDER_WIDTH")
	GuiSpinner(New RRectangle(670, 345, 90, 20), Null, style, 2, 100, False)
	GuiSetStyle(SCROLLBAR, SLIDER_WIDTH, style)

	Local txt:String
	If GuiGetStyle(LISTVIEW, SCROLLBAR_SIDE) = SCROLLBAR_LEFT_SIDE Then
		txt = "SCROLLBAR: LEFT"
	Else
		txt = "SCROLLBAR: RIGHT"
	End If
	style = GuiToggle(New RRectangle(560, 110, 200, 35), txt, GuiGetStyle(LISTVIEW, SCROLLBAR_SIDE))
	GuiSetStyle(LISTVIEW, SCROLLBAR_SIDE, style)
	'----------------------------------------------------------

	' ScrollBar style controls
	'----------------------------------------------------------
	GuiGroupBox(New RRectangle(550, 20, 220, 135), "SCROLLPANEL STYLE")

	style = GuiGetStyle(LISTVIEW, SCROLLBAR_WIDTH)
	GuiLabel(New RRectangle(555, 35, 110, 10), "SCROLLBAR_WIDTH")
	GuiSpinner(New RRectangle(670, 30, 90, 20), Null, style, 6, 30, False)
	GuiSetStyle(LISTVIEW, SCROLLBAR_WIDTH, style)

	style = GuiGetStyle(GUI_DEFAULT, BORDER_WIDTH)
	GuiLabel(New RRectangle(555, 60, 110, 10), "BORDER_WIDTH")
	GuiSpinner(New RRectangle(670, 55, 90, 20), Null, style, 0, 20, False)
	GuiSetStyle(GUI_DEFAULT, BORDER_WIDTH, style)
	'----------------------------------------------------------
End Function
