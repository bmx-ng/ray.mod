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
?

Import "source.bmx"

Extern
	
	Function bmx_raylib_InitWindow(width:Int, height:Int, title:Byte Ptr)="InitWindow"
	Function bmx_raylib_WindowShouldClose:Int()="WindowShouldClose"
	Function bmx_raylib_CloseWindow()
	Function bmx_raylib_IsWindowReady:Int()="IsWindowReady"
	Function bmx_raylib_IsWindowMinimized:Int()="IsWindowMinimized"
	Function bmx_raylib_IsWindowResized:Int()="IsWindowResized"
	Function bmx_raylib_IsWindowHidden:Int()="IsWindowHidden"
	Function bmx_raylib_ToggleFullscreen()="ToggleFullscreen"
	Function bmx_raylib_UnhideWindow()="UnhideWindow"
	Function bmx_raylib_HideWindow()="HideWindow"
	Function bmx_raylib_SetWindowIcon(image:RImage)="SetWindowIcon"
	Function bmx_raylib_SetWindowTitle(title:Byte Ptr)="SetWindowTitle"
	Function bmx_raylib_SetWindowPosition(x:Int, y:Int)="SetWindowPosition"
	Function bmx_raylib_SetWindowMonitor(monitor:Int)="SetWindowMonitor"
	Function bmx_raylib_SetWindowMinSize(width:Int, height:Int)="SetWindowMinSize"
	Function bmx_raylib_SetWindowSize(width:Int, height:Int)="SetWindowSize"
	Function bmx_raylib_GetWindowHandle:Byte Ptr()="GetWindowHandle"
	Function bmx_raylib_GetScreenWidth:Int()="GetScreenWidth"
	Function bmx_raylib_GetScreenHeight:Int()="GetScreenHeight"
	Function bmx_raylib_GetMonitorCount:Int()="GetMonitorCount"
	Function bmx_raylib_GetMonitorWidth:Int(monitor:Int)="GetMonitorWidth"
	Function bmx_raylib_GetMonitorHeight:Int(monitor:Int)="GetMonitorHeight"
	Function bmx_raylib_GetMonitorPhysicalWidth:Int(monitor:Int)="GetMonitorPhysicalWidth"
	Function bmx_raylib_GetMonitorPhysicalHeight:Int(monitor:Int)="GetMonitorPhysicalHeight"
	Function bmx_raylib_GetWindowPosition:RVector2()="GetWindowPosition"
	Function bmx_raylib_GetMonitorName:Byte Ptr(monitor:Int)="GetMonitorName"
	Function bmx_raylib_GetClipboardText:Byte Ptr()="GetClipboardText"
	Function bmx_raylib_SetClipboardText(txt:Byte Ptr)="SetClipboardText"

	Function bmx_raylib_ShowCursor()
	Function bmx_raylib_HideCursor()="HideCursor"
	Function bmx_raylib_IsCursorHidden:Int()="IsCursorHidden"
	Function bmx_raylib_EnableCursor()="EnableCursor"
	Function bmx_raylib_DisableCursor()="DisableCursor"

	Function bmx_raylib_ClearBackground(color:RColor)="ClearBackground"
	Function bmx_raylib_BeginDrawing()="BeginDrawing"
	Function bmx_raylib_EndDrawing()="EndDrawing"
	Function bmx_raylib_BeginMode2D(camera:RCamera2D)="BeginMode2D"
	Function bmx_raylib_EndMode2D()="EndMode2D"
	Function bmx_raylib_BeginMode3D(camera:RCamera)="BeginMode3D"
	Function bmx_raylib_EndMode3D()="EndMode3D"
	Function bmx_raylib_BeginTextureMode(target:RRenderTexture2D)="BeginTextureMode"
	Function bmx_raylib_EndTextureMode()="EndTextureMode"
	Function bmx_raylib_BeginScissorMode(x:Int, y:Int, width:Int, height:Int)="BeginScissorMode"
	Function bmx_raylib_EndScissorMode()="EndScissorMode"

	Function bmx_raylib_GetMouseRay:RRay(mousePosition:RVector2, camera:RCamera)="GetMouseRay"
	Function bmx_raylib_GetCameraMatrix:RMatrix(camera:RCamera)="GetCameraMatrix"
	Function bmx_raylib_GetCameraMatrix2D:RMatrix(camera:RCamera2D)="GetCameraMatrix2D"
	Function bmx_raylib_GetWorldToScreen:RVector2(position:RVector3, camera:RCamera)="GetWorldToScreen"
	Function bmx_raylib_GetWorldToScreenEx:RVector2(position:RVector3, camera:RCamera, width:Int, height:Int)="GetWorldToScreenEx"
	Function bmx_raylib_GetWorldToScreen2D:RVector2(position:RVector2, camera:RCamera2D)="GetWorldToScreen2D"
	Function bmx_raylib_GetScreenToWorld2D:RVector2(position:RVector2, camera:RCamera2D)="GetScreenToWorld2D"

	Function bmx_raylib_DrawFPS(posX:Int, posY:Int)="DrawFPS"
	Function bmx_raylib_DrawText(txt:Byte Ptr, posX:Int, posY:Int, FontSize:Int, color:RColor)
	Function bmx_raylib_DrawTextEx(font:RFont, txt:Byte Ptr, position:RVector2, FontSize:Float, spacing:Float, tint:RColor)
	Function bmx_raylib_DrawTextRec(font:RFont, txt:Byte Ptr, rec:RRectangle, FontSize:Float, spacing:Float, wordWrap:Int, tint:RColor)="DrawTextRec"
	Function bmx_raylib_DrawTextRecEx(font:RFont, txt:Byte Ptr, rec:RRectangle, FontSize:Float, spacing:Float, wordWrap:Int, tint:RColor, selectStart:Int, selectLength:Int, selectTint:RColor, selectBackTint:RColor)="DrawTextRecEx"
	Function bmx_raylib_DrawTextCodepoint(font:RFont, codepoint:Int, position:RVector2, scale:Float, tint:RColor)="DrawTextCodepoint"

	Function bmx_raylib_SetTargetFPS(fps:Int)="SetTargetFPS"
	Function bmx_raylib_GetFPS:Int()="GetFPS"
	Function bmx_raylib_GetFrameTime:Float()="GetFrameTime"
	Function bmx_raylib_GetTime:Double()="GetTime"

	Function bmx_raylib_DrawPixel(posX:Int, posY:Int, color:RColor)="DrawPixel"
	Function bmx_raylib_DrawPixelV(position:RVector2, color:RColor)="DrawPixelV"
	Function bmx_raylib_DrawLine(startPosX:Int, startPosY:Int, endPosX:Int, endPosY:Int, color:RColor)="DrawLine"
	Function bmx_raylib_DrawLineV(startPos:RVector2, endPos:RVector2, color:RColor)="DrawLineV"
	Function bmx_raylib_DrawLineEx(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)="DrawLineEx"
	Function bmx_raylib_DrawLineBezier(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)="DrawLineBezier"
	Function bmx_raylib_DrawLineStrip(points:RVector2 Ptr, numPoints:Int, color:RColor)="DrawLineStrip"
	Function bmx_raylib_DrawCircle(centerX:Int, centerY:Int, radius:Float, color:RColor)="DrawCircle"
	Function bmx_raylib_DrawCircleSector(center:RVector2, radius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)="DrawCircleSector"
	Function bmx_raylib_DrawCircleSectorLines(center:RVector2, radius:Float, startAngle:Int, endAngle:Int, segments:Int, color:RColor)="DrawCircleSectorLines"
	Function bmx_raylib_DrawCircleGradient(centerX:Int, centerY:Int, radius:Float, color1:RColor, color2:RColor)="DrawCircleGradient"
	Function bmx_raylib_DrawCircleV(center:RVector2, radius:Float, color:RColor)="DrawCircleV"
	Function bmx_raylib_DrawCircleLines(centerX:Int, centerY:Int, radius:Float, color:RColor)="DrawCircleLines"
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
	Function bmx_raylib_DrawTriangle(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)="DrawTriangle"
	Function bmx_raylib_DrawTriangleLines(v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)="DrawTriangleLines"
	Function bmx_raylib_DrawTriangleFan(points:RVector2 Ptr, numPoints:Int, color:RColor)="DrawTriangleFan"
	Function bmx_raylib_DrawTriangleStrip(points:RVector2 Ptr, pointsCount:Int, color:RColor)="DrawTriangleStrip"
	Function bmx_raylib_DrawPoly(center:RVector2, sides:Int, radius:Float, Rotation:Float, color:RColor)="DrawPoly"
	Function bmx_raylib_DrawPolyLines(center:RVector2, sides:Int, radius:Float, Rotation:Float, color:RColor)="DrawPolyLines"

	Function bmx_raylib_SetConfigFlags(flags:UInt)="SetConfigFlags"
	Function bmx_raylib_TakeScreenshot(fileName:Byte Ptr)="TakeScreenshot"
	Function bmx_raylib_GetRandomValue:Int(minimum:Int, maximum:Int)="GetRandomValue"

	Function bmx_raylib_IsKeyPressed:Int(key:Int)="IsKeyPressed"
	Function bmx_raylib_IsKeyDown:Int(key:Int)="IsKeyDown"
	Function bmx_raylib_IsKeyReleased:Int(key:Int)="IsKeyReleased"
	Function bmx_raylib_IsKeyUp:Int(key:Int)="IsKeyUp"
	Function bmx_raylib_SetExitKey(key:Int)="SetExitKey"
	Function bmx_raylib_GetKeyPressed:Int()="GetKeyPressed"

	Function bmx_raylib_IsGamepadAvailable:Int(gamepad:Int)="IsGamepadAvailable"
	Function bmx_raylib_IsGamepadName:Int(gamepad:Int, name:Byte Ptr)="IsGamepadName"
	Function bmx_raylib_GetGamepadName:Byte Ptr(gamepad:Int)="GetGamepadName"
	Function bmx_raylib_IsGamepadButtonPressed:Int(gamepad:Int, button:Int)="IsGamepadButtonPressed"
	Function bmx_raylib_IsGamepadButtonDown:Int(gamepad:Int, button:Int)="IsGamepadButtonDown"
	Function bmx_raylib_IsGamepadButtonReleased:Int(gamepad:Int, button:Int)="IsGamepadButtonReleased"
	Function bmx_raylib_IsGamepadButtonUp:Int(gamepad:Int, button:Int)="IsGamepadButtonUp"
	Function bmx_raylib_GetGamepadButtonPressed:Int()="GetGamepadButtonPressed"
	Function bmx_raylib_GetGamepadAxisCount:Int(gamepad:Int)="GetGamepadAxisCount"
	Function bmx_raylib_GetGamepadAxisMovement:Float(gamepad:Int, axis:Int)="GetGamepadAxisMovement"

	Function bmx_raylib_IsMouseButtonPressed:Int(button:Int)="IsMouseButtonPressed"
	Function bmx_raylib_IsMouseButtonDown:Int(button:Int)="IsMouseButtonDown"
	Function bmx_raylib_IsMouseButtonReleased:Int(button:Int)="IsMouseButtonReleased"
	Function bmx_raylib_IsMouseButtonUp:Int(button:Int)="IsMouseButtonUp"
	Function bmx_raylib_GetMouseX:Int()="GetMouseX"
	Function bmx_raylib_GetMouseY:Int()="GetMouseY"
	Function bmx_raylib_GetMousePosition:RVector2()="GetMousePosition"
	Function bmx_raylib_SetMousePosition(x:Int, y:Int)="SetMousePosition"
	Function bmx_raylib_SetMouseOffset(offsetX:Int, offsetY:Int)="SetMouseOffset"
	Function bmx_raylib_SetMouseScale(scaleX:Float, scaleY:Float)="SetMouseScale"
	Function bmx_raylib_GetMouseWheelMove:Int()="GetMouseWheelMove"

	Function bmx_raylib_GetTouchX:Int()="GetTouchX"
	Function bmx_raylib_GetTouchY:Int()="GetTouchY"
	Function bmx_raylib_GetTouchPosition:RVector2(index:Int)="GetTouchPosition"

	Function bmx_raylib_SetGesturesEnabled(gestureFlags:UInt)="SetGesturesEnabled"
	Function bmx_raylib_IsGestureDetected:Int(gesture:Int)="IsGestureDetected"
	Function bmx_raylib_GetGestureDetected:Int()="GetGestureDetected"
	Function bmx_raylib_GetTouchPointsCount:Int()="GetTouchPointsCount"
	Function bmx_raylib_GetGestureHoldDuration:Float()="GetGestureHoldDuration"
	Function bmx_raylib_GetGestureDragVector:RVector2()="GetGestureDragVector"
	Function bmx_raylib_GetGestureDragAngle:Float()="GetGestureDragAngle"
	Function bmx_raylib_GetGesturePinchVector:RVector2()="GetGesturePinchVector"
	Function bmx_raylib_GetGesturePinchAngle:Float()="GetGesturePinchAngle"
	
	Function bmx_raylib_ColorToInt:Int(color:RColor)="ColorToInt"
	Function bmx_raylib_ColorNormalize:RVector4(color:RColor)="ColorNormalize"
	Function bmx_raylib_ColorFromNormalized:RColor(normalized:RVector4)="ColorFromNormalized"
	Function bmx_raylib_ColorToHSV:RVector3(color:RColor)="ColorToHSV"
	Function bmx_raylib_ColorFromHSV:RColor(hsv:RVector3)="ColorFromHSV"
	Function bmx_raylib_GetColor:RColor(hexValue:Int)="GetColor"
	Function bmx_raylib_Fade:RColor(color:RColor, alpha:Float)="Fade"

	Function bmx_raylib_SetCameraMode(camera:RCamera, Mode:Int)="SetCameraMode"
	Function bmx_raylib_UpdateCamera(camera:RCamera Var)="UpdateCamera"
	Function bmx_raylib_SetCameraPanControl(panKey:Int)="SetCameraPanControl"
	Function bmx_raylib_SetCameraAltControl(altKey:Int)="SetCameraAltControl"
	Function bmx_raylib_SetCameraSmoothZoomControl(szKey:Int)="SetCameraSmoothZoomControl"
	Function bmx_raylib_SetCameraMoveControls(frontKey:Int, backKey:Int, rightKey:Int, leftKey:Int, upKey:Int, downKey:Int)="SetCameraMoveControls"

	Function bmx_raylib_DrawLine3D(startPos:RVector3, endPos:RVector3, color:RColor)="DrawLine3D"
	Function bmx_raylib_DrawPoint3D(position:RVector3, color:RColor)="DrawPoint3D"
	Function bmx_raylib_DrawCircle3D(center:RVector3, radius:Float, rotationAxis:RVector3, rotationAngle:Float, color:RColor)="DrawCircle3D"
	Function bmx_raylib_DrawCube(position:RVector3, width:Float, height:Float, length:Float, color:RColor)="DrawCube"
	Function bmx_raylib_DrawCubeV(position:RVector3, size:RVector3, color:RColor)="DrawCubeV"
	Function bmx_raylib_DrawCubeWires(position:RVector3, width:Float, height:Float, length:Float, color:RColor)="DrawCubeWires"
	Function bmx_raylib_DrawCubeWiresV(position:RVector3, size:RVector3, color:RColor)="DrawCubeWiresV"
	Function bmx_raylib_DrawCubeTexture(texture:RTexture2D, position:RVector3, width:Float, height:Float, length:Float, color:RColor)="DrawCubeTexture"
	Function bmx_raylib_DrawSphere(centerPos:RVector3, radius:Float, color:RColor)="DrawSphere"
	Function bmx_raylib_DrawSphereEx(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)="DrawSphereEx"
	Function bmx_raylib_DrawSphereWires(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)="DrawSphereWires"
	Function bmx_raylib_DrawCylinder(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)="DrawCylinder"
	Function bmx_raylib_DrawCylinderWires(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)="DrawCylinderWires"
	Function bmx_raylib_DrawPlane(centerPos:RVector3, size:RVector2, color:RColor)="DrawPlane"
	Function bmx_raylib_DrawRay(ray:RRay, color:RColor)="DrawRay"
	Function bmx_raylib_DrawGrid(slices:Int, spacing:Float)="DrawGrid"
	Function bmx_raylib_DrawGizmo(position:RVector3)="DrawGizmo"

	Function bmx_raylib_LoadImage:RImage(filename:Byte Ptr)
	Function bmx_raylib_LoadImageEx:RImage(pixels:RColor Ptr, width:Int, height:Int)="LoadImageEx"
	Function bmx_raylib_LoadImagePro:RImage(data:Byte Ptr, width:Int, height:Int, format:Int)="LoadImagePro"
	Function bmx_raylib_LoadImageRaw:RImage(filename:Byte Ptr, width:Int, height:Int, format:Int, headerSize:Int)="LoadImageRaw"
	Function bmx_raylib_ExportImage(image:RImage, filename:Byte Ptr)="ExportImage"
	Function bmx_raylib_ExportImageAsCode(image:RImage, filename:Byte Ptr)="ExportImageAsCode"
	Function bmx_raylib_LoadTexture:RTexture2D(filename:Byte Ptr)="LoadTexture"
	Function bmx_raylib_LoadTextureFromImage:RTexture2D(image:RImage)="LoadTextureFromImage"
	Function bmx_raylib_LoadRenderTexture:RRenderTexture2D(width:Int, height:Int)="LoadRenderTexture"
	Function bmx_raylib_LoadTextureCubemap:RTextureCubemap(image:RImage, layoutType:Int)="LoadTextureCubemap"
	Function bmx_raylib_UnloadImage(image:RImage)="UnloadImage"
	Function bmx_raylib_UnloadTexture(texture:RTexture2D)="UnloadTexture"
	Function bmx_raylib_UnloadRenderTexture(target:RRenderTexture2D)="UnloadRenderTexture"
	Function bmx_raylib_GetImageData:RColor Ptr(image:RImage)="GetImageData"
	Function bmx_raylib_GetImageDataNormalized:RVector4 Ptr(image:RImage)="GetImageDataNormalized"
	Function bmx_raylib_GetImageAlphaBorder:RRectangle(image:RImage, threshold:Float)="GetImageAlphaBorder"
	Function bmx_raylib_GetPixelDataSize:Int(width:Int, height:Int, format:Int)="GetPixelDataSize"
	Function bmx_raylib_GetTextureData:RImage(texture:RTexture2D)="GetTextureData"
	Function bmx_raylib_GetScreenData:RImage()="GetScreenData"
	Function bmx_raylib_UpdateTexture(texture:RTexture2D, pixels:Byte Ptr)="UpdateTexture"

	Function bmx_raylib_GenTextureMipmaps(texture:RTexture2D Var)="GenTextureMipmaps"
	Function bmx_raylib_SetTextureFilter(texture:RTexture2D, filterMode:Int)="SetTextureFilter"
	Function bmx_raylib_SetTextureWrap(texture:RTexture2D, wrapMode:Int)="SetTextureWrap"

	Function bmx_raylib_DrawTexture(texture:RTexture2D, posX:Int, posY:Int, tint:RColor)="DrawTexture"
	Function bmx_raylib_DrawTextureV(texture:RTexture2D, position:RVector2, tint:RColor)="DrawTextureV"
	Function bmx_raylib_DrawTextureEx(texture:RTexture2D, position:RVector2, Rotation:Float, scale:Float, tint:RColor)="DrawTextureEx"
	Function bmx_raylib_DrawTextureRec(texture:RTexture2D, sourceRec:RRectangle, position:RVector2, tint:RColor)="DrawTextureRec"
	Function bmx_raylib_DrawTextureQuad(texture:RTexture2D, tiling:RVector2, offset:RVector2, quad:RRectangle, tint:RColor)="DrawTextureQuad"
	Function bmx_raylib_DrawTexturePro(texture:RTexture2D, sourceRec:RRectangle, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)="DrawTexturePro"
	Function bmx_raylib_DrawTextureNPatch(texture:RTexture2D, nPatchInfo:RNPatchInfo, destRec:RRectangle, origin:RVector2, Rotation:Float, tint:RColor)="DrawTextureNPatch"

	Function bmx_raylib_CheckCollisionRecs:Int(rec1:RRectangle, rec2:RRectangle)="CheckCollisionRecs"
	Function bmx_raylib_CheckCollisionCircles:Int(center1:RVector2, radius1:Float, center2:RVector2, radius2:Float)="CheckCollisionCircles"
	Function bmx_raylib_CheckCollisionCircleRec:Int(center:RVector2, radius:Float, rec:RRectangle)="CheckCollisionCircleRec"
	Function bmx_raylib_GetCollisionRec:RRectangle(rec1:RRectangle, rec2:RRectangle)="GetCollisionRec"
	Function bmx_raylib_CheckCollisionPointRec:Int(point:RVector2, rec:RRectangle)="CheckCollisionPointRec"
	Function bmx_raylib_CheckCollisionPointCircle:Int(point:RVector2, center:RVector2, radius:Float)="CheckCollisionPointCircle"
	Function bmx_raylib_CheckCollisionPointTriangle:Int(point:RVector2, p1:RVector2, p2:RVector2, p3:RVector2)="CheckCollisionPointTriangle"

	Function bmx_raylib_GenImageColor:RImage(width:Int, height:Int, color:RColor)="GenImageColor"
	Function bmx_raylib_GenImageGradientV:RImage(width:Int, height:Int, top:RColor, bottom:RColor)="GenImageGradientV"
	Function bmx_raylib_GenImageGradientH:RImage(width:Int, height:Int, Left:RColor, Right:RColor)="GenImageGradientH"
	Function bmx_raylib_GenImageGradientRadial:RImage(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)="GenImageGradientRadial"
	Function bmx_raylib_GenImageChecked:RImage(width:Int, height:Int, checksX:Int, checksY:Int, col1:RColor, col2:RColor)="GenImageChecked"
	Function bmx_raylib_GenImageWhiteNoise:RImage(width:Int, height:Int, factor:Float)="GenImageWhiteNoise"
	Function bmx_raylib_GenImagePerlinNoise:RImage(width:Int, height:Int, offsetX:Int, offsetY:Int, scale:Float)="GenImagePerlinNoise"
	Function bmx_raylib_GenImageCellular:RImage(width:Int, height:Int, tileSize:Int)="GenImageCellular"

	Function bmx_raylib_LoadModel:RModel(filename:Byte Ptr)="LoadModel"
	Function bmx_raylib_LoadModelFromMesh:RModel(mesh:RMesh)="LoadModelFromMesh"
	Function bmx_raylib_UnloadModel(model:RModel)="UnloadModel"

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

	Function bmx_raylib_MeshBoundingBox:RBoundingBox(mesh:RMesh)="MeshBoundingBox"
	Function bmx_raylib_MeshTangents(mesh:RMesh Var)="MeshTangents"
	Function bmx_raylib_MeshBinormals(mesh:RMesh Var)="MeshBinormals"

	Function bmx_raylib_DrawModel(model:RModel, position:RVector3, scale:Float, tint:RColor)="DrawModel"
	Function bmx_raylib_DrawModelEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)="DrawModelEx"
	Function bmx_raylib_DrawModelWires(model:RModel, position:RVector3, scale:Float, tint:RColor)="DrawModelWires"
	Function bmx_raylib_DrawModelWiresEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)="DrawModelWiresEx"
	Function bmx_raylib_DrawBoundingBox(box:RBoundingBox, color:RColor)="DrawBoundingBox"
	Function bmx_raylib_DrawBillboard(camera:RCamera, texture:RTexture2D, center:RVector3, size:Float, tint:RColor)="DrawBillboard"
	Function bmx_raylib_DrawBillboardRec(camera:RCamera, texture:RTexture2D, sourceRec:RRectangle, center:RVector3, size:Float, tint:RColor)="DrawBillboardRec"

	Function bmx_raylib_MeasureText:Int(txt:Byte Ptr, FontSize:Int)="MeasureText"
	Function bmx_raylib_MeasureTextEx:RVector2(font:RFont, txt:Byte Ptr, FontSize:Float, spacing:Float)="MeasureTextEx"
	Function bmx_raylib_GetGlyphIndex:Int(font:RFont, codepoint:Int)="GetGlyphIndex"

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
	Function bmx_raylib_ImageToPOT(image:RImage Var, fillColor:RColor)="ImageToPOT"
	Function bmx_raylib_ImageFormat(image:RImage Var, newFormat:Int)="ImageFormat"
	Function bmx_raylib_ImageAlphaMask(image:RImage Var, alphaMask:RImage)="ImageAlphaMask"
	Function bmx_raylib_ImageAlphaClear(image:RImage Var, color:RColor, threshold:Float)="ImageAlphaClear"
	Function bmx_raylib_ImageAlphaCrop(image:RImage Var, threshold:Float)="ImageAlphaCrop"
	Function bmx_raylib_ImageAlphaPremultiply(image:RImage Var)="ImageAlphaPremultiply"
	Function bmx_raylib_ImageCrop(image:RImage Var, crop:RRectangle)="ImageCrop"
	Function bmx_raylib_ImageResize(image:RImage Var, newWidth:Int, newHeight:Int)="ImageResize"
	Function bmx_raylib_ImageResizeNN(image:RImage Var, newWidth:Int, newHeight:Int)="ImageResizeNN"
	Function bmx_raylib_ImageResizeCanvas(image:RImage Var, newWidth:Int, newHeight:Int, offsetX:Int, offsetY:Int, color:RColor)="ImageResizeCanvas"
	Function bmx_raylib_ImageMipmaps(image:RImage Var)="ImageMipmaps"
	Function bmx_raylib_ImageDither(image:RImage Var, rBpp:Int, gBpp:Int, bBpp:Int, aBpp:Int)="ImageDither"
	Function bmx_raylib_ImageText:RImage(txt:String, FontSize:Int, color:RColor)="ImageText"
	Function bmx_raylib_ImageTextEx:RImage(font:RFont, txt:String, FontSize:Float, spacing:Float, tint:RColor)="ImageTextEx"
	Function bmx_raylib_ImageDraw(dst:RImage Var, src:RImage, srcRec:RRectangle, dstRec:RRectangle, tint:RColor)="ImageDraw"
	Function bmx_raylib_ImageDrawRectangle(dst:RImage Var, rec:RRectangle, color:RColor)="ImageDrawRectangle"
	Function bmx_raylib_ImageDrawRectangleLines(dst:RImage Var, rec:RRectangle, thick:Int, color:RColor)="ImageDrawRectangleLines"
	Function bmx_raylib_ImageDrawText(dst:RImage Var, position:RVector2, txt:String, FontSize:Int, color:RColor)="ImageDrawText"
	Function bmx_raylib_ImageDrawTextEx(dst:RImage Var, position:RVector2, font:RFont, txt:String, FontSize:Float, spacing:Float, color:RColor)="ImageDrawTextEx"
	Function bmx_raylib_ImageFlipVertical(image:RImage Var)="ImageFlipVertical"
	Function bmx_raylib_ImageFlipHorizontal(image:RImage Var)="ImageFlipHorizontal"
	Function bmx_raylib_ImageRotateCW(image:RImage Var)="ImageRotateCW"
	Function bmx_raylib_ImageRotateCCW(image:RImage Var)="ImageRotateCCW"
	Function bmx_raylib_ImageColorTint(image:RImage Var, color:RColor)="ImageColorTint"
	Function bmx_raylib_ImageColorInvert(image:RImage Var)="ImageColorInvert"
	Function bmx_raylib_ImageColorGrayscale(image:RImage Var)="ImageColorGrayscale"
	Function bmx_raylib_ImageColorContrast(image:RImage Var, contrast:Float)="ImageColorContrast"
	Function bmx_raylib_ImageColorBrightness(image:RImage Var, brightness:Int)="ImageColorBrightness"
	Function bmx_raylib_ImageColorReplace(image:RImage Var, color:RColor, Replace:RColor)="ImageColorReplace"

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
End Struct

Struct RCamera
	Field position:RVector3
	Field target:RVector3
	Field up:RVector3
	Field fovy:Float
	Field cameraType:Int
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

Struct RBoundingBox
	Field minimum:RVector3
	Field maximum:RVector3
End Struct

Struct RCharInfo
	Field value:Int
	Field offsetX:Int
	Field offsetY:Int
	Field advanceX:Int
	Field image:RImage
End Struct

Struct RFont
	Field baseSize:Int
	Field charsCount:Int
	Field texture:RTexture2D
	Field recs:RRectangle Ptr
	Field chars:RCharInfo Ptr
End Struct

Struct RNPatchInfo
	Field sourceRec:RRectangle
	Field Left:Int
	Field top:Int
	Field Right:Int
	Field bottom:Int
	Field patchType:Int
End Struct

Struct RModel
	Field transform:RTransform
	
	Field meshCount:Int
	Field meshes:RMesh Ptr
	
	Field materialCount:Int
	Field meterials:RMaterial Ptr
	Field meshMaterial:Int Ptr
	
	Field boneCount:Int
	Field bones:RBoneInfo
	Field bindPose:RTransform
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
End Struct

Struct RMaterial
	Field shader:RShader
	Field map:RMaterialMap
	Field params:Float Ptr
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
	Field name00:Byte
	Field name01:Byte
	Field name02:Byte
	Field name03:Byte
	Field name04:Byte
	Field name05:Byte
	Field name06:Byte
	Field name07:Byte
	Field name08:Byte
	Field name09:Byte
	Field name10:Byte
	Field name12:Byte
	Field name13:Byte
	Field name14:Byte
	Field name15:Byte
	Field name16:Byte
	Field name17:Byte
	Field name18:Byte
	Field name19:Byte
	Field name20:Byte
	Field name21:Byte
	Field name22:Byte
	Field name23:Byte
	Field name24:Byte
	Field name25:Byte
	Field name26:Byte
	Field name27:Byte
	Field name28:Byte
	Field name29:Byte
	Field name30:Byte
	Field name31:Byte
	Field name32:Byte
	Field parent:Int
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
Const KEY_LEFT_BRACKET:Int = 91
Const KEY_BACKSLASH:Int = 92
Const KEY_RIGHT_BRACKET:Int = 93
Const KEY_GRAVE:Int = 96

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

Const CAMERA_PERSPECTIVE:Int = 0
Const CAMERA_ORTHOGRAPHIC:Int = 1

Const CAMERA_CUSTOM:Int = 0
Const CAMERA_FREE:Int = 1
Const CAMERA_ORBITAL:Int = 2
Const CAMERA_FIRST_PERSON:Int = 3
Const CAMERA_THIRD_PERSON:Int = 4

Const BLEND_ALPHA:Int = 0
Const BLEND_ADDITIVE:Int = 1
Const BLEND_MULTIPLIED:Int = 2


Const FLAG_RESERVED:Int           = 1
Const FLAG_FULLSCREEN_MODE:Int    = 2
Const FLAG_WINDOW_RESIZABLE:Int   = 4
Const FLAG_WINDOW_UNDECORATED:Int = 8
Const FLAG_WINDOW_TRANSPARENT:Int = 16
Const FLAG_WINDOW_HIDDEN:Int      = 128
Const FLAG_WINDOW_ALWAYS_RUN:Int  = 256
Const FLAG_MSAA_4X_HINT:Int       = 32
Const FLAG_VSYNC_HINT:Int         = 64


Const FILTER_POINT:Int = 0
Const FILTER_BILINEAR:Int = 1
Const FILTER_TRILINEAR:Int = 2
Const FILTER_ANISOTROPIC_4X:Int = 3
Const FILTER_ANISOTROPIC_8X:Int = 4
Const FILTER_ANISOTROPIC_16X:Int = 5

Const MOUSE_LEFT_BUTTON:Int   = 0
Const MOUSE_RIGHT_BUTTON:Int  = 1
Const MOUSE_MIDDLE_BUTTON:Int = 2
