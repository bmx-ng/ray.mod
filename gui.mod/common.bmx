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

Import Ray.Lib
Import "source.bmx"

Extern

	Function bmx_raygui_GuiEnable()="GuiEnable"
	Function bmx_raygui_GuiDisable()="GuiDisable"
	Function bmx_raygui_GuiLock()="GuiLock"
	Function bmx_raygui_GuiUnlock()="GuiUnlock"
	Function bmx_raygui_GuiIsLocked:Int()="GuiIsLocked"
	Function bmx_raygui_GuiSetAlpha(alpha:Float)="GuiSetAlpha"
	' Function bmx_raygui_GuiFade(alpha:Float)="GuiFade"
	Function bmx_raygui_GuiSetState(state:Int)="GuiSetState"
	Function bmx_raygui_GuiGetState:Int()="GuiGetState"

	Function bmx_raygui_GuiSetFont(font:RFont)="GuiSetFont"
	Function bmx_raygui_GuiGetFont:RFont()="GuiGetFont"

	Function bmx_raygui_GuiSetStyle(control:Int, property:Int, value:Int)="GuiSetStyle"
	Function bmx_raygui_GuiGetStyle:Int(control:Int, property:Int)="GuiGetStyle"

	Function bmx_raygui_GuiLoadStyle(fileName:Byte Ptr)="GuiLoadStyle"
	Function bmx_raygui_GuiLoadStyleDefault()="GuiLoadStyleDefault"		
	
	Function bmx_raygui_GuiEnableTooltip()="GuiEnableTooltip"
	Function bmx_raygui_GuiDisableTooltip()="GuiDisableTooltip"
	Function bmx_raygui_GuiSetTooltip(text:Byte Ptr)="GuiSetTooltip"

	Function bmx_raygui_GuiIconText:Byte Ptr(iconId:Int, txt:Byte Ptr)="GuiIconText"
	Function bmx_raygui_GuiDrawIcon(iconId:Int, position:RVector2, pixelSize:Int, color:RColor)="GuiDrawIcon"
		
	Function bmx_raygui_GuiWindowBox:Int(bounds:RRectangle, title:Byte Ptr)="GuiWindowBox"
	Function bmx_raygui_GuiGroupBox(bounds:RRectangle, txt:Byte Ptr)="GuiGroupBox"
	Function bmx_raygui_GuiLine(bounds:RRectangle, txt:Byte Ptr)="GuiLine"
	Function bmx_raygui_GuiPanel(bounds:RRectangle)="GuiPanel"
	Function bmx_raygui_GuiTabBar:Int(bounds:RRectangle, tabs:String[], active:Int Var)
	Function bmx_raygui_GuiScrollPanel:RRectangle(bounds:RRectangle, content:RRectangle, scroll:RVector2 Var)="GuiScrollPanel"

	Function bmx_raygui_GuiLabel(bounds:RRectangle, txt:Byte Ptr)="GuiLabel"
	Function bmx_raygui_GuiButton:Int(bounds:RRectangle, txt:Byte Ptr)="GuiButton"
	Function bmx_raygui_GuiLabelButton:Int(bounds:RRectangle, txt:Byte Ptr)="GuiLabelButton"
	' Function bmx_raygui_GuiImageButton:Int(bounds:RRectangle, txt:Byte Ptr, texture:RTexture2D)="GuiImageButton"
	' Function bmx_raygui_GuiImageButtonEx:Int(bounds:RRectangle, txt:Byte Ptr, texture:RTexture2D, texSource:RRectangle)="GuiImageButtonEx"
	Function bmx_raygui_GuiToggle:Int(bounds:RRectangle, txt:Byte Ptr, active:Int Var)="GuiToggle"
	Function bmx_raygui_GuiToggleGroup:Int(bounds:RRectangle, txt:Byte Ptr, active:Int Var)="GuiToggleGroup"
	Function bmx_raygui_GuiToggleSlider:Int(bounds:RRectangle, txt:Byte Ptr, active:Int Var)="GuiToggleSlider"
	Function bmx_raygui_GuiCheckBox:Int(bounds:RRectangle, txt:Byte Ptr, checked:Int Var)="GuiCheckBox"
	Function bmx_raygui_GuiComboBox:Int(bounds:RRectangle, txt:Byte Ptr, active:Int Var)="GuiComboBox"

	Function bmx_raygui_GuiDropdownBox:Int(bounds:RRectangle, txt:Byte Ptr, active:Int Var, editMode:Int)="GuiDropdownBox"
	Function bmx_raygui_GuiSpinner:Int(bounds:RRectangle, txt:Byte Ptr, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)="GuiSpinner"
	Function bmx_raygui_GuiValueBox:Int(bounds:RRectangle, txt:Byte Ptr, value:Int Var, minValue:Int, maxValue:Int, editMode:Int)="GuiValueBox"
	Function bmx_raygui_GuiValueBoxFloat:Int(bounds:RRectangle, txt:Byte Ptr, textValue:Byte Ptr, value:Float Var, editMode:Int)="GuiValueBoxFloat"
	Function bmx_raygui_GuiTextBox:Int(bounds:RRectangle, txt:Byte Ptr, textSize:Int, editMode:Int)="GuiTextBox"

	' Function bmx_raygui_GuiTextBoxMulti:Int(bounds:RRectangle, txt:Byte Ptr, textSize:Int, editMode:Int)="GuiTextBoxMulti"
	Function bmx_raygui_GuiSlider:Int(bounds:RRectangle, txtLeft:Byte Ptr, txtRight:Byte Ptr, value:Float Var, minValue:Float, maxValue:Float)="GuiSlider"
	Function bmx_raygui_GuiSliderBar:Int(bounds:RRectangle, txtLeft:Byte Ptr, txtRight:Byte Ptr, value:Float Var, minValue:Float, maxValue:Float)="GuiSliderBar"
	Function bmx_raygui_GuiProgressBar:Int(bounds:RRectangle, txtLeft:Byte Ptr, txtRight:Byte Ptr, value:Float Var, minValue:Float, maxValue:Float)="GuiProgressBar"
	Function bmx_raygui_GuiStatusBar(bounds:RRectangle, txt:Byte Ptr)="GuiStatusBar"
	Function bmx_raygui_GuiDummyRec(bounds:RRectangle, txt:Byte Ptr)="GuiDummyRec"
	' Function bmx_raygui_GuiScrollBar:Int(bounds:RRectangle, value:Int, minValue:Int, maxValue:Int)="GuiScrollBar"
	Function bmx_raygui_GuiGrid:RVector2(bounds:RRectangle, spacing:Float, subdivs:Int)="GuiGrid"

	Function bmx_raygui_GuiListView:Int(bounds:RRectangle, txt:Byte Ptr, scrollIndex:Int Var, active:Int Var)="GuiListView"
	Function bmx_raygui_GuiListViewEx:Int(bounds:RRectangle, txt:Size_T Ptr, count:Int, focus:Int Var, scrollIndex:Int Var, active:Int)="GuiListViewEx"
	Function bmx_raygui_GuiMessageBox:Int(bounds:RRectangle, title:Byte Ptr, message:Byte Ptr, buttons:Byte Ptr)="GuiMessageBox"
	Function bmx_raygui_GuiTextInputBox:Int(bounds:RRectangle, title:Byte Ptr, message:Byte Ptr, buttons:Byte Ptr, txt:Byte Ptr, textMaxSize:Int, secretViewActive:Int Var)="GuiTextInputBox"
	Function bmx_raygui_GuiColorPicker:Int(bounds:RRectangle, text:Byte Ptr, color:RColor Var)="GuiColorPicker"
	Function bmx_raygui_GuiColorPanel:Int(bounds:RRectangle, text:Byte Ptr, color:RColor Var)="GuiColorPanel"
	Function bmx_raygui_GuiColorBarAlpha:Float(bounds:RRectangle, text:Byte Ptr, alpha:Float Var)="GuiColorBarAlpha"
	Function bmx_raygui_GuiColorBarHue:Float(bounds:RRectangle, text:Byte Ptr, value:Float Var)="GuiColorBarHue"
	Function bmx_raygui_GuiColorPickerHSV:Int(bounds:RRectangle, text:Byte Ptr, colorHsv:RVector3 Var)="GuiColorPickerHSV"
	Function bmx_raygui_GuiColorPanelHSV:Int(bounds:RRectangle, text:Byte Ptr, colorHsv:RVector3 Var)="GuiColorPanelHSV"
End Extern

Const GUI_DEFAULT:Int = 0
Const LABEL:Int = 1
Const BUTTON:Int = 2
Const TOGGLE:Int = 3
Const SLIDER:Int = 4
Const PROGRESSBAR:Int = 5
Const CHECKBOX:Int = 6
Const COMBOBOX:Int = 7
Const DROPDOWNBOX:Int = 8
Const TEXTBOX:Int = 9
Const VALUEBOX:Int = 10
Const SPINNER:Int = 11
Const LISTVIEW:Int = 12
Const COLORPICKER:Int = 13
Const SCROLLBAR:Int = 14
Const STATUSBAR:Int = 15

Const GUI_STATE_NORMAL:Int = 0
Const GUI_STATE_FOCUSED:Int = 1
Const GUI_STATE_PRESSED:Int = 2
Const GUI_STATE_DISABLED:Int = 3

Const GUI_TEXT_ALIGN_LEFT:Int = 0
Const GUI_TEXT_ALIGN_CENTER:Int = 1
Const GUI_TEXT_ALIGN_RIGHT:Int = 2

Const BORDER_COLOR_NORMAL:Int = 0
Const BASE_COLOR_NORMAL:Int = 1
Const TEXT_COLOR_NORMAL:Int = 2
Const BORDER_COLOR_FOCUSED:Int = 3
Const BASE_COLOR_FOCUSED:Int = 4
Const TEXT_COLOR_FOCUSED:Int = 5
Const BORDER_COLOR_PRESSED:Int = 6
Const BASE_COLOR_PRESSED:Int = 7
Const TEXT_COLOR_PRESSED:Int = 8
Const BORDER_COLOR_DISABLED:Int = 9
Const BASE_COLOR_DISABLED:Int = 10
Const TEXT_COLOR_DISABLED:Int = 11
Const BORDER_WIDTH:Int = 12
Const TEXT_PADDING:Int = 13
Const TEXT_ALIGNMENT:Int = 14
Const RESERVED:Int = 15

Const TEXT_SIZE:Int = 16
Const TEXT_SPACING:Int = 17
Const LINE_COLOR:Int = 18
Const BACKGROUND_COLOR:Int = 19

Const GROUP_PADDING:Int = 16

Const SLIDER_WIDTH:Int = 16
Const SLIDER_PADDING:Int = 17

Const PROGRESS_PADDING:Int = 16

Const CHECK_PADDING:Int = 16

Const COMBO_BUTTON_WIDTH:Int = 16
Const COMBO_BUTTON_PADDING:Int = 17

Const ARROW_PADDING:Int = 16
Const DROPDOWN_ITEMS_PADDING:Int = 17

Const TEXT_INNER_PADDING:Int = 16
Const TEXT_LINES_PADDING:Int = 17
Const COLOR_SELECTED_FG:Int = 18
Const COLOR_SELECTED_BG:Int = 19

Const SPIN_BUTTON_WIDTH:Int = 16
Const SPIN_BUTTON_PADDING:Int = 17

Const ARROWS_SIZE:Int = 16
Const ARROWS_VISIBLE:Int = 17
Const SCROLL_SLIDER_PADDING:Int = 18
Const SCROLL_SLIDER_SIZE:Int = 19
Const SCROLL_PADDING:Int = 20
Const SCROLL_SPEED:Int = 21

Const SCROLLBAR_LEFT_SIDE:Int = 0
Const SCROLLBAR_RIGHT_SIDE:Int = 1

Const LIST_ITEMS_HEIGHT:Int = 16
Const LIST_ITEMS_PADDING:Int = 17
Const SCROLLBAR_WIDTH:Int = 18
Const SCROLLBAR_SIDE:Int = 19

Const COLOR_SELECTOR_SIZE:Int = 16
Const HUEBAR_WIDTH:Int = 17
Const HUEBAR_PADDING:Int = 18
Const HUEBAR_SELECTOR_HEIGHT:Int = 19
Const HUEBAR_SELECTOR_OVERFLOW:Int = 20



Const RICON_NONE:Int = 0
Const RICON_FOLDER_FILE_OPEN:Int = 1
Const RICON_FILE_SAVE_CLASSIC:Int = 2
Const RICON_FOLDER_OPEN:Int = 3
Const RICON_FOLDER_SAVE:Int = 4
Const RICON_FILE_OPEN:Int = 5
Const RICON_FILE_SAVE:Int = 6
Const RICON_FILE_EXPORT:Int = 7
Const RICON_FILE_NEW:Int = 8
Const RICON_FILE_DELETE:Int = 9
Const RICON_FILETYPE_TEXT:Int = 10
Const RICON_FILETYPE_AUDIO:Int = 11
Const RICON_FILETYPE_IMAGE:Int = 12
Const RICON_FILETYPE_PLAY:Int = 13
Const RICON_FILETYPE_VIDEO:Int = 14
Const RICON_FILETYPE_INFO:Int = 15
Const RICON_FILE_COPY:Int = 16
Const RICON_FILE_CUT:Int = 17
Const RICON_FILE_PASTE:Int = 18
Const RICON_CURSOR_HAND:Int = 19
Const RICON_CURSOR_POINTER:Int = 20
Const RICON_CURSOR_CLASSIC:Int = 21
Const RICON_PENCIL:Int = 22
Const RICON_PENCIL_BIG:Int = 23
Const RICON_BRUSH_CLASSIC:Int = 24
Const RICON_BRUSH_PAINTER:Int = 25
Const RICON_WATER_DROP:Int = 26
Const RICON_COLOR_PICKER:Int = 27
Const RICON_RUBBER:Int = 28
Const RICON_COLOR_BUCKET:Int = 29
Const RICON_TEXT_T:Int = 30
Const RICON_TEXT_A:Int = 31
Const RICON_SCALE:Int = 32
Const RICON_RESIZE:Int = 33
Const RICON_FILTER_POINT:Int = 34
Const RICON_FILTER_BILINEAR:Int = 35
Const RICON_CROP:Int = 36
Const RICON_CROP_ALPHA:Int = 37
Const RICON_SQUARE_TOGGLE:Int = 38
Const RICON_SIMMETRY:Int = 39
Const RICON_SIMMETRY_HORIZONTAL:Int = 40
Const RICON_SIMMETRY_VERTICAL:Int = 41
Const RICON_LENS:Int = 42
Const RICON_LENS_BIG:Int = 43
Const RICON_EYE_ON:Int = 44
Const RICON_EYE_OFF:Int = 45
Const RICON_FILTER_TOP:Int = 46
Const RICON_FILTER:Int = 47
Const RICON_TARGET_POINT:Int = 48
Const RICON_TARGET_SMALL:Int = 49
Const RICON_TARGET_BIG:Int = 50
Const RICON_TARGET_MOVE:Int = 51
Const RICON_CURSOR_MOVE:Int = 52
Const RICON_CURSOR_SCALE:Int = 53
Const RICON_CURSOR_SCALE_RIGHT:Int = 54
Const RICON_CURSOR_SCALE_LEFT:Int = 55
Const RICON_UNDO:Int = 56
Const RICON_REDO:Int = 57
Const RICON_REREDO:Int = 58
Const RICON_MUTATE:Int = 59
Const RICON_ROTATE:Int = 60
Const RICON_REPEAT:Int = 61
Const RICON_SHUFFLE:Int = 62
Const RICON_EMPTYBOX:Int = 63
Const RICON_TARGET:Int = 64
Const RICON_TARGET_SMALL_FILL:Int = 65
Const RICON_TARGET_BIG_FILL:Int = 66
Const RICON_TARGET_MOVE_FILL:Int = 67
Const RICON_CURSOR_MOVE_FILL:Int = 68
Const RICON_CURSOR_SCALE_FILL:Int = 69
Const RICON_CURSOR_SCALE_RIGHT_FILL:Int = 70
Const RICON_CURSOR_SCALE_LEFT_FILL:Int = 71
Const RICON_UNDO_FILL:Int = 72
Const RICON_REDO_FILL:Int = 73
Const RICON_REREDO_FILL:Int = 74
Const RICON_MUTATE_FILL:Int = 75
Const RICON_ROTATE_FILL:Int = 76
Const RICON_REPEAT_FILL:Int = 77
Const RICON_SHUFFLE_FILL:Int = 78
Const RICON_EMPTYBOX_SMALL:Int = 79
Const RICON_BOX:Int = 80
Const RICON_BOX_TOP:Int = 81
Const RICON_BOX_TOP_RIGHT:Int = 82
Const RICON_BOX_RIGHT:Int = 83
Const RICON_BOX_BOTTOM_RIGHT:Int = 84
Const RICON_BOX_BOTTOM:Int = 85
Const RICON_BOX_BOTTOM_LEFT:Int = 86
Const RICON_BOX_LEFT:Int = 87
Const RICON_BOX_TOP_LEFT:Int = 88
Const RICON_BOX_CENTER:Int = 89
Const RICON_BOX_CIRCLE_MASK:Int = 90
Const RICON_POT:Int = 91
Const RICON_ALPHA_MULTIPLY:Int = 92
Const RICON_ALPHA_CLEAR:Int = 93
Const RICON_DITHERING:Int = 94
Const RICON_MIPMAPS:Int = 95
Const RICON_BOX_GRID:Int = 96
Const RICON_GRID:Int = 97
Const RICON_BOX_CORNERS_SMALL:Int = 98
Const RICON_BOX_CORNERS_BIG:Int = 99
Const RICON_FOUR_BOXES:Int = 100
Const RICON_GRID_FILL:Int = 101
Const RICON_BOX_MULTISIZE:Int = 102
Const RICON_ZOOM_SMALL:Int = 103
Const RICON_ZOOM_MEDIUM:Int = 104
Const RICON_ZOOM_BIG:Int = 105
Const RICON_ZOOM_ALL:Int = 106
Const RICON_ZOOM_CENTER:Int = 107
Const RICON_BOX_DOTS_SMALL:Int = 108
Const RICON_BOX_DOTS_BIG:Int = 109
Const RICON_BOX_CONCENTRIC:Int = 110
Const RICON_BOX_GRID_BIG:Int = 111
Const RICON_OK_TICK:Int = 112
Const RICON_CROSS:Int = 113
Const RICON_ARROW_LEFT:Int = 114
Const RICON_ARROW_RIGHT:Int = 115
Const RICON_ARROW_BOTTOM:Int = 116
Const RICON_ARROW_TOP:Int = 117
Const RICON_ARROW_LEFT_FILL:Int = 118
Const RICON_ARROW_RIGHT_FILL:Int = 119
Const RICON_ARROW_BOTTOM_FILL:Int = 120
Const RICON_ARROW_TOP_FILL:Int = 121
Const RICON_AUDIO:Int = 122
Const RICON_FX:Int = 123
Const RICON_WAVE:Int = 124
Const RICON_WAVE_SINUS:Int = 125
Const RICON_WAVE_SQUARE:Int = 126
Const RICON_WAVE_TRIANGULAR:Int = 127
Const RICON_CROSS_SMALL:Int = 128
Const RICON_PLAYER_PREVIOUS:Int = 129
Const RICON_PLAYER_PLAY_BACK:Int = 130
Const RICON_PLAYER_PLAY:Int = 131
Const RICON_PLAYER_PAUSE:Int = 132
Const RICON_PLAYER_STOP:Int = 133
Const RICON_PLAYER_NEXT:Int = 134
Const RICON_PLAYER_RECORD:Int = 135
Const RICON_MAGNET:Int = 136
Const RICON_LOCK_CLOSE:Int = 137
Const RICON_LOCK_OPEN:Int = 138
Const RICON_CLOCK:Int = 139
Const RICON_TOOLS:Int = 140
Const RICON_GEAR:Int = 141
Const RICON_GEAR_BIG:Int = 142
Const RICON_BIN:Int = 143
Const RICON_HAND_POINTER:Int = 144
Const RICON_LASER:Int = 145
Const RICON_COIN:Int = 146
Const RICON_EXPLOSION:Int = 147
Const RICON_1UP:Int = 148
Const RICON_PLAYER:Int = 149
Const RICON_PLAYER_JUMP:Int = 150
Const RICON_KEY:Int = 151
Const RICON_DEMON:Int = 152
Const RICON_TEXT_POPUP:Int = 153
Const RICON_GEAR_EX:Int = 154
Const RICON_CRACK:Int = 155
Const RICON_CRACK_POINTS:Int = 156
Const RICON_STAR:Int = 157
Const RICON_DOOR:Int = 158
Const RICON_EXIT:Int = 159
Const RICON_MODE_2D:Int = 160
Const RICON_MODE_3D:Int = 161
Const RICON_CUBE:Int = 162
Const RICON_CUBE_FACE_TOP:Int = 163
Const RICON_CUBE_FACE_LEFT:Int = 164
Const RICON_CUBE_FACE_FRONT:Int = 165
Const RICON_CUBE_FACE_BOTTOM:Int = 166
Const RICON_CUBE_FACE_RIGHT:Int = 167
Const RICON_CUBE_FACE_BACK:Int = 168
Const RICON_CAMERA:Int = 169
Const RICON_SPECIAL:Int = 170
Const RICON_LINK_NET:Int = 171
Const RICON_LINK_BOXES:Int = 172
Const RICON_LINK_MULTI:Int = 173
Const RICON_LINK:Int = 174
Const RICON_LINK_BROKE:Int = 175
Const RICON_TEXT_NOTES:Int = 176
Const RICON_NOTEBOOK:Int = 177
Const RICON_SUITCASE:Int = 178
Const RICON_SUITCASE_ZIP:Int = 179
Const RICON_MAILBOX:Int = 180
Const RICON_MONITOR:Int = 181
Const RICON_PRINTER:Int = 182
Const RICON_PHOTO_CAMERA:Int = 183
Const RICON_PHOTO_CAMERA_FLASH:Int = 184
Const RICON_HOUSE:Int = 185
Const RICON_HEART:Int = 186
Const RICON_CORNER:Int = 187
Const RICON_VERTICAL_BARS:Int = 188
Const RICON_VERTICAL_BARS_FILL:Int = 189
Const RICON_LIFE_BARS:Int = 190
Const RICON_INFO:Int = 191
Const RICON_CROSSLINE:Int = 192
Const RICON_HELP:Int = 193
Const RICON_FILETYPE_ALPHA:Int = 194
Const RICON_FILETYPE_HOME:Int = 195
Const RICON_LAYERS_VISIBLE:Int = 196
Const RICON_LAYERS:Int = 197
Const RICON_WINDOW:Int = 198
Const RICON_HIDPI:Int = 199
Const RICON_FILETYPE_BINARY:Int = 200
Const RICON_HEX:Int = 201
Const RICON_SHIELD:Int = 202
Const RICON_FILE_NEW:Int = 203
Const RICON_FOLDER_ADD:Int = 204
Const RICON_ALARM:Int = 205
Const RICON_CPU:Int = 206
Const RICON_ROM:Int = 207
Const RICON_STEP_OVER:Int = 208
Const RICON_STEP_INTO:Int = 209
Const RICON_STEP_OUT:Int = 210
Const RICON_RESTART:Int = 211
Const RICON_BREAKPOINT_ON:Int = 212
Const RICON_BREAKPOINT_OFF:Int = 213
Const RICON_BURGER_MENU:Int = 214
Const RICON_CASE_SENSITIVE:Int = 215
Const RICON_REG_EXP:Int = 216
Const RICON_FOLDER:Int = 217
Const RICON_FILE:Int = 218
Const RICON_SAND_TIMER:Int = 219
Const RICON_WARNING:Int = 220
Const RICON_HELP_BOX:Int = 221
Const RICON_INFO_BOX:Int = 222
Const RICON_PRIORITY:Int = 223
Const RICON_LAYERS_ISO:Int = 224
Const RICON_LAYERS2:Int = 225
Const RICON_MLAYERS:Int = 226
Const RICON_MAPS:Int = 227
Const RICON_HOT:Int = 228
Const RICON_229:Int = 229
Const RICON_230:Int = 230
Const RICON_231:Int = 231
Const RICON_232:Int = 232
Const RICON_233:Int = 233
Const RICON_234:Int = 234
Const RICON_235:Int = 235
Const RICON_236:Int = 236
Const RICON_237:Int = 237
Const RICON_238:Int = 238
Const RICON_239:Int = 239
Const RICON_240:Int = 240
Const RICON_241:Int = 241
Const RICON_242:Int = 242
Const RICON_243:Int = 243
Const RICON_244:Int = 244
Const RICON_245:Int = 245
Const RICON_246:Int = 246
Const RICON_247:Int = 247
Const RICON_248:Int = 248
Const RICON_249:Int = 249
Const RICON_250:Int = 250
Const RICON_251:Int = 251
Const RICON_252:Int = 252
Const RICON_253:Int = 253
Const RICON_254:Int = 254
Const RICON_255:Int = 255
