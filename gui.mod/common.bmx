' Copyright (c) 2020 Bruce A Henderson
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

Import Ray.Lib
Import "source.bmx"

Extern

	Function bmx_raygui_GuiEnable()="GuiEnable"
	Function bmx_raygui_GuiDisable()="GuiDisable"
	Function bmx_raygui_GuiLock()="GuiLock"
	Function bmx_raygui_GuiUnlock()="GuiUnlock"
	Function bmx_raygui_GuiFade(alpha:Float)="GuiFade"

	Function bmx_raygui_GuiSetState(state:Int)="GuiSetState"
	Function bmx_raygui_GuiGetState:Int()="GuiGetState"

	Function bmx_raygui_GuiSetFont(font:RFont)="GuiSetFont"
	Function bmx_raygui_GuiGetFont:RFont()="GuiGetFont"

	Function bmx_raygui_GuiSetStyle(control:Int, property:Int, value:Int)="GuiSetStyle"
	Function bmx_raygui_GuiGetStyle:Int(control:Int, property:Int)="GuiGetStyle"

	Function bmx_raygui_GuiWindowBox:Int(bounds:RRectangle, title:Byte Ptr)="GuiWindowBox"
	Function bmx_raygui_GuiGroupBox(bounds:RRectangle, txt:Byte Ptr)="GuiGroupBox"
	Function bmx_raygui_GuiLine(bounds:RRectangle, txt:Byte Ptr)="GuiLine"
	Function bmx_raygui_GuiPanel(bounds:RRectangle)="GuiPanel"
	Function bmx_raygui_GuiScrollPanel:RRectangle(bounds:RRectangle, content:RRectangle, scroll:RVector2 Var)="GuiScrollPanel"

	Function bmx_raygui_GuiLabel(bounds:RRectangle, txt:Byte Ptr)="GuiLabel"
	Function bmx_raygui_GuiButton:Int(bounds:RRectangle, txt:Byte Ptr)="GuiButton"
	Function bmx_raygui_GuiLabelButton:Int(bounds:RRectangle, txt:Byte Ptr)="GuiLabelButton"
	Function bmx_raygui_GuiImageButton:Int(bounds:RRectangle, txt:Byte Ptr, texture:RTexture2D)="GuiImageButton"
	Function bmx_raygui_GuiImageButtonEx:Int(bounds:RRectangle, txt:Byte Ptr, texture:RTexture2D, texSource:RRectangle)="GuiImageButtonEx"
	Function bmx_raygui_GuiToggle:Int(bounds:RRectangle, txt:Byte Ptr, active:Int)="GuiToggle"
	Function bmx_raygui_GuiToggleGroup:Int(bounds:RRectangle, txt:Byte Ptr, active:Int)="GuiToggleGroup"
	Function bmx_raygui_GuiCheckBox:Int(bounds:RRectangle, txt:Byte Ptr, checked:Int)="GuiCheckBox"
	Function bmx_raygui_GuiComboBox:Int(bounds:RRectangle, txt:Byte Ptr, active:Int)="GuiComboBox"
	Function bmx_raygui_GuiDropdownBox:Int(bounds:RRectangle, txt:Byte Ptr, active:Int Var, editMode:Int)="GuiDropdownBox"
	Function bmx_raygui_GuiSpinner:Int(bounds:RRectangle, txt:Byte Ptr, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)="GuiSpinner"
	Function bmx_raygui_GuiValueBox:Int(bounds:RRectangle, txt:Byte Ptr, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)="GuiValueBox"
	Function bmx_raygui_GuiTextBox:Int(bounds:RRectangle, txt:Byte Ptr, textSize:Int, editMode:Int)="GuiTextBox"
	Function bmx_raygui_GuiTextBoxMulti:Int(bounds:RRectangle, txt:Byte Ptr, textSize:Int, editMode:Int)="GuiTextBoxMulti"
	Function bmx_raygui_GuiSlider:Float(bounds:RRectangle, txtLeft:Byte Ptr, txtRight:Byte Ptr, value:Float, minValue:Float, maxValue:Float)="GuiSlider"
	Function bmx_raygui_GuiSliderBar:Float(bounds:RRectangle, txtLeft:Byte Ptr, txtRight:Byte Ptr, value:Float, minValue:Float, maxValue:Float)="GuiSliderBar"
	Function bmx_raygui_GuiProgressBar:Float(bounds:RRectangle, txtLeft:Byte Ptr, txtRight:Byte Ptr, value:Float, minValue:Float, maxValue:Float)="GuiProgressBar"
	Function bmx_raygui_GuiStatusBar(bounds:RRectangle, txt:Byte Ptr)="GuiStatusBar"
	Function bmx_raygui_GuiDummyRec(bounds:RRectangle, txt:Byte Ptr)="GuiDummyRec"
	Function bmx_raygui_GuiScrollBar:Int(bounds:RRectangle, value:Int, minValue:Int, maxValue:Int)="GuiScrollBar"
	Function bmx_raygui_GuiGrid:RVector2(bounds:RRectangle, spacing:Float, subdivs:Int)="GuiGrid"

	Function bmx_raygui_GuiListView:Int(bounds:RRectangle, txt:Byte Ptr, scrollIndex:Int Var, active:Int)="GuiListView"
	Function bmx_raygui_GuiListViewEx:Int(bounds:RRectangle, txt:Size_T Ptr, focus:Int Var, scrollIndex:Int Var, active:Int)="GuiListViewEx"
	Function bmx_raygui_GuiMessageBox:Int(bounds:RRectangle, title:Byte Ptr, message:Byte Ptr, buttons:Byte Ptr)="GuiMessageBox"
	Function bmx_raygui_GuiColorPicker:RColor(bounds:RRectangle, color:RColor)="GuiColorPicker"
	Function bmx_raygui_GuiTextInputBox:Int(bounds:RRectangle, title:Byte Ptr, message:Byte Ptr, buttons:Byte Ptr, txt:Byte Ptr)="GuiTextInputBox"

	Function bmx_raygui_GuiLoadStyle(fileName:Byte Ptr)="GuiLoadStyle"
	Function bmx_raygui_GuiLoadStyleDefault()="GuiLoadStyleDefault"

End Extern
