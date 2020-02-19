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
Rem
bbdoc: Shows cursor.
End Rem
Function ShowCursor()
	bmx_raylib_ShowCursor()
End Function

Rem
bbdoc: Hides cursor.
End Rem
Function HideCursor()
	bmx_raylib_HideCursor()
End Function

Rem
bbdoc: Checks if cursor is not visible.
End Rem
Function IsCursorHidden:Int()
	Return bmx_raylib_IsCursorHidden()
End Function

Rem
bbdoc: Enables cursor (unlock cursor).
End Rem
Function EnableCursor()
	bmx_raylib_EnableCursor()
End Function

Rem
bbdoc: Disables cursor (lock cursor).
End Rem
Function DisableCursor()
	bmx_raylib_DisableCursor()
End Function

' Drawing-related functions
Rem
bbdoc: Sets background color (framebuffer clear color).
End Rem
Function ClearBackground(color:RColor)
	bmx_raylib_ClearBackground(color)
End Function

Rem
bbdoc: Sets up canvas (framebuffer) to start drawing.
End Rem
Function BeginDrawing()
	bmx_raylib_BeginDrawing()
End Function

Rem
bbdoc: Ends canvas drawing and swap buffers (double buffering).
End Rem
Function EndDrawing()
	bmx_raylib_EndDrawing()
End Function

Rem
bbdoc: Initializes 2D mode with custom camera (2D).
End Rem
Function BeginMode2D(camera:RCamera2D)
	bmx_raylib_BeginMode2D(camera)
End Function

Rem
bbdoc: Ends 2D mode with custom camera.
End Rem
Function EndMode2D()
	bmx_raylib_EndMode2D()
End Function

Rem
bbdoc: Initializes 3D mode with custom camera (3D).
End Rem
Function BeginMode3D(camera:RCamera)
	bmx_raylib_BeginMode3D(camera)
End Function

Rem
bbdoc: Ends 3D mode and returns to default 2D orthographic mode.
End Rem
Function EndMode3D()
	bmx_raylib_EndMode3D()
End Function

Rem
bbdoc: Initializes render texture for drawing.
End Rem
Function BeginTextureMode(target:RRenderTexture2D)
	bmx_raylib_BeginTextureMode(target)
End Function

Rem
bbdoc: Ends drawing to render texture.
End Rem
Function EndTextureMode()
	bmx_raylib_EndTextureMode()
End Function

Rem
bbdoc: Begins scissor mode (define screen area for following drawing).
End Rem
Function BeginScissorMode(x:Int, y:Int, width:Int, height:Int)
	bmx_raylib_BeginScissorMode(x, y, width, height)
End Function

Rem
bbdoc: Begins scissor mode (define screen area for following drawing).
End Rem
Function BeginScissorMode(x:Float, y:Float, width:Float, height:Float)
	bmx_raylib_BeginScissorMode(Int(x), Int(y), Int(width), Int(height))
End Function

Rem
bbdoc: Ends scissor mode.
End Rem
Function EndScissorMode()
	bmx_raylib_EndScissorMode()
End Function

' Screen-space-related functions
Rem
bbdoc: Returns a ray trace from mouse position.
End Rem
Function GetMouseRay:RRay(mousePosition:RVector2, camera:RCamera)
	Return bmx_raylib_GetMouseRay(mousePosition, camera)
End Function

Rem
bbdoc: Returns camera transform matrix (view matrix).
End Rem
Function GetCameraMatrix:RMatrix(camera:RCamera)
	Return bmx_raylib_GetCameraMatrix(camera)
End Function

Rem
bbdoc: Returns camera 2d transform matrix.
End Rem
Function GetCameraMatrix2D:RMatrix(camera:RCamera2D)
	Return bmx_raylib_GetCameraMatrix2D(camera)
End Function

Rem
bbdoc: Returns the screen space position for a 3d world space position.
End Rem
Function GetWorldToScreen:RVector2(position:RVector3, camera:RCamera)
	Return bmx_raylib_GetWorldToScreen(position, camera)
End Function

Rem
bbdoc: Returns size position for a 3d world space position.
End Rem
Function GetWorldToScreenEx:RVector2(position:RVector3, camera:RCamera, width:Int, height:Int)
	Return bmx_raylib_GetWorldToScreenEx(position, camera, width, height)
End Function

Rem
bbdoc: Returns the screen space position for a 2d camera world space position.
End Rem
Function GetWorldToScreen2D:RVector2(position:RVector2, camera:RCamera2D)
	Return bmx_raylib_GetWorldToScreen2D(position, camera)
End Function

Rem
bbdoc: Returns the world space position for a 2d camera screen space position.
End Rem
Function GetScreenToWorld2D:RVector2(position:RVector2, camera:RCamera2D)
	Return bmx_raylib_GetScreenToWorld2D(position, camera)
End Function


' Timing-related functions
Rem
bbdoc: Sets target FPS (maximum).
End Rem
Function SetTargetFPS(fps:Int)
	bmx_raylib_SetTargetFPS(fps)
End Function

Rem
bbdoc: Returns current FPS.
End Rem
Function GetFPS:Int()
	Return bmx_raylib_GetFPS()
End Function

Rem
bbdoc: Returns time in seconds for last frame drawn.
End Rem
Function GetFrameTime:Float()
	Return bmx_raylib_GetFrameTime()
End Function

Rem
bbdoc: Returns elapsed time in seconds since InitWindow().
End Rem
Function GetTime:Double()
	Return bmx_raylib_GetTime()
End Function

' Text Drawing functions
Rem
bbdoc: Shows current FPS.
End Rem
Function DrawFPS(posX:Int, posY:Int)
	bmx_raylib_DrawFPS(posX, posY)
End Function

Rem
bbdoc: Draws text (using default font).
End Rem
Function DrawText(txt:String, posX:Int, posY:Int, FontSize:Int, color:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawText(t, posX, posY, FontSize, color)
	MemFree(t)
End Function

Rem
bbdoc: Draws text using font and additional parameters.
End Rem
Function DrawTextEx(font:RFont, txt:String, position:RVector2, FontSize:Float, spacing:Float, tint:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawTextEx(font, t, position, FontSize, spacing, tint)
	MemFree(t)
End Function

Rem
bbdoc: Draw text using font inside rectangle limits.
End Rem
Function DrawTextRec(font:RFont, txt:String, rec:RRectangle, FontSize:Float, spacing:Float, wordWrap:Int, tint:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawTextRec(font, t, rec, FontSize, spacing, wordWrap, tint)
	MemFree(t)
End Function

Rem
bbdoc: Draws text using font inside rectangle limits with support for text selection.
End Rem
Function DrawTextRecEx(font:RFont, txt:String, rec:RRectangle, FontSize:Float, spacing:Float, wordWrap:Int, tint:RColor, selectStart:Int, selectLength:Int, selectTint:RColor, selectBackTint:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawTextRecEx(font, t, rec, FontSize, spacing, wordWrap, tint, selectStart, selectLength, selectTint, selectBackTint)
	MemFree(t)
End Function

Rem
bbdoc: Draws one character (codepoint).
End Rem
Function DrawTextCodepoint(font:RFont, codepoint:Int, position:RVector2, scale:Float, tint:RColor)
	bmx_raylib_DrawTextCodepoint(font, codepoint, position, scale, tint)
End Function


' Misc. functions
Rem
bbdoc: Sets up window configuration flags (view FLAGS)
End Rem
Function SetConfigFlags(flags:UInt)
	bmx_raylib_SetConfigFlags(flags)
End Function

Rem
bbdoc: Takes a screenshot of current screen (saved a .png)
End Rem
Function TakeScreenshot(fileName:String)
	Local f:Byte Ptr = fileName.ToUTF8String()
	bmx_raylib_TakeScreenshot(f)
	MemFree(f)
End Function

Rem
bbdoc: Returns a random value between min and max (both included).
End Rem
Function GetRandomValue:Int(minimum:Int, maximum:Int)
	Return bmx_raylib_GetRandomValue(minimum, maximum)
End Function

Rem
bbdoc: Returns a random value between min and max (both included).
End Rem
Function GetRandomValue:Int(minimum:Float, maximum:Float)
	Return bmx_raylib_GetRandomValue(Int(minimum), Int(maximum))
End Function

' Basic shapes drawing functions
Rem
bbdoc: Draws a pixel.
End Rem
Function DrawPixel(posX:Int, posY:Int, color:RColor)
	bmx_raylib_DrawPixel(posX, posY, color)
End Function

Rem
bbdoc: Draws a pixel (Vector version)
End Rem
Function DrawPixelV(position:RVector2, color:RColor)
	bmx_raylib_DrawPixelV(position, color)
End Function

Rem
bbdoc: Draws a line.
End Rem
Function DrawLine(startPosX:Int, startPosY:Int, endPosX:Int, endPosY:Int, color:RColor)
	bmx_raylib_DrawLine(startPosX, startPosY, endPosX, endPosY, color)
End Function

Rem
bbdoc: Draws a line (Vector version)
End Rem
Function DrawLineV(startPos:RVector2, endPos:RVector2, color:RColor)
	bmx_raylib_DrawLineV(startPos, endPos, color)
End Function

Rem
bbdoc: Draw a line defining thickness.
End Rem
Function DrawLineEx(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawLineEx(startPos, endPos, thick, color)
End Function

Rem
bbdoc: Draws a line using cubic-bezier curves in-out.
End Rem
Function DrawLineBezier(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawLineBezier(startPos, endPos, thick, color)
End Function

Rem
bbdoc: Draws lines sequence.
End Rem
Function DrawLineStrip(points:RVector2 Ptr, numPoints:Int, color:RColor)
	bmx_raylib_DrawLineStrip(points, numPoints, color)
End Function

Rem
bbdoc: Draws a color-filled circle.
End Rem
Function DrawCircle(centerX:Int, centerY:Int, radius:Float, color:RColor)
	bmx_raylib_DrawCircle(centerX, centerY, radius, color)
End Function

Rem
bbdoc: Draws a piece of a circle.
End Rem
Function DrawCircleSector(center:RVector2, radius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawCircleSector(center, radius, startAngle, endAngle, segments, color)
End Function

Rem
bbdoc: Draws circle sector outline.
End Rem
Function DrawCircleSectorLines(center:RVector2, radius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawCircleSectorLines(center, radius, startAngle, endAngle, segments, color)
End Function

Rem
bbdoc: Draws a gradient-filled circle.
End Rem
Function DrawCircleGradient(centerX:Int, centerY:Int, radius:Float, color1:RColor, color2:RColor)
	bmx_raylib_DrawCircleGradient(centerX, centerY, radius, color1, color2)
End Function

Rem
bbdoc: Draws a color-filled circle (Vector version)
End Rem
Function DrawCircleV(center:RVector2, radius:Float, color:RColor)
	bmx_raylib_DrawCircleV(center, radius, color)
End Function

Rem
bbdoc: Draws circle outline.
End Rem
Function DrawCircleLines(centerX:Int, centerY:Int, radius:Float, color:RColor)
	bmx_raylib_DrawCircleLines(centerX, centerY, radius, color)
End Function

Rem
bbdoc: Draws an ellipse.
End Rem
Function DrawEllipse(centerX:Int, centerY:Int, radiusH:Float, radiusV:Float, color:RColor)
	bmx_raylib_DrawEllipse(centerX, centerY, radiusH, radiusV, color)
End Function

Rem
bbdoc: Draws ellipse outline.
End Rem
Function DrawEllipseLines(centerX:Int, centerY:Int, radiusH:Float, radiusV:Float, color:RColor)
	bmx_raylib_DrawEllipseLines(centerX, centerY, radiusH, radiusV, color)
End Function

Rem
bbdoc: Draws a ring.
End Rem
Function DrawRing(center:RVector2, innerRadius:Float, outerRadius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawRing(center, innerRadius, outerRadius, startAngle, endAngle, segments, color:RColor)
End Function

Rem
bbdoc: Draws ring outline.
End Rem
Function DrawRingLines(center:RVector2, innerRadius:Float, outerRadius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)
	bmx_raylib_DrawRingLines(center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
End Function

Rem
bbdoc: Draws a color-filled rectangle.
End Rem
Function DrawRectangle(posX:Int, posY:Int, width:Int, height:Int, color:RColor)
	bmx_raylib_DrawRectangle(posX, posY, width, height, color)
End Function

Rem
bbdoc: Draws a color-filled rectangle (Vector version)
End Rem
Function DrawRectangleV(position:RVector2, size:RVector2, color:RColor)
	bmx_raylib_DrawRectangleV(position, size, color)
End Function

Rem
bbdoc: Draws a color-filled rectangle.
End Rem
Function DrawRectangleRec(rec:RRectangle, color:RColor)
	bmx_raylib_DrawRectangleRec(rec, color)
End Function

Rem
bbdoc: Draws a color-filled rectangle with pro parameters.
End Rem
Function DrawRectanglePro(rec:RRectangle, origin:RVector2, Rotation:Float, color:RColor)
	bmx_raylib_DrawRectanglePro(rec, origin, Rotation, color)
End Function

Rem
bbdoc: Draws a vertical-gradient-filled rectangle.
End Rem
Function DrawRectangleGradientV(posX:Int, posY:Int, width:Int, height:Int, color1:RColor, color2:RColor)
	bmx_raylib_DrawRectangleGradientV(posX, posY, width, height, color1, color2)
End Function

Rem
bbdoc: Draws a horizontal-gradient-filled rectangle.
End Rem
Function DrawRectangleGradientH(posX:Int, posY:Int, width:Int, height:Int, color1:RColor, color2:RColor)
	bmx_raylib_DrawRectangleGradientH(posX, posY, width, height, color1, color2)
End Function

Rem
bbdoc: Draws a gradient-filled rectangle with custom vertex colors.
End Rem
Function DrawRectangleGradientEx(rec:RRectangle, col1:RColor, col2:RColor, col3:RColor, col4:RColor)
	bmx_raylib_DrawRectangleGradientEx(rec, col1, col2, col3, col4)
End Function

Rem
bbdoc: Draws rectangle outline.
End Rem
Function DrawRectangleLines(posX:Int, posY:Int, width:Int, height:Int, color:RColor)
	bmx_raylib_DrawRectangleLines(posX, posY, width, height, color)
End Function

Rem
bbdoc: Draws rectangle outline with extended parameters.
End Rem
Function DrawRectangleLinesEx(rec:RRectangle, lineThick:Int, color:RColor)
	bmx_raylib_DrawRectangleLinesEx(rec, lineThick, color)
End Function

Rem
bbdoc: Draws a rectangle with rounded edges.
End Rem
Function DrawRectangleRounded(rec:RRectangle, roundness:Float, segments:Int, color:RColor)
	bmx_raylib_DrawRectangleRounded(rec, roundness, segments, color)
End Function

Rem
bbdoc: Draws a rectangle with rounded edges outline.
End Rem
Function DrawRectangleRoundedLines(rec:RRectangle, roundness:Float, segments:Int, lineThick:Int, color:RColor)
	bmx_raylib_DrawRectangleRoundedLines(rec, roundness, segments, lineThick, color)
End Function

Rem
bbdoc: Draws a color-filled triangle (vertex in counter-clockwise order!)
End Rem
Function DrawTriangle(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)
	bmx_raylib_DrawTriangle(v1, v2, v3, color)
End Function

Rem
bbdoc: Draws triangle outline (vertex in counter-clockwise order!).
End Rem
Function DrawTriangleLines(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)
	bmx_raylib_DrawTriangleLines(v1, v2, v3, color)
End Function

Rem
bbdoc: Draws a triangle fan defined by points (first vertex is the center)
End Rem
Function DrawTriangleFan(points:RVector2 Ptr, numPoints:Int, color:RColor)
	bmx_raylib_DrawTriangleFan(points, numPoints, color)
End Function

Rem
bbdoc: Draws a triangle strip defined by points.
End Rem
Function DrawTriangleStrip(points:RVector2 Ptr, pointsCount:Int, color:RColor)
	bmx_raylib_DrawTriangleStrip(points, pointsCount, color)
End Function

Rem
bbdoc: Draws a regular polygon (Vector version)
End Rem
Function DrawPoly(center:RVector2, sides:Int, radius:Float, Rotation:Float, color:RColor)
	bmx_raylib_DrawPoly(center, sides, radius, Rotation, color)
End Function

Rem
bbdoc: Draws a polygon outline of n sides.
End Rem
Function DrawPolyLines(center:RVector2, sides:Int, radius:Float, Rotation:Float, color:RColor)
	bmx_raylib_DrawPolyLines(center, sides, radius, Rotation, color)
End Function

' Basic shapes collision detection functions
Rem
bbdoc: Checks collision between two rectangles.
End Rem
Function CheckCollisionRecs:Int(rec1:RRectangle, rec2:RRectangle)
	Return bmx_raylib_CheckCollisionRecs(rec1, rec2)
End Function

Rem
bbdoc: Checks collision between two circles.
End Rem
Function CheckCollisionCircles:Int(center1:RVector2, radius1:Float, center2:RVector2, radius2:Float)
	Return bmx_raylib_CheckCollisionCircles(center1, radius1, center2, radius2)
End Function

Rem
bbdoc: Checks collision between circle and rectangle.
End Rem
Function CheckCollisionCircleRec:Int(center:RVector2, radius:Float, rec:RRectangle)
	Return bmx_raylib_CheckCollisionCircleRec(center, radius, rec)
End Function

Rem
bbdoc: Gets collision rectangle for two rectangles collision.
End Rem
Function GetCollisionRec:RRectangle(rec1:RRectangle, rec2:RRectangle)
	Return bmx_raylib_GetCollisionRec(rec1, rec2)
End Function

Rem
bbdoc: Checks if point is inside rectangle.
End Rem
Function CheckCollisionPointRec:Int(point:RVector2, rec:RRectangle)
	Return bmx_raylib_CheckCollisionPointRec(point, rec)
End Function

Rem
bbdoc: Checks if point is inside circle.
End Rem
Function CheckCollisionPointCircle:Int(point:RVector2, center:RVector2, radius:Float)
	Return bmx_raylib_CheckCollisionPointCircle(point, center, radius)
End Function

Rem
bbdoc: Checks if point is inside a triangle.
End Rem
Function CheckCollisionPointTriangle:Int(point:RVector2, p1:RVector2, p2:RVector2, p3:RVector2)
	Return bmx_raylib_CheckCollisionPointTriangle(point, p1, p2, p3)
End Function


' Input-related functions: keyboard
Rem
bbdoc: Detects if a key has been pressed once.
End Rem
Function IsKeyPressed:Int(key:Int)
	Return bmx_raylib_IsKeyPressed(key)
End Function

Rem
bbdoc: Detects if a key is being pressed.
End Rem
Function IsKeyDown:Int(key:Int)
	Return bmx_raylib_IsKeyDown(key)
End Function

Rem
bbdoc: Detects if a key has been released once.
End Rem
Function IsKeyReleased:Int(key:Int)
	Return bmx_raylib_IsKeyReleased(key)
End Function

Rem
bbdoc: Detects if a key is NOT being pressed.
End Rem
Function IsKeyUp:Int(key:Int)
	Return bmx_raylib_IsKeyUp(key)
End Function

Rem
bbdoc: Sets a custom key to exit program (default is ESC).
End Rem
Function SetExitKey(key:Int)
	bmx_raylib_SetExitKey(Key)
End Function

Rem
bbdoc: Gets key pressed, call it multiple times for chars queued.
End Rem
Function GetKeyPressed:Int()
	Return bmx_raylib_GetKeyPressed()
End Function

' Input-related functions: gamepads
Rem
bbdoc: Detects if a gamepad is available.
End Rem
Function IsGamepadAvailable:Int(gamepad:Int)
	Return bmx_raylib_IsGamepadAvailable(gamepad:Int)
End Function

Rem
bbdoc: Checks gamepad name (if available).
End Rem
Function IsGamepadName:Int(gamepad:Int, name:String)
	Local n:Byte Ptr = name.ToUTF8String()
	Local res:Int = bmx_raylib_IsGamepadName(gamepad:Int, n)
	MemFree(n)
	Return res
End Function

Rem
bbdoc: Returns gamepad internal name id.
End Rem
Function GetGamepadName:String(gamepad:Int)
	Return String.FromUTF8String(bmx_raylib_GetGamepadName(gamepad:Int))
End Function

Rem
bbdoc: Detects if a gamepad button has been pressed once.
End Rem
Function IsGamepadButtonPressed:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonPressed(gamepad:Int, button:Int)
End Function

Rem
bbdoc: Detects if a gamepad button is being pressed.
End Rem
Function IsGamepadButtonDown:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonDown(gamepad:Int, button:Int)
End Function

Rem
bbdoc: Detects if a gamepad button has been released once.
End Rem
Function IsGamepadButtonReleased:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonReleased(gamepad:Int, button:Int)
End Function

Rem
bbdoc: Detects if a gamepad button is NOT being pressed.
End Rem
Function IsGamepadButtonUp:Int(gamepad:Int, button:Int)
	Return bmx_raylib_IsGamepadButtonUp(gamepad:Int, button:Int)
End Function

Rem
bbdoc: Gets the last gamepad button pressed.
End Rem
Function GetGamepadButtonPressed:Int()
	Return bmx_raylib_GetGamepadButtonPressed()
End Function

Rem
bbdoc: Returns gamepad axis count for a gamepad.
End Rem
Function GetGamepadAxisCount:Int(gamepad:Int)
	Return bmx_raylib_GetGamepadAxisCount(gamepad:Int)
End Function

Rem
bbdoc: Returns axis movement value for a gamepad axis.
End Rem
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
Rem
bbdoc: Returns the hexadecimal value for an #RColor.
End Rem
Function ColorToInt:Int(color:RColor)
	Return bmx_raylib_ColorToInt(color)
End Function

Rem
bbdoc: Returns @color normalized as float [0..1]
End Rem
Function ColorNormalize:RVector4(color:RColor)
	Return bmx_raylib_ColorNormalize(color)
End Function

Rem
bbdoc: Returns @color from normalized values [0..1]
End Rem
Function ColorFromNormalized:RColor(normalized:RVector4)
	Return bmx_raylib_ColorFromNormalized(normalized)
End Function

Rem
bbdoc: Returns HSV values for an #RColor.
End Rem
Function ColorToHSV:RVector3(color:RColor)
	Return bmx_raylib_ColorToHSV(color)
End Function

Rem
bbdoc: Returns an #RColor from HSV values.
End Rem
Function ColorFromHSV:RColor(hsv:RVector3)
	Return bmx_raylib_ColorFromHSV(hsv)
End Function

Rem
bbdoc: Returns an #RColor from a hexadecimal value.
End Rem
Function GetColor:RColor(hexValue:Int)
	Return bmx_raylib_GetColor(hexValue)
End Function

Rem
bbdoc: Color fade-in or fade-out.
about: @alpha goes from 0.0 to 1.0.
End Rem
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
Rem
bbdoc: Loads image from file into CPU memory (RAM).
End Rem
Function LoadImage:RImage(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImage(f)
	MemFree(f)
	Return image
End Function

Rem
bbdoc: Loads image from Color array data (RGBA - 32bit).
End Rem
Function LoadImageEx:RImage(pixels:RColor Ptr, width:Int, height:Int)
	Return bmx_raylib_LoadImageEx(pixels, width, height)
End Function

Rem
bbdoc: Loads image from raw data with parameters.
End Rem
Function LoadImagePro:RImage(data:Byte Ptr, width:Int, height:Int, format:Int)
	Return bmx_raylib_LoadImagePro(data, width, height, format)
End Function

Rem
bbdoc: Loads image from RAW file data.
End Rem
Function LoadImageRaw:RImage(filename:String, width:Int, height:Int, format:Int, headerSize:Int)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImageRaw(f, width, height, format, headerSize)
	MemFree(f)
	Return image
End Function

Rem
bbdoc: Exports image data to file.
End Rem
Function ExportImage(image:RImage, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportImage(image, f)
	MemFree(f)
End Function

Rem
bbdoc: Exports image as code file defining an array of bytes.
End Rem
Function ExportImageAsCode(image:RImage, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportImageAsCode(image, f)
	MemFree(f)
End Function

Rem
bbdoc: Loads texture from file into GPU memory (VRAM).
End Rem
Function LoadTexture:RTexture2D(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local texture:RTexture2D = bmx_raylib_LoadTexture(f)
	MemFree(f)
	Return texture
End Function

Rem
bbdoc: Loads texture from image data.
End Rem
Function LoadTextureFromImage:RTexture2D(image:RImage)
	Return bmx_raylib_LoadTextureFromImage(image)
End Function

Rem
bbdoc: Loads cubemap from image, multiple image cubemap layouts supported.
End Rem
Function LoadRenderTexture:RRenderTexture2D(width:Int, height:Int)
	Return bmx_raylib_LoadRenderTexture(width, height)
End Function

Rem
bbdoc: Loads texture for rendering (framebuffer).
End Rem
Function LoadTextureCubemap:RTextureCubemap(image:RImage, layoutType:Int)
	Return bmx_raylib_LoadTextureCubemap(image, layoutType)
End Function

Rem
bbdoc: Unloads image from CPU memory (RAM).
End Rem
Function UnloadImage(image:RImage)
	bmx_raylib_UnloadImage(image)
End Function

Rem
bbdoc: Unloads texture from GPU memory (VRAM).
End Rem
Function UnloadTexture(texture:RTexture2D)
	bmx_raylib_UnloadTexture(texture)
End Function

Rem
bbdoc: Unloads render texture from GPU memory (VRAM).
End Rem
Function UnloadRenderTexture(target:RRenderTexture2D)
	bmx_raylib_UnloadRenderTexture(target)
End Function

Rem
bbdoc: Gets pixel data from image as an #RColor array.
End Rem
Function GetImageData:RColor Ptr(image:RImage)
	Return bmx_raylib_GetImageData(image)
End Function

Rem
bbdoc: Gets pixel data from image as an RVector4 array (float normalized).
End Rem
Function GetImageDataNormalized:RVector4 Ptr(image:RImage)
	Return bmx_raylib_GetImageDataNormalized(image)
End Function

Rem
bbdoc: Gets image alpha border rectangle.
End Rem
Function GetImageAlphaBorder:RRectangle(image:RImage, threshold:Float)
	Return bmx_raylib_GetImageAlphaBorder(image, threshold)
End Function

Rem
bbdoc: Gets pixel data size in bytes (image or texture).
End Rem
Function GetPixelDataSize:Int(width:Int, height:Int, format:Int)
	Return bmx_raylib_GetPixelDataSize(width, height, format)
End Function

Rem
bbdoc: Gets pixel data from GPU texture and return an #RImage.
End Rem
Function GetTextureData:RImage(texture:RTexture2D)
	Return bmx_raylib_GetTextureData(texture)
End Function

Rem
bbdoc: Gets pixel data from screen buffer and return an #RImage (screenshot).
End Rem
Function GetScreenData:RImage()
	Return bmx_raylib_GetScreenData()
End Function

Rem
bbdoc: Updates GPU texture with new data.
End Rem
Function UpdateTexture(texture:RTexture2D, pixels:Byte Ptr)
	bmx_raylib_UpdateTexture(texture, pixels)
End Function

' Image generation functions

Rem
bbdoc: Generates an image: plain color.
End Rem
Function GenImageColor:RImage(width:Int, height:Int, color:RColor)
	Return bmx_raylib_GenImageColor(width:Int, height:Int, color:RColor)
End Function

Rem
bbdoc: Generates an image: vertical gradient.
End Rem
Function GenImageGradientV:RImage(width:Int, height:Int, top:RColor, bottom:RColor)
	Return bmx_raylib_GenImageGradientV(width:Int, height:Int, top:RColor, bottom:RColor)
End Function

Rem
bbdoc: Generates an image: horizontal gradient.
End Rem
Function GenImageGradientH:RImage(width:Int, height:Int, Left:RColor, Right:RColor)
	Return bmx_raylib_GenImageGradientH(width:Int, height:Int, Left:RColor, Right:RColor)
End Function

Rem
bbdoc: Generates an image: radial gradient.
End Rem
Function GenImageGradientRadial:RImage(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)
	Return bmx_raylib_GenImageGradientRadial(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)
End Function

Rem
bbdoc: Generates an image: checked.
End Rem
Function GenImageChecked:RImage(width:Int, height:Int, checksX:Int, checksY:Int, col1:RColor, col2:RColor)
	Return bmx_raylib_GenImageChecked(width:Int, height:Int, checksX:Int, checksY:Int, col1:RColor, col2:RColor)
End Function

Rem
bbdoc: Generates an image: white noise.
End Rem
Function GenImageWhiteNoise:RImage(width:Int, height:Int, factor:Float)
	Return bmx_raylib_GenImageWhiteNoise(width:Int, height:Int, factor:Float)
End Function

Rem
bbdoc: Generates an image: perlin noise.
End Rem
Function GenImagePerlinNoise:RImage(width:Int, height:Int, offsetX:Int, offsetY:Int, scale:Float)
	Return bmx_raylib_GenImagePerlinNoise(width:Int, height:Int, offsetX:Int, offsetY:Int, scale:Float)
End Function

Rem
bbdoc: Generates an image: cellular algorithm. Bigger tileSize means bigger cells.
End Rem
Function GenImageCellular:RImage(width:Int, height:Int, tileSize:Int)
	Return bmx_raylib_GenImageCellular(width:Int, height:Int, tileSize:Int)
End Function


' Texture2D configuration functions
Rem
bbdoc: Generates GPU mipmaps for a texture.
End Rem
Function GenTextureMipmaps(texture:RTexture2D Var)
	bmx_raylib_GenTextureMipmaps(texture)
End Function

Rem
bbdoc: Sets texture scaling filter mode.
End Rem
Function SetTextureFilter(texture:RTexture2D, filterMode:Int)
	bmx_raylib_SetTextureFilter(texture, filterMode)
End Function

Rem
bbdoc: Sets the texture wrapping mode.
End Rem
Function SetTextureWrap(texture:RTexture2D, wrapMode:Int)
	bmx_raylib_SetTextureWrap(texture, wrapMode)
End Function

' Texture2D drawing functions
Rem
bbdoc: Draws an #RTexture2D.
End Rem
Function DrawTexture(texture:RTexture2D, posX:Int, posY:Int, tint:RColor)
	bmx_raylib_DrawTexture(texture, posX, posY, tint)
End Function

Rem
bbdoc: Draws an #RTexture2D with position defined as #RVector2.
End Rem
Function DrawTextureV(texture:RTexture2D, position:RVector2, tint:RColor)
	bmx_raylib_DrawTextureV(texture, position, tint)
End Function

Rem
bbdoc: Draws an #RTexture2D with extended parameters.
End Rem
Function DrawTextureEx(texture:RTexture2D, position:RVector2, Rotation:Float, scale:Float, tint:RColor)
	bmx_raylib_DrawTextureEx(texture, position, Rotation, scale, tint)
End Function

Rem
bbdoc: Draws a part of a texture defined by a rectangle.
End Rem
Function DrawTextureRec(texture:RTexture2D, sourceRec:RRectangle, position:RVector2, tint:RColor)
	bmx_raylib_DrawTextureRec(texture, sourceRec, position, tint)
End Function

Rem
bbdoc: Draws a texture quad with tiling and offset parameters.
End Rem
Function DrawTextureQuad(texture:RTexture2D, tiling:RVector2, offset:RVector2, quad:RRectangle, tint:RColor)
	bmx_raylib_DrawTextureQuad(texture, tiling, offset, quad, tint)
End Function

Rem
bbdoc: Draws a part of a texture defined by a rectangle with 'pro' parameters.
End Rem
Function DrawTexturePro(texture:RTexture2D, sourceRec:RRectangle, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)
	bmx_raylib_DrawTexturePro(texture, sourceRec, destRec, origin, Rotation, tint)
End Function

Rem
bbdoc: Draws a texture (or part of it) that stretches or shrinks nicely.
End Rem
Function DrawTextureNPatch(texture:RTexture2D, nPatchInfo:RNPatchInfo, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)
	bmx_raylib_DrawTextureNPatch(texture, nPatchInfo, destRec, origin, Rotation, tint)
End Function

' Input-related functions: touch
Rem
bbdoc: Returns touch position X for touch point 0 (relative to screen size).
End Rem
Function GetTouchX:Int()
	Return bmx_raylib_GetTouchX()
End Function

Rem
bbdoc: Returns touch position Y for touch point 0 (relative to screen size).
End Rem
Function GetTouchY:Int()
	Return bmx_raylib_GetTouchY()
End Function

Rem
bbdoc: Returns touch position XY for a touch point index (relative to screen size).
End Rem
Function GetTouchPosition:RVector2(index:Int)
	Return bmx_raylib_GetTouchPosition(index)
End Function

' Gestures and Touch Handling Functions (Module: gestures)
Rem
bbdoc: Enables a set of gestures using flags.
End Rem
Function SetGesturesEnabled(gestureFlags:UInt)
	bmx_raylib_SetGesturesEnabled(gestureFlags)
End Function

Rem
bbdoc: Checks if a gesture have been detected.
End Rem
Function IsGestureDetected:Int(gesture:Int)
	Return bmx_raylib_IsGestureDetected(gesture)
End Function

Rem
bbdoc: Gets latest detected gesture.
End Rem
Function GetGestureDetected:Int()
	Return bmx_raylib_GetGestureDetected()
End Function

Rem
bbdoc: Gets touch points count.
End Rem
Function GetTouchPointsCount:Int()
	Return bmx_raylib_GetTouchPointsCount()
End Function

Rem
bbdoc: Gets gesture hold time in milliseconds.
End Rem
Function GetGestureHoldDuration:Float()
	Return bmx_raylib_GetGestureHoldDuration()
End Function

Rem
bbdoc: Gets gesture drag vector.
End Rem
Function GetGestureDragVector:RVector2()
	Return bmx_raylib_GetGestureDragVector()
End Function

Rem
bbdoc: Gets gesture drag angle.
End Rem
Function GetGestureDragAngle:Float()
	Return bmx_raylib_GetGestureDragAngle()
End Function

Rem
bbdoc: Gets gesture pinch delta.
End Rem
Function GetGesturePinchVector:RVector2()
	Return bmx_raylib_GetGesturePinchVector()
End Function

Rem
bbdoc: Gets gesture pinch angle.
End Rem
Function GetGesturePinchAngle:Float()
	Return bmx_raylib_GetGesturePinchAngle()
End Function

' Model loading/unloading functions
Rem
bbdoc: Loads model from files (meshes and materials)
End Rem
Function LoadModel:RModel(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local model:RModel = bmx_raylib_LoadModel(f)
	MemFree(f)
	Return model
End Function

Rem
bbdoc: Loads model from generated mesh (default material)
End Rem
Function LoadModelFromMesh:RModel(mesh:RMesh)
	Return bmx_raylib_LoadModelFromMesh(mesh)
End Function

Rem
bbdoc: Unloads model from memory (RAM and/or VRAM)
End Rem
Function UnloadModel(model:RModel)
	bmx_raylib_UnloadModel(model)
End Function

' Mesh generation functions
Rem
bbdoc: Generates polygonal mesh.
End Rem
Function GenMeshPoly:RMesh(sides:Int, radius:Float)
	Return bmx_raylib_GenMeshPoly(sides, radius)
End Function

Rem
bbdoc: Generates plane mesh (with subdivisions).
End Rem
Function GenMeshPlane:RMesh(width:Float, length:Float, resX:Int, resZ:Int)
	Return bmx_raylib_GenMeshPlane(width, length, resX, resZ)
End Function

Rem
bbdoc: Generates cuboid mesh.
End Rem
Function GenMeshCube:RMesh(width:Float, height:Float, length:Float)
	Return bmx_raylib_GenMeshCube(width, height, length)
End Function

Rem
bbdoc: Generates sphere mesh (standard sphere).
End Rem
Function GenMeshSphere:RMesh(radius:Float, rings:Int, slices:Int)
	Return bmx_raylib_GenMeshSphere(radius, rings, slices)
End Function

Rem
bbdoc: Generates half-sphere mesh (no bottom cap).
End Rem
Function GenMeshHemiSphere:RMesh(radius:Float, rings:Int, slices:Int)
	Return bmx_raylib_GenMeshHemiSphere(radius, rings, slices)
End Function

Rem
bbdoc: Generates cylinder mesh.
End Rem
Function GenMeshCylinder:RMesh(radius:Float, height:Float, slices:Int)
	Return bmx_raylib_GenMeshCylinder(radius, height, slices)
End Function

Rem
bbdoc: Generates torus mesh.
End Rem
Function GenMeshTorus:RMesh(radius:Float, size:Float, radSeg:Int, sides:Int)
	Return bmx_raylib_GenMeshTorus(radius, size, radSeg, sides)
End Function

Rem
bbdoc: Generates trefoil knot mesh.
End Rem
Function GenMeshKnot:RMesh(radius:Float, size:Float, radSeg:Int, sides:Int)
	Return bmx_raylib_GenMeshKnot(radius, size, radSeg, sides)
End Function

Rem
bbdoc: Generates heightmap mesh from image data.
End Rem
Function GenMeshHeightmap:RMesh(heightmap:RImage, size:RVector3)
	Return bmx_raylib_GenMeshHeightmap(heightmap, size)
End Function

Rem
bbdoc: Generates cubes-based map mesh from image data.
End Rem
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

Rem
bbdoc: Creates an image duplicate (useful for transformations).
End Rem
Function ImageCopy:RImage(image:RImage)
	Return bmx_raylib_ImageCopy(image)
End Function

Rem
bbdoc: Creates an image from another image piece.
End Rem
Function ImageFromImage:RImage(image:RImage, rec:RRectangle)
	Return bmx_raylib_ImageFromImage(image, rec)
End Function

Rem
bbdoc: Converts image to POT (power-of-two).
End Rem
Function ImageToPOT(image:RImage Var, fillColor:RColor)
	bmx_raylib_ImageToPOT(image, fillColor)
End Function

Rem
bbdoc: Converts image data to desired format.
End Rem
Function ImageFormat(image:RImage Var, newFormat:Int)
	bmx_raylib_ImageFormat(image, newFormat)
End Function

Rem
bbdoc: Applys alpha mask to image.
End Rem
Function ImageAlphaMask(image:RImage Var, alphaMask:RImage)
	bmx_raylib_ImageAlphaMask(image, alphaMask)
End Function

Rem
bbdoc: Clears alpha channel to desired color.
End Rem
Function ImageAlphaClear(image:RImage Var, color:RColor, threshold:Float)
	bmx_raylib_ImageAlphaClear(image, color, threshold)
End Function

Rem
bbdoc: Crops image depending on alpha value.
End Rem
Function ImageAlphaCrop(image:RImage Var, threshold:Float)
	bmx_raylib_ImageAlphaCrop(image, threshold)
End Function

Rem
bbdoc: Premultiplies alpha channel.
End Rem
Function ImageAlphaPremultiply(image:RImage Var)
	bmx_raylib_ImageAlphaPremultiply(image)
End Function

Rem
bbdoc: Crops an image to a defined rectangle.
End Rem
Function ImageCrop(image:RImage Var, crop:RRectangle)
	bmx_raylib_ImageCrop(image, crop)
End Function

Rem
bbdoc: Resizes image (Bicubic scaling algorithm).
End Rem
Function ImageResize(image:RImage Var, newWidth:Int, newHeight:Int)
	bmx_raylib_ImageResize(image, newWidth, newHeight)
End Function

Rem
bbdoc: Resizes image (Nearest-Neighbor scaling algorithm).
End Rem
Function ImageResizeNN(image:RImage Var, newWidth:Int, newHeight:Int)
	bmx_raylib_ImageResizeNN(image, newWidth, newHeight)
End Function

Rem
bbdoc: Resizes canvas and fill with color.
End Rem
Function ImageResizeCanvas(image:RImage Var, newWidth:Int, newHeight:Int, offsetX:Int, offsetY:Int, color:RColor)
	bmx_raylib_ImageResizeCanvas(image, newWidth, newHeight, offsetX, offsetY, color)
End Function

Rem
bbdoc: Generates all mipmap levels for a provided image.
End Rem
Function ImageMipmaps(image:RImage Var)
	bmx_raylib_ImageMipmaps(image)
End Function

Rem
bbdoc: Dithers image data to 16bpp or lower (Floyd-Steinberg dithering).
End Rem
Function ImageDither(image:RImage Var, rBpp:Int, gBpp:Int, bBpp:Int, aBpp:Int)
	bmx_raylib_ImageDither(image, rBpp, gBpp, bBpp, aBpp)
End Function

'Function ImageExtractPalette:RColor Ptr(image:RImage, maxPaletteSize:Int, extractCount:Int Ptr)

Rem
bbdoc: Creates an image from text (default font).
End Rem
Function ImageText:RImage(txt:String, FontSize:Int, color:RColor)
	Return bmx_raylib_ImageText(txt, FontSize, color)
End Function

Rem
bbdoc: Creates an image from text (custom sprite font).
End Rem
Function ImageTextEx:RImage(font:RFont, txt:String, FontSize:Float, spacing:Float, tint:RColor)
	Return bmx_raylib_ImageTextEx(font, txt, FontSize, spacing, tint)
End Function

Rem
bbdoc: Draws a source image within a destination image (tint applied to source).
End Rem
Function ImageDraw(dst:RImage Var, src:RImage, srcRec:RRectangle, dstRec:RRectangle, tint:RColor)
	bmx_raylib_ImageDraw(dst, src, srcRec, dstRec, tint)
End Function

Rem
bbdoc: Draws a rectangle within an image.
End Rem
Function ImageDrawRectangle(dst:RImage Var, rec:RRectangle, color:RColor)
	bmx_raylib_ImageDrawRectangle(dst, rec, color)
End Function

Rem
bbdoc: Draws rectangle lines within an image.
End Rem
Function ImageDrawRectangleLines(dst:RImage Var, rec:RRectangle, thick:Int, color:RColor)
	bmx_raylib_ImageDrawRectangleLines(dst, rec, thick, color)
End Function

Rem
bbdoc: Draws text (default font) within an image (destination).
End Rem
Function ImageDrawText(dst:RImage Var, position:RVector2, txt:String, FontSize:Int, color:RColor)
	bmx_raylib_ImageDrawText(dst, position, txt, FontSize, color)
End Function

Rem
bbdoc: Draws text (custom sprite font) within an image (destination).
End Rem
Function ImageDrawTextEx(dst:RImage Var, position:RVector2, font:RFont, txt:String, FontSize:Float, spacing:Float, color:RColor)
	bmx_raylib_ImageDrawTextEx(dst, position, font, txt, FontSize, spacing, color)
End Function

Rem
bbdoc: Flips image vertically.
End Rem
Function ImageFlipVertical(image:RImage Var)
	bmx_raylib_ImageFlipVertical(image)
End Function

Rem
bbdoc: Flips image horizontally.
End Rem
Function ImageFlipHorizontal(image:RImage Var)
	bmx_raylib_ImageFlipHorizontal(image)
End Function

Rem
bbdoc: Rotates image clockwise 90deg.
End Rem
Function ImageRotateCW(image:RImage Var)
	bmx_raylib_ImageRotateCW(image)
End Function

Rem
bbdoc: Rotates image counter-clockwise 90deg.
End Rem
Function ImageRotateCCW(image:RImage Var)
	bmx_raylib_ImageRotateCCW(image)
End Function

Rem
bbdoc: Modifies image color: tint.
End Rem
Function ImageColorTint(image:RImage Var, color:RColor)
	bmx_raylib_ImageColorTint(image, color)
End Function

Rem
bbdoc: Modifies image color: invert.
End Rem
Function ImageColorInvert(image:RImage Var)
	bmx_raylib_ImageColorInvert(image)
End Function

Rem
bbdoc: Modifies image color: grayscale.
End Rem
Function ImageColorGrayscale(image:RImage Var)
	bmx_raylib_ImageColorGrayscale(image)
End Function

Rem
bbdoc: Modifies image color: contrast (-100 to 100).
End Rem
Function ImageColorContrast(image:RImage Var, contrast:Float)
	bmx_raylib_ImageColorContrast(image, contrast)
End Function

Rem
bbdoc: Modifies image color: brightness (-255 to 255).
End Rem
Function ImageColorBrightness(image:RImage Var, brightness:Int)
	bmx_raylib_ImageColorBrightness(image, brightness)
End Function

Rem
bbdoc: Modifies image color: replace color.
End Rem
Function ImageColorReplace(image:RImage Var, color:RColor, Replace:RColor)
	bmx_raylib_ImageColorReplace(image, color, Replace)
End Function
