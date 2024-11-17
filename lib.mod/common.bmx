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

?linux
Import "-ldl"
Import "-lm"
Import "-lX11"
Import "-lxcb"
Import "-lGL"
Import "-lGLX"
Import "-lXext"
Import "-lGLdispatch"
Import "-lXau"
Import "-lXdmcp"
?macos
Import "-framework IOKit"
Import "-framework OpenGL"
?

Import "source.bmx"

Extern
	
	' Window-related functions
	Function bmx_raylib_InitWindow(width:Int, height:Int, title:Byte Ptr)="InitWindow"
	Function bmx_raylib_CloseWindow()
	Function bmx_raylib_WindowShouldClose:Int()="WindowShouldClose"
	Function bmx_raylib_IsWindowReady:Int()="IsWindowReady"
	Function bmx_raylib_IsWindowFullscreen:Int()="IsWindowFullscreen"
	Function bmx_raylib_IsWindowHidden:Int()="IsWindowHidden"
	Function bmx_raylib_IsWindowMinimized:Int()="IsWindowMinimized"
	Function bmx_raylib_IsWindowMaximized:Int()="IsWindowMaximized"
	Function bmx_raylib_IsWindowFocused:Int()="IsWindowFocused"
	Function bmx_raylib_IsWindowResized:Int()="IsWindowResized"
	Function bmx_raylib_IsWindowState:Int(flags:UInt)="IsWindowState"
	Function bmx_raylib_SetWindowState(flags:UInt)="SetWindowState"
	Function bmx_raylib_ClearWindowState(flags:UInt)="ClearWindowState"
	Function bmx_raylib_ToggleFullscreen()="ToggleFullscreen"
	Function bmx_raylib_ToggleBorderlessWindowed()="ToggleBorderlessWindowed"
	Function bmx_raylib_MaximizeWindow()="MaximizeWindow"
	Function bmx_raylib_MinimizeWindow()="MinimizeWindow"
	Function bmx_raylib_RestoreWindow()="RestoreWindow"
	Function bmx_raylib_SetWindowIcon(image:RImage)="SetWindowIcon"
	Function bmx_raylib_SetWindowIcons(images:RImage Ptr, count:Int)="SetWindowIcons"
	Function bmx_raylib_SetWindowTitle(title:Byte Ptr)="SetWindowTitle"
	Function bmx_raylib_SetWindowPosition(x:Int, y:Int)="SetWindowPosition"
	Function bmx_raylib_SetWindowMonitor(monitor:Int)="SetWindowMonitor"
	Function bmx_raylib_SetWindowMinSize(width:Int, height:Int)="SetWindowMinSize"
	Function bmx_raylib_SetWindowMaxSize(width:Int, height:Int)="SetWindowMaxSize"
	Function bmx_raylib_SetWindowSize(width:Int, height:Int)="SetWindowSize"
	Function bmx_raylib_SetWindowOpacity(opacity:Float)="SetWindowOpacity"
	Function bmx_raylib_SetWindowFocused()="SetWindowFocused"
	Function bmx_raylib_GetWindowHandle:Byte Ptr()="GetWindowHandle"
	Function bmx_raylib_GetScreenWidth:Int()="GetScreenWidth"
	Function bmx_raylib_GetScreenHeight:Int()="GetScreenHeight"
	Function bmx_raylib_GetRenderWidth:Int()="GetRenderWidth"
	Function bmx_raylib_GetRenderHeight:Int()="GetRenderHeight"
	Function bmx_raylib_GetMonitorCount:Int()="GetMonitorCount"
	Function bmx_raylib_GetCurrentMonitor:Int()="GetCurrentMonitor"
	Function bmx_raylib_GetMonitorPosition:RVector2(monitor:Int)="GetMonitorPosition"
	Function bmx_raylib_GetMonitorWidth:Int(monitor:Int)="GetMonitorWidth"
	Function bmx_raylib_GetMonitorHeight:Int(monitor:Int)="GetMonitorHeight"
	Function bmx_raylib_GetMonitorPhysicalWidth:Int(monitor:Int)="GetMonitorPhysicalWidth"
	Function bmx_raylib_GetMonitorPhysicalHeight:Int(monitor:Int)="GetMonitorPhysicalHeight"
	Function bmx_raylib_GetMonitorRefreshRate:Int(monitor:Int)="GetMonitorRefreshRate"
	Function bmx_raylib_GetWindowPosition:RVector2()="GetWindowPosition"
	Function bmx_raylib_GetWindowScaleDPI:RVector2()="GetWindowScaleDPI"
	Function bmx_raylib_GetMonitorName:Byte Ptr(monitor:Int)="GetMonitorName"
	Function bmx_raylib_SetClipboardText(txt:Byte Ptr)="SetClipboardText"
	Function bmx_raylib_GetClipboardText:Byte Ptr()="GetClipboardText"
	Function bmx_raylib_GetClipboardImage:RImage()="GetClipboardImage"
	Function bmx_raylib_EnableEventWaiting()="EnableEventWaiting"
	Function bmx_raylib_DisableEventWaiting()="DisableEventWaiting"

	' Cursor-related functions
	Function bmx_raylib_ShowCursor()
	Function bmx_raylib_HideCursor()="HideCursor"
	Function bmx_raylib_IsCursorHidden:Int()="IsCursorHidden"
	Function bmx_raylib_EnableCursor()="EnableCursor"
	Function bmx_raylib_DisableCursor()="DisableCursor"
	Function bmx_raylib_IsCursorOnScreen:Int()="IsCursorOnScreen"

	' Drawing-related functions
	Function bmx_raylib_ClearBackground(color:RColor)="ClearBackground"
	Function bmx_raylib_BeginDrawing()="BeginDrawing"
	Function bmx_raylib_EndDrawing()="EndDrawing"
	Function bmx_raylib_BeginMode2D(camera:RCamera2D)="BeginMode2D"
	Function bmx_raylib_EndMode2D()="EndMode2D"
	Function bmx_raylib_BeginMode3D(camera:RCamera)="BeginMode3D"
	Function bmx_raylib_EndMode3D()="EndMode3D"
	Function bmx_raylib_BeginTextureMode(target:RRenderTexture2D)="BeginTextureMode"
	Function bmx_raylib_EndTextureMode()="EndTextureMode"
	Function bmx_raylib_BeginShaderMode(shader:RShader)="BeginShaderMode"
	Function bmx_raylib_EndShaderMode()="EndShaderMode"
	Function bmx_raylib_BeginBlendMode(mode:Int)="BeginBlendMode"
	Function bmx_raylib_EndBlendMode()="EndBlendMode"
	Function bmx_raylib_BeginScissorMode(x:Int, y:Int, width:Int, height:Int)="BeginScissorMode"
	Function bmx_raylib_EndScissorMode()="EndScissorMode"
	Function bmx_raylib_BeginVrStereoMode(config:RVrStereoConfig)="BeginVrStereoMode"
	Function bmx_raylib_EndVrStereoMode()="EndVrStereoMode"

	' VR stereo config functions for VR simulator
	Function bmx_raylib_LoadVrStereoConfig:RVrStereoConfig(device:RVrDeviceInfo)="LoadVrStereoConfig"
	Function bmx_raylib_UnloadVrStereoConfig(config:RVrStereoConfig)="UnloadVrStereoConfig"

	' Shader management functions
	Function bmx_raylib_LoadShader:RShader(vsFilename:Byte Ptr, fsFilename:Byte Ptr)="LoadShader"
	Function bmx_raylib_LoadShaderFromMemory:RShader(vsCode:Byte Ptr, fsCode:Byte Ptr)="LoadShaderFromMemory"
	Function bmx_raylib_IsShaderValid:Int(shader:RShader)="IsShaderValid"
	Function bmx_raylib_GetShaderLocation:Int(shader:RShader, uniformName:Byte Ptr)="GetShaderLocation"
	Function bmx_raylib_GetShaderLocationAttrib:Int(shader:RShader, attribName:Byte Ptr)="GetShaderLocationAttrib"
	Function bmx_raylib_SetShaderValue(shader:RShader, locIndex:Int, value:Byte Ptr, uniformType:Int)="SetShaderValue"
	Function bmx_raylib_SetShaderValueV(shader:RShader, locIndex:Int, value:Byte Ptr, uniformType:Int, count:Int)="SetShaderValueV"
	Function bmx_raylib_SetShaderValueMatrix(shader:RShader, locIndex:Int, mat:RMatrix)="SetShaderValueMatrix"
	Function bmx_raylib_SetShaderValueTexture(shader:RShader, locIndex:Int, texture:RTexture2D)="SetShaderValueTexture"
	Function bmx_raylib_UnloadShader(shader:RShader)="UnloadShader"

	' Screen-space-related functions
	Function bmx_raylib_GetScreenToWorldRay:RRay(position:RVector2, camera:RCamera)="GetScreenToWorldRay"
	Function bmx_raylib_GetScreenToWorldRayEx:RRay(position:RVector2, camera:RCamera, width:Int, height:Int)="GetScreenToWorldRayEx"
	Function bmx_raylib_GetWorldToScreen:RVector2(position:RVector3, camera:RCamera)="GetWorldToScreen"
	Function bmx_raylib_GetWorldToScreenEx:RVector2(position:RVector3, camera:RCamera, width:Int, height:Int)="GetWorldToScreenEx"
	Function bmx_raylib_GetWorldToScreen2D:RVector2(position:RVector2, camera:RCamera2D)="GetWorldToScreen2D"
	Function bmx_raylib_GetScreenToWorld2D:RVector2(position:RVector2, camera:RCamera2D)="GetScreenToWorld2D"
	Function bmx_raylib_GetCameraMatrix:RMatrix(camera:RCamera)="GetCameraMatrix"
	Function bmx_raylib_GetCameraMatrix2D:RMatrix(camera:RCamera2D)="GetCameraMatrix2D"

	' Timing-related functions
	Function bmx_raylib_SetTargetFPS(fps:Int)="SetTargetFPS"
	Function bmx_raylib_GetFrameTime:Float()="GetFrameTime"
	Function bmx_raylib_GetTime:Double()="GetTime"
	Function bmx_raylib_GetFPS:Int()="GetFPS"

	' Custom frame control functions
	Function bmx_raylib_SwapScreenBuffer()="SwapScreenBuffer"
	Function bmx_raylib_PollInputEvents()="PollInputEvents"
	Function bmx_raylib_WaitTime(seconds:Double)="WaitTime"

	' Random values generation functions
	Function bmx_raylib_SetRandomSeed(seed:UInt)="SetRandomSeed"
	Function bmx_raylib_GetRandomValue:Int(minimum:Int, maximum:Int)="GetRandomValue"
	Function bmx_raylib_LoadRandomSequence:Int Ptr(count:UInt, minimum:Int, maximum:Int)="LoadRandomSequence"
	Function bmx_raylib_UnloadRandomSequence(seq:Int Ptr)="UnloadRandomSequence"

	' Misc. functions
	Function bmx_raylib_TakeScreenshot(fileName:Byte Ptr)="TakeScreenshot"
	Function bmx_raylib_SetConfigFlags(flags:UInt)="SetConfigFlags"
	Function bmx_raylib_OpenURL(url:Byte Ptr)="OpenURL"

	Function bmx_raylib_MemAlloc:Byte Ptr(size:UInt)="MemAlloc"
	Function bmx_raylib_MemRealloc:Byte Ptr(data:Byte Ptr, size:UInt)="MemRealloc"
	Function bmx_raylib_MemFree(data:Byte Ptr)="MemFree"

	Function bmx_raylib_DrawFPS(posX:Int, posY:Int)="DrawFPS"
	Function bmx_raylib_DrawText(txt:Byte Ptr, posX:Int, posY:Int, FontSize:Int, color:RColor)
	Function bmx_raylib_DrawTextEx(font:RFont, txt:Byte Ptr, position:RVector2, FontSize:Float, spacing:Float, tint:RColor)
	Function bmx_raylib_DrawTextPro(font:RFont, txt:Byte Ptr, position:RVector2, origin:RVector2, fontSize:Float, spacing:Float, tint:RColor)="DrawTextPro"
	Function bmx_raylib_DrawTextCodepoint(font:RFont, codepoint:Int, position:RVector2, scale:Float, tint:RColor)="DrawTextCodepoint"
	Function bmx_raylib_DrawTextCodepoints(font:RFont, codepoints:Int Ptr, count:Int, position:RVector2, fontSize:Float, spacing:Float, tint:RColor)="DrawTextCodepoints"

	Function bmx_raylib_DrawPixel(posX:Int, posY:Int, color:RColor)="DrawPixel"
	Function bmx_raylib_DrawPixelV(position:RVector2, color:RColor)="DrawPixelV"
	Function bmx_raylib_DrawLine(startPosX:Int, startPosY:Int, endPosX:Int, endPosY:Int, color:RColor)="DrawLine"
	Function bmx_raylib_DrawLineV(startPos:RVector2, endPos:RVector2, color:RColor)="DrawLineV"
	Function bmx_raylib_DrawLineEx(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)="DrawLineEx"
	Function bmx_raylib_DrawLineBezier(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)="DrawLineBezier"
	Function bmx_raylib_DrawLineStrip(points:RVector2 Ptr, numPoints:Int, color:RColor)="DrawLineStrip"
	Function bmx_raylib_DrawCircle(centerX:Int, centerY:Int, radius:Float, color:RColor)="DrawCircle"
	Function bmx_raylib_DrawCircleSector(center:RVector2, radius:Float, startAngle:Float, endAngle:Float, segments:Int, color:RColor)="DrawCircleSector"
	Function bmx_raylib_DrawCircleSectorLines(center:RVector2, radius:Float, startAngle:Float, endAngle:Float, segments:Int, color:RColor)="DrawCircleSectorLines"
	Function bmx_raylib_DrawCircleGradient(centerX:Int, centerY:Int, radius:Float, color1:RColor, color2:RColor)="DrawCircleGradient"
	Function bmx_raylib_DrawCircleV(center:RVector2, radius:Float, color:RColor)="DrawCircleV"
	Function bmx_raylib_DrawCircleLines(centerX:Int, centerY:Int, radius:Float, color:RColor)="DrawCircleLines"
	Function bmx_raylib_DrawCircleLinesV(center:RVector2, radius:Float, color:RColor)="DrawCircleLinesV"
	Function bmx_raylib_DrawEllipse(centerX:Int, centerY:Int, radiusH:Float, radiusV:Float, color:RColor)="DrawEllipse"
	Function bmx_raylib_DrawEllipseLines(centerX:Int, centerY:Int, radiusH:Float, radiusV:Float, color:RColor)="DrawEllipseLines"
	Function bmx_raylib_DrawRing(center:RVector2, innerRadius:Float, outerRadius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)="DrawRing"
	Function bmx_raylib_DrawRingLines(center:RVector2, innerRadius:Float, outerRadius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)="DrawRingLines"
	Function bmx_raylib_DrawRectangle(posX:Int, posY:Int, width:Int, height:Int, color:RColor)="DrawRectangle"
	Function bmx_raylib_DrawRectangleV(position:RVector2, size:RVector2, color:RColor)="DrawRectangleV"
	Function bmx_raylib_DrawRectangleRec(rec:RRectangle, color:RColor)="DrawRectangleRec"
	Function bmx_raylib_DrawRectanglePro(rec:RRectangle, origin:RVector2, Rotation:Float, color:RColor)="DrawRectanglePro"
	Function bmx_raylib_DrawRectangleGradientV(posX:Int, posY:Int, width:Int, height:Int, color1:RColor, color2:RColor)="DrawRectangleGradientV"
	Function bmx_raylib_DrawRectangleGradientH(posX:Int, posY:Int, width:Int, height:Int, color1:RColor, color2:RColor)="DrawRectangleGradientH"
	Function bmx_raylib_DrawRectangleGradientEx(rec:RRectangle, col1:RColor, col2:RColor, col3:RColor, col4:RColor)="DrawRectangleGradientEx"
	Function bmx_raylib_DrawRectangleLines(posX:Int, posY:Int, width:Int, height:Int, color:RColor)="DrawRectangleLines"
	Function bmx_raylib_DrawRectangleLinesEx(rec:RRectangle, lineThick:Int, color:RColor)="DrawRectangleLinesEx"
	Function bmx_raylib_DrawRectangleRounded(rec:RRectangle, roundness:Float, segments:Int, color:RColor)="DrawRectangleRounded"
	Function bmx_raylib_DrawRectangleRoundedLines(rec:RRectangle, roundness:Float, segments:Int, lineThick:Int, color:RColor)="DrawRectangleRoundedLines"
	Function bmx_raylib_DrawRectangleRoundedLinesEx(rec:RRectangle, roundness:Float, segments:Int, lineThick:Int, color:RColor)="DrawRectangleRoundedLinesEx"
	Function bmx_raylib_DrawTriangle(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)="DrawTriangle"
	Function bmx_raylib_DrawTriangleLines(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)="DrawTriangleLines"
	Function bmx_raylib_DrawTriangleFan(points:RVector2 Ptr, numPoints:Int, color:RColor)="DrawTriangleFan"
	Function bmx_raylib_DrawTriangleStrip(points:RVector2 Ptr, pointsCount:Int, color:RColor)="DrawTriangleStrip"
	Function bmx_raylib_DrawPoly(center:RVector2, sides:Int, radius:Float, rotation:Float, color:RColor)="DrawPoly"
	Function bmx_raylib_DrawPolyLines(center:RVector2, sides:Int, radius:Float, rotation:Float, color:RColor)="DrawPolyLines"
	Function bmx_raylib_DrawPolyLinesEx(center:RVector2, sides:Int, radius:Float, rotation:Float, lineThick:Float, color:RColor)="DrawPolyLinesEx"

	Function bmx_raylib_DrawSplineLinear(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)="DrawSplineLinear"
	Function bmx_raylib_DrawSplineBasis(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)="DrawSplineBasis"
	Function bmx_raylib_DrawSplineCatmullRom(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)="DrawSplineCatmullRom"
	Function bmx_raylib_DrawSplineBezierQuadratic(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)="DrawSplineBezierQuadratic"
	Function bmx_raylib_DrawSplineBezierCubic(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)="DrawSplineBezierCubic"
	Function bmx_raylib_DrawSplineSegmentLinear(p1:RVector2, p2:RVector2, thick:Float, color:RColor)="DrawSplineSegmentLinear"
	Function bmx_raylib_DrawSplineSegmentBasis(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, thick:Float, color:RColor)="DrawSplineSegmentBasis"
	Function bmx_raylib_DrawSplineSegmentCatmullRom(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, thick:Float, color:RColor)="DrawSplineSegmentCatmullRom"
	Function bmx_raylib_DrawSplineSegmentBezierQuadratic(p1:RVector2, p2:RVector2, p3:RVector2, thick:Float, color:RColor)="DrawSplineSegmentBezierQuadratic"
	Function bmx_raylib_DrawSplineSegmentBezierCubic(p1:RVector2, c2:RVector2, c3:RVector2, p4:RVector2, thick:Float, color:RColor)="DrawSplineSegmentBezierCubic"

	Function bmx_raylib_GetSplinePointLinear:RVector2(startPos:RVector2, endPos:RVector2, t:Float)="GetSplinePointLinear"
	Function bmx_raylib_GetSplinePointBasis:RVector2(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, t:Float)="GetSplinePointBasis"
	Function bmx_raylib_GetSplinePointCatmullRom:RVector2(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, t:Float)="GetSplinePointCatmullRom"
	Function bmx_raylib_GetSplinePointBezierQuad:RVector2(p1:RVector2, c2:RVector2, p3:RVector2, t:Float)="GetSplinePointBezierQuad"
	Function bmx_raylib_GetSplinePointBezierCubic:RVector2(p1:RVector2, c2:RVector2, c3:RVector2, p4:RVector2, t:Float)="GetSplinePointBezierCubic"

	Function bmx_raylib_CheckCollisionRecs:Int(rec1:RRectangle, rec2:RRectangle)="CheckCollisionRecs"
	Function bmx_raylib_CheckCollisionCircles:Int(center1:RVector2, radius1:Float, center2:RVector2, radius2:Float)="CheckCollisionCircles"
	Function bmx_raylib_CheckCollisionCircleRec:Int(center:RVector2, radius:Float, rec:RRectangle)="CheckCollisionCircleRec"
	Function bmx_raylib_CheckCollisionCircleLine:Int(center:RVector2, radius:Float, p1:RVector2, p2:RVector2)="CheckCollisionCircleLine"
	Function bmx_raylib_CheckCollisionPointRec:Int(point:RVector2, rec:RRectangle)="CheckCollisionPointRec"
	Function bmx_raylib_CheckCollisionPointCircle:Int(point:RVector2, center:RVector2, radius:Float)="CheckCollisionPointCircle"
	Function bmx_raylib_CheckCollisionPointTriangle:Int(point:RVector2, p1:RVector2, p2:RVector2, p3:RVector2)="CheckCollisionPointTriangle"
	Function bmx_raylib_CheckCollisionPointLine:Int(point:RVector2, p1:RVector2, p2:RVector2, threshold:Int)="CheckCollisionPointLine"
	Function bmx_raylib_CheckCollisionPointPoly:Int(point:RVector2, points:RVector2 Ptr, pointCount:Int)="CheckCollisionPointPoly"
	Function bmx_raylib_CheckCollisionLines:Int(startPos1:RVector2, endPos1:RVector2, startPos2:RVector2, endPos2:RVector2, collisionPoint:RVector2 Var)="CheckCollisionLines"
	Function bmx_raylib_GetCollisionRec:RRectangle(rec1:RRectangle, rec2:RRectangle)="GetCollisionRec"

	Function bmx_raylib_LoadImage:RImage(filename:Byte Ptr)
	Function bmx_raylib_LoadImageRaw:RImage(filename:Byte Ptr, width:Int, height:Int, format:Int, headerSize:Int)="LoadImageRaw"
	Function bmx_raylib_LoadImageAnim:RImage(filename:Byte Ptr, frames:Int Var)="LoadImageAnim"
	Function bmx_raylib_LoadImageAnimFromMemory:RImage(fileType:Byte Ptr, data:Byte Ptr, dataSize:Int, frames:Int Var)="LoadImageAnimFromMemory"
	Function bmx_raylib_LoadImageFromMemory:RImage(fileType:Byte Ptr, fileData:Byte Ptr, dataSize:Int)="LoadImageFromMemory"
	Function bmx_raylib_LoadImageFromTexture:RImage(texture:RTexture2D)="LoadImageFromTexture"
	Function bmx_raylib_LoadImageFromScreen:RImage()="LoadImageFromScreen"
	Function bmx_raylib_IsImageValid:Int(image:RImage)="IsImageValid"
	Function bmx_raylib_UnloadImage(image:RImage)="UnloadImage"
	Function bmx_raylib_ExportImage(image:RImage, filename:Byte Ptr)="ExportImage"
	Function bmx_raylib_ExportImageToMemory:Byte Ptr(image:RImage, fileType:Byte Ptr, fileSize:Int Var)="ExportImageToMemory"
	Function bmx_raylib_ExportImageAsCode(image:RImage, filename:Byte Ptr)="ExportImageAsCode"

	Function bmx_raylib_GenImageColor:RImage(width:Int, height:Int, color:RColor)="GenImageColor"
	Function bmx_raylib_GenImageGradientLinear:RImage(width:Int, height:Int, direction:Int, startColor:RColor, endColor:RColor)="GenImageGradientLinear"
	Function bmx_raylib_GenImageGradientRadial:RImage(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)="GenImageGradientRadial"
	Function bmx_raylib_GenImageGradientSquare:RImage(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)="GenImageGradientSquare"
	Function bmx_raylib_GenImageChecked:RImage(width:Int, height:Int, checksX:Int, checksY:Int, col1:RColor, col2:RColor)="GenImageChecked"
	Function bmx_raylib_GenImageWhiteNoise:RImage(width:Int, height:Int, factor:Float)="GenImageWhiteNoise"
	Function bmx_raylib_GenImagePerlinNoise:RImage(width:Int, height:Int, offsetX:Int, offsetY:Int, scale:Float)="GenImagePerlinNoise"
	Function bmx_raylib_GenImageCellular:RImage(width:Int, height:Int, tileSize:Int)="GenImageCellular"
	Function bmx_raylib_GenImageText:RImage(width:Int, height:Int, text:Byte Ptr)="GenImageText"

'	Function bmx_raylib_GetRandomValue:Int(minimum:Int, maximum:Int)="GetRandomValue"

	' Input-related functions: keyboard
	Function bmx_raylib_IsKeyPressed:Int(key:Int)="IsKeyPressed"
	Function bmx_raylib_IsKeyPressedRepeat:Int(key:Int)="IsKeyPressedRepeat"
	Function bmx_raylib_IsKeyDown:Int(key:Int)="IsKeyDown"
	Function bmx_raylib_IsKeyReleased:Int(key:Int)="IsKeyReleased"
	Function bmx_raylib_IsKeyUp:Int(key:Int)="IsKeyUp"
	Function bmx_raylib_GetKeyPressed:Int()="GetKeyPressed"
	Function bmx_raylib_GetCharPressed:Int()="GetCharPressed"
	Function bmx_raylib_SetExitKey(key:Int)="SetExitKey"
	
	' Input-related functions: gamepads
	Function bmx_raylib_IsGamepadAvailable:Int(gamepad:Int)="IsGamepadAvailable"
	Function bmx_raylib_GetGamepadName:Byte Ptr(gamepad:Int)="GetGamepadName"
	Function bmx_raylib_IsGamepadButtonPressed:Int(gamepad:Int, button:Int)="IsGamepadButtonPressed"
	Function bmx_raylib_IsGamepadButtonDown:Int(gamepad:Int, button:Int)="IsGamepadButtonDown"
	Function bmx_raylib_IsGamepadButtonReleased:Int(gamepad:Int, button:Int)="IsGamepadButtonReleased"
	Function bmx_raylib_IsGamepadButtonUp:Int(gamepad:Int, button:Int)="IsGamepadButtonUp"
	Function bmx_raylib_GetGamepadButtonPressed:Int()="GetGamepadButtonPressed"
	Function bmx_raylib_GetGamepadAxisCount:Int(gamepad:Int)="GetGamepadAxisCount"
	Function bmx_raylib_GetGamepadAxisMovement:Float(gamepad:Int, axis:Int)="GetGamepadAxisMovement"
	Function bmx_raylib_SetGamepadMappings:Int(mappings:Byte Ptr)="SetGamepadMappings"
	Function bmx_raylib_SetGamepadVibration(gamepad:Int, leftMotor:Float, rightMotor:Float, duration:Float)="SetGamepadVibration"

	' Input-related functions: mouse
	Function bmx_raylib_IsMouseButtonPressed:Int(button:Int)="IsMouseButtonPressed"
	Function bmx_raylib_IsMouseButtonDown:Int(button:Int)="IsMouseButtonDown"
	Function bmx_raylib_IsMouseButtonReleased:Int(button:Int)="IsMouseButtonReleased"
	Function bmx_raylib_IsMouseButtonUp:Int(button:Int)="IsMouseButtonUp"
	Function bmx_raylib_GetMouseX:Int()="GetMouseX"
	Function bmx_raylib_GetMouseY:Int()="GetMouseY"
	Function bmx_raylib_GetMousePosition:RVector2()="GetMousePosition"
	Function bmx_raylib_GetMouseDelta:RVector2()="GetMouseDelta"
	Function bmx_raylib_SetMousePosition(x:Int, y:Int)="SetMousePosition"
	Function bmx_raylib_SetMouseOffset(offsetX:Int, offsetY:Int)="SetMouseOffset"
	Function bmx_raylib_SetMouseScale(scaleX:Float, scaleY:Float)="SetMouseScale"
	Function bmx_raylib_GetMouseWheelMove:Float()="GetMouseWheelMove"
	Function bmx_raylib_GetMouseWheelMoveV:RVector2()="GetMouseWheelMoveV"
	Function bmx_raylib_SetMouseCursor(cursor:Int)="SetMouseCursor"

	Function bmx_raylib_GetTouchX:Int()="GetTouchX"
	Function bmx_raylib_GetTouchY:Int()="GetTouchY"
	Function bmx_raylib_GetTouchPosition:RVector2(index:Int)="GetTouchPosition"
	Function bmx_raylib_GetTouchPointId:Int(index:Int)="GetTouchPointId"
	Function bmx_raylib_GetTouchPointCount:Int()="GetTouchPointCount"

	Function bmx_raylib_SetGesturesEnabled(gestureFlags:UInt)="SetGesturesEnabled"
	Function bmx_raylib_IsGestureDetected:Int(gesture:Int)="IsGestureDetected"
	Function bmx_raylib_GetGestureDetected:Int()="GetGestureDetected"
	Function bmx_raylib_GetGestureHoldDuration:Float()="GetGestureHoldDuration"
	Function bmx_raylib_GetGestureDragVector:RVector2()="GetGestureDragVector"
	Function bmx_raylib_GetGestureDragAngle:Float()="GetGestureDragAngle"
	Function bmx_raylib_GetGesturePinchVector:RVector2()="GetGesturePinchVector"
	Function bmx_raylib_GetGesturePinchAngle:Float()="GetGesturePinchAngle"
	
	Function bmx_raylib_ColorIsEqual:Int(color1:RColor, color2:RColor)="ColorIsEqual"
	Function bmx_raylib_Fade:RColor(color:RColor, alpha:Float)="Fade"
	Function bmx_raylib_ColorToInt:Int(color:RColor)="ColorToInt"
	Function bmx_raylib_ColorNormalize:RVector4(color:RColor)="ColorNormalize"
	Function bmx_raylib_ColorFromNormalized:RColor(normalized:RVector4)="ColorFromNormalized"
	Function bmx_raylib_ColorToHSV:RVector3(color:RColor)="ColorToHSV"
	Function bmx_raylib_ColorFromHSV:RColor(hsv:RVector3)="ColorFromHSV"
	Function bmx_raylib_ColorTint:RColor(color:RColor, tint:RColor)="ColorTint"
	Function bmx_raylib_ColorBrightness:RColor(color:RColor, factor:Float)="ColorBrightness"
	Function bmx_raylib_ColorContrast:RColor(color:RColor, contrast:Float)="ColorContrast"
	Function bmx_raylib_ColorAlpha:RColor(color:RColor, alpha:Float)="ColorAlpha"
	Function bmx_raylib_ColorAlphaBlend:RColor(dst:RColor, src:RColor, tint:RColor)="ColorAlphaBlend"
	Function bmx_raylib_ColorLerp:RColor(color1:RColor, color2:RColor, factor:Float)="ColorLerp"
	Function bmx_raylib_GetColor:RColor(hexValue:Int)="GetColor"
	Function bmx_raylib_GetPixelColor:RColor(data:Byte Ptr, format:Int)="GetPixelColor"
	Function bmx_raylib_SetPixelColor(data:Byte Ptr, color:RColor, format:Int)="SetPixelColor"
	Function bmx_raylib_GetPixelDataSize:Int(width:Int, height:Int, format:Int)="GetPixelDataSize"

	Function bmx_raylib_UpdateCamera(camera:RCamera Var, mode:Int)="UpdateCamera"
	Function bmx_raylib_UpdateCameraPro(camera:RCamera Var, movement:RVector3, rotation:RVector3, zoom:Float)="UpdateCameraPro"

	Function bmx_raylib_DrawLine3D(startPos:RVector3, endPos:RVector3, color:RColor)="DrawLine3D"
	Function bmx_raylib_DrawPoint3D(position:RVector3, color:RColor)="DrawPoint3D"
	Function bmx_raylib_DrawCircle3D(center:RVector3, radius:Float, rotationAxis:RVector3, rotationAngle:Float, color:RColor)="DrawCircle3D"
	Function bmx_raylib_DrawTriangle3D(v1:RVector3, v2:RVector3, v3:RVector3, color:RColor)="DrawTriangle3D"
	Function bmx_raylib_DrawTriangleStrip3D(points:RVector3 Ptr, pointsCount:Int, color:RColor)="DrawTriangleStrip3D"
	Function bmx_raylib_DrawCube(position:RVector3, width:Float, height:Float, length:Float, color:RColor)="DrawCube"
	Function bmx_raylib_DrawCubeV(position:RVector3, size:RVector3, color:RColor)="DrawCubeV"
	Function bmx_raylib_DrawCubeWires(position:RVector3, width:Float, height:Float, length:Float, color:RColor)="DrawCubeWires"
	Function bmx_raylib_DrawCubeWiresV(position:RVector3, size:RVector3, color:RColor)="DrawCubeWiresV"
	Function bmx_raylib_DrawSphere(centerPos:RVector3, radius:Float, color:RColor)="DrawSphere"
	Function bmx_raylib_DrawSphereEx(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)="DrawSphereEx"
	Function bmx_raylib_DrawSphereWires(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)="DrawSphereWires"
	Function bmx_raylib_DrawCylinder(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)="DrawCylinder"
	Function bmx_raylib_DrawCylinderEx(startPos:RVector3, endPos:RVector3, startRadius:Float, endRadius:Float, sides:Int, color:RColor)="DrawCylinderEx"
	Function bmx_raylib_DrawCylinderWires(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)="DrawCylinderWires"
	Function bmx_raylib_DrawCylinderWiresEx(startPos:RVector3, endPos:RVector3, startRadius:Float, endRadius:Float, sides:Int, color:RColor)="DrawCylinderWiresEx"
	Function bmx_raylib_DrawCapsule(startPos:RVector3, endPos:RVector3, radius:Float, slices:Int, rings:Int, color:RColor)="DrawCapsule"
	Function bmx_raylib_DrawCapsuleWires(startPos:RVector3, endPos:RVector3, radius:Float, slices:Int, rings:Int, color:RColor)="DrawCapsuleWires"
	Function bmx_raylib_DrawPlane(centerPos:RVector3, size:RVector2, color:RColor)="DrawPlane"
	Function bmx_raylib_DrawRay(ray:RRay, color:RColor)="DrawRay"
	Function bmx_raylib_DrawGrid(slices:Int, spacing:Float)="DrawGrid"

	Function bmx_raylib_LoadTexture:RTexture2D(filename:Byte Ptr)="LoadTexture"
	Function bmx_raylib_LoadTextureFromImage:RTexture2D(image:RImage)="LoadTextureFromImage"
	Function bmx_raylib_LoadTextureCubemap:RTextureCubemap(image:RImage, layoutType:Int)="LoadTextureCubemap"
	Function bmx_raylib_LoadRenderTexture:RRenderTexture2D(width:Int, height:Int)="LoadRenderTexture"
	Function bmx_raylib_IsTextureValid:Int(texture:RTexture2D)="IsTextureValid"
	Function bmx_raylib_UnloadTexture(texture:RTexture2D)="UnloadTexture"
	Function bmx_raylib_IsRenderTextureValid:Int(target:RRenderTexture2D)="IsRenderTextureValid"
	Function bmx_raylib_UnloadRenderTexture(target:RRenderTexture2D)="UnloadRenderTexture"
	Function bmx_raylib_UpdateTexture(texture:RTexture2D, pixels:Byte Ptr)="UpdateTexture"
	Function bmx_raylib_UpdateTextureRec(texture:RTexture2D, rec:RRectangle, pixels:Byte Ptr)="UpdateTextureRec"
	
	Function bmx_raylib_GenTextureMipmaps(texture:RTexture2D Var)="GenTextureMipmaps"
	Function bmx_raylib_SetTextureFilter(texture:RTexture2D, filterMode:Int)="SetTextureFilter"
	Function bmx_raylib_SetTextureWrap(texture:RTexture2D, wrapMode:Int)="SetTextureWrap"

	Function bmx_raylib_DrawTexture(texture:RTexture2D, posX:Int, posY:Int, tint:RColor)="DrawTexture"
	Function bmx_raylib_DrawTextureV(texture:RTexture2D, position:RVector2, tint:RColor)="DrawTextureV"
	Function bmx_raylib_DrawTextureEx(texture:RTexture2D, position:RVector2, Rotation:Float, scale:Float, tint:RColor)="DrawTextureEx"
	Function bmx_raylib_DrawTextureRec(texture:RTexture2D, sourceRec:RRectangle, position:RVector2, tint:RColor)="DrawTextureRec"
	' Function bmx_raylib_DrawTextureQuad(texture:RTexture2D, tiling:RVector2, offset:RVector2, quad:RRectangle, tint:RColor)="DrawTextureQuad"
	Function bmx_raylib_DrawTexturePro(texture:RTexture2D, sourceRec:RRectangle, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)="DrawTexturePro"
	Function bmx_raylib_DrawTextureNPatch(texture:RTexture2D, nPatchInfo:RNPatchInfo, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)="DrawTextureNPatch"

	Function bmx_raylib_LoadModel:RModel(filename:Byte Ptr)="LoadModel"
	Function bmx_raylib_LoadModelFromMesh:RModel(mesh:RMesh)="LoadModelFromMesh"
	Function bmx_raylib_IsModelValid:Int(model:RModel)="IsModelValid"
	Function bmx_raylib_UnloadModel(model:RModel)="UnloadModel"
	Function bmx_raylib_GetModelBoundingBox:RBoundingBox(model:RModel)="GetModelBoundingBox"

	Function bmx_raylib_GenMeshPoly:RMesh(sides:Int, radius:Float)="GenMeshPoly"
	Function bmx_raylib_GenMeshPlane:RMesh(width:Float, length:Float, resX:Int, resZ:Int)="GenMeshPlane"
	Function bmx_raylib_GenMeshCube:RMesh(width:Float, height:Float, length:Float)="GenMeshCube"
	Function bmx_raylib_GenMeshSphere:RMesh(radius:Float, rings:Int, slices:Int)="GenMeshSphere"
	Function bmx_raylib_GenMeshHemiSphere:RMesh(radius:Float, rings:Int, slices:Int)="GenMeshHemiSphere"
	Function bmx_raylib_GenMeshCylinder:RMesh(radius:Float, height:Float, slices:Int)="GenMeshCylinder"
	Function bmx_raylib_GenMeshTorus:RMesh(radius:Float, size:Float, radSeg:Int, sides:Int)="GenMeshTorus"
	Function bmx_raylib_GenMeshKnot:RMesh(radius:Float, size:Float, radSeg:Int, sides:Int)="GenMeshKnot"
	Function bmx_raylib_GenMeshHeightmap:RMesh(heightmap:RImage, size:RVector3)="GenMeshHeightmap"
	Function bmx_raylib_GenMeshCubicmap:RMesh(cubicmap:RImage, cubeSize:RVector3)="GenMeshCubicmap"

	Function bmx_raylib_UploadMesh:RMesh(mesh:RMesh Var, dynamic:Int)="UploadMesh"
	Function bmx_raylib_UpdateMeshBuffer(mesh:RMesh, index:Int, data:Byte Ptr, dataSize:Int, offset:Int)="UpdateMeshBuffer"
	Function bmx_raylib_UnloadMesh(mesh:RMesh)="UnloadMesh"
	Function bmx_raylib_DrawMesh(mesh:RMesh, material:RMaterial, transform:RMatrix)="DrawMesh"
	Function bmx_raylib_DrawMeshInstanced(mesh:RMesh, material:RMaterial, transforms:RMatrix Ptr, instances:Int)="DrawMeshInstanced"
	Function bmx_raylib_GetMeshBoundingBox:RBoundingBox(mesh:RMesh)="GetMeshBoundingBox"
	Function bmx_raylib_GenMeshTangents(mesh:RMesh Var)="GenMeshTangents"
	' Function bmx_raylib_MeshBinormals(mesh:RMesh Var)="MeshBinormals"
	Function bmx_raylib_ExportMesh(mesh:RMesh, filename:Byte Ptr)="ExportMesh"
	Function bmx_raylib_ExportMeshAsCode(mesh:RMesh, filename:Byte Ptr)="ExportMeshAsCode"

	Function bmx_raylib_DrawModel(model:RModel, position:RVector3, scale:Float, tint:RColor)="DrawModel"
	Function bmx_raylib_DrawModelEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)="DrawModelEx"
	Function bmx_raylib_DrawModelWires(model:RModel, position:RVector3, scale:Float, tint:RColor)="DrawModelWires"
	Function bmx_raylib_DrawModelWiresEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)="DrawModelWiresEx"
	Function bmx_raylib_DrawModelPoints(model:RModel, position:RVector3, scale:Float, tint:RColor)="DrawModelPoints"
	Function bmx_raylib_DrawModelPointsEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)="DrawModelPointsEx"
	Function bmx_raylib_DrawBoundingBox(box:RBoundingBox, color:RColor)="DrawBoundingBox"
	Function bmx_raylib_DrawBillboard(camera:RCamera, texture:RTexture2D, center:RVector3, size:Float, tint:RColor)="DrawBillboard"
	Function bmx_raylib_DrawBillboardRec(camera:RCamera, texture:RTexture2D, source:RRectangle, position:RVector3, size:RVector2, tint:RColor)="DrawBillboardRec"
	FUnction bmx_raylib_DrawBillboardPro(camera:RCamera, texture:RTexture2D, source:RRectangle, position:RVector3, up:RVector3, size:RVector2, origin:RVector2, rotation:Float, tint:RColor)="DrawBillboardPro"

	Function bmx_raylib_SetTextLineSpacing(spacing:Int)="SetTextLineSpacing"
	Function bmx_raylib_MeasureText:Int(txt:Byte Ptr, FontSize:Int)="MeasureText"
	Function bmx_raylib_MeasureTextEx:RVector2(font:RFont, txt:Byte Ptr, FontSize:Float, spacing:Float)="MeasureTextEx"
	Function bmx_raylib_GetGlyphIndex:Int(font:RFont, codepoint:Int)="GetGlyphIndex"
	Function bmx_raylib_GetGlyphInfo:RGlyphInfo(font:RFont, codepoint:Int)="GetGlyphInfo"
	Function bmx_raylib_GetGlyphAtlasRec:RRectangle(font:RFont, codepoint:Int)="GetGlyphAtlasRec"

	Function bmx_raylib_LoadUTF8:Byte Ptr(codepoints:Int Ptr, length:Int)="LoadUTF8"
	Function bmx_raylib_UnloadUTF8(utf8:Byte Ptr)="UnloadUTF8"
	Function bmx_raylib_LoadCodepoints:Byte Ptr(utf8:Byte Ptr, count:Int Var)="LoadCodepoints"
	Function bmx_raylib_UnloadCodepoints(codepoints:Byte Ptr)="UnloadCodepoints"

	Function bmx_raylib_EaseSineIn:Float(t:Float, b:Float, c:Float, d:Float)="EaseSineIn"
	Function bmx_raylib_EaseSineOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseSineOut"
	Function bmx_raylib_EaseSineInOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseSineInOut"
	Function bmx_raylib_EaseCircIn:Float(t:Float, b:Float, c:Float, d:Float)="EaseCircIn"
	Function bmx_raylib_EaseCircOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseCircOut"
	Function bmx_raylib_EaseCircInOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseCircInOut"
	Function bmx_raylib_EaseExpoIn:Float(t:Float, b:Float, c:Float, d:Float)="EaseExpoIn"
	Function bmx_raylib_EaseExpoOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseExpoOut"
	Function bmx_raylib_EaseExpoInOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseExpoInOut"
	Function bmx_raylib_EaseBackIn:Float(t:Float, b:Float, c:Float, d:Float)="EaseBackIn"
	Function bmx_raylib_EaseBackOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseBackOut"
	Function bmx_raylib_EaseBackInOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseBackInOut"
	Function bmx_raylib_EaseBounceOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseBounceOut"
	Function bmx_raylib_EaseBounceIn:Float(t:Float, b:Float, c:Float, d:Float)="EaseBounceIn"
	Function bmx_raylib_EaseBounceInOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseBounceInOut"
	Function bmx_raylib_EaseElasticIn:Float(t:Float, b:Float, c:Float, d:Float)="EaseElasticIn"
	Function bmx_raylib_EaseElasticOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseElasticOut"
	Function bmx_raylib_EaseElasticInOut:Float(t:Float, b:Float, c:Float, d:Float)="EaseElasticInOut"

	Function bmx_raylib_ImageCopy:RImage(image:RImage)="ImageCopy"
	Function bmx_raylib_ImageFromImage:RImage(image:RImage, rec:RRectangle)="ImageFromImage"
	Function bmx_raylib_ImageFromChannel:RImage(image:RImage, selectedChannel:Int)="ImageFromChannel"
	Function bmx_raylib_ImageText:RImage(txt:Byte Ptr, FontSize:Int, color:RColor)="ImageText"
	Function bmx_raylib_ImageTextEx:RImage(font:RFont, txt:Byte Ptr, FontSize:Float, spacing:Float, tint:RColor)="ImageTextEx"
	Function bmx_raylib_ImageFormat(image:RImage Var, newFormat:Int)="ImageFormat"
	Function bmx_raylib_ImageToPOT(image:RImage Var, fillColor:RColor)="ImageToPOT"
	Function bmx_raylib_ImageCrop(image:RImage Var, crop:RRectangle)="ImageCrop"
	Function bmx_raylib_ImageAlphaCrop(image:RImage Var, threshold:Float)="ImageAlphaCrop"
	Function bmx_raylib_ImageAlphaClear(image:RImage Var, color:RColor, threshold:Float)="ImageAlphaClear"
	Function bmx_raylib_ImageAlphaMask(image:RImage Var, alphaMask:RImage)="ImageAlphaMask"
	Function bmx_raylib_ImageAlphaPremultiply(image:RImage Var)="ImageAlphaPremultiply"
	Function bmx_raylib_ImageBlurGaussian(image:RImage Var, blurSize:Int)="ImageBlurGaussian"
	Function bmx_raylib_ImageKernelConvolution(image:RImage Var, kernel:Float Ptr, kernelSize:Int)="ImageKernelConvolution"
	Function bmx_raylib_ImageResize(image:RImage Var, newWidth:Int, newHeight:Int)="ImageResize"
	Function bmx_raylib_ImageResizeNN(image:RImage Var, newWidth:Int, newHeight:Int)="ImageResizeNN"
	Function bmx_raylib_ImageResizeCanvas(image:RImage Var, newWidth:Int, newHeight:Int, offsetX:Int, offsetY:Int, color:RColor)="ImageResizeCanvas"
	Function bmx_raylib_ImageMipmaps(image:RImage Var)="ImageMipmaps"
	Function bmx_raylib_ImageDither(image:RImage Var, rBpp:Int, gBpp:Int, bBpp:Int, aBpp:Int)="ImageDither"
	Function bmx_raylib_ImageFlipVertical(image:RImage Var)="ImageFlipVertical"
	Function bmx_raylib_ImageFlipHorizontal(image:RImage Var)="ImageFlipHorizontal"
	Function bmx_raylib_ImageRotate(image:RImage Var, degrees:Int)="ImageRotate"
	Function bmx_raylib_ImageRotateCW(image:RImage Var)="ImageRotateCW"
	Function bmx_raylib_ImageRotateCCW(image:RImage Var)="ImageRotateCCW"
	Function bmx_raylib_ImageColorTint(image:RImage Var, color:RColor)="ImageColorTint"
	Function bmx_raylib_ImageColorInvert(image:RImage Var)="ImageColorInvert"
	Function bmx_raylib_ImageColorGrayscale(image:RImage Var)="ImageColorGrayscale"
	Function bmx_raylib_ImageColorContrast(image:RImage Var, contrast:Float)="ImageColorContrast"
	Function bmx_raylib_ImageColorBrightness(image:RImage Var, brightness:Int)="ImageColorBrightness"
	Function bmx_raylib_ImageColorReplace(image:RImage Var, color:RColor, Replace:RColor)="ImageColorReplace"
	Function bmx_raylib_LoadImageColors:RColor Ptr(image:RImage)="LoadImageColors"
	Function bmx_raylib_LoadImagePalette:RColor Ptr(image:RImage, maxPaletteSize:Int Var, colorCount:Int Var)="LoadImagePalette"
	Function bmx_raylib_UnloadImageColors(colors:RColor Ptr)="UnloadImageColors"
	Function bmx_raylib_UnloadImagePalette(palette:RColor Ptr)="UnloadImagePalette"
	Function bmx_raylib_GetImageAlphaBorder:RRectangle(image:RImage, threshold:Float)="GetImageAlphaBorder"
	Function bmx_raylib_GetImageColor:RColor(image:RImage, x:Int, y:Int)="GetImageColor"

	Function bmx_raylib_ImageClearBackground(dst:RImage Var, color:RColor)="ImageClearBackground"
	Function bmx_raylib_ImageDrawPixel(dst:RImage Var, posX:Int, posY:Int, color:RColor)="ImageDrawPixel"
	Function bmx_raylib_ImageDrawPixelV(dst:RImage Var, position:RVector2, color:RColor)="ImageDrawPixelV"
	Function bmx_raylib_ImageDrawLine(dst:RImage Var, startPosX:Int, startPosY:Int, endPosX:Int, endPosY:Int, color:RColor)="ImageDrawLine"
	Function bmx_raylib_ImageDrawLineV(dst:RImage Var, lineStart:RVector2, lineEnd:RVector2, color:RColor)="ImageDrawLineV"
	Function bmx_raylib_ImageDrawLineEx(dst:RImage Var, lineStart:RVector2, lineEnd:RVector2, thick:Int, color:RColor)="ImageDrawLineEx"
	Function bmx_raylib_ImageDrawCircle(dst:RImage Var, centerX:Int, centerY:Int, radius:Int, color:RColor)="ImageDrawCircle"
	Function bmx_raylib_ImageDrawCircleV(dst:RImage Var, center:RVector2, radius:Int, color:RColor)="ImageDrawCircleV"
	Function bmx_raylib_ImageDrawCircleLines(dst:RImage Var, centerX:Int, centerY:Int, radius:Int, color:RColor)="ImageDrawCircleLines"
	Function bmx_raylib_ImageDrawCircleLinesV(dst:RImage Var, center:RVector2, radius:Int, color:RColor)="ImageDrawCircleLinesV"
	Function bmx_raylib_ImageDrawRectangle(dst:RImage Var, posX:Int, posY:Int, width:Int, height:Int, color:RColor)="ImageDrawRectangle"
	Function bmx_raylib_ImageDrawRectangleV(dst:RImage Var, position:RVector2, size:RVector2, color:RColor)="ImageDrawRectangleV"
	Function bmx_raylib_ImageDrawRectangleRec(dst:RImage Var, rec:RRectangle, color:RColor)="ImageDrawRectangleRec"
	Function bmx_raylib_ImageDrawRectangleLines(dst:RImage Var, rec:RRectangle, thick:Int, color:RColor)="ImageDrawRectangleLines"
	Function bmx_raylib_ImageDrawTriangle(dst:RImage Var, v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)="ImageDrawTriangle"
	Function bmx_raylib_ImageDrawTriangleEx(dst:RImage Var, v1:RVector2, v2:RVector2, v3:RVector2, c1:RColor, c2:RColor, c3:RColor)="ImageDrawTriangleEx"
	Function bmx_raylib_ImageDrawTriangleLines(dst:RImage Var, v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)="ImageDrawTriangleLines"
	Function bmx_raylib_ImageDrawTriangleFan(dst:RImage Var, points:RVector2 Ptr, pointCount:Int, color:RColor)="ImageDrawTriangleFan"
	Function bmx_raylib_ImageDrawTriangleStrip(dst:RImage Var, points:RVector2 Ptr, pointCount:Int, color:RColor)="ImageDrawTriangleStrip"
	Function bmx_raylib_ImageDraw(dst:RImage Var, src:RImage, srcRec:RRectangle, dstRec:RRectangle, tint:RColor)="ImageDraw"
	Function bmx_raylib_ImageDrawText(dst:RImage Var, txt:Byte Ptr, posX:Int, posY:Int, fontSize:Int, color:RColor)="ImageDrawText"
	Function bmx_raylib_ImageDrawTextEx(dst:RImage Var, font:RFont, txt:Byte Ptr, position:RVector2, fontSize:Float, spacing:Float, color:RColor)="ImageDrawTextEx"
			
	' Function bmx_raylib_LoadMeshes:RMesh Ptr(filename:Byte Ptr, meshCount:Int Var)="LoadMeshes"

	Function bmx_raylib_LoadMaterials:RMaterial Ptr(filename:Byte Ptr, materialCount:Int Var)="LoadMaterials"
	Function bmx_raylib_LoadMaterialDefault:RMaterial()="LoadMaterialDefault"
	Function bmx_raylib_IsMaterialValid:Int(material:RMaterial)="IsMaterialValid"
	Function bmx_raylib_UnloadMaterial(material:RMaterial)="UnloadMaterial"
	Function bmx_raylib_SetMaterialTexture(material:RMaterial Var, mapType:Int, texture:RTexture2D)="SetMaterialTexture"
	Function bmx_raylib_SetModelMeshMaterial(model:RModel Var, meshId:Int, materialId:Int)="SetModelMeshMaterial"

	Function bmx_raylib_LoadModelAnimations:RModelAnimation Ptr(filename:Byte Ptr, animsCount:Int Var)="LoadModelAnimations"
	Function bmx_raylib_UpdateModelAnimation(model:RModel, anim:RModelAnimation, frame:Int)="UpdateModelAnimation"
	Function bmx_raylib_UpdateModelAnimationBones(model:RModel, anim:RModelAnimation, frame:Int)="UpdateModelAnimationBones"
	Function bmx_raylib_UnloadModelAnimation(anim:RModelAnimation)="UnloadModelAnimation"
	Function bmx_raylib_UnloadModelAnimations(animations:RModelAnimation Ptr, count:Int)="UnloadModelAnimations"
	Function bmx_raylib_IsModelAnimationValid:Int(model:RModel, anim:RModelAnimation)="IsModelAnimationValid"

	Function bmx_raylib_GetShaderDefault:RShader()="GetShaderDefault"
	Function bmx_raylib_GetTextureDefault:RTexture2D()="GetTextureDefault"
	Function bmx_raylib_GetShapesTexture:RTexture2D()="GetShapesTexture"
	Function bmx_raylib_GetShapesTextureRectangle:RRectangle()="GetShapesTextureRectangle"
	Function bmx_raylib_SetShapesTexture(texture:RTexture2D, source:RRectangle)="SetShapesTexture"

	Function bmx_raylib_CheckCollisionSpheres:Int(center1:RVector3, radius1:Float, center2:RVector3, radius2:Float)="CheckCollisionSpheres"
	Function bmx_raylib_CheckCollisionBoxes:Int(box1:RBoundingBox, box2:RBoundingBox)="CheckCollisionBoxes"
	Function bmx_raylib_CheckCollisionBoxSphere:Int(box:RBoundingBox, center:RVector3, radius:Float)="CheckCollisionBoxSphere"
	Function bmx_raylib_GetRayCollisionSphere:RRayCollision(ray:RRay, center:RVector3, radius:Float)="GetRayCollisionSphere"
	Function bmx_raylib_GetRayCollisionBox:RRayCollision(ray:RRay, box:RBoundingBox)="GetRayCollisionBox"
	Function bmx_raylib_GetRayCollisionMesh:RRayCollision(ray:RRay, mesh:RMesh, transform:RMatrix)="GetRayCollisionMesh"
	Function bmx_raylib_GetRayCollisionTriangle:RRayCollision(ray:RRay, p1:RVector3, p2:RVector3, p3:RVector3)="GetRayCollisionTriangle"
	Function bmx_raylib_GetRayCollisionQuad:RRayCollision(ray:RRay, p1:RVector3, p2:RVector3, p3:RVector3, p4:RVector3)="GetRayCollisionQuad"
	
	Function bmx_raylib_GetFontDefault:RFont()="GetFontDefault"
	Function bmx_raylib_LoadFont:RFont(filename:Byte Ptr)="LoadFont"
	Function bmx_raylib_LoadFontEx:RFont(filename:Byte Ptr, FontSize:Int, fontChars:Int Ptr, charsCount:Int)="LoadFontEx"
	Function bmx_raylib_LoadFontFromImage:RFont(image:RImage, key:RColor, firstChar:Int)="LoadFontFromImage"
	Function bmx_raylib_LoadFontFromMemory:RFont(fileType:Byte Ptr, data:Byte Ptr, dataSize:Int, fontSize:Int, codePoints:Int Ptr, codepointCount:Int)="LoadFontFromMemory"
	Function bmx_raylib_IsFontValid:Int(font:RFont)="IsFontValid"
	Function bmx_raylib_LoadFontData:RGlyphInfo Ptr(filename:Byte Ptr, FontSize:Int, fontChars:Int Ptr, charsCount:Int, fontType:Int)="LoadFontData"
	Function bmx_raylib_GenImageFontAtlas:RImage(chars:RGlyphInfo Ptr, recs:RRectangle Ptr Ptr, charsCount:Int, FontSize:Int, padding:Int, packMethod:Int)="GenImageFontAtlas"
	Function bmx_raylib_UnloadFontData(glyphs:RGlyphInfo Ptr, glyphCount:Int)="UnloadFontData"
	Function bmx_raylib_UnloadFont(font:RFont)="UnloadFont"
	Function bmx_raylib_ExportFontAsCode:Int(font:RFont, filename:Byte Ptr)="ExportFontAsCode"

	Function bmx_raylib_IsFileDropped:Int()="IsFileDropped"
	Function bmx_raylib_LoadDroppedFiles:String[]()

End Extern


Struct RColor
	Field r:Byte
	Field g:Byte
	Field b:Byte
	Field a:Byte
	
	Method New(r:Byte, g:Byte, b:Byte, a:Byte)
		Self.r = r
		Self.g = g
		Self.b = b
		Self.a = a
	End Method

	Method New(r:Int, g:Int, b:Int, a:Int)
		Self.r = r
		Self.g = g
		Self.b = b
		Self.a = a
	End Method
End Struct

Global LIGHTGRAY:RColor = New RColor(200, 200, 200, 255)
Global GRAY:RColor = New RColor(130, 130, 130, 255)
Global DARKGRAY:RColor = New RColor(80, 80, 80, 255)
Global YELLOW:RColor = New RColor(253, 249, 0, 255)
Global GOLD:RColor = New RColor(255, 203, 0, 255)
Global ORANGE:RColor = New RColor(255, 161, 0, 255)
Global PINK:RColor = New RColor(255, 109, 194, 255)
Global RED:RColor = New RColor(230, 41, 55, 255)
Global MAROON:RColor = New RColor(190, 33, 55, 255)
Global GREEN:RColor = New RColor(0, 228, 48, 255)
Global LIME:RColor = New RColor(0, 158, 47, 255)
Global DARKGREEN:RColor = New RColor(0, 117, 44, 255)
Global SKYBLUE:RColor = New RColor(102, 191, 255, 255)
Global BLUE:RColor = New RColor(0, 121, 241, 255)
Global DARKBLUE:RColor = New RColor(0, 82, 172, 255)
Global PURPLE:RColor = New RColor(200, 122, 255, 255)
Global VIOLET:RColor = New RColor(135, 60, 190, 255)
Global DARKPURPLE:RColor = New RColor(112, 31, 126, 255)
Global BEIGE:RColor = New RColor(211, 176, 131, 255)
Global BROWN:RColor = New RColor(127, 106, 79, 255)
Global DARKBROWN:RColor = New RColor(76, 63, 47, 255)

Global WHITE:RColor = New RColor(255, 255, 255, 255)
Global BLACK:RColor = New RColor(0, 0, 0, 255)
Global BLANK:RColor = New RColor(0, 0, 0, 0)
Global MAGENTA:RColor = New RColor(255, 0, 255, 255)
Global RAYWHITE:RColor = New RColor(245, 245, 245, 255)

Struct RVector2
	Field x:Float
	Field y:Float
	
	Method New(x:Float, y:Float)
		Self.x = x
		Self.y = y
	End Method
End Struct

Struct RVector3
	Field x:Float
	Field y:Float
	Field z:Float

	Method New(x:Float, y:Float, z:Float)
		Self.x = x
		Self.y = y
		Self.z = z
	End Method
End Struct

Struct RVector4
	Field x:Float
	Field y:Float
	Field z:Float
	Field w:Float

	Method New(x:Float, y:Float, z:Float, w:Float)
		Self.x = x
		Self.y = y
		Self.z = z
		Self.w = w
	End Method
End Struct

Struct RMatrix
    Field m0:Float, m4:Float, m8:Float, m12:Float
    Field m1:Float, m5:Float, m9:Float, m13:Float
    Field m2:Float, m6:Float, m10:Float, m14:Float
    Field m3:Float, m7:Float, m11:Float, m15:Float
End Struct

Struct RRectangle
    Field x:Float
    Field y:Float
    Field width:Float
    Field height:Float

	Method New(x:Float, y:Float, width:Float, height:Float)
		Self.x = x
		Self.y = y
		Self.width = width
		Self.height = height
	End Method
End Struct

Struct RTexture2D
	Field id:UInt
	Field width:Int
	Field height:Int
	Field mipmaps:Int
	Field format:Int
End Struct

Struct RTexture
	Field id:UInt
	Field width:Int
	Field height:Int
	Field mipmaps:Int
	Field format:Int
End Struct

Struct RTextureCubemap
	Field id:UInt
	Field width:Int
	Field height:Int
	Field mipmaps:Int
	Field format:Int
End Struct

Struct RRenderTexture2D
	Field id:UInt
	Field texture:RTexture2D
	Field depth:RTexture2D
	Field depthTexture:Int
End Struct

Struct RRenderTexture
	Field id:UInt
	Field texture:RTexture2D
	Field depth:RTexture2D
	Field depthTexture:Int
End Struct

Struct RImage
	Field data:Byte Ptr
	Field width:Int
	Field height:Int
	Field mipmaps:Int
	Field format:Int

	Method New(data:Byte Ptr, width:Int, height:Int, mipmaps:Int, format:Int)
		Self.data = data
		Self.width = width
		Self.height = height
		Self.mipmaps = mipmaps
		Self.format = format
	End Method
End Struct

Struct RCamera
	Field position:RVector3
	Field target:RVector3
	Field up:RVector3
	Field fovy:Float
	Field projection:Int
	
	Method New(position:RVector3, target:RVector3, up:RVector3, fovy:Float, projection:Int)
		Self.position = position
		Self.target = target
		Self.up = up
		Self.fovy = fovy
		Self.projection = projection
	End Method
End Struct

Struct RCamera2D
	Field offset:RVector2
	Field target:RVector2
	Field Rotation:Float
	Field zoom:Float
End Struct

Struct RRay
	Field position:RVector3
	Field direction:RVector3
End Struct

Struct RRayHitInfo
	Field hit:Int
	Field distance:Float
	Field position:RVector3
	Field normal:RVector3	
End Struct

Struct RRayCollision
	Field hit:Int
	Field distance:Float
	Field point:RVector3
	Field normal:RVector3
End Struct

Struct RBoundingBox
	Field minimum:RVector3
	Field maximum:RVector3
	
	Method New(minimum:RVector3, maximum:RVector3)
		Self.minimum = minimum
		Self.maximum = maximum
	End Method
End Struct

Struct RGlyphInfo
	Field value:Int
	Field offsetX:Int
	Field offsetY:Int
	Field advanceX:Int
	Field image:RImage
End Struct

Struct RFont
	Field baseSize:Int
	Field charsCount:Int
	Field glyphPadding:Int
	Field texture:RTexture2D
	Field recs:RRectangle Ptr
	Field chars:RGlyphInfo Ptr
End Struct

Struct RNPatchInfo
	Field sourceRec:RRectangle
	Field Left:Int
	Field top:Int
	Field Right:Int
	Field bottom:Int
	Field patchType:Int
	
	Method New(sourceRec:RRectangle, Left:Int, top:Int, Right:Int, bottom:Int, patchType:Int)
		Self.sourceRec = sourceRec
		Self.Left = Left
		Self.top = top
		Self.Right = Right
		Self.bottom = bottom
		Self.patchType = patchType
	End Method
End Struct

Struct RModel
	Field transform:RMatrix
	
	Field meshCount:Int
	Field materialCount:Int
	Field meshes:RMesh Ptr
	Field materials:RMaterial Ptr
	Field meshMaterial:Int Ptr
	
	Field boneCount:Int
	Field bones:RBoneInfo Ptr
	Field bindPose:RTransform Ptr
End Struct

Struct RMesh
	Field vertexCount:Int
	Field triangleCount:Int
	
	Field vertices:Float Ptr
	Field texcoords:Float Ptr
	Field texcoords2:Float Ptr
	Field normals:Float Ptr
	Field tangents:Float Ptr
	Field colors:Byte Ptr
	Field indices:Short Ptr
	
	Field animVertices:Float Ptr
	Field animNormals:Float Ptr
	Field boneIds:Int Ptr
	Field boneWeights:Float Ptr
	Field boneMatrices:RMatrix Ptr
	Field boneCount:Int
	
	Field vaoId:UInt
	Field vboId:UInt Ptr
End Struct

Struct RTransform
	Field Translation:RVector3
	Field Rotation:RQuaternion
	Field scale:RVector3
End Struct

Struct RQuaternion
	Field x:Float
	Field y:Float
	Field z:Float
	Field w:Float

	Method New(x:Float, y:Float, z:Float, w:Float)
		Self.x = x
		Self.y = y
		Self.z = z
		Self.w = w
	End Method
End Struct

Struct RMaterial
	Field shader:RShader
	Field maps:RMaterialMap Ptr
	Field StaticArray params:Float[4]
End Struct

Struct RMaterialMap
	Field texture:RTexture2D
	Field color:RColor
	Field value:Float
End Struct

Struct RShader
	Field id:UInt
	Field locs:Int Ptr
End Struct

Struct RBoneInfo
	Field StaticArray name:Byte[32]
	Field parent:Int
End Struct

Struct RModelAnimation
	Field boneCount:Int
	Field frameCount:Int
	Field bones:RBoneInfo Ptr
	Field framePoses:RTransform Ptr Ptr
	Field StaticArray name:Byte[32]
End Struct

' VrDeviceInfo, Head-Mounted-Display device parameters
Struct RVrDeviceInfo
	Field hResolution:Int
	Field vResolution:Int
	Field hScreenSize:Float
	Field vScreenSize:Float
	Field vScreenCenter:Float
	Field eyeToScreenDistance:Float
	Field lensSeparationDistance:Float
	Field interpupillaryDistance:Float
	Field StaticArray lensDistortionValues:Float[4]
	Field StaticArray chromaAbCorrection:Float[4]
End Struct

' VrStereoConfig, VR stereo rendering configuration for simulator
Struct RVrStereoConfig
	Field StaticArray projection:RMatrix[2]
	Field StaticArray viewOffset:RMatrix[2]
	Field StaticArray leftLensCenter:Float[2]
	Field StaticArray rightLensCenter:Float[2]
	Field StaticArray leftScreenCenter:Float[2]
	Field StaticArray rightScreenCenter:Float[2]
	Field StaticArray scale:Float[2]
	Field StaticArray scaleIn:Float[2]
End Struct

' Alphanumeric keys
Const KEY_APOSTROPHE:Int = 39
Const KEY_COMMA:Int = 44
Const KEY_MINUS:Int = 45
Const KEY_PERIOD:Int = 46
Const KEY_SLASH:Int = 47
Const KEY_ZERO:Int = 48
Const KEY_ONE:Int = 49
Const KEY_TWO:Int = 50
Const KEY_THREE:Int = 51
Const KEY_FOUR:Int = 52
Const KEY_FIVE:Int = 53
Const KEY_SIX:Int = 54
Const KEY_SEVEN:Int = 55
Const KEY_EIGHT:Int = 56
Const KEY_NINE:Int = 57
Const KEY_SEMICOLON:Int = 59
Const KEY_EQUAL:Int = 61
Const KEY_A:Int = 65
Const KEY_B:Int = 66
Const KEY_C:Int = 67
Const KEY_D:Int = 68
Const KEY_E:Int = 69
Const KEY_F:Int = 70
Const KEY_G:Int = 71
Const KEY_H:Int = 72
Const KEY_I:Int = 73
Const KEY_J:Int = 74
Const KEY_K:Int = 75
Const KEY_L:Int = 76
Const KEY_M:Int = 77
Const KEY_N:Int = 78
Const KEY_O:Int = 79
Const KEY_P:Int = 80
Const KEY_Q:Int = 81
Const KEY_R:Int = 82
Const KEY_S:Int = 83
Const KEY_T:Int = 84
Const KEY_U:Int = 85
Const KEY_V:Int = 86
Const KEY_W:Int = 87
Const KEY_X:Int = 88
Const KEY_Y:Int = 89
Const KEY_Z:Int = 90
Const KEY_LEFT_BRACKET:Int = 91
Const KEY_BACKSLASH:Int = 92
Const KEY_RIGHT_BRACKET:Int = 93
Const KEY_GRAVE:Int = 96

' Function keys
Const KEY_SPACE:Int = 32
Const KEY_ESCAPE:Int = 256
Const KEY_ENTER:Int = 257
Const KEY_TAB:Int = 258
Const KEY_BACKSPACE:Int = 259
Const KEY_INSERT:Int = 260
Const KEY_DELETE:Int = 261
Const KEY_RIGHT:Int = 262
Const KEY_LEFT:Int = 263
Const KEY_DOWN:Int = 264
Const KEY_UP:Int = 265
Const KEY_PAGE_UP:Int = 266
Const KEY_PAGE_DOWN:Int = 267
Const KEY_HOME:Int = 268
Const KEY_END:Int = 269
Const KEY_CAPS_LOCK:Int = 280
Const KEY_SCROLL_LOCK:Int = 281
Const KEY_NUM_LOCK:Int = 282
Const KEY_PRINT_SCREEN:Int = 283
Const KEY_PAUSE:Int = 284
Const KEY_F1:Int = 290
Const KEY_F2:Int = 291
Const KEY_F3:Int = 292
Const KEY_F4:Int = 293
Const KEY_F5:Int = 294
Const KEY_F6:Int = 295
Const KEY_F7:Int = 296
Const KEY_F8:Int = 297
Const KEY_F9:Int = 298
Const KEY_F10:Int = 299
Const KEY_F11:Int = 300
Const KEY_F12:Int = 301
Const KEY_LEFT_SHIFT:Int = 340
Const KEY_LEFT_CONTROL:Int = 341
Const KEY_LEFT_ALT:Int = 342
Const KEY_LEFT_SUPER:Int = 343
Const KEY_RIGHT_SHIFT:Int = 344
Const KEY_RIGHT_CONTROL:Int = 345
Const KEY_RIGHT_ALT:Int = 346
Const KEY_RIGHT_SUPER:Int = 347
Const KEY_KB_MENU:Int = 348

' Keypad keys
Const KEY_KP_0:Int = 320
Const KEY_KP_1:Int = 321
Const KEY_KP_2:Int = 322
Const KEY_KP_3:Int = 323
Const KEY_KP_4:Int = 324
Const KEY_KP_5:Int = 325
Const KEY_KP_6:Int = 326
Const KEY_KP_7:Int = 327
Const KEY_KP_8:Int = 328
Const KEY_KP_9:Int = 329
Const KEY_KP_DECIMAL:Int = 330
Const KEY_KP_DIVIDE:Int = 331
Const KEY_KP_MULTIPLY:Int = 332
Const KEY_KP_SUBTRACT:Int = 333
Const KEY_KP_ADD:Int = 334
Const KEY_KP_ENTER:Int = 335
Const KEY_KP_EQUAL:Int = 336

' Android key buttons
Const KEY_BACK:Int = 4
Const KEY_MENU:Int = 82
Const KEY_VOLUME_UP:Int = 24
Const KEY_VOLUME_DOWN:Int = 25

' Camera projection
Const CAMERA_PERSPECTIVE:Int = 0
Const CAMERA_ORTHOGRAPHIC:Int = 1

' Camera system modes
Const CAMERA_CUSTOM:Int = 0
Const CAMERA_FREE:Int = 1
Const CAMERA_ORBITAL:Int = 2
Const CAMERA_FIRST_PERSON:Int = 3
Const CAMERA_THIRD_PERSON:Int = 4

' Color blending modes (pre-defined)
Const BLEND_ALPHA:Int = 0
Const BLEND_ADDITIVE:Int = 1
Const BLEND_MULTIPLIED:Int = 2
Const BLEND_ADD_COLORS:Int = 3
Const BLEND_SUBTRACT_COLORS:Int = 4
Const BLEND_ALPHA_PREMULTIPLY:Int = 5
Const BLEND_CUSTOM:Int = 6
Const BLEND_CUSTOM_SEPARATE:Int = 7

' System/Window config flags
' NOTE: Every bit registers one state (use it with bit masks)
' By default all flags are set to 0
Const FLAG_VSYNC_HINT:Int         = $00000040
Const FLAG_FULLSCREEN_MODE:Int    = $00000002
Const FLAG_WINDOW_RESIZABLE:Int   = $00000004
Const FLAG_WINDOW_UNDECORATED:Int = $00000008
Const FLAG_WINDOW_HIDDEN:Int      = $00000080
Const FLAG_WINDOW_MINIMIZED:Int   = $00000200
Const FLAG_WINDOW_MAXIMIZED:Int   = $00000400
Const FLAG_WINDOW_UNFOCUSED:Int   = $00000800
Const FLAG_WINDOW_TRANSPARENT:Int = $00000010
Const FLAG_WINDOW_HIGHDPI:Int     = $00002000
Const FLAG_WINDOW_MOUSE_PASSTHROUGH:Int = $00004000
Const FLAG_BORDERLESS_WINDOWED_MODE:Int = $00001000
Const FLAG_MSAA_4X_HINT:Int       = $00000020
Const FLAG_INTERLACED_HINT:Int    = $00010000

' Texture parameters: filter mode
Const TEXTURE_FILTER_POINT:Int = 0
Const TEXTURE_FILTER_BILINEAR:Int = 1
Const TEXTURE_FILTER_TRILINEAR:Int = 2
Const TEXTURE_FILTER_ANISOTROPIC_4X:Int = 3
Const TEXTURE_FILTER_ANISOTROPIC_8X:Int = 4
Const TEXTURE_FILTER_ANISOTROPIC_16X:Int = 5

' Texture parameters: wrap mode
Const TEXTURE_WRAP_REPEAT:Int = 0
Const TEXTURE_WRAP_CLAMP:Int = 1
Const TEXTURE_WRAP_MIRROR_REPEAT:Int = 2
Const TEXTURE_WRAP_MIRROR_CLAMP:Int = 3

' Cubemap layouts
Const CUBEMAP_LAYOUT_AUTO_DETECT:Int = 0
Const CUBEMAP_LAYOUT_LINE_VERTICAL:Int = 1
Const CUBEMAP_LAYOUT_LINE_HORIZONTAL:Int = 2
Const CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR:Int = 3
Const CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE:Int = 4

' backwards compatibility support for deprecated names
Const MOUSE_LEFT_BUTTON:Int   = 0
Const MOUSE_RIGHT_BUTTON:Int  = 1
Const MOUSE_MIDDLE_BUTTON:Int = 2

' Mouse buttons
Const MOUSE_BUTTON_LEFT:Int = 0
Const MOUSE_BUTTON_RIGHT:Int = 1
Const MOUSE_BUTTON_MIDDLE:Int = 2
Const MOUSE_BUTTON_SIDE:Int = 3
Const MOUSE_BUTTON_EXTRA:Int = 4
Const MOUSE_BUTTON_FORWARD:Int = 5
Const MOUSE_BUTTON_BACK:Int = 6

' Mouse cursor
Const MOUSE_CURSOR_DEFAULT:Int = 0
Const MOUSE_CURSOR_ARROW:Int = 1
Const MOUSE_CURSOR_IBEAM:Int = 2
Const MOUSE_CURSOR_CROSSHAIR:Int = 3
Const MOUSE_CURSOR_POINTING_HAND:Int = 4
Const MOUSE_CURSOR_RESIZE_EW:Int = 5
Const MOUSE_CURSOR_RESIZE_NS:Int = 6
Const MOUSE_CURSOR_RESIZE_NWSE:Int = 7
Const MOUSE_CURSOR_RESIZE_NESW:Int = 8
Const MOUSE_CURSOR_RESIZE_ALL:Int = 9
Const MOUSE_CURSOR_NOT_ALLOWED:Int = 10

' Gamepad buttons
Const GAMEPAD_BUTTON_UNKNOWN:Int = 0
Const GAMEPAD_BUTTON_LEFT_FACE_UP:Int = 1
Const GAMEPAD_BUTTON_LEFT_FACE_RIGHT:Int = 2
Const GAMEPAD_BUTTON_LEFT_FACE_DOWN:Int = 3
Const GAMEPAD_BUTTON_LEFT_FACE_LEFT:Int = 4
Const GAMEPAD_BUTTON_RIGHT_FACE_UP:Int = 5
Const GAMEPAD_BUTTON_RIGHT_FACE_RIGHT:Int = 6
Const GAMEPAD_BUTTON_RIGHT_FACE_DOWN:Int = 7
Const GAMEPAD_BUTTON_RIGHT_FACE_LEFT:Int = 8
Const GAMEPAD_BUTTON_LEFT_TRIGGER_1:Int = 9
Const GAMEPAD_BUTTON_LEFT_TRIGGER_2:Int = 10
Const GAMEPAD_BUTTON_RIGHT_TRIGGER_1:Int = 11
Const GAMEPAD_BUTTON_RIGHT_TRIGGER_2:Int = 12
Const GAMEPAD_BUTTON_MIDDLE_LEFT:Int = 13
Const GAMEPAD_BUTTON_MIDDLE:Int = 14
Const GAMEPAD_BUTTON_MIDDLE_RIGHT:Int = 15
Const GAMEPAD_BUTTON_LEFT_THUMB:Int = 16
Const GAMEPAD_BUTTON_RIGHT_THUMB:Int = 17

' Gamepad axis
Const GAMEPAD_AXIS_LEFT_X:Int = 0
Const GAMEPAD_AXIS_LEFT_Y:Int = 1
Const GAMEPAD_AXIS_RIGHT_X:Int = 2
Const GAMEPAD_AXIS_RIGHT_Y:Int = 3
Const GAMEPAD_AXIS_LEFT_TRIGGER:Int = 4
Const GAMEPAD_AXIS_RIGHT_TRIGGER:Int = 5

' Material map index
Const MATERIAL_MAP_ALBEDO:Int = 0       ' MAP_DIFFUSE
Const MATERIAL_MAP_METALNESS:Int = 1       ' MAP_SPECULAR
Const MATERIAL_MAP_NORMAL:Int = 2
Const MATERIAL_MAP_ROUGHNESS:Int = 3
Const MATERIAL_MAP_OCCLUSION:Int = 4
Const MATERIAL_MAP_EMISSION:Int = 5
Const MATERIAL_MAP_HEIGHT:Int = 6
Const MATERIAL_MAP_CUBEMAP:Int = 7             ' NOTE: Uses GL_TEXTURE_CUBE_MAP
Const MATERIAL_MAP_IRRADIANCE:Int = 8          ' NOTE: Uses GL_TEXTURE_CUBE_MAP
Const MATERIAL_MAP_PREFILTER:Int = 9           ' NOTE: Uses GL_TEXTURE_CUBE_MAP
Const MATERIAL_MAP_BRDF:Int = 10

Const MATERIAL_MAP_DIFFUSE:Int = MATERIAL_MAP_ALBEDO
Const MATERIAL_MAP_SPECULAR:Int = MATERIAL_MAP_METALNESS

' Shader uniform data type
Const SHADER_UNIFORM_FLOAT:Int = 0
Const SHADER_UNIFORM_VEC2:Int = 1
Const SHADER_UNIFORM_VEC3:Int = 2
Const SHADER_UNIFORM_VEC4:Int = 3
Const SHADER_UNIFORM_INT:Int = 4
Const SHADER_UNIFORM_IVEC2:Int = 5
Const SHADER_UNIFORM_IVEC3:Int = 6
Const SHADER_UNIFORM_IVEC4:Int = 7
Const SHADER_UNIFORM_SAMPLER2D:Int = 8

' Shader location index
Const SHADER_LOC_VERTEX_POSITION:Int = 0
Const SHADER_LOC_VERTEX_TEXCOORD01:Int = 1
Const SHADER_LOC_VERTEX_TEXCOORD02:Int = 2
Const SHADER_LOC_VERTEX_NORMAL:Int = 3
Const SHADER_LOC_VERTEX_TANGENT:Int = 4
Const SHADER_LOC_VERTEX_COLOR:Int = 5
Const SHADER_LOC_MATRIX_MVP:Int = 6
Const SHADER_LOC_MATRIX_MODEL:Int = 7
Const SHADER_LOC_MATRIX_VIEW:Int = 8
Const SHADER_LOC_MATRIX_PROJECTION:Int = 9
Const SHADER_LOC_VECTOR_VIEW:Int = 10
Const SHADER_LOC_COLOR_DIFFUSE:Int = 11
Const SHADER_LOC_COLOR_SPECULAR:Int = 12
Const SHADER_LOC_COLOR_AMBIENT:Int = 13
Const SHADER_LOC_MAP_ALBEDO:Int = 14          ' LOC_MAP_DIFFUSE
Const SHADER_LOC_MAP_METALNESS:Int = 15       ' LOC_MAP_SPECULAR
Const SHADER_LOC_MAP_NORMAL:Int = 16
Const SHADER_LOC_MAP_ROUGHNESS:Int = 17
Const SHADER_LOC_MAP_OCCLUSION:Int = 18
Const SHADER_LOC_MAP_EMISSION:Int = 19
Const SHADER_LOC_MAP_HEIGHT:Int = 20
Const SHADER_LOC_MAP_CUBEMAP:Int = 21
Const SHADER_LOC_MAP_IRRADIANCE:Int = 22
Const SHADER_LOC_MAP_PREFILTER:Int = 23
Const SHADER_LOC_MAP_BRDF:Int = 24
Const SHADER_LOC_VERTEX_BONEIDS:Int = 25
Const SHADER_LOC_VERTEX_BONEWEIGHTS:Int = 26
Const SHADER_LOC_BONE_MATRICES:Int = 27

' Shader attribute data types
Const SHADER_ATTRIB_FLOAT:Int = 0
Const SHADER_ATTRIB_VEC2:Int = 1
Const SHADER_ATTRIB_VEC3:Int = 2
Const SHADER_ATTRIB_VEC4:Int = 3

' Font type, defines generation method
Const FONT_DEFAULT:Int = 0
Const FONT_BITMAP:Int = 1
Const FONT_SDF:Int = 2

Const PIXELFORMAT_UNCOMPRESSED_GRAYSCALE:Int = 1
Const PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA:Int = 2
Const PIXELFORMAT_UNCOMPRESSED_R5G6B5:Int = 3
Const PIXELFORMAT_UNCOMPRESSED_R8G8B8:Int = 4
Const PIXELFORMAT_UNCOMPRESSED_R5G5B5A1:Int = 5
Const PIXELFORMAT_UNCOMPRESSED_R4G4B4A4:Int = 6
Const PIXELFORMAT_UNCOMPRESSED_R8G8B8A8:Int = 7
Const PIXELFORMAT_UNCOMPRESSED_R32:Int = 8
Const PIXELFORMAT_UNCOMPRESSED_R32G32B32:Int = 9
Const PIXELFORMAT_UNCOMPRESSED_R32G32B32A32:Int = 10
Const PIXELFORMAT_UNCOMPRESSED_R16:Int = 11
Const PIXELFORMAT_UNCOMPRESSED_R16G16B16:Int = 12
Const PIXELFORMAT_UNCOMPRESSED_R16G16B16A16:Int = 13
Const PIXELFORMAT_COMPRESSED_DXT1_RGB:Int = 14
Const PIXELFORMAT_COMPRESSED_DXT1_RGBA:Int = 15
Const PIXELFORMAT_COMPRESSED_DXT3_RGBA:Int = 16
Const PIXELFORMAT_COMPRESSED_DXT5_RGBA:Int = 17
Const PIXELFORMAT_COMPRESSED_ETC1_RGB:Int = 18
Const PIXELFORMAT_COMPRESSED_ETC2_RGB:Int = 19
Const PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA:Int = 20
Const PIXELFORMAT_COMPRESSED_PVRT_RGB:Int = 21
Const PIXELFORMAT_COMPRESSED_PVRT_RGBA:Int = 22
Const PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA:Int = 23
Const PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA:Int = 24

Const GESTURE_NONE:Int = 0
Const GESTURE_TAP:Int = 1
Const GESTURE_DOUBLETAP:Int = 2
Const GESTURE_HOLD:Int = 4
Const GESTURE_DRAG:Int = 8
Const GESTURE_SWIPE_RIGHT:Int = 16
Const GESTURE_SWIPE_LEFT:Int = 32
Const GESTURE_SWIPE_UP:Int = 64
Const GESTURE_SWIPE_DOWN:Int = 128
Const GESTURE_PINCH_IN:Int = 256
Const GESTURE_PINCH_OUT:Int = 512

Const NPATCH_NINE_PATCH:Int = 0
Const NPATCH_THREE_PATCH_VERTICAL:Int = 1
Const NPATCH_THREE_PATCH_HORIZONTAL:Int = 2
