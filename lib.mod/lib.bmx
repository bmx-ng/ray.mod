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

Rem
bbdoc: Raylib - Simple Games Programming
End Rem
Module Ray.Lib

ModuleInfo "Version: 1.00"
ModuleInfo "License: zlib"
ModuleInfo "Copyright: Wrapper - 2020 Bruce A Henderson"
ModuleInfo "Copyright: raylib - 2013-2020 Ramon Santamaria"

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

' Notes -
' Changed definition of bool in raylib.h to always be enum.
' Fixes issue where we use Int in BlitzMax to represent bools.
'
' Changed easings.h to not use static inline.
'

Rem
bbdoc: Initializes window and OpenGL context.
End Rem
Function InitWindow(width:Int, height:Int, title:String)
	Local t:Byte Ptr = title.ToUTF8String()
	bmx_raylib_InitWindow(width, height,  title)
	MemFree(t)
End Function

Rem
bbdoc: Checks if KEY_ESCAPE pressed or Close icon pressed.
End Rem
Function WindowShouldClose:Int()
	Return bmx_raylib_WindowShouldClose()
End Function

Rem
bbdoc: Closes window and unload OpenGL context
End Rem
Function CloseWindow()
	bmx_raylib_CloseWindow()
End Function

Rem
bbdoc: Checks if window has been initialized successfully.
End Rem
Function IsWindowReady:Int()
	Return bmx_raylib_IsWindowReady()
End Function

Rem
bbdoc: Checks if window has been minimized (or lost focus).
End Rem
Function IsWindowMinimized:Int()
	Return bmx_raylib_IsWindowMinimized()
End Function

Rem
bbdoc: Checks if window has been resized.
End Rem
Function IsWindowResized:Int()
	Return bmx_raylib_IsWindowResized()
End Function

Rem
bbdoc: Checks if window is currently hidden.
End Rem
Function IsWindowHidden:Int()
	Return bmx_raylib_IsWindowHidden()
End Function

Rem
bbdoc: Toggles fullscreen mode (only Desktop)
End Rem
Function ToggleFullscreen()
	bmx_raylib_ToggleFullscreen()
End Function

Rem
bbdoc: Shows the window.
End Rem
Function UnhideWindow()
	bmx_raylib_UnhideWindow()
End Function

Rem
bbdoc: Hides the window.
End Rem
Function HideWindow()
	bmx_raylib_HideWindow()
End Function

Rem
bbdoc: Sets icon for window (only Desktop)
End Rem
Function SetWindowIcon(image:RImage)
	bmx_raylib_SetWindowIcon(image)
End Function

Rem
bbdoc: Sets title for window (only Desktop)
End Rem
Function SetWindowTitle(title:String)
	Local t:Byte Ptr = title.ToUTF8String()
	bmx_raylib_SetWindowTitle(t)
	MemFree(t)
End Function

Rem
bbdoc: Sets window position on screen (only Desktop)
End Rem
Function SetWindowPosition(x:Int, y:Int)
	bmx_raylib_SetWindowPosition(x, y)
End Function

Rem
bbdoc: Sets monitor for the current window (fullscreen mode)
End Rem
Function SetWindowMonitor(monitor:Int)
	bmx_raylib_SetWindowMonitor(monitor)
End Function

Rem
bbdoc: Sets window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
End Rem
Function SetWindowMinSize(width:Int, height:Int)
	bmx_raylib_SetWindowMinSize(width, height)
End Function

Rem
bbdoc: Sets window dimensions.
End Rem
Function SetWindowSize(width:Int, height:Int)
	bmx_raylib_SetWindowSize(width, height)
End Function

Rem
bbdoc: Gets native window handle.
End Rem
Function GetWindowHandle:Byte Ptr()
	Return bmx_raylib_GetWindowHandle()
End Function

Rem
bbdoc: Gets current screen width.
End Rem
Function GetScreenWidth:Int()
	Return bmx_raylib_GetScreenWidth()
End Function

Rem
bbdoc: Gets current screen height.
End Rem
Function GetScreenHeight:Int()
	Return bmx_raylib_GetScreenHeight()
End Function

Rem
bbdoc: Gets number of connected monitors.
End Rem
Function GetMonitorCount:Int()
	Return bmx_raylib_GetMonitorCount()
End Function

Rem
bbdoc: Gets primary monitor width.
End Rem
Function GetMonitorWidth:Int(monitor:Int)
	Return bmx_raylib_GetMonitorWidth(monitor)
End Function

Rem
bbdoc: Gets primary monitor height.
End Rem
Function GetMonitorHeight:Int(monitor:Int)
	Return bmx_raylib_GetMonitorHeight(monitor)
End Function

Rem
bbdoc: Gets primary monitor physical width in millimetres.
End Rem
Function GetMonitorPhysicalWidth:Int(monitor:Int)
	Return bmx_raylib_GetMonitorPhysicalWidth(monitor)
End Function

Rem
bbdoc: Gets primary monitor physical height in millimetres.
End Rem
Function GetMonitorPhysicalHeight:Int(monitor:Int)
	Return bmx_raylib_GetMonitorPhysicalHeight(monitor)
End Function

Rem
bbdoc: Gets window position XY on monitor.
End Rem
Function GetWindowPosition:RVector2()
	Return bmx_raylib_GetWindowPosition()
End Function

Rem
bbdoc: Gets the human-readable name of the primary monitor.
End Rem
Function GetMonitorName:String(monitor:Int)
	Local n:Byte Ptr = bmx_raylib_GetMonitorName(monitor)
	Return String.FromUTF8String(n)
End Function

Rem
bbdoc: Gets clipboard text content.
End Rem
Function GetClipboardText:String()
	Local t:Byte Ptr = bmx_raylib_GetClipboardText()
	Return String.FromUTF8String(t)
End Function

Rem
bbdoc: Sets clipboard text content.
End Rem
Function SetClipboardText(txt:String)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_SetClipboardText(t)
	MemFree(t)
End Function

' Cursor-related functions
Function ShowCursor()
	bmx_raylib_ShowCursor()
End Function

Function HideCursor()
	bmx_raylib_HideCursor()
End Function

Function IsCursorHidden:Int()
	Return bmx_raylib_IsCursorHidden()
End Function

Function EnableCursor()
	bmx_raylib_EnableCursor()
End Function

Function DisableCursor()
	bmx_raylib_DisableCursor()
End Function

' Drawing-related functions
Function ClearBackground(color:RColor)
	bmx_raylib_ClearBackground(color)
End Function

Function BeginDrawing()
	bmx_raylib_BeginDrawing()
End Function

Function EndDrawing()
	bmx_raylib_EndDrawing()
End Function

Function BeginMode2D(camera:RCamera2D)
	bmx_raylib_BeginMode2D(camera)
End Function

Function EndMode2D()
	bmx_raylib_EndMode2D()
End Function

Function BeginMode3D(camera:RCamera)
	bmx_raylib_BeginMode3D(camera)
End Function

Function EndMode3D()
	bmx_raylib_EndMode3D()
End Function

Function BeginTextureMode(target:RRenderTexture2D)
	bmx_raylib_BeginTextureMode(target)
End Function

Function EndTextureMode()
	bmx_raylib_EndTextureMode()
End Function

Function BeginScissorMode(x:Int, y:Int, width:Int, height:Int)
	bmx_raylib_BeginScissorMode(x, y, width, height)
End Function

Function BeginScissorMode(x:Float, y:Float, width:Float, height:Float)
	bmx_raylib_BeginScissorMode(Int(x), Int(y), Int(width), Int(height))
End Function

Function EndScissorMode()
	bmx_raylib_EndScissorMode()
End Function

' Screen-space-related functions
Function GetMouseRay:RRay(mousePosition:RVector2, camera:RCamera)
	Return bmx_raylib_GetMouseRay(mousePosition, camera)
End Function

Function GetCameraMatrix:RMatrix(camera:RCamera)
	Return bmx_raylib_GetCameraMatrix(camera)
End Function

Function GetCameraMatrix2D:RMatrix(camera:RCamera2D)
	Return bmx_raylib_GetCameraMatrix2D(camera)
End Function

Function GetWorldToScreen:RVector2(position:RVector3, camera:RCamera)
	Return bmx_raylib_GetWorldToScreen(position, camera)
End Function

Function GetWorldToScreenEx:RVector2(position:RVector3, camera:RCamera, width:Int, height:Int)
	Return bmx_raylib_GetWorldToScreenEx(position, camera, width, height)
End Function

Function GetWorldToScreen2D:RVector2(position:RVector2, camera:RCamera2D)
	Return bmx_raylib_GetWorldToScreen2D(position, camera)
End Function

Function GetScreenToWorld2D:RVector2(position:RVector2, camera:RCamera2D)
	Return bmx_raylib_GetScreenToWorld2D(position, camera)
End Function


' Timing-related functions
Function SetTargetFPS(fps:Int)
	bmx_raylib_SetTargetFPS(fps)
End Function

Function GetFPS:Int()
	Return bmx_raylib_GetFPS()
End Function

Function GetFrameTime:Float()
	Return bmx_raylib_GetFrameTime()
End Function

Function GetTime:Double()
	Return bmx_raylib_GetTime()
End Function

' Text Drawing functions
Function DrawFPS(posX:Int, posY:Int)
	bmx_raylib_DrawFPS(posX, posY)
End Function

Function DrawText(txt:String, posX:Int, posY:Int, FontSize:Int, color:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawText(t, posX, posY, FontSize, color)
	MemFree(t)
End Function

Function DrawTextEx(font:RFont, txt:String, position:RVector2, FontSize:Float, spacing:Float, tint:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawTextEx(font, t, position, FontSize, spacing, tint)
	MemFree(t)
End Function

Function DrawTextRec(font:RFont, txt:String, rec:RRectangle, FontSize:Float, spacing:Float, wordWrap:Int, tint:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawTextRec(font, t, rec, FontSize, spacing, wordWrap, tint)
	MemFree(t)
End Function

Function DrawTextRecEx(font:RFont, txt:String, rec:RRectangle, FontSize:Float, spacing:Float, wordWrap:Int, tint:RColor, selectStart:Int, selectLength:Int, selectTint:RColor, selectBackTint:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawTextRecEx(font, t, rec, FontSize, spacing, wordWrap, tint, selectStart, selectLength, selectTint, selectBackTint)
	MemFree(t)
End Function

Function DrawTextCodepoint(font:RFont, codepoint:Int, position:RVector2, scale:Float, tint:RColor)
	bmx_raylib_DrawTextCodepoint(font, codepoint, position, scale, tint)
End Function


' Misc. functions
Function SetConfigFlags(flags:UInt)
	bmx_raylib_SetConfigFlags(flags)
End Function

Function TakeScreenshot(fileName:String)
	Local f:Byte Ptr = fileName.ToUTF8String()
	bmx_raylib_TakeScreenshot(f)
	MemFree(f)
End Function

Function GetRandomValue:Int(minimum:Int, maximum:Int)
	Return bmx_raylib_GetRandomValue(minimum, maximum)
End Function


Function DrawPixel(posX:Int, posY:Int, color:RColor)
	bmx_raylib_DrawPixel(posX, posY, color)
End Function

Function DrawPixelV(position:RVector2, color:RColor)
	bmx_raylib_DrawPixelV(position, color)
End Function

Function DrawLine(startPosX:Int, startPosY:Int, endPosX:Int, endPosY:Int, color:RColor)
	bmx_raylib_DrawLine(startPosX, startPosY, endPosX, endPosY, color)
End Function

Function DrawLineV(startPos:RVector2, endPos:RVector2, color:RColor)
	bmx_raylib_DrawLineV(startPos, endPos, color)
End Function

Function DrawLineEx(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawLineEx(startPos, endPos, thick, color)
End Function

Function DrawLineBezier(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawLineBezier(startPos, endPos, thick, color)
End Function

Function DrawLineStrip(points:RVector2 Ptr, numPoints:Int, color:RColor)
	bmx_raylib_DrawLineStrip(points, numPoints, color)
End Function

Function DrawCircle(centerX:Int, centerY:Int, radius:Float, color:RColor)
	bmx_raylib_DrawCircle(centerX, centerY, radius, color)
End Function

Function DrawCircleSector(center:RVector2, radius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawCircleSector(center, radius, startAngle, endAngle, segments, color)
End Function

Function DrawCircleSectorLines(center:RVector2, radius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawCircleSectorLines(center, radius, startAngle, endAngle, segments, color)
End Function

Function DrawCircleGradient(centerX:Int, centerY:Int, radius:Float, color1:RColor, color2:RColor)
	bmx_raylib_DrawCircleGradient(centerX, centerY, radius, color1, color2)
End Function

Function DrawCircleV(center:RVector2, radius:Float, color:RColor)
	bmx_raylib_DrawCircleV(center, radius, color)
End Function

Function DrawCircleLines(centerX:Int, centerY:Int, radius:Float, color:RColor)
	bmx_raylib_DrawCircleLines(centerX, centerY, radius, color)
End Function

Function DrawEllipse(centerX:Int, centerY:Int, radiusH:Float, radiusV:Float, color:RColor)
	bmx_raylib_DrawEllipse(centerX, centerY, radiusH, radiusV, color)
End Function

Function DrawEllipseLines(centerX:Int, centerY:Int, radiusH:Float, radiusV:Float, color:RColor)
	bmx_raylib_DrawEllipseLines(centerX, centerY, radiusH, radiusV, color)
End Function

Function DrawRing(center:RVector2, innerRadius:Float, outerRadius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawRing(center, innerRadius, outerRadius, startAngle, endAngle, segments, color:RColor)
End Function

Function DrawRingLines(center:RVector2, innerRadius:Float, outerRadius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawRingLines(center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
End Function

Function DrawRectangle(posX:Int, posY:Int, width:Int, height:Int, color:RColor)
	bmx_raylib_DrawRectangle(posX, posY, width, height, color)
End Function

Function DrawRectangleV(position:RVector2, size:RVector2, color:RColor)
	bmx_raylib_DrawRectangleV(position, size, color)
End Function

Function DrawRectangleRec(rec:RRectangle, color:RColor)
	bmx_raylib_DrawRectangleRec(rec, color)
End Function

Function DrawRectanglePro(rec:RRectangle, origin:RVector2, Rotation:Float, color:RColor)
	bmx_raylib_DrawRectanglePro(rec, origin, Rotation, color)
End Function

Function DrawRectangleGradientV(posX:Int, posY:Int, width:Int, height:Int, color1:RColor, color2:RColor)
	bmx_raylib_DrawRectangleGradientV(posX, posY, width, height, color1, color2)
End Function

Function DrawRectangleGradientH(posX:Int, posY:Int, width:Int, height:Int, color1:RColor, color2:RColor)
	bmx_raylib_DrawRectangleGradientH(posX, posY, width, height, color1, color2)
End Function

Function DrawRectangleGradientEx(rec:RRectangle, col1:RColor, col2:RColor, col3:RColor, col4:RColor)
	bmx_raylib_DrawRectangleGradientEx(rec, col1, col2, col3, col4)
End Function

Function DrawRectangleLines(posX:Int, posY:Int, width:Int, height:Int, color:RColor)
	bmx_raylib_DrawRectangleLines(posX, posY, width, height, color)
End Function

Function DrawRectangleLinesEx(rec:RRectangle, lineThick:Int, color:RColor)
	bmx_raylib_DrawRectangleLinesEx(rec, lineThick, color)
End Function

Function DrawRectangleRounded(rec:RRectangle, roundness:Float, segments:Int, color:RColor)
	bmx_raylib_DrawRectangleRounded(rec, roundness, segments, color)
End Function

Function DrawRectangleRoundedLines(rec:RRectangle, roundness:Float, segments:Int, lineThick:Int, color:RColor)
	bmx_raylib_DrawRectangleRoundedLines(rec, roundness, segments, lineThick, color)
End Function

Function DrawTriangle(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)
	bmx_raylib_DrawTriangle(v1, v2, v3, color)
End Function

Function DrawTriangleLines(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)
	bmx_raylib_DrawTriangleLines(v1, v2, v3, color)
End Function

Function DrawTriangleFan(points:RVector2 Ptr, numPoints:Int, color:RColor)
	bmx_raylib_DrawTriangleFan(points, numPoints, color)
End Function

Function DrawTriangleStrip(points:RVector2 Ptr, pointsCount:Int, color:RColor)
	bmx_raylib_DrawTriangleStrip(points, pointsCount, color)
End Function

Function DrawPoly(center:RVector2, sides:Int, radius:Float, Rotation:Float, color:RColor)
	bmx_raylib_DrawPoly(center, sides, radius, Rotation, color)
End Function

Function DrawPolyLines(center:RVector2, sides:Int, radius:Float, Rotation:Float, color:RColor)
	bmx_raylib_DrawPolyLines(center, sides, radius, Rotation, color)
End Function

' Basic shapes collision detection functions
Function CheckCollisionRecs:Int(rec1:RRectangle, rec2:RRectangle)
	Return bmx_raylib_CheckCollisionRecs(rec1, rec2)
End Function

Function CheckCollisionCircles:Int(center1:RVector2, radius1:Float, center2:RVector2, radius2:Float)
	Return bmx_raylib_CheckCollisionCircles(center1, radius1, center2, radius2)
End Function

Function CheckCollisionCircleRec:Int(center:RVector2, radius:Float, rec:RRectangle)
	Return bmx_raylib_CheckCollisionCircleRec(center, radius, rec)
End Function

Function GetCollisionRec:RRectangle(rec1:RRectangle, rec2:RRectangle)
	Return bmx_raylib_GetCollisionRec(rec1, rec2)
End Function

Function CheckCollisionPointRec:Int(point:RVector2, rec:RRectangle)
	Return bmx_raylib_CheckCollisionPointRec(point, rec)
End Function

Function CheckCollisionPointCircle:Int(point:RVector2, center:RVector2, radius:Float)
	Return bmx_raylib_CheckCollisionPointCircle(point, center, radius)
End Function

Function CheckCollisionPointTriangle:Int(point:RVector2, p1:RVector2, p2:RVector2, p3:RVector2)
	Return bmx_raylib_CheckCollisionPointTriangle(point, p1, p2, p3)
End Function


' Input-related functions: keyboard
Function IsKeyPressed:Int(key:Int)
	Return bmx_raylib_IsKeyPressed(key)
End Function

Function IsKeyDown:Int(key:Int)
	Return bmx_raylib_IsKeyDown(key)
End Function

Function IsKeyReleased:Int(key:Int)
	Return bmx_raylib_IsKeyReleased(key)
End Function

Function IsKeyUp:Int(key:Int)
	Return bmx_raylib_IsKeyUp(key)
End Function

Function SetExitKey(key:Int)
	bmx_raylib_SetExitKey(Key)
End Function

Function GetKeyPressed:Int()
	Return bmx_raylib_GetKeyPressed()
End Function

' Input-related functions: gamepads
Function IsGamepadAvailable:Int(gamepad:Int)
	Return bmx_raylib_IsGamepadAvailable(gamepad:Int)
End Function

Function IsGamepadName:Int(gamepad:Int, name:String)
	Local n:Byte Ptr = name.ToUTF8String()
	Local res:Int = bmx_raylib_IsGamepadName(gamepad:Int, n)
	MemFree(n)
	Return res
End Function

Function GetGamepadName:String(gamepad:Int)
	Return String.FromUTF8String(bmx_raylib_GetGamepadName(gamepad:Int))
End Function

Function IsGamepadButtonPressed:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonPressed(gamepad:Int, button:Int)
End Function

Function IsGamepadButtonDown:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonDown(gamepad:Int, button:Int)
End Function

Function IsGamepadButtonReleased:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonReleased(gamepad:Int, button:Int)
End Function

Function IsGamepadButtonUp:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonUp(gamepad:Int, button:Int)
End Function

Function GetGamepadButtonPressed:Int()
	Return bmx_raylib_GetGamepadButtonPressed()
End Function

Function GetGamepadAxisCount:Int(gamepad:Int)
	Return bmx_raylib_GetGamepadAxisCount(gamepad:Int)
End Function

Function GetGamepadAxisMovement:Float(gamepad:Int, axis:Int)
	Return bmx_raylib_GetGamepadAxisMovement(gamepad:Int, axis:Int)
End Function

' Input-related functions: mouse
Function IsMouseButtonPressed:Int(button:Int)
	Return bmx_raylib_IsMouseButtonPressed(button:Int)
End Function

Function IsMouseButtonDown:Int(button:Int)
	Return bmx_raylib_IsMouseButtonDown(button:Int)
End Function

Function IsMouseButtonReleased:Int(button:Int)
	Return bmx_raylib_IsMouseButtonReleased(button:Int)
End Function

Function IsMouseButtonUp:Int(button:Int)
	Return bmx_raylib_IsMouseButtonUp(button:Int)
End Function

Function GetMouseX:Int()
	Return bmx_raylib_GetMouseX()
End Function

Function GetMouseY:Int()
	Return bmx_raylib_GetMouseY()
End Function

Function GetMousePosition:RVector2()
	Return bmx_raylib_GetMousePosition()
End Function

Function SetMousePosition(x:Int, y:Int)
	bmx_raylib_SetMousePosition(x:Int, y:Int)
End Function

Function SetMouseOffset(offsetX:Int, offsetY:Int)
	bmx_raylib_SetMouseOffset(offsetX:Int, offsetY:Int)
End Function

Function SetMouseScale(scaleX:Float, scaleY:Float)
	bmx_raylib_SetMouseScale(scaleX:Float, scaleY:Float)
End Function

Function GetMouseWheelMove:Int()
	Return bmx_raylib_GetMouseWheelMove()
End Function

' Color-related functions
Function ColorToInt:Int(color:RColor)
	Return bmx_raylib_ColorToInt(color)
End Function

Function ColorNormalize:RVector4(color:RColor)
	Return bmx_raylib_ColorNormalize(color)
End Function

Function ColorFromNormalized:RColor(normalized:RVector4)
	Return bmx_raylib_ColorFromNormalized(normalized)
End Function

Function ColorToHSV:RVector3(color:RColor)
	Return bmx_raylib_ColorToHSV(color)
End Function

Function ColorFromHSV:RColor(hsv:RVector3)
	Return bmx_raylib_ColorFromHSV(hsv)
End Function

Function GetColor:RColor(hexValue:Int)
	Return bmx_raylib_GetColor(hexValue)
End Function

Function Fade:RColor(color:RColor, alpha:Float)
	Return bmx_raylib_Fade(color, alpha)
End Function



' Camera System Functions (Module: camera)
Function SetCameraMode(camera:RCamera, Mode:Int)
	bmx_raylib_SetCameraMode(camera, Mode)
End Function

Function UpdateCamera(camera:RCamera Var)
	bmx_raylib_UpdateCamera(camera)
End Function

Function SetCameraPanControl(panKey:Int)
	bmx_raylib_SetCameraPanControl(panKey)
End Function

Function SetCameraAltControl(altKey:Int)
	bmx_raylib_SetCameraAltControl(altKey)
End Function

Function SetCameraSmoothZoomControl(szKey:Int)
	bmx_raylib_SetCameraSmoothZoomControl(szKey)
End Function

Function SetCameraMoveControls(frontKey:Int, backKey:Int, rightKey:Int, leftKey:Int, upKey:Int, downKey:Int)
	bmx_raylib_SetCameraMoveControls(frontKey, backKey, rightKey, leftKey, upKey, downKey)
End Function

' Basic geometric 3D shapes drawing functions
Function DrawLine3D(startPos:RVector3, endPos:RVector3, color:RColor)
	bmx_raylib_DrawLine3D(startPos, endPos, color)
End Function

Function DrawPoint3D(position:RVector3, color:RColor)
	bmx_raylib_DrawPoint3D(position, color)
End Function

Function DrawCircle3D(center:RVector3, radius:Float, rotationAxis:RVector3, rotationAngle:Float, color:RColor)
	bmx_raylib_DrawCircle3D(center, radius, rotationAxis, rotationAngle, color)
End Function

Function DrawCube(position:RVector3, width:Float, height:Float, length:Float, color:RColor)
	bmx_raylib_DrawCube(position, width, height, length, color)
End Function

Function DrawCubeV(position:RVector3, size:RVector3, color:RColor)
	bmx_raylib_DrawCubeV(position, size, color)
End Function

Function DrawCubeWires(position:RVector3, width:Float, height:Float, length:Float, color:RColor)
	bmx_raylib_DrawCubeWires(position, width, height, length, color)
End Function

Function DrawCubeWiresV(position:RVector3, size:RVector3, color:RColor)
	bmx_raylib_DrawCubeWiresV(position, size, color)
End Function

Function DrawCubeTexture(texture:RTexture2D, position:RVector3, width:Float, height:Float, length:Float, color:RColor)
	bmx_raylib_DrawCubeTexture(texture, position, width, height, length, color)
End Function

Function DrawSphere(centerPos:RVector3, radius:Float, color:RColor)
	bmx_raylib_DrawSphere(centerPos, radius, color)
End Function

Function DrawSphereEx(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)
	bmx_raylib_DrawSphereEx(centerPos, radius, rings, slices, color)
End Function

Function DrawSphereWires(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)
	bmx_raylib_DrawSphereWires(centerPos, radius, rings, slices, color)
End Function

Function DrawCylinder(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)
	bmx_raylib_DrawCylinder(position, radiusTop, radiusBottom, height, slices, color)
End Function

Function DrawCylinderWires(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)
	bmx_raylib_DrawCylinderWires(position, radiusTop, radiusBottom, height, slices, color)
End Function

Function DrawPlane(centerPos:RVector3, size:RVector2, color:RColor)
	bmx_raylib_DrawPlane(centerPos, size, color)
End Function

Function DrawRay(ray:RRay, color:RColor)
	bmx_raylib_DrawRay(ray, color)
End Function

Function DrawGrid(slices:Int, spacing:Float)
	bmx_raylib_DrawGrid(slices, spacing)
End Function

Function DrawGizmo(position:RVector3)
	bmx_raylib_DrawGizmo(position)
End Function

' Image/Texture2D data loading/unloading/saving functions
Function LoadImage:RImage(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImage(f)
	MemFree(f)
	Return image
End Function

Function LoadImageEx:RImage(pixels:RColor Ptr, width:Int, height:Int)
	Return bmx_raylib_LoadImageEx(pixels, width, height)
End Function

Function LoadImagePro:RImage(data:Byte Ptr, width:Int, height:Int, format:Int)
	Return bmx_raylib_LoadImagePro(data, width, height, format)
End Function

Function LoadImageRaw:RImage(filename:String, width:Int, height:Int, format:Int, headerSize:Int)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImageRaw(f, width, height, format, headerSize)
	MemFree(f)
	Return image
End Function

Function ExportImage(image:RImage, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportImage(image, f)
	MemFree(f)
End Function

Function ExportImageAsCode(image:RImage, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportImageAsCode(image, f)
	MemFree(f)
End Function

Function LoadTexture:RTexture2D(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local texture:RTexture2D = bmx_raylib_LoadTexture(f)
	MemFree(f)
	Return texture
End Function

Function LoadTextureFromImage:RTexture2D(image:RImage)
	Return bmx_raylib_LoadTextureFromImage(image)
End Function

Function LoadRenderTexture:RRenderTexture2D(width:Int, height:Int)
	Return bmx_raylib_LoadRenderTexture(width, height)
End Function

Function LoadTextureCubemap:RTextureCubemap(image:RImage, layoutType:Int)
	Return bmx_raylib_LoadTextureCubemap(image, layoutType)
End Function

Function UnloadImage(image:RImage)
	bmx_raylib_UnloadImage(image)
End Function

Function UnloadTexture(texture:RTexture2D)
	bmx_raylib_UnloadTexture(texture)
End Function

Function UnloadRenderTexture(target:RRenderTexture2D)
	bmx_raylib_UnloadRenderTexture(target)
End Function

'Function GetImageData:RColor Ptr(image:RImage)
'	Return bmx_raylib_GetImageData(image)
'End Function

'Function GetImageDataNormalized:RVector4 Ptr(image:RImage)
'	Return bmx_raylib_GetImageDataNormalized(image)
'End Function

Function GetImageAlphaBorder:RRectangle(image:RImage, threshold:Float)
	Return bmx_raylib_GetImageAlphaBorder(image, threshold)
End Function

Function GetPixelDataSize:Int(width:Int, height:Int, format:Int)
	Return bmx_raylib_GetPixelDataSize(width, height, format)
End Function

Function GetTextureData:RImage(texture:RTexture2D)
	Return bmx_raylib_GetTextureData(texture)
End Function

Function GetScreenData:RImage()
	Return bmx_raylib_GetScreenData()
End Function

Function UpdateTexture(texture:RTexture2D, pixels:Byte Ptr)
	bmx_raylib_UpdateTexture(texture, pixels)
End Function

' Image generation functions
Function GenImageColor:RImage(width:Int, height:Int, color:RColor)
	Return bmx_raylib_GenImageColor(width:Int, height:Int, color:RColor)
End Function

Function GenImageGradientV:RImage(width:Int, height:Int, top:RColor, bottom:RColor)
	Return bmx_raylib_GenImageGradientV(width:Int, height:Int, top:RColor, bottom:RColor)
End Function

Function GenImageGradientH:RImage(width:Int, height:Int, Left:RColor, Right:RColor)
	Return bmx_raylib_GenImageGradientH(width:Int, height:Int, Left:RColor, Right:RColor)
End Function

Function GenImageGradientRadial:RImage(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)
	Return bmx_raylib_GenImageGradientRadial(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)
End Function

Function GenImageChecked:RImage(width:Int, height:Int, checksX:Int, checksY:Int, col1:RColor, col2:RColor)
	Return bmx_raylib_GenImageChecked(width:Int, height:Int, checksX:Int, checksY:Int, col1:RColor, col2:RColor)
End Function

Function GenImageWhiteNoise:RImage(width:Int, height:Int, factor:Float)
	Return bmx_raylib_GenImageWhiteNoise(width:Int, height:Int, factor:Float)
End Function

Function GenImagePerlinNoise:RImage(width:Int, height:Int, offsetX:Int, offsetY:Int, scale:Float)
	Return bmx_raylib_GenImagePerlinNoise(width:Int, height:Int, offsetX:Int, offsetY:Int, scale:Float)
End Function

Function GenImageCellular:RImage(width:Int, height:Int, tileSize:Int)
	Return bmx_raylib_GenImageCellular(width:Int, height:Int, tileSize:Int)
End Function


' Texture2D configuration functions
Function GenTextureMipmaps(texture:RTexture2D Var)
	bmx_raylib_GenTextureMipmaps(texture)
End Function

Function SetTextureFilter(texture:RTexture2D, filterMode:Int)
	bmx_raylib_SetTextureFilter(texture, filterMode)
End Function

Function SetTextureWrap(texture:RTexture2D, wrapMode:Int)
	bmx_raylib_SetTextureWrap(texture, wrapMode)
End Function

' Texture2D drawing functions
Function DrawTexture(texture:RTexture2D, posX:Int, posY:Int, tint:RColor)
	bmx_raylib_DrawTexture(texture, posX, posY, tint)
End Function

Function DrawTextureV(texture:RTexture2D, position:RVector2, tint:RColor)
	bmx_raylib_DrawTextureV(texture, position, tint)
End Function

Function DrawTextureEx(texture:RTexture2D, position:RVector2, Rotation:Float, scale:Float, tint:RColor)
	bmx_raylib_DrawTextureEx(texture, position, Rotation, scale, tint)
End Function

Function DrawTextureRec(texture:RTexture2D, sourceRec:RRectangle, position:RVector2, tint:RColor)
	bmx_raylib_DrawTextureRec(texture, sourceRec, position, tint)
End Function

Function DrawTextureQuad(texture:RTexture2D, tiling:RVector2, offset:RVector2, quad:RRectangle, tint:RColor)
	bmx_raylib_DrawTextureQuad(texture, tiling, offset, quad, tint)
End Function

Function DrawTexturePro(texture:RTexture2D, sourceRec:RRectangle, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)
	bmx_raylib_DrawTexturePro(texture, sourceRec, destRec, origin, Rotation, tint)
End Function

Function DrawTextureNPatch(texture:RTexture2D, nPatchInfo:RNPatchInfo, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)
	bmx_raylib_DrawTextureNPatch(texture, nPatchInfo, destRec, origin, Rotation, tint)
End Function

' Input-related functions: touch
Function GetTouchX:Int()
	Return bmx_raylib_GetTouchX()
End Function

Function GetTouchY:Int()
	Return bmx_raylib_GetTouchY()
End Function

Function GetTouchPosition:RVector2(index:Int)
	Return bmx_raylib_GetTouchPosition(index)
End Function

' Gestures and Touch Handling Functions (Module: gestures)
Function SetGesturesEnabled(gestureFlags:UInt)
	bmx_raylib_SetGesturesEnabled(gestureFlags)
End Function

Function IsGestureDetected:Int(gesture:Int)
	Return bmx_raylib_IsGestureDetected(gesture)
End Function

Function GetGestureDetected:Int()
	Return bmx_raylib_GetGestureDetected()
End Function

Function GetTouchPointsCount:Int()
	Return bmx_raylib_GetTouchPointsCount()
End Function

Function GetGestureHoldDuration:Float()
	Return bmx_raylib_GetGestureHoldDuration()
End Function

Function GetGestureDragVector:RVector2()
	Return bmx_raylib_GetGestureDragVector()
End Function

Function GetGestureDragAngle:Float()
	Return bmx_raylib_GetGestureDragAngle()
End Function

Function GetGesturePinchVector:RVector2()
	Return bmx_raylib_GetGesturePinchVector()
End Function

Function GetGesturePinchAngle:Float()
	Return bmx_raylib_GetGesturePinchAngle()
End Function

' Model loading/unloading functions
Function LoadModel:RModel(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local model:RModel = bmx_raylib_LoadModel(f)
	MemFree(f)
	Return model
End Function

Function LoadModelFromMesh:RModel(mesh:RMesh)
	Return bmx_raylib_LoadModelFromMesh(mesh)
End Function

Function UnloadModel(model:RModel)
	bmx_raylib_UnloadModel(model)
End Function

' Mesh generation functions
Function GenMeshPoly:RMesh(sides:Int, radius:Float)
	Return bmx_raylib_GenMeshPoly(sides, radius)
End Function

Function GenMeshPlane:RMesh(width:Float, length:Float, resX:Int, resZ:Int)
	Return bmx_raylib_GenMeshPlane(width, length, resX, resZ)
End Function

Function GenMeshCube:RMesh(width:Float, height:Float, length:Float)
	Return bmx_raylib_GenMeshCube(width, height, length)
End Function

Function GenMeshSphere:RMesh(radius:Float, rings:Int, slices:Int)
	Return bmx_raylib_GenMeshSphere(radius, rings, slices)
End Function

Function GenMeshHemiSphere:RMesh(radius:Float, rings:Int, slices:Int)
	Return bmx_raylib_GenMeshHemiSphere(radius, rings, slices)
End Function

Function GenMeshCylinder:RMesh(radius:Float, height:Float, slices:Int)
	Return bmx_raylib_GenMeshCylinder(radius, height, slices)
End Function

Function GenMeshTorus:RMesh(radius:Float, size:Float, radSeg:Int, sides:Int)
	Return bmx_raylib_GenMeshTorus(radius, size, radSeg, sides)
End Function

Function GenMeshKnot:RMesh(radius:Float, size:Float, radSeg:Int, sides:Int)
	Return bmx_raylib_GenMeshKnot(radius, size, radSeg, sides)
End Function

Function GenMeshHeightmap:RMesh(heightmap:RImage, size:RVector3)
	Return bmx_raylib_GenMeshHeightmap(heightmap, size)
End Function

Function GenMeshCubicmap:RMesh(cubicmap:RImage, cubeSize:RVector3)
	Return bmx_raylib_GenMeshCubicmap(cubicmap, cubeSize)
End Function


' Mesh manipulation functions
Function MeshBoundingBox:RBoundingBox(mesh:RMesh)
	Return bmx_raylib_MeshBoundingBox(mesh)
End Function

Function MeshTangents(mesh:RMesh Var)
	bmx_raylib_MeshTangents(mesh)
End Function

Function MeshBinormals(mesh:RMesh Var)
	bmx_raylib_MeshBinormals(mesh)
End Function


' Model drawing functions
Function DrawModel(model:RModel, position:RVector3, scale:Float, tint:RColor)
	bmx_raylib_DrawModel(model, position, scale, tint)
End Function

Function DrawModelEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)
	bmx_raylib_DrawModelEx(model, position, rotationAxis, rotationAngle, scale, tint)
End Function

Function DrawModelWires(model:RModel, position:RVector3, scale:Float, tint:RColor)
	bmx_raylib_DrawModelWires(model, position, scale, tint)
End Function

Function DrawModelWiresEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)
	bmx_raylib_DrawModelWiresEx(model, position, rotationAxis, rotationAngle, scale, tint)
End Function

Function DrawBoundingBox(box:RBoundingBox, color:RColor)
	bmx_raylib_DrawBoundingBox(box, color)
End Function

Function DrawBillboard(camera:RCamera, texture:RTexture2D, center:RVector3, size:Float, tint:RColor)
	bmx_raylib_DrawBillboard(camera, texture, center, size, tint)
End Function

Function DrawBillboardRec(camera:RCamera, texture:RTexture2D, sourceRec:RRectangle, center:RVector3, size:Float, tint:RColor)
	bmx_raylib_DrawBillboardRec(camera, texture, sourceRec, center, size, tint)
End Function

' Text misc. functions
Function MeasureText:Int(txt:String, FontSize:Int)
	Local t:Byte Ptr = txt.ToUTF8String()
	Local res:Int = bmx_raylib_MeasureText(t, FontSize)
	MemFree(t)
	Return res
End Function

Function MeasureTextEx:RVector2(font:RFont, txt:String, FontSize:Float, spacing:Float)
	Local t:Byte Ptr = txt.ToUTF8String()
	Local res:RVector2 = bmx_raylib_MeasureTextEx(font, txt, FontSize, spacing)
	MemFree(t)
	Return res
End Function

Function GetGlyphIndex:Int(font:RFont, codepoint:Int)
	Return bmx_raylib_GetGlyphIndex(font, codepoint)
End Function

' Linear Easing functions
Function EaseLinearNone:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return c * t / d + b
End Function 

Function EaseLinearIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return c * t / d + b
End Function

Function EaseLinearOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return c * t / d + b
End Function

Function EaseLinearInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return c * t / d + b
End Function

' Sine Easing functions
Function EaseSineIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseSineIn(t, b, c, d)
End Function

Function EaseSineOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseSineOut(t, b, c, d)
End Function

Function EaseSineInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseSineInOut(t, b, c, d)
End Function

' Circular Easing functions
Function EaseCircIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseCircIn(t, b, c, d)
End Function

Function EaseCircOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseCircOut(t, b, c, d)
End Function

Function EaseCircInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseCircInOut(t, b, c, d)
End Function

' Cubic Easing functions
Function EaseCubicIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	t :/ d
	Return c * t * t * t + b
End Function

Function EaseCubicOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	t = t / d - 1.0
	Return c * (t * t * t + 1.0) + b
End Function

Function EaseCubicInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	t :/ d / 2.0
	If t < 1.0 Then
		Return c / 2.0 * t * t * t + b
	End If
    t :- 2.0
	Return c / 2.0 * (t * t * t + 2.0) + b
End Function

' Quadratic Easing functions
Function EaseQuadIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	t :/ d
	Return c * t * t + b
End Function

Function EaseQuadOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	t :/ d
	Return -c * t * (t - 2.0) + b
End Function

Function EaseQuadInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	t :/ d / 2.0
	If t < 1 Then
		Return ((c / 2) * (t * t)) + b
	End If
    Return -c / 2.0 * (((t - 1.0) * (t - 3.0)) - 1.0) + b
End Function

' Exponential Easing functions
Function EaseExpoIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseExpoIn(t, b, c, d)
End Function

Function EaseExpoOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseExpoOut(t, b, c, d)
End Function

Function EaseExpoInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseExpoInOut(t, b, c, d)
End Function

' Back Easing functions
Function EaseBackIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseBackIn(t, b, c, d)
End Function

Function EaseBackOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseBackOut(t, b, c, d)
End Function

Function EaseBackInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseBackInOut(t, b, c, d)
End Function

' Bounce Easing functions
Function EaseBounceOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseBounceOut(t, b, c, d)
End Function

Function EaseBounceIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseBounceIn(t, b, c, d)
End Function

Function EaseBounceInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseBounceInOut(t, b, c, d)
End Function

' Elastic Easing functions
Function EaseElasticIn:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseElasticIn(t, b, c, d)
End Function

Function EaseElasticOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseElasticOut(t, b, c, d)
End Function

Function EaseElasticInOut:Float(t:Float, b:Float, c:Float, d:Float) Inline
	Return bmx_raylib_EaseElasticInOut(t, b, c, d)
End Function


' Image manipulation functions
Function ImageCopy:RImage(image:RImage)
	Return bmx_raylib_ImageCopy(image)
End Function

Function ImageFromImage:RImage(image:RImage, rec:RRectangle)
	Return bmx_raylib_ImageFromImage(image, rec)
End Function

Function ImageToPOT(image:RImage Var, fillColor:RColor)
	bmx_raylib_ImageToPOT(image, fillColor)
End Function

Function ImageFormat(image:RImage Var, newFormat:Int)
	bmx_raylib_ImageFormat(image, newFormat)
End Function

Function ImageAlphaMask(image:RImage Var, alphaMask:RImage)
	bmx_raylib_ImageAlphaMask(image, alphaMask)
End Function

Function ImageAlphaClear(image:RImage Var, color:RColor, threshold:Float)
	bmx_raylib_ImageAlphaClear(image, color, threshold)
End Function

Function ImageAlphaCrop(image:RImage Var, threshold:Float)
	bmx_raylib_ImageAlphaCrop(image, threshold)
End Function

Function ImageAlphaPremultiply(image:RImage Var)
	bmx_raylib_ImageAlphaPremultiply(image)
End Function

Function ImageCrop(image:RImage Var, crop:RRectangle)
	bmx_raylib_ImageCrop(image, crop)
End Function

Function ImageResize(image:RImage Var, newWidth:Int, newHeight:Int)
	bmx_raylib_ImageResize(image, newWidth, newHeight)
End Function

Function ImageResizeNN(image:RImage Var, newWidth:Int, newHeight:Int)
	bmx_raylib_ImageResizeNN(image, newWidth, newHeight)
End Function

Function ImageResizeCanvas(image:RImage Var, newWidth:Int, newHeight:Int, offsetX:Int, offsetY:Int, color:RColor)
	bmx_raylib_ImageResizeCanvas(image, newWidth, newHeight, offsetX, offsetY, color)
End Function

Function ImageMipmaps(image:RImage Var)
	bmx_raylib_ImageMipmaps(image)
End Function

Function ImageDither(image:RImage Var, rBpp:Int, gBpp:Int, bBpp:Int, aBpp:Int)
	bmx_raylib_ImageDither(image, rBpp, gBpp, bBpp, aBpp)
End Function

'Function ImageExtractPalette:RColor Ptr(image:RImage, maxPaletteSize:Int, extractCount:Int Ptr)

Function ImageText:RImage(txt:String, FontSize:Int, color:RColor)
	Return bmx_raylib_ImageText(txt, FontSize, color)
End Function

Function ImageTextEx:RImage(font:RFont, txt:String, FontSize:Float, spacing:Float, tint:RColor)
	Return bmx_raylib_ImageTextEx(font, txt, FontSize, spacing, tint)
End Function

Function ImageDraw(dst:RImage Var, src:RImage, srcRec:RRectangle, dstRec:RRectangle, tint:RColor)
	bmx_raylib_ImageDraw(dst, src, srcRec, dstRec, tint)
End Function

Function ImageDrawRectangle(dst:RImage Var, rec:RRectangle, color:RColor)
	bmx_raylib_ImageDrawRectangle(dst, rec, color)
End Function

Function ImageDrawRectangleLines(dst:RImage Var, rec:RRectangle, thick:Int, color:RColor)
	bmx_raylib_ImageDrawRectangleLines(dst, rec, thick, color)
End Function

Function ImageDrawText(dst:RImage Var, position:RVector2, txt:String, FontSize:Int, color:RColor)
	bmx_raylib_ImageDrawText(dst, position, txt, FontSize, color)
End Function

Function ImageDrawTextEx(dst:RImage Var, position:RVector2, font:RFont, txt:String, FontSize:Float, spacing:Float, color:RColor)
	bmx_raylib_ImageDrawTextEx(dst, position, font, txt, FontSize, spacing, color)
End Function

Function ImageFlipVertical(image:RImage Var)
	bmx_raylib_ImageFlipVertical(image)
End Function

Function ImageFlipHorizontal(image:RImage Var)
	bmx_raylib_ImageFlipHorizontal(image)
End Function

Function ImageRotateCW(image:RImage Var)
	bmx_raylib_ImageRotateCW(image)
End Function

Function ImageRotateCCW(image:RImage Var)
	bmx_raylib_ImageRotateCCW(image)
End Function

Function ImageColorTint(image:RImage Var, color:RColor)
	bmx_raylib_ImageColorTint(image, color)
End Function

Function ImageColorInvert(image:RImage Var)
	bmx_raylib_ImageColorInvert(image)
End Function

Function ImageColorGrayscale(image:RImage Var)
	bmx_raylib_ImageColorGrayscale(image)
End Function

Function ImageColorContrast(image:RImage Var, contrast:Float)
	bmx_raylib_ImageColorContrast(image, contrast)
End Function

Function ImageColorBrightness(image:RImage Var, brightness:Int)
	bmx_raylib_ImageColorBrightness(image, brightness)
End Function

Function ImageColorReplace(image:RImage Var, color:RColor, Replace:RColor)
	bmx_raylib_ImageColorReplace(image, color, Replace)
End Function
