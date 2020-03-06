SuperStrict

Framework Ray.GUI
Import Text.Format
Import BRL.FileSystem


Local formatter:TFormatter = TFormatter.Create("%2.2f")

' Initialization
'---------------------------------------------------------------------------------------
Local screenWidth:Int = 690
Local screenHeight:Int = 560

InitWindow(screenWidth, screenHeight, "raygui - controls test suite")
SetExitKey(0)

' GUI controls initialization
'----------------------------------------------------------------------------------
Local dropdownBox000Active:Int = 0
Local dropDown000EditMode:Int = False

Local dropdownBox001Active:Int = 0
Local dropDown001EditMode:Int = False    

Local spinner001Value:Int = 0
Local spinnerEditMode:Int = False

Local valueBox002Value:Int = 0
Local valueBoxEditMode:Int = False

Local textBoxText:String = "Text box"
Local textBoxEditMode:Int = False

Local listViewScrollIndex:Int = 0
Local listViewActive:Int = -1

Local listViewExScrollIndex:Int = 0
Local listViewExActive:Int = 2
Local listViewExFocus:Int = -1
Local listViewExList:String[] = ["This", "is", "a", "list view", "with", "disable", "elements", "amazing!"]

Local multiTextBoxText:String = "Multi text box"    
Local multiTextBoxEditMode:Int = False
Local colorPickerValue:RColor = RED

Local SliderValue:Int = 50
Local sliderBarValue:Int = 60
Local progressValue:Float = 0.4

Local forceSquaredChecked:Int = False

Local alphaValue:Float = 0.5

Local comboBoxActive:Int = 1

Local toggleGroupActive:Int = 0

Local viewScroll:RVector2
'----------------------------------------------------------------------------------

' Custom GUI font loading
'Font font = LoadFontEx("fonts/rainyhearts16.ttf", 12, 0, 0)
'GuiSetFont(font)

Local exitWindow:Int = False
Local showMessageBox:Int = False

Local textInput:String
Local showTextInputBox:Int = False

Local textInputFileName:String

SetTargetFPS(60)
'--------------------------------------------------------------------------------------

' Main game loop
While Not exitWindow    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------
	exitWindow = WindowShouldClose()
	
	If IsKeyPressed(KEY_ESCAPE) Then
		showMessageBox = Not showMessageBox
	End If
	
	If IsKeyDown(KEY_LEFT_CONTROL) And IsKeyPressed(KEY_S) Then
		showTextInputBox = True
	End If
	
	If IsFileDropped() Then
		Local droppedFiles:String[] = GetDroppedFiles()
		
		If droppedFiles.length And ExtractExt(droppedFiles[0]) = "rgs" Then
			GuiLoadStyle(droppedFiles[0])
		End If
	End If
	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(GetColor(GuiGetStyle(GUI_DEFAULT, BACKGROUND_COLOR)))

		' raygui: controls drawing
		'----------------------------------------------------------------------------------
		If dropDown000EditMode Or dropDown001EditMode Then
			GuiLock()
		End If
		'GuiDisable()
		
		' First GUI column
		'GuiSetStyle(CHECKBOX, TEXT_ALIGNMENT, GUI_TEXT_ALIGN_LEFT)
		forceSquaredChecked = GuiCheckBox(New RRectangle(25, 108, 15, 15), "FORCE CHECK!", forceSquaredChecked)
		
		GuiSetStyle(TEXTBOX, TEXT_ALIGNMENT, GUI_TEXT_ALIGN_CENTER)
		'GuiSetStyle(VALUEBOX, TEXT_ALIGNMENT, GUI_TEXT_ALIGN_LEFT)
		If GuiSpinner(New RRectangle(25, 135, 125, 30), Null, spinner001Value, 0, 100, spinnerEditMode) Then
			spinnerEditMode = Not spinnerEditMode
		End If
		If GuiValueBox(New RRectangle(25, 175, 125, 30), Null, valueBox002Value, 0, 100, valueBoxEditMode) Then
			valueBoxEditMode = Not valueBoxEditMode
		End If
		GuiSetStyle(TEXTBOX, TEXT_ALIGNMENT, GUI_TEXT_ALIGN_LEFT)
		If GuiTextBox(New RRectangle(25, 215, 125, 30), textBoxText, 64, textBoxEditMode) Then
			textBoxEditMode = Not textBoxEditMode
		End If
		
		GuiSetStyle(BUTTON, TEXT_ALIGNMENT, GUI_TEXT_ALIGN_CENTER)
		
		If GuiButton(New RRectangle(25, 255, 125, 30), GuiIconText(RICON_FILE_SAVE, "Save File")) Then
			showTextInputBox = True
		End If
		
		GuiGroupBox(New RRectangle(25, 310, 125, 150), "STATES")
		GuiLock()
		GuiSetState(GUI_STATE_NORMAL)
		If GuiButton(New RRectangle(30, 320, 115, 30), "NORMAL") Then
			' ...
		End If
		
		GuiSetState(GUI_STATE_FOCUSED)
		If GuiButton(New RRectangle(30, 355, 115, 30), "FOCUSED") Then
			' ...
		End If
		
		GuiSetState(GUI_STATE_PRESSED)
		If GuiButton(New RRectangle(30, 390, 115, 30), "#15#PRESSED") Then
			' ...
		End If
		
		GuiSetState(GUI_STATE_DISABLED)
		If GuiButton(New RRectangle(30, 425, 115, 30), "DISABLED") Then
			' ...
		End If
		GuiSetState(GUI_STATE_NORMAL)
		GuiUnlock()
		
		comboBoxActive = GuiComboBox(New RRectangle(25, 470, 125, 30), "ONE;TWO;THREE;FOUR;", comboBoxActive)

		' NOTE: GuiDropdownBox must draw after any other control that can be covered on unfolding
		GuiSetStyle(DROPDOWNBOX, TEXT_ALIGNMENT, GUI_TEXT_ALIGN_LEFT)
		If GuiDropdownBox(New RRectangle(25, 65, 125, 30), "#01#ONE;#02#TWO;#03#THREE;#04#FOUR;", dropdownBox001Active, dropDown001EditMode) Then
			dropDown001EditMode = Not dropDown001EditMode
		End If

		GuiSetStyle(DROPDOWNBOX, TEXT_ALIGNMENT, GUI_TEXT_ALIGN_CENTER)
		If GuiDropdownBox(New RRectangle(25, 25, 125, 30), "ONE;TWO;THREE;", dropdownBox000Active, dropDown000EditMode) Then
			dropDown000EditMode = Not dropDown000EditMode
		End If

		' Second GUI column
		listViewActive = GuiListView(New RRectangle(165, 25, 140, 140), "Charmander;Bulbasaur;#18#Squirtel;Pikachu;Eevee;Pidgey;", listViewScrollIndex, listViewActive)
		listViewExActive = GuiListViewEx(New RRectangle(165, 180, 140, 200), listViewExList, listViewExFocus, listViewExScrollIndex, listViewExActive)

		toggleGroupActive = GuiToggleGroup(New RRectangle(165, 400, 140, 25), "#1#ONE~n#3#TWO~n#8#THREE~n#23#", toggleGroupActive)

		' Third GUI column
		If GuiTextBoxMulti(New RRectangle(320, 25, 225, 140), multiTextBoxText, 141, multiTextBoxEditMode) Then
			multiTextBoxEditMode = Not multiTextBoxEditMode
		End If
		colorPickerValue = GuiColorPicker(New RRectangle(320, 185, 196, 192), colorPickerValue)

		SliderValue = GuiSlider(New RRectangle(355, 400, 165, 20), "TEST", formatter.Clear().Arg(Float(SliderValue)).Format(), SliderValue, -50, 100)
		sliderBarValue = GuiSliderBar(New RRectangle(320, 430, 200, 20), Null, Int(sliderBarValue), sliderBarValue, 0, 100)
		progressValue = GuiProgressBar(New RRectangle(320, 460, 200, 20), Null, Null, progressValue, 0, 1)

		' NOTE: View rectangle could be used to perform some scissor test
		Local view:RRectangle = GuiScrollPanel(New RRectangle(560, 25, 100, 160), New RRectangle(560, 25, 200, 400), viewScroll)
		
		GuiStatusBar(New RRectangle(0, GetScreenHeight() - 20, GetScreenWidth(), 20), "This is a status bar")
		
		alphaValue = GuiColorBarAlpha(New RRectangle(320, 490, 200, 30), alphaValue)

		If showMessageBox Then
			DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
			Local result:Int = GuiMessageBox(New RRectangle(GetScreenWidth()/2 - 125, GetScreenHeight()/2 - 50, 250, 100), GuiIconText(RICON_EXIT, "Close Window"), "Do you really want to exit?", "Yes;No") 
		
			If (result = 0) Or (result = 2) Then
				showMessageBox = False
			Else If result = 1 Then
				exitWindow = True
			End If
		End If
		
		If showTextInputBox Then
			DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
			Local result:Int = GuiTextInputBox(New RRectangle(GetScreenWidth()/2 - 120, GetScreenHeight()/2 - 60, 240, 140), GuiIconText(RICON_FILE_SAVE, "Save file as..."), "Introduce a save file name", "Ok;Cancel", textInput)
			
			If result = 1 Then
				' TODO: Validate textInput value and save
				
				textInputFileName = textInput
			End If
			
			If (result = 0) Or (result = 1) Or (result = 2) Then
				showTextInputBox = False
				textInput = Null
			End If
		End If
'End Rem
		GuiUnlock()
		'----------------------------------------------------------------------------------

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
CloseWindow()        ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
