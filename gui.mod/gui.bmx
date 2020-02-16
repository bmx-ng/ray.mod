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

Module Ray.GUI

Import "common.bmx"




Function GuiEnable()
	bmx_raygui_GuiEnable()
End Function

Function GuiDisable()
	bmx_raygui_GuiDisable()
End Function

Function GuiLock()
	bmx_raygui_GuiLock()
End Function

Function GuiUnlock()
	bmx_raygui_GuiUnlock()
End Function

Function GuiFade(alpha:Float)
	bmx_raygui_GuiFade(alpha)
End Function


Function GuiSetState(state:Int)
	bmx_raygui_GuiSetState(state)
End Function

Function GuiGetState:Int()
	Return bmx_raygui_GuiGetState()
End Function


Function GuiSetFont(font:RFont)
	bmx_raygui_GuiSetFont(font)
End Function

Function GuiGetFont:RFont()
	bmx_raygui_GuiGetFont()
End Function


' Style set/get functions
Function GuiSetStyle(control:Int, property:Int, value:Int)
	bmx_raygui_GuiSetStyle(control, property, value)
End Function

Function GuiGetStyle:Int(control:Int, property:Int)
	bmx_raygui_GuiGetStyle(control, property)
End Function


' Container/separator controls, useful for controls organization
Function GuiWindowBox:Int(bounds:RRectangle, title:String)
	Local length:Size_T = title.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	title.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiWindowBox(bounds, t)
End Function

Function GuiGroupBox(bounds:RRectangle, txt:String)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	bmx_raygui_GuiGroupBox(bounds, t)
End Function

Function GuiLine(bounds:RRectangle, txt:String)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	bmx_raygui_GuiLine(bounds, t)
End Function

Function GuiPanel(bounds:RRectangle)
	bmx_raygui_GuiPanel(bounds)
End Function

Function GuiScrollPanel:RRectangle(bounds:RRectangle, content:RRectangle, scroll:RVector2 Var)
	Return bmx_raygui_GuiScrollPanel(bounds, content, scroll)
End Function


' Basic controls set
Function GuiLabel(bounds:RRectangle, txt:String)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	bmx_raygui_GuiLabel(bounds:RRectangle, t)
End Function

Function GuiButton:Int(bounds:RRectangle, txt:String)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiButton(bounds:RRectangle, t)
End Function

Function GuiLabelButton:Int(bounds:RRectangle, txt:String)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiLabelButton(bounds:RRectangle, t)
End Function

Function GuiImageButton:Int(bounds:RRectangle, txt:String, texture:RTexture2D)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiImageButton(bounds, t, texture)
End Function

Function GuiImageButtonEx:Int(bounds:RRectangle, txt:String, texture:RTexture2D, texSource:RRectangle)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiImageButtonEx(bounds, t, texture, texSource)
End Function

Function GuiToggle:Int(bounds:RRectangle, txt:String, active:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiToggle(bounds, t, active)
End Function

Function GuiToggleGroup:Int(bounds:RRectangle, txt:String, active:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiToggleGroup(bounds, t, active)
End Function

Function GuiCheckBox:Int(bounds:RRectangle, txt:String, checked:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiCheckBox(bounds, t, checked)
End Function

Function GuiComboBox:Int(bounds:RRectangle, txt:String, active:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiComboBox(bounds, t, active)
End Function

Function GuiDropdownBox:Int(bounds:RRectangle, txt:String, active:Int Var, editMode:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiDropdownBox(bounds, t, active, editMode)
End Function

Function GuiSpinner:Int(bounds:RRectangle, txt:String, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiSpinner(bounds, t, value, minValue, maxValue, editMode)
End Function

Function GuiValueBox:Int(bounds:RRectangle, txt:String, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raygui_GuiValueBox(bounds, t, value, minValue, maxValue, editMode)
End Function

Function GuiTextBox:Int(bounds:RRectangle, txt:String Var, textSize:Int, editMode:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Local res:Int = bmx_raygui_GuiTextBox(bounds, t, textSize, editMode)
	txt = String.FromUTF8String(t)
	Return res
End Function

Function GuiTextBoxMulti:Int(bounds:RRectangle, txt:String Var, textSize:Int, editMode:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Local res:Int = bmx_raygui_GuiTextBoxMulti(bounds, t, textSize, editMode)
	txt = String.FromUTF8String(t)
	Return res
End Function

Function GuiSlider:Float(bounds:RRectangle, txtLeft:String, txtRight:String, value:Float, minValue:Float, maxValue:Float)
	Local length:Size_T = txtLeft.length * 3 + 1
	Local tl:Byte Ptr = StackAlloc(length)
	txtLeft.ToUTF8StringBuffer(tl, length)

	length = txtRight.length * 3 + 1
	Local tr:Byte Ptr = StackAlloc(length)
	txtRight.ToUTF8StringBuffer(tr, length)

	Return bmx_raygui_GuiSlider(bounds, tl, tr, value, minValue, maxValue)
End Function

Function GuiSliderBar:Float(bounds:RRectangle, txtLeft:String, txtRight:String, value:Float, minValue:Float, maxValue:Float)
	Local length:Size_T = txtLeft.length * 3 + 1
	Local tl:Byte Ptr = StackAlloc(length)
	txtLeft.ToUTF8StringBuffer(tl, length)

	length = txtRight.length * 3 + 1
	Local tr:Byte Ptr = StackAlloc(length)
	txtRight.ToUTF8StringBuffer(tr, length)

	Return bmx_raygui_GuiSliderBar(bounds, tl, tr, value, minValue, maxValue)
End Function

Function GuiProgressBar:Float(bounds:RRectangle, txtLeft:String, txtRight:String, value:Float, minValue:Float, maxValue:Float)
	Local length:Size_T = txtLeft.length * 3 + 1
	Local tl:Byte Ptr = StackAlloc(length)
	txtLeft.ToUTF8StringBuffer(tl, length)

	length = txtRight.length * 3 + 1
	Local tr:Byte Ptr = StackAlloc(length)
	txtRight.ToUTF8StringBuffer(tr, length)

	Return bmx_raygui_GuiProgressBar(bounds, tl, tr, value, minValue, maxValue)
End Function

Function GuiStatusBar(bounds:RRectangle, txt:String)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	bmx_raygui_GuiStatusBar(bounds, t)
End Function

Function GuiDummyRec(bounds:RRectangle, txt:String)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	bmx_raygui_GuiDummyRec(bounds, t)
End Function

Function GuiScrollBar:Int(bounds:RRectangle, value:Int, minValue:Int, maxValue:Int)
	Return bmx_raygui_GuiScrollBar(bounds, value, minValue, maxValue)
End Function

Function GuiGrid:RVector2(bounds:RRectangle, spacing:Float, subdivs:Int)
	Return bmx_raygui_GuiGrid(bounds:RRectangle, spacing, subdivs)
End Function


' Advance controls set
Function GuiListView:Int(bounds:RRectangle, txt:String, scrollIndex:Int Var, active:Int)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)

	Return bmx_raygui_GuiListView(bounds:RRectangle, t, scrollIndex, active)
End Function

Function GuiListViewEx:Int(bounds:RRectangle, txt:String[], focus:Int Var, scrollIndex:Int Var, active:Int)
	Local list:Size_T Ptr = MemAlloc(Size_T(txt.length * 8))
	For Local i:Int = 0 Until txt.length
		list[i] = Size_T(txt[i].ToUTF8String())
	Next
	Local res:Int = bmx_raygui_GuiListViewEx(bounds, list, focus, scrollIndex, active)
	For Local i:Int = 0 Until txt.length
		MemFree(Byte Ptr(list[i]))
	Next
	MemFree(list)
	Return res
End Function

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

Function GuiColorPicker:RColor(bounds:RRectangle, color:RColor)
	Return bmx_raygui_GuiColorPicker(bounds, color)
End Function

Function GuiTextInputBox:Int(bounds:RRectangle, title:String, message:String, buttons:String, txt:String)
	Local length:Size_T = title.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	title.ToUTF8StringBuffer(t, length)

	length = message.length * 3 + 1
	Local m:Byte Ptr = StackAlloc(length)
	message.ToUTF8StringBuffer(m, length)

	length = buttons.length * 3 + 1
	Local b:Byte Ptr = StackAlloc(length)
	buttons.ToUTF8StringBuffer(b, length)

	Local t2:Byte Ptr = txt.ToUTF8String()
	Local res:Int = bmx_raygui_GuiTextInputBox(bounds, t, m, b, t2)
	MemFree(t2)
	
	Return res
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

