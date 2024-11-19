' Copyright (c) 2024 Bruce A Henderson
'
' This software is provided 'as-is', without any express or implied
' warranty. In no event will the authors be held liable for any damages
' arising from the use of this software.
'
' Permission is granted to anyone to use this software for any purpose,
' including commercial applications, and to alter it and redistribute it
' freely, subject to the following restrictions:
'
'    1. The origin of this software must not be misrepresented; you must not
'    claim that you wrote the original software. If you use this software
'    in a product, an acknowledgment in the product documentation would be
'    appreciated but is not required.
'
'    2. Altered source versions must be plainly marked as such, and must not be
'    misrepresented as being the original software.
'
'    3. This notice may not be removed or altered from any source
'    distribution.
'
SuperStrict

Rem
bbdoc: RayGui - Simple and Easy-to-use Immediate-mode Gui
End Rem
Module Ray.GUI

ModuleInfo "Version: 1.02"
ModuleInfo "License: zlib"
ModuleInfo "Copyright: Wrapper - 2024 Bruce A Henderson"
ModuleInfo "Copyright: raylib - 2013-2020 Ramon Santamaria"

ModuleInfo "History: 1.02"
ModuleInfo "History: Update to latest raygui.1e03efc."
ModuleInfo "History: 1.01"
ModuleInfo "History: Update to latest raygui.b2974f3."
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release."


ModuleInfo "CC_OPTS: -std=c99"
ModuleInfo "CC_OPTS: -DSTATIC"
ModuleInfo "CC_OPTS: -DSUPPORT_CAMERA_SYSTEM"

?win32
ModuleInfo "CC_OPTS: -DPLATFORM_DESKTOP"
ModuleInfo "CC_OPTS: -D_GLFW_WIN32"
?osx
ModuleInfo "CC_OPTS: -DPLATFORM_DESKTOP"
ModuleInfo "CC_OPTS: -D_GLFW_COCOA"
?linux And Not raspberrypi
ModuleInfo "CC_OPTS: -DPLATFORM_DESKTOP"
ModuleInfo "CC_OPTS: -D_POSIX_C_SOURCE=199309L"
ModuleInfo "CC_OPTS: -D_GLFW_X11"
?raspberrypi
ModuleInfo "CC_OPTS: -DPLATFORM_RPI"
ModuleInfo "CC_OPTS: -D_GLFW_X11"
?

Import "common.bmx"



Rem
bbdoc: Enables gui controls (global state).
End Rem
Function GuiEnable()
	bmx_raygui_GuiEnable()
End Function

Rem
bbdoc: Disables gui controls (global state).
End Rem
Function GuiDisable()
	bmx_raygui_GuiDisable()
End Function

Rem
bbdoc: Locks gui controls (global state).
End Rem
Function GuiLock()
	bmx_raygui_GuiLock()
End Function

Rem
bbdoc: Unlocks gui controls (global state).
End Rem
Function GuiUnlock()
	bmx_raygui_GuiUnlock()
End Function

Rem
bbdoc: Checks if gui is locked (global state)
End Rem
Function GuiIsLocked:Int()
	Return bmx_raygui_GuiIsLocked()
End Function

Rem
bbdoc: Sets gui controls alpha (global state), alpha goes from 0.0f to 1.0f
End Rem
Function GuiSetAlpha(alpha:Float)
	bmx_raygui_GuiSetAlpha(alpha)
End Function

' Rem
' bbdoc: Sets gui controls alpha (global state).
' About: @alpha goes from 0.0. to 1.0.
' End Rem
' Function GuiFade(alpha:Float)
' 	bmx_raygui_GuiFade(alpha)
' End Function


Rem
bbdoc: Sets gui state (global state).
End Rem
Function GuiSetState(state:Int)
	bmx_raygui_GuiSetState(state)
End Function

Rem
bbdoc: Gets gui state (global state).
End Rem
Function GuiGetState:Int()
	Return bmx_raygui_GuiGetState()
End Function

' Font set/get functions
Rem
bbdoc: Sets gui custom font (global state).
End Rem
Function GuiSetFont(font:RFont)
	bmx_raygui_GuiSetFont(font)
End Function

Rem
bbdoc: Gets gui custom font (global state).
End Rem
Function GuiGetFont:RFont()
	Return bmx_raygui_GuiGetFont()
End Function

' Style set/get functions
Rem
bbdoc: Sets one style property.
End Rem
Function GuiSetStyle(control:Int, property:Int, value:Int)
	bmx_raygui_GuiSetStyle(control, property, value)
End Function

Rem
bbdoc: Gets one style property.
End Rem
Function GuiGetStyle:Int(control:Int, property:Int)
	Return bmx_raygui_GuiGetStyle(control, property)
End Function

' Styles loading functions
Function GuiLoadStyle(fileName:String)
	Local length:Size_T = fileName.length * 3 + 1
	Local f:Byte Ptr = StackAlloc(length)
	fileName.ToUTF8StringBuffer(f, length)

	bmx_raygui_GuiLoadStyle(f)
End Function

Function GuiLoadStyleDefault()
	bmx_raygui_GuiLoadStyleDefault()
End Function

' Tooltips management functions
Function GuiEnableTooltip()
	bmx_raygui_GuiEnableTooltip()
End Function

Function GuiDisableTooltip()
	bmx_raygui_GuiDisableTooltip()
End Function

Function GuiSetTooltip(text:String)
	Local length:Size_T = text.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	text.ToUTF8StringBuffer(t, length)
	bmx_raygui_GuiSetTooltip(t)
End Function


' Container/separator controls, useful for controls organization
Rem
bbdoc: Window Box control, shows a window that can be closed.
End Rem
Function GuiWindowBox:Int(bounds:RRectangle, title:String)
	Local t:Byte Ptr
	If title Then
		Local length:Size_T = title.length * 3 + 1
		t = StackAlloc(length)
		title.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiWindowBox(bounds, t)
End Function

Rem
bbdoc: Group Box control with text name.
End Rem
Function GuiGroupBox(bounds:RRectangle, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	bmx_raygui_GuiGroupBox(bounds, t)
End Function

Rem
bbdoc: Line separator control, that could contain text.
End Rem
Function GuiLine(bounds:RRectangle, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	bmx_raygui_GuiLine(bounds, t)
End Function

Rem
bbdoc: Panel control, useful to group controls.
End Rem
Function GuiPanel(bounds:RRectangle)
	bmx_raygui_GuiPanel(bounds)
End Function

Rem
bbdoc: Scroll Panel control.
End Rem
Function GuiScrollPanel:RRectangle(bounds:RRectangle, content:RRectangle, scroll:RVector2 Var)
	Return bmx_raygui_GuiScrollPanel(bounds, content, scroll)
End Function


' Basic controls set
Rem
bbdoc: Label control, that shows text.
End Rem
Function GuiLabel(bounds:RRectangle, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	bmx_raygui_GuiLabel(bounds:RRectangle, t)
End Function

Rem
bbdoc: Button control, which returns #True when clicked.
End Rem
Function GuiButton:Int(bounds:RRectangle, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiButton(bounds:RRectangle, t)
End Function

Rem
bbdoc: Label button control, that shows #True when clicked.
End Rem
Function GuiLabelButton:Int(bounds:RRectangle, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiLabelButton(bounds:RRectangle, t)
End Function

' Rem
' bbdoc: Image button control, which returns #True when clicked.
' End Rem
' Function GuiImageButton:Int(bounds:RRectangle, txt:String, texture:RTexture2D)
' 	Local t:Byte Ptr
' 	If txt Then
' 		Local length:Size_T = txt.length * 3 + 1
' 		t = StackAlloc(length)
' 		txt.ToUTF8StringBuffer(t, length)
' 	End If
' 	Return bmx_raygui_GuiImageButton(bounds, t, texture)
' End Function

' Rem
' bbdoc: Image button extended control, which returns #True when clicked.
' End Rem
' Function GuiImageButtonEx:Int(bounds:RRectangle, txt:String, texture:RTexture2D, texSource:RRectangle)
' 	Local t:Byte Ptr
' 	If txt Then
' 		Local length:Size_T = txt.length * 3 + 1
' 		t = StackAlloc(length)
' 		txt.ToUTF8StringBuffer(t, length)
' 	End If
' 	Return bmx_raygui_GuiImageButtonEx(bounds, t, texture, texSource)
' End Function

Rem
bbdoc: Toggle Button control, which returns #True when active.
End Rem
Function GuiToggle:Int(bounds:RRectangle, txt:String, active:Int Var)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiToggle(bounds, t, active)
End Function

Rem
bbdoc: Toggle Group control, which returns active toggle index.
End Rem
Function GuiToggleGroup:Int(bounds:RRectangle, txt:String, active:Int Var)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiToggleGroup(bounds, t, active)
End Function

Rem
bbdoc: Check Box control, which returns #True when active.
End Rem
Function GuiCheckBox:Int(bounds:RRectangle, txt:String, checked:Int Var)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiCheckBox(bounds, t, checked)
End Function

Rem
bbdoc: Combo Box control, which returns selected item index.
End Rem
Function GuiComboBox:Int(bounds:RRectangle, txt:String, active:Int Var)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiComboBox(bounds, t, active)
End Function

Rem
bbdoc: Dropdown Box control, which returns selected item.
End Rem
Function GuiDropdownBox:Int(bounds:RRectangle, txt:String, active:Int Var, editMode:Int)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiDropdownBox(bounds, t, active, editMode)
End Function

Rem
bbdoc: Spinner control, which returns selected value.
End Rem
Function GuiSpinner:Int(bounds:RRectangle, txt:String, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiSpinner(bounds, t, value, minValue, maxValue, editMode)
End Function

Rem
bbdoc: Value Box control, which updates input text with numbers.
End Rem
Function GuiValueBox:Int(bounds:RRectangle, txt:String, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiValueBox(bounds, t, value, minValue, maxValue, editMode)
End Function

Rem
bbdoc: Text Box control, which updates input text.
about: @textSize is the maximum number of UTF-8 characters.
End Rem
Function GuiTextBox:Int(bounds:RRectangle, txt:String Var, textSize:Int, editMode:Int)
	Local length:Size_T = Min(textSize, txt.length * 3 + 1)
	Local t:Byte Ptr = StackAlloc(textSize)
	MemClear(t, Size_T(textSize))
	txt.ToUTF8StringBuffer(t, length)
	Local res:Int = bmx_raygui_GuiTextBox(bounds, t, textSize, editMode)
	txt = String.FromUTF8String(t)
	Return res
End Function

' Rem
' bbdoc: Text Box control with multiple lines
' End Rem
' Function GuiTextBoxMulti:Int(bounds:RRectangle, txt:String Var, textSize:Int, editMode:Int)
' 	Local length:Size_T = Min(textSize, txt.length * 3 + 1)
' 	Local t:Byte Ptr = StackAlloc(textSize)
' 	MemClear(t, Size_T(textSize))
' 	txt.ToUTF8StringBuffer(t, length)
' 	Local res:Int = bmx_raygui_GuiTextBoxMulti(bounds, t, textSize, editMode)
' 	txt = String.FromUTF8String(t)
' 	Return res
' End Function

Rem
bbdoc: Slider control.
End Rem
Function GuiSlider:Int(bounds:RRectangle, txtLeft:String, txtRight:String, value:Float Var, minValue:Float, maxValue:Float)
	Local length:Size_T = txtLeft.length * 3 + 1
	Local tl:Byte Ptr = StackAlloc(length)
	txtLeft.ToUTF8StringBuffer(tl, length)

	length = txtRight.length * 3 + 1
	Local tr:Byte Ptr = StackAlloc(length)
	txtRight.ToUTF8StringBuffer(tr, length)

	Return bmx_raygui_GuiSlider(bounds, tl, tr, value, minValue, maxValue)
End Function

Rem
bbdoc: Slider Bar control.
End Rem
Function GuiSliderBar:Int(bounds:RRectangle, txtLeft:String, txtRight:String, value:Float Var, minValue:Float, maxValue:Float)
	Local length:Size_T = txtLeft.length * 3 + 1
	Local tl:Byte Ptr = StackAlloc(length)
	txtLeft.ToUTF8StringBuffer(tl, length)

	length = txtRight.length * 3 + 1
	Local tr:Byte Ptr = StackAlloc(length)
	txtRight.ToUTF8StringBuffer(tr, length)

	Return bmx_raygui_GuiSliderBar(bounds, tl, tr, value, minValue, maxValue)
End Function

Rem
bbdoc: Progress Bar control, which shows current progress value.
End Rem
Function GuiProgressBar:Int(bounds:RRectangle, txtLeft:String, txtRight:String, value:Float Var, minValue:Float, maxValue:Float)
	Local tl:Byte Ptr
	Local length:Size_T
	If txtLeft Then
		Local length:Size_T = txtLeft.length * 3 + 1
		tl = StackAlloc(length)
		txtLeft.ToUTF8StringBuffer(tl, length)
	End If

	Local tr:Byte Ptr
	If txtRight Then
		length = txtRight.length * 3 + 1
		tr = StackAlloc(length)
		txtRight.ToUTF8StringBuffer(tr, length)
	End If

	Return bmx_raygui_GuiProgressBar(bounds, tl, tr, value, minValue, maxValue)
End Function

Rem
bbdoc: Status Bar control, shows info text.
End Rem
Function GuiStatusBar(bounds:RRectangle, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	bmx_raygui_GuiStatusBar(bounds, t)
End Function

Rem
bbdoc: Dummy control for placeholders.
End Rem
Function GuiDummyRec(bounds:RRectangle, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	bmx_raygui_GuiDummyRec(bounds, t)
End Function

' Rem
' bbdoc: Scroll Bar control.
' End Rem
' Function GuiScrollBar:Int(bounds:RRectangle, value:Int, minValue:Int, maxValue:Int)
' 	Return bmx_raygui_GuiScrollBar(bounds, value, minValue, maxValue)
' End Function

Rem
bbdoc: Grid control.
End Rem
Function GuiGrid:RVector2(bounds:RRectangle, spacing:Float, subdivs:Int)
	Return bmx_raygui_GuiGrid(bounds:RRectangle, spacing, subdivs)
End Function


' Advance controls set
Rem
bbdoc: List View control, which returns selected list item index.
End Rem
Function GuiListView:Int(bounds:RRectangle, txt:String, scrollIndex:Int Var, active:Int Var)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return bmx_raygui_GuiListView(bounds:RRectangle, t, scrollIndex, active)
End Function

Rem
bbdoc: List View with extended parameters.
End Rem
Function GuiListViewEx:Int(bounds:RRectangle, txt:String[], scrollIndex:Int Var, active:Int Var, focus:Int Var)
	Local list:Byte Ptr Ptr = StackAlloc(Size_T(txt.length * 8))
	For Local i:Int = 0 Until txt.length
		list[i] = txt[i].ToUTF8String()
	Next
	Local res:Int = bmx_raygui_GuiListViewEx(bounds, list, txt.length, scrollIndex, active, focus)
	For Local i:Int = 0 Until txt.length
		MemFree(list[i])
	Next
	Return res
End Function

Rem
bbdoc: Message Box control, which displays a message.
End Rem
Function GuiMessageBox:Int(bounds:RRectangle, title:String, message:String, buttons:String)
	Local length:Size_T = title.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	title.ToUTF8StringBuffer(t, length)

	length = message.length * 3 + 1
	Local m:Byte Ptr = StackAlloc(length)
	message.ToUTF8StringBuffer(m, length)

	length = buttons.length * 3 + 1
	Local b:Byte Ptr = StackAlloc(length)
	buttons.ToUTF8StringBuffer(b, length)
	
	Return bmx_raygui_GuiMessageBox(bounds, t, m, b)
End Function

Rem
bbdoc: Color Picker control.
End Rem
Function GuiColorPicker:Int(bounds:RRectangle, text:String, color:RColor Var)
	Local length:Size_T = text.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	text.ToUTF8StringBuffer(t, length)

	Return bmx_raygui_GuiColorPicker(bounds, t, color)
End Function

Function GuiColorPanel:Int(bounds:RRectangle, text:String, color:RColor Var)
	Local length:Size_T = text.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	text.ToUTF8StringBuffer(t, length)

	Return bmx_raygui_GuiColorPanel(bounds, t, color)
End Function

Rem
bbdoc: Text Input Box control, asks for text.
End Rem
Function GuiTextInputBox:Int(bounds:RRectangle, title:String, message:String, buttons:String, txt:String Var, textMaxSize:Int, secretViewActive:Int Var)
	Local length:Size_T = title.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	title.ToUTF8StringBuffer(t, length)

	length = message.length * 3 + 1
	Local m:Byte Ptr = StackAlloc(length)
	message.ToUTF8StringBuffer(m, length)

	length = buttons.length * 3 + 1
	Local b:Byte Ptr = StackAlloc(length)
	buttons.ToUTF8StringBuffer(b, length)

	Local t2:Byte Ptr = StackAlloc(textMaxSize)
	If txt Then
		length = txt.length * 3 + 1
		txt.ToUTF8StringBuffer(t2, length)
	Else
		t2[0] = 0
	End If
	Local res:Int = bmx_raygui_GuiTextInputBox(bounds, t, m, b, t2, textMaxSize, secretViewActive)
	txt = String.FromUTF8String(t2)
	
	Return res
End Function


' Styles loading functions
' Rem
' bbdoc: Loads a style file (.rgs).
' End Rem
' Function GuiLoadStyle(fileName:String)
' 	Local length:Size_T = fileName.length * 3 + 1
' 	Local f:Byte Ptr = StackAlloc(length)
' 	fileName.ToUTF8StringBuffer(f, length)

' 	bmx_raygui_GuiLoadStyle(f)
' End Function

' Rem
' bbdoc: Loads style default over global style.
' End Rem
' Function GuiLoadStyleDefault()
' 	bmx_raygui_GuiLoadStyleDefault()
' End Function

Rem
bbdoc: Gets text with icon id prepended.
about: Useful to add icons by name id (enum) instead of a number that can change between ricon versions
End Rem
Function GuiIconText:String(iconId:Int, txt:String)
	Local t:Byte Ptr
	If txt Then
		Local length:Size_T = txt.length * 3 + 1
		t = StackAlloc(length)
		txt.ToUTF8StringBuffer(t, length)
	End If
	Return String.FromUTF8String(bmx_raygui_GuiIconText(iconId, t))
End Function

Rem
bbdoc: Draws a an icon.
End Rem
Function GuiDrawIcon(iconId:Int, position:RVector2, pixelSize:Int, color:RColor)
	bmx_raygui_GuiDrawIcon(iconId, position, pixelSize, color)
End Function

Rem
bbdoc: Color Bar Alpha control.
about: Returns alpha value normalized `[0..1]`.
End Rem
Function GuiColorBarAlpha:Int(bounds:RRectangle, text:String, alpha:Float Var)
	Local length:Size_T = text.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	text.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiColorBarAlpha(bounds, t, alpha)
End Function

Rem
bbdoc: Color Bar Hue control.
about: Returns hue value normalized `[0..1]`.
End Rem
Function GuiColorBarHue:Int(bounds:RRectangle, text:String, value:Float Var)
	Local length:Size_T = text.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	text.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiColorBarHue(bounds, t, value)
End Function

Function GuiColorPickerHSV:Int(bounds:RRectangle, text:String, colorHsv:RVector3 Var)
	Local length:Size_T = text.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	text.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiColorPickerHSV(bounds, t, colorHsv)
End Function

Function GuiColorPanelHSV:Int(bounds:RRectangle, text:String, colorHsv:RVector3)
	Local length:Size_T = text.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	text.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiColorPanelHSV(bounds, t, colorHsv)
End Function
