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
bbdoc: Raylib - Simple Games Programming
End Rem
Module Ray.Lib

ModuleInfo "Version: 1.03"
ModuleInfo "License: zlib"
ModuleInfo "Copyright: Wrapper - 2024 Bruce A Henderson"
ModuleInfo "Copyright: raylib - 2013-2024 Ramon Santamaria"

ModuleInfo "History: 1.03"
ModuleInfo "History: Updated to raylib 5.5.377248b."
ModuleInfo "History: 1.02"
ModuleInfo "History: Updated to raylib 3.0.7ef114d."
ModuleInfo "History: 1.01"
ModuleInfo "History: Updated to raylib 3.0.cb4c676."
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release."


ModuleInfo "CC_OPTS: -std=c99"
ModuleInfo "CC_OPTS: -DSTATIC"
ModuleInfo "CC_OPTS: -DSUPPORT_CAMERA_SYSTEM"
ModuleInfo "CC_OPTS: -DSUPPORT_FILEFORMAT_OBJ -DSUPPORT_FILEFORMAT_IQM -DSUPPORT_FILEFORMAT_GLTF -DSUPPORT_FILEFORMAT_MTL"

?win32
ModuleInfo "CC_OPTS: -DPLATFORM_DESKTOP_GLFW"
ModuleInfo "CC_OPTS: -D_GLFW_WIN32"
?macos
ModuleInfo "CC_OPTS: -DPLATFORM_DESKTOP_GLFW"
ModuleInfo "CC_OPTS: -D_GLFW_COCOA"
?linux And Not raspberrypi
ModuleInfo "CC_OPTS: -DPLATFORM_DESKTOP_GLFW"
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
' Changed config.h to include more image/audio formats.
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
bbdoc: Closes window and unload OpenGL context
End Rem
Function CloseWindow()
	bmx_raylib_CloseWindow()
End Function

Rem
bbdoc: Checks if KEY_ESCAPE pressed or Close icon pressed.
End Rem
Function WindowShouldClose:Int()
	Return bmx_raylib_WindowShouldClose()
End Function

Rem
bbdoc: Checks if window has been initialized successfully.
End Rem
Function IsWindowReady:Int()
	Return bmx_raylib_IsWindowReady()
End Function

Rem
bbdoc: Checks if window is currently fullscreen
End Rem
Function IsWindowFullscreen:Int()
	Return bmx_raylib_IsWindowFullscreen()
End Function

Rem
bbdoc: Checks if window is currently hidden.
End Rem
Function IsWindowHidden:Int()
	Return bmx_raylib_IsWindowHidden()
End Function

Rem
bbdoc: Checks if window has been minimized (or lost focus).
End Rem
Function IsWindowMinimized:Int()
	Return bmx_raylib_IsWindowMinimized()
End Function

Rem
bbdoc: Checks if window has been maximized.
End Rem
Function IsWindowMaximized:Int()
	Return bmx_raylib_IsWindowMaximized()
End Function

Rem
bbdoc: Checks if window is focused.
End Rem
Function IsWindowFocused:Int()
	Return bmx_raylib_IsWindowFocused()
End Function

Rem
bbdoc: Checks if window has been resized.
End Rem
Function IsWindowResized:Int()
	Return bmx_raylib_IsWindowResized()
End Function

Function IsWindowState:Int(flag:UInt)
	Return bmx_raylib_IsWindowState(flag)
End Function

Function SetWindowState(flag:UInt)
	bmx_raylib_SetWindowState(flag)
End Function

Function ClearWindowState(flag:UInt)
	bmx_raylib_ClearWindowState(flag)
End Function

Rem
bbdoc: Toggles fullscreen mode (only Desktop)
End Rem
Function ToggleFullscreen()
	bmx_raylib_ToggleFullscreen()
End Function

Function ToggleBorderlessWindowed()
	bmx_raylib_ToggleBorderlessWindowed()
End Function

Function MaximizeWindow()
	bmx_raylib_MaximizeWindow()
End Function

Function MinimizeWindow()
	bmx_raylib_MinimizeWindow()
End Function

Function RestoreWindow()
	bmx_raylib_RestoreWindow()
End Function

Rem
bbdoc: Sets icon for window (only Desktop)
End Rem
Function SetWindowIcon(image:RImage)
	bmx_raylib_SetWindowIcon(image)
End Function

Function SetWindowIcons(images:RImage[], count:Int)
	bmx_raylib_SetWindowIcons(images, count)
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

Function SetWindowMaxSize(width:Int, height:Int)
	bmx_raylib_SetWindowMaxSize(width, height)
End Function

Rem
bbdoc: Sets window dimensions.
End Rem
Function SetWindowSize(width:Int, height:Int)
	bmx_raylib_SetWindowSize(width, height)
End Function

Function SetWindowOpacity(opacity:Float)
	bmx_raylib_SetWindowOpacity(opacity)
End Function

Function SetWindowFocused()
	bmx_raylib_SetWindowFocused()
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

Function GetRenderWidth:Int()
	Return bmx_raylib_GetRenderWidth()
End Function

Function GetRenderHeight:Int()
	Return bmx_raylib_GetRenderHeight()
End Function

Rem
bbdoc: Gets number of connected monitors.
End Rem
Function GetMonitorCount:Int()
	Return bmx_raylib_GetMonitorCount()
End Function

Function GetCurrentMonitor:Int()
	Return bmx_raylib_GetCurrentMonitor()
End Function

Function GetMonitorPosition:RVector2(monitor:Int)
	Return bmx_raylib_GetMonitorPosition(monitor)
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

Function GetMonitorRefreshRate:Int(monitor:Int)
	Return bmx_raylib_GetMonitorRefreshRate(monitor)
End Function

Rem
bbdoc: Gets window position XY on monitor.
End Rem
Function GetWindowPosition:RVector2()
	Return bmx_raylib_GetWindowPosition()
End Function

Function GetWindowScaleDPI:RVector2()
	Return bmx_raylib_GetWindowScaleDPI()
End Function

Rem
bbdoc: Gets the human-readable name of the primary monitor.
End Rem
Function GetMonitorName:String(monitor:Int)
	Local n:Byte Ptr = bmx_raylib_GetMonitorName(monitor)
	Return String.FromUTF8String(n)
End Function

Rem
bbdoc: Sets clipboard text content.
End Rem
Function SetClipboardText(txt:String)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_SetClipboardText(t)
	MemFree(t)
End Function

Rem
bbdoc: Gets clipboard text content.
End Rem
Function GetClipboardText:String()
	Local t:Byte Ptr = bmx_raylib_GetClipboardText()
	Return String.FromUTF8String(t)
End Function

Rem
bbdoc: Gets clipboard image.
End Rem
Function GetClipboardImage:RImage()
	Return bmx_raylib_GetClipboardImage()
End Function

Rem
bbdoc: Enables waiting for events on EndDrawing(), no automatic event polling
End Rem
Function EnableEventWaiting()
	bmx_raylib_EnableEventWaiting()
End Function

Rem
bbdoc: Disables waiting for events on EndDrawing(), automatic events polling
End Rem
Function DisableEventWaiting()
	bmx_raylib_DisableEventWaiting()
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

Function IsCursorOnScreen:Int()
	Return bmx_raylib_IsCursorOnScreen()
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
bbdoc: Begins custom shader drawing.
End Rem
Function BeginShaderMode(shader:RShader)
	bmx_raylib_BeginShaderMode(shader)
End Function

Rem
bbdoc: Ends custom shader drawing (use default shader).
End Rem
Function EndShaderMode()
	bmx_raylib_EndShaderMode()
End Function

Rem
bbdoc: Begins blending mode (alpha, additive, multiplied).
End Rem
Function BeginBlendMode(Mode:Int)
	bmx_raylib_BeginBlendMode(Mode)
End Function

Rem
bbdoc: Ends blending mode (reset to default: alpha blending).
End Rem
Function EndBlendMode()
	bmx_raylib_EndBlendMode()
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

Rem
bbdoc: Begins stereo rendering (requires VR simulator).
End Rem
Function BeginVrStereoMode(vrConfig:RVrStereoConfig)
	bmx_raylib_BeginVrStereoMode(vrConfig)
End Function

Rem
bbdoc: Ends stereo rendering (requires VR simulator)'
End Rem
Function EndVrStereoMode()
	bmx_raylib_EndVrStereoMode()
End Function

' VR stereo config functions for VR simulator
Function LoadVrStereoConfig:RVrStereoConfig(device:RVrDeviceInfo)
	Return bmx_raylib_LoadVrStereoConfig(device)
End Function

Function UnloadVrStereoConfig(config:RVrStereoConfig)
	bmx_raylib_UnloadVrStereoConfig(config)
End Function

' Shader management functions
Function LoadShader:RShader(vsFileName:String, fsFileName:String)
	Local vs:Byte Ptr = vsFileName.ToUTF8String()
	Local fs:Byte Ptr = fsFileName.ToUTF8String()
	Local result:RShader = bmx_raylib_LoadShader(vs, fs)
	MemFree(vs)
	MemFree(fs)
	Return result
End Function

Function LoadShaderFromMemory:RShader(vsCode:String, fsCode:String)
	Local vs:Byte Ptr = vsCode.ToUTF8String()
	Local fs:Byte Ptr = fsCode.ToUTF8String()
	Local result:RShader = bmx_raylib_LoadShaderFromMemory(vs, fs)
	MemFree(vs)
	MemFree(fs)
	Return result
End Function

Function IsShaderValid:Int(shader:RShader)
	Return bmx_raylib_IsShaderValid(shader)
End Function

Function GetShaderLocation:Int(shader:RShader, uniformName:String)
	Local n:Byte Ptr = uniformName.ToUTF8String()
	Local result:Int = bmx_raylib_GetShaderLocation(shader, n)
	MemFree(n)
	Return result
End Function

Function GetShaderLocationAttrib:Int(shader:RShader, attribName:String)
	Local n:Byte Ptr = attribName.ToUTF8String()
	Local result:Int = bmx_raylib_GetShaderLocationAttrib(shader, n)
	MemFree(n)
	Return result
End Function

Function SetShaderValue(shader:RShader, loc:Int, value:Byte Ptr, uniformType:Int)
	bmx_raylib_SetShaderValue(shader, loc, value, uniformType)
End Function

Function SetShaderValueV(shader:RShader, loc:Int, value:Byte Ptr, uniformType:Int, count:Int)
	bmx_raylib_SetShaderValueV(shader, loc, value, uniformType, count)
End Function

Function SetShaderValueMatrix(shader:RShader, loc:Int, mat:RMatrix)
	bmx_raylib_SetShaderValueMatrix(shader, loc, mat)
End Function

Function SetShaderValueTexture(shader:RShader, loc:Int, texture:RTexture2D)
	bmx_raylib_SetShaderValueTexture(shader, loc, texture)
End Function

Function UnloadShader(shader:RShader)
	bmx_raylib_UnloadShader(shader)
End Function

' Screen-space-related functions
Rem
bbdoc: Returns a ray trace from mouse position.
End Rem
Function GetScreenToWorldRay:RRay(mousePosition:RVector2, camera:RCamera)
	Return bmx_raylib_GetScreenToWorldRay(mousePosition, camera)
End Function

Rem
bbdoc: Gets a ray trace from screen position (i.e mouse) in a viewport.
End Rem
Function GetScreenToWorldRayEx:RRay(mousePosition:RVector2, camera:RCamera, width:Int, height:Int)
	Return bmx_raylib_GetScreenToWorldRayEx(mousePosition, camera, width, height)
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


' Timing-related functions
Rem
bbdoc: Sets target FPS (maximum).
End Rem
Function SetTargetFPS(fps:Int)
	bmx_raylib_SetTargetFPS(fps)
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

Rem
bbdoc: Returns current FPS.
End Rem
Function GetFPS:Int()
	Return bmx_raylib_GetFPS()
End Function

' Custom frame control functions
Rem
bbdoc: Swaps back buffer with front buffer (screen drawing).
End Rem
Function SwapScreenBuffer()
	bmx_raylib_SwapScreenBuffer()
End Function

Rem
bbdoc: Registers all input events.
End Rem
Function PollInputEvents()
	bmx_raylib_PollInputEvents()
End Function

Rem
bbdoc: Waits for some time (halt program execution).
End Rem
Function WaitTime(seconds:Double)
	bmx_raylib_WaitTime(seconds)
End Function


' Random values generation functions
Function SetRandomSeed(seed:UInt)
	bmx_raylib_SetRandomSeed(seed)
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

Rem
bbdoc: Loads random values sequence, no values repeated.
End Rem
Function LoadRandomSequence:Int Ptr(count:UInt, min:Int, max:Int)
	Return bmx_raylib_LoadRandomSequence(count, min, max)
End Function

Rem
bbdoc: Unloads random values sequence.
End Rem
Function UnloadRandomSequence(sequence:Int Ptr)
	bmx_raylib_UnloadRandomSequence(sequence)
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
bbdoc: Opens URL with default system browser (if available).
End Rem
Function OpenURL(url:String)
	Local u:Byte Ptr = url.ToUTF8String()
	bmx_raylib_OpenURL(u)
	MemFree(u)
End Function

Rem
bbdoc: Internal memory allocator.
End Rem
Function RMemAlloc:Byte Ptr(size:UInt)
	Return bmx_raylib_MemAlloc(size)
End Function

Rem
bbc: Internal memory reallocator.
End Rem
Function RMemRealloc:Byte Ptr(data:Byte Ptr, size:UInt)
	Return bmx_raylib_MemRealloc(data, size)
End Function

Rem
bbdoc: Internal memory free.
End Rem
Function RMemFree(data:Byte Ptr)
	bmx_raylib_MemFree(data)
End Function


' Input-related functions: keyboard
Rem
bbdoc: Detects if a key has been pressed once.
End Rem
Function IsKeyPressed:Int(key:Int)
	Return bmx_raylib_IsKeyPressed(key)
End Function

Rem
bbdoc: Checks if a key has been pressed again.
End Rem
Function IsKeyPressedRepeat:Int(key:Int)
	Return bmx_raylib_IsKeyPressedRepeat(key)
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
bbdoc: Gets key pressed, call it multiple times for chars queued.
End Rem
Function GetKeyPressed:Int()
	Return bmx_raylib_GetKeyPressed()
End Function

Rem
bbdoc: Gets char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
End Rem
Function GetCharPressed:Int()
	Return bmx_raylib_GetCharPressed()
End Function

Rem
bbdoc: Sets a custom key to exit program (default is ESC).
End Rem
Function SetExitKey(key:Int)
	bmx_raylib_SetExitKey(Key)
End Function

' Input-related functions: gamepads
Rem
bbdoc: Detects if a gamepad is available.
End Rem
Function IsGamepadAvailable:Int(gamepad:Int)
	Return bmx_raylib_IsGamepadAvailable(gamepad:Int)
End Function

' Rem
' bbdoc: Checks gamepad name (if available).
' End Rem
' Function IsGamepadName:Int(gamepad:Int, name:String)
' 	Local n:Byte Ptr = name.ToUTF8String()
' 	Local res:Int = bmx_raylib_IsGamepadName(gamepad:Int, n)
' 	MemFree(n)
' 	Return res
' End Function

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

Rem
bbdoc: Sets internal gamepad mappings (SDL_GameControllerDB)
End Rem
Function SetGamepadMappings:Int(mappings:String)
	Local m:Byte Ptr = mappings.ToUTF8String()
	Local res:Int = bmx_raylib_SetGamepadMappings(m)
	MemFree(m)
	Return res
End Function

Rem
bbdoc: Sets gamepad vibration for both motors (duration in seconds)
End Rem
Function SetGamepadVibration(gamepad:Int, leftMotor:Float, rightMotor:Float, duration:Float)
	bmx_raylib_SetGamepadVibration(gamepad, leftMotor, rightMotor, duration)
End Function

' Input-related functions: mouse
Rem
bbdoc: Detects if a mouse button has been pressed once.
End Rem
Function IsMouseButtonPressed:Int(button:Int)
	Return bmx_raylib_IsMouseButtonPressed(button:Int)
End Function

Rem
bbdoc: Detects if a mouse button is being pressed.
End Rem
Function IsMouseButtonDown:Int(button:Int)
	Return bmx_raylib_IsMouseButtonDown(button:Int)
End Function

Rem
bbdoc: Detects if a mouse button has been released once.
End Rem
Function IsMouseButtonReleased:Int(button:Int)
	Return bmx_raylib_IsMouseButtonReleased(button:Int)
End Function

Rem
bbdoc: Detects if a mouse button is NOT being pressed.
End Rem
Function IsMouseButtonUp:Int(button:Int)
	Return bmx_raylib_IsMouseButtonUp(button:Int)
End Function

Rem
bbdoc: Returns mouse position X.
End Rem
Function GetMouseX:Int()
	Return bmx_raylib_GetMouseX()
End Function

Rem
bbdoc: Returns mouse position Y.
End Rem
Function GetMouseY:Int()
	Return bmx_raylib_GetMouseY()
End Function

Rem
bbdoc: Returns mouse position XY.
End Rem
Function GetMousePosition:RVector2()
	Return bmx_raylib_GetMousePosition()
End Function

Rem
bbdoc: 
End Rem
Function GetMouseDelta:RVector2()
	Return bmx_raylib_GetMouseDelta()
End Function

Rem
bbdoc: Sets mouse position XY.
End Rem
Function SetMousePosition(x:Int, y:Int)
	bmx_raylib_SetMousePosition(x:Int, y:Int)
End Function

Rem
bbdoc: Sets mouse offset.
End Rem
Function SetMouseOffset(offsetX:Int, offsetY:Int)
	bmx_raylib_SetMouseOffset(offsetX:Int, offsetY:Int)
End Function

Rem
bbdoc: Sets mouse scaling.
End Rem
Function SetMouseScale(scaleX:Float, scaleY:Float)
	bmx_raylib_SetMouseScale(scaleX:Float, scaleY:Float)
End Function

Rem
bbdoc: Gets mouse wheel movement for X or Y, whichever is larger.
End Rem
Function GetMouseWheelMove:Float()
	Return bmx_raylib_GetMouseWheelMove()
End Function

Rem
bbdoc: Gets mouse wheel movement for both X and Y.
End Rem
Function GetMouseWheelMoveV:RVector2()
	Return bmx_raylib_GetMouseWheelMoveV()
End Function

Rem
bbdoc: Sets mouse cursor.
End Rem
Function SetMouseCursor(cursor:Int)
	bmx_raylib_SetMouseCursor(cursor)
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

Rem
bbdoc: Gets touch point identifier for given index.
End Rem
Function GetTouchPointId:Int(index:Int)
	Return bmx_raylib_GetTouchPointId(index)
End Function

Rem
bbdoc: Gets number of touch points.
End Rem
Function GetTouchPointCount:Int()
	Return bmx_raylib_GetTouchPointCount()
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

' Camera System Functions (Module: rcamera)
Rem
bbdoc: Updates camera position for selected mode.
End Rem
Function UpdateCamera(camera:RCamera Var, mode:Int)
	bmx_raylib_UpdateCamera(camera, mode:Int)
End Function

Function UpdateCameraPro(camera:RCamera Var, movement:RVector3, rotation:RVector3, zoom:Float)
	bmx_raylib_UpdateCameraPro(camera, movement, rotation, zoom)
End Function

' Basic Shapes Drawing Functions (Module: shapes)
Rem
bbdoc: Defines default texture used to draw shapes.
End Rem
Function SetShapesTexture(texture:RTexture2D, source:RRectangle)
	bmx_raylib_SetShapesTexture(texture, source)
End Function

Rem
bbdoc: Gets texture to draw shapes.
End Rem
Function GetShapesTexture:RTexture2D()
	Return bmx_raylib_GetShapesTexture()
End Function

Rem
bbdoc: Gets texture rectangle to draw shapes.
End Rem
Function GetShapesTextureRectangle:RRectangle()
	Return bmx_raylib_GetShapesTextureRectangle()
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
bbdoc: Draws lines sequence.
End Rem
Function DrawLineStrip(points:RVector2 Ptr, numPoints:Int, color:RColor)
	bmx_raylib_DrawLineStrip(points, numPoints, color)
End Function

Rem
bbdoc: Draws a line using cubic-bezier curves in-out.
End Rem
Function DrawLineBezier(startPos:RVector2, endPos:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawLineBezier(startPos, endPos, thick, color)
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
Function DrawCircleSector(center:RVector2, radius:Float, startAngle:Float, endAngle:Float, segments:Int, color:RColor)
	bmx_raylib_DrawCircleSector(center, radius, startAngle, endAngle, segments, color)
End Function

Rem
bbdoc: Draws circle sector outline.
End Rem
Function DrawCircleSectorLines(center:RVector2, radius:Float, startAngle:Float, endAngle:Float, segments:Int, color:RColor)
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

Function DrawCircleLinesV(center:RVector2, radius:Float, color:RColor)
	bmx_raylib_DrawCircleLinesV(center, radius, color)
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

Function DrawRectangleRoundedLinesEx(rec:RRectangle, roundness:Float, segments:Int, lineThick:Int, color:RColor)
	bmx_raylib_DrawRectangleRoundedLinesEx(rec, roundness, segments, lineThick, color)
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

Function DrawPolyLinesEx(center:RVector2, sides:Int, radius:Float, rotation:Float, lineThick:Int, color:RColor)
	bmx_raylib_DrawPolyLinesEx(center, sides, radius, rotation, lineThick, color)
End Function

' Splines drawing functions
Function DrawSplineLinear(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)
	bmx_raylib_DrawSplineLinear(points, pointCount, thick, color)
End Function

Function DrawSplineBasis(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)
	bmx_raylib_DrawSplineBasis(points, pointCount, thick, color)
End Function

Function DrawSplineCatmullRom(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)
	bmx_raylib_DrawSplineCatmullRom(points, pointCount, thick, color)
End Function

Function DrawSplineBezierQuadratic(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)
	bmx_raylib_DrawSplineBezierQuadratic(points, pointCount, thick, color)
End Function

Function DrawSplineBezierCubic(points:RVector2 Ptr, pointCount:Int, thick:Float, color:RColor)
	bmx_raylib_DrawSplineBezierCubic(points, pointCount, thick, color)
End Function

Function DrawSplineSegmentLinear(p1:RVector2, p2:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawSplineSegmentLinear(p1, p2, thick, color)
End Function

Function DrawSplineSegmentBasis(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawSplineSegmentBasis(p1, p2, p3, p4, thick, color)
End Function

Function DrawSplineSegmentCatmullRom(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawSplineSegmentCatmullRom(p1, p2, p3, p4, thick, color)
End Function

Function DrawSplineSegmentBezierQuadratic(p1:RVector2, p2:RVector2, p3:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawSplineSegmentBezierQuadratic(p1, p2, p3, thick, color)
End Function

Function DrawSplineSegmentBezierCubic(p1:RVector2, c2:RVector2, c3:RVector2, p4:RVector2, thick:Float, color:RColor)
	bmx_raylib_DrawSplineSegmentBezierCubic(p1, c2, c3, p4, thick, color)
End Function


' Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
Function GetSplinePointLinear:RVector2(startPos:RVector2, endPos:RVector2, t:Float)
	Return bmx_raylib_GetSplinePointLinear(startPos, endPos, t)
End Function

Function GetSplinePointBasis:RVector2(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, t:Float)
	Return bmx_raylib_GetSplinePointBasis(p1, p2, p3, p4, t)
End Function

Function GetSplinePointCatmullRom:RVector2(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, t:Float)
	Return bmx_raylib_GetSplinePointCatmullRom(p1, p2, p3, p4, t)
End Function

Function GetSplinePointBezierQuad:RVector2(p1:RVector2, p2:RVector2, p3:RVector2, t:Float)
	Return bmx_raylib_GetSplinePointBezierQuad(p1, p2, p3, t)
End Function

Function GetSplinePointBezierCubic:RVector2(p1:RVector2, p2:RVector2, p3:RVector2, p4:RVector2, t:Float)
	Return bmx_raylib_GetSplinePointBezierCubic(p1, p2, p3, p4, t)
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

Function CheckCollisionCircleLine:Int(center:RVector2, radius:Float, p1:RVector2, p2:RVector2)
	Return bmx_raylib_CheckCollisionCircleLine(center, radius, p1, p2)
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

Rem
bbdoc: Checks if point belongs to line created between two points @p1 and @p2 with defined margin in pixels @threshold.
End Rem
Function CheckCollisionPointLine:Int(point:RVector2, p1:RVector2, p2:RVector2, threshold:Int)
	Return bmx_raylib_CheckCollisionPointLine(point, p1, p2, threshold)
End Function

Rem
bbdoc: Checks if point is within a polygon described by array of vertices.
End Rem
Function CheckCollisionPointPoly:Int(point:RVector2, points:RVector2 Ptr, pointCount:Int)
	Return bmx_raylib_CheckCollisionPointPoly(point, points, pointCount)
End Function

Rem
bbdoc: Checks the collision between two lines defined by two points each, returns collision point by reference
End Rem
Function CheckCollisionLines:Int(startPos1:RVector2, endPos1:RVector2, startPos2:RVector2, endPos2:RVector2, collisionPoint:RVector2 Var)
	Return bmx_raylib_CheckCollisionLines(startPos1, endPos1, startPos2, endPos2, collisionPoint)
End Function

Rem
bbdoc: Gets collision rectangle for two rectangles collision.
End Rem
Function GetCollisionRec:RRectangle(rec1:RRectangle, rec2:RRectangle)
	Return bmx_raylib_GetCollisionRec(rec1, rec2)
End Function

' Image loading functions
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
bbdoc: Loads image from RAW file data.
End Rem
Function LoadImageRaw:RImage(filename:String, width:Int, height:Int, format:Int, headerSize:Int)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImageRaw(f, width, height, format, headerSize)
	MemFree(f)
	Return image
End Function

Function LoadImageAnim:RImage(filename:String, frames:Int Var)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImageAnim(f, frames)
	MemFree(f)
	Return image
End Function

Function LoadImageAnimFromMemory:RImage(fileType:String, data:Byte Ptr, dataSize:Int, frames:Int Var)
	Local f:Byte Ptr = fileType.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImageAnimFromMemory(f, data, dataSize, frames)
	MemFree(f)
	Return image
End Function

Function LoadImageFromMemory:RImage(fileType:String, data:Byte Ptr, dataSize:Int)
	Local f:Byte Ptr = fileType.ToUTF8String()
	Local image:RImage = bmx_raylib_LoadImageFromMemory(f, data, dataSize)
	MemFree(f)
	Return image
End Function

Function LoadImageFromTexture:RImage(texture:RTexture2D)
	Return bmx_raylib_LoadImageFromTexture(texture)
End Function

Function LoadImageFromScreen:RImage()
	Return bmx_raylib_LoadImageFromScreen()
End Function

Function IsImageValid:Int(image:RImage)
	Return bmx_raylib_IsImageValid(image)
End Function

Rem
bbdoc: Unloads image from CPU memory (RAM).
End Rem
Function UnloadImage(image:RImage)
	bmx_raylib_UnloadImage(image)
End Function

Rem
bbdoc: Exports image data to file.
End Rem
Function ExportImage(image:RImage, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportImage(image, f)
	MemFree(f)
End Function

Function ExportImageToMemory:Byte Ptr(image:RImage, fileType:String Var, size:Int Var)
	Local f:Byte Ptr
	Local s:Int
	Local data:Byte Ptr = bmx_raylib_ExportImageToMemory(image, f, s)
	fileType = String.FromUTF8String(f)
	size = s
	Return data
End Function

Rem
bbdoc: Exports image as code file defining an array of bytes.
End Rem
Function ExportImageAsCode(image:RImage, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportImageAsCode(image, f)
	MemFree(f)
End Function

' Image generation functions
Rem
bbdoc: Generates an image: plain color.
End Rem
Function GenImageColor:RImage(width:Int, height:Int, color:RColor)
	Return bmx_raylib_GenImageColor(width, height, color)
End Function

' Rem
' bbdoc: Generates an image: vertical gradient.
' End Rem
' Function GenImageGradientV:RImage(width:Int, height:Int, top:RColor, bottom:RColor)
' 	Return bmx_raylib_GenImageGradientV(width:Int, height:Int, top:RColor, bottom:RColor)
' End Function

Rem
bbdoc: 
End Rem
Function GenImageGradientLinear:RImage(width:Int, height:Int, direction:Int, startColor:RColor, endColor:RColor)
	Return bmx_raylib_GenImageGradientLinear(width, height, direction, startColor, endColor)
End Function

Rem
bbdoc: Generates an image: radial gradient.
End Rem
Function GenImageGradientRadial:RImage(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)
	Return bmx_raylib_GenImageGradientRadial(width, height, density, inner, outer)
End Function

Function GenImageGradientSquare:RImage(width:Int, height:Int, density:Float, inner:RColor, outer:RColor)
	Return bmx_raylib_GenImageGradientSquare(width, height, density, inner, outer)
End Function

Rem
bbdoc: Generates an image: checked.
End Rem
Function GenImageChecked:RImage(width:Int, height:Int, checksX:Int, checksY:Int, col1:RColor, col2:RColor)
	Return bmx_raylib_GenImageChecked(width, height, checksX, checksY, col1, col2)
End Function

Rem
bbdoc: Generates an image: white noise.
End Rem
Function GenImageWhiteNoise:RImage(width:Int, height:Int, factor:Float)
	Return bmx_raylib_GenImageWhiteNoise(width, height, factor)
End Function

Rem
bbdoc: Generates an image: perlin noise.
End Rem
Function GenImagePerlinNoise:RImage(width:Int, height:Int, offsetX:Int, offsetY:Int, scale:Float)
	Return bmx_raylib_GenImagePerlinNoise(width, height, offsetX, offsetY, scale)
End Function

Rem
bbdoc: Generates an image: cellular algorithm. Bigger tileSize means bigger cells.
End Rem
Function GenImageCellular:RImage(width:Int, height:Int, tileSize:Int)
	Return bmx_raylib_GenImageCellular(width, height, tileSize)
End Function

Function GenImageText:RImage(width:Int, height:Int, text:String)
	Local t:Byte Ptr = text.ToUTF8String()
	Local image:RImage = bmx_raylib_GenImageText(width, height, t)
	MemFree(t)
	Return image
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

Function ImageFromChannel:RImage(image:RImage, selectedChannel:Int)
	Return bmx_raylib_ImageFromChannel(image, selectedChannel)
End Function

Rem
bbdoc: Creates an image from text (default font).
End Rem
Function ImageText:RImage(txt:String, FontSize:Int, color:RColor)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raylib_ImageText(t, FontSize, color)
End Function

Rem
bbdoc: Creates an image from text (custom sprite font).
End Rem
Function ImageTextEx:RImage(font:RFont, txt:String, FontSize:Float, spacing:Float, tint:RColor)
	Local length:Size_T = txt.length * 3 + 1
	Local t:Byte Ptr = StackAlloc(length)
	txt.ToUTF8StringBuffer(t, length)
	Return bmx_raylib_ImageTextEx(font, t, FontSize, spacing, tint)
End Function

Rem
bbdoc: Converts image data to desired format.
End Rem
Function ImageFormat(image:RImage Var, newFormat:Int)
	bmx_raylib_ImageFormat(image, newFormat)
End Function

Rem
bbdoc: Converts image to POT (power-of-two).
End Rem
Function ImageToPOT(image:RImage Var, fillColor:RColor)
	bmx_raylib_ImageToPOT(image, fillColor)
End Function

Rem
bbdoc: Crops an image to a defined rectangle.
End Rem
Function ImageCrop(image:RImage Var, crop:RRectangle)
	bmx_raylib_ImageCrop(image, crop)
End Function

Rem
bbdoc: Crops image depending on alpha value.
End Rem
Function ImageAlphaCrop(image:RImage Var, threshold:Float)
	bmx_raylib_ImageAlphaCrop(image, threshold)
End Function

Rem
bbdoc: Clears alpha channel to desired color.
End Rem
Function ImageAlphaClear(image:RImage Var, color:RColor, threshold:Float)
	bmx_raylib_ImageAlphaClear(image, color, threshold)
End Function

Rem
bbdoc: Applys alpha mask to image.
End Rem
Function ImageAlphaMask(image:RImage Var, alphaMask:RImage)
	bmx_raylib_ImageAlphaMask(image, alphaMask)
End Function

Rem
bbdoc: Premultiplies alpha channel.
End Rem
Function ImageAlphaPremultiply(image:RImage Var)
	bmx_raylib_ImageAlphaPremultiply(image)
End Function

Function ImageBlurGaussian(image:RImage Var, blurSize:Int)
	bmx_raylib_ImageBlurGaussian(image, blurSize)
End Function

Function ImageKernelConvolution(image:RImage Var, kernel:Float Ptr, kernelSize:Int)
	bmx_raylib_ImageKernelConvolution(image, kernel, kernelSize)
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

Function ImageRotate(image:RImage Var, degrees:Int)
	bmx_raylib_ImageRotate(image, degrees)
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

Function LoadImageColors:RColor Ptr(image:RImage)
	Return bmx_raylib_LoadImageColors(image)
End Function

Function LoadImagePalette:RColor Ptr(image:RImage, maxPaletteSize:Int, colorCount:Int Var)
	Return bmx_raylib_LoadImagePalette(image, maxPaletteSize, colorCount)
End Function

Function UnloadImageColors(colors:RColor Ptr)
	bmx_raylib_UnloadImageColors(colors)
End Function

Function UnloadImagePalette(palette:RColor Ptr)
	bmx_raylib_UnloadImagePalette(palette)
End Function

Function GetImageAlphaBorder:RRectangle(image:RImage, threshold:Float)
	Return bmx_raylib_GetImageAlphaBorder(image, threshold)
End Function

Function GetImageColor:RColor(image:RImage, x:Int, y:Int)
	Return bmx_raylib_GetImageColor(image, x, y)
End Function

' Image drawing functions
' NOTE: Image software-rendering functions (CPU)

Rem
bbdoc: Clears image background with given color.
End Rem
Function ImageClearBackground(dst:RImage Var, color:RColor)
	bmx_raylib_ImageClearBackground(dst, color)
End Function

Rem
bbdoc: Draws pixel within an image.
End Rem
Function ImageDrawPixel(dst:RImage Var, posX:Int, posY:Int, color:RColor)
	bmx_raylib_ImageDrawPixel(dst, posX, posY, color)
End Function

Rem
bbdoc: Draws pixel within an image (Vector version).
End Rem
Function ImageDrawPixelV(dst:RImage Var, position:RVector2, color:RColor)
	bmx_raylib_ImageDrawPixelV(dst, position, color)
End Function

Rem
bbdoc: Draws line within an image.
End Rem
Function ImageDrawLine(dst:RImage Var, startPosX:Int, startPosY:Int, endPosX:Int, endPosY:Int, color:RColor)
	bmx_raylib_ImageDrawLine(dst, startPosX, startPosY, endPosX, endPosY, color)
End Function

Rem
bbdoc: Draws line within an image (Vector version).
End Rem
Function ImageDrawLineV(dst:RImage Var, lineStart:RVector2, lineEnd:RVector2, color:RColor)
	bmx_raylib_ImageDrawLineV(dst, lineStart, lineEnd, color)
End Function

Function ImageDrawLineEx(dst:RImage Var, lineStart:RVector2, lineEnd:RVector2, thick:Int, color:RColor)
	bmx_raylib_ImageDrawLineEx(dst, lineStart, lineEnd, thick, color)
End Function

Rem
bbdoc: Draws circle within an image.
End Rem
Function ImageDrawCircle(dst:RImage Var, centerX:Int, centerY:Int, radius:Int, color:RColor)
	bmx_raylib_ImageDrawCircle(dst, centerX, centerY, radius, color)
End Function

Rem
bbdoc: Draws circle within an image (Vector version).
End Rem
Function ImageDrawCircleV(dst:RImage Var, center:RVector2, radius:Int, color:RColor)
	bmx_raylib_ImageDrawCircleV(dst, center, radius, color)
End Function

Function ImageDrawCircleLines(dst:RImage Var, centerX:Int, centerY:Int, radius:Int, color:RColor)
	bmx_raylib_ImageDrawCircleLines(dst, centerX, centerY, radius, color)
End Function

Function ImageDrawCircleLinesV(dst:RImage Var, center:RVector2, radius:Int, color:RColor)
	bmx_raylib_ImageDrawCircleLinesV(dst, center, radius, color)
End Function

Rem
bbdoc: Draws a rectangle within an image.
End Rem
Function ImageDrawRectangle(dst:RImage Var, posX:Int, posY:Int, width:Int, height:Int, color:RColor)
	bmx_raylib_ImageDrawRectangle(dst, posX, posY, width, height, color)
End Function

Rem
bbdoc: Draws rectangle within an image (Vector version).
End Rem
Function ImageDrawRectangleV(dst:RImage Var, position:RVector2, size:RVector2, color:RColor)
	bmx_raylib_ImageDrawRectangleV(dst, position, size, color)
End Function

Rem
bbdoc: Draws rectangle within an image.
End Rem
Function ImageDrawRectangleRec(dst:RImage Var, rec:RRectangle, color:RColor)
	bmx_raylib_ImageDrawRectangleRec(dst, rec, color)
End Function

Rem
bbdoc: Draws rectangle lines within an image.
End Rem
Function ImageDrawRectangleLines(dst:RImage Var, rec:RRectangle, thick:Int, color:RColor)
	bmx_raylib_ImageDrawRectangleLines(dst, rec, thick, color)
End Function

Rem
bbdoc: Draws triangle within an image.
End Rem
Function ImageDrawTriangle(dst:RImage Var, v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)
	bmx_raylib_ImageDrawTriangle(dst, v1, v2, v3, color)
End Function

Rem
bbdoc: Draws triangle with interpolated colors within an image.
End Rem
Function ImageDrawTriangleEx(dst:RImage Var, v1:RVector2, v2:RVector2, v3:RVector2, c1:RColor, c2:RColor, c3:RColor)
	bmx_raylib_ImageDrawTriangleEx(dst, v1, v2, v3, c1, c2, c3)
End Function

Rem
bbdoc: Draws triangle outline within an image.
End Rem
Function ImageDrawTriangleLines(dst:RImage Var, v1:RVector2, v2:RVector2, v3:RVector2, color:RColor)
	bmx_raylib_ImageDrawTriangleLines(dst, v1, v2, v3, color)
End Function

Rem
bbdoc: Draws a triangle fan defined by points within an image (first vertex is the center).
End Rem
Function ImageDrawTriangleFan(dst:RImage Var, points:RVector2 Ptr, pointCount:Int, color:RColor)
	bmx_raylib_ImageDrawTriangleFan(dst, points, pointCount, color)
End Function

Rem
bbdoc: Draws a triangle strip defined by points within an image.
End Rem
Function ImageDrawTriangleStrip(dst:RImage Var, points:RVector2 Ptr, pointCount:Int, color:RColor)
	bmx_raylib_ImageDrawTriangleStrip(dst, points, pointCount, color)
End Function

Rem
bbdoc: Draws a source image within a destination image (tint applied to source).
End Rem
Function ImageDraw(dst:RImage Var, src:RImage, srcRec:RRectangle, dstRec:RRectangle, tint:RColor)
	bmx_raylib_ImageDraw(dst, src, srcRec, dstRec, tint)
End Function

Rem
bbdoc: Draws text (default font) within an image (destination).
End Rem
Function ImageDrawText(dst:RImage Var, txt:String, posX:Int, posY:Int, fontSize:Int, color:RColor)
	bmx_raylib_ImageDrawText(dst, txt, posX, posY, fontSize, color)
End Function

Rem
bbdoc: Draws text (custom sprite font) within an image (destination).
End Rem
Function ImageDrawTextEx(dst:RImage Var, font:RFont, txt:String, position:RVector2, fontSize:Float, spacing:Float, color:RColor)
	bmx_raylib_ImageDrawTextEx(dst, font, txt, position, fontSize, spacing, color)
End Function

' Texture loading functions
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
bbdoc: Loads texture for rendering (framebuffer).
End Rem
Function LoadTextureCubemap:RTextureCubemap(image:RImage, layoutType:Int)
	Return bmx_raylib_LoadTextureCubemap(image, layoutType)
End Function

Rem
bbdoc: Loads cubemap from image, multiple image cubemap layouts supported.
End Rem
Function LoadRenderTexture:RRenderTexture2D(width:Int, height:Int)
	Return bmx_raylib_LoadRenderTexture(width, height)
End Function

Rem
bbdoc: Checks if a texture is valid (loaded in GPU).
End Rem
Function IsTextureValid:Int(texture:RTexture2D)
	Return bmx_raylib_IsTextureValid(texture)
End Function

Rem
bbdoc: Unloads texture from GPU memory (VRAM).
End Rem
Function UnloadTexture(texture:RTexture2D)
	bmx_raylib_UnloadTexture(texture)
End Function

Rem
bbdoc: Checks if a render texture is valid (loaded in GPU).
End Rem
Function IsRenderTextureValid:Int(target:RRenderTexture2D)
	Return bmx_raylib_IsRenderTextureValid(target)
End Function

Rem
bbdoc: Unloads render texture from GPU memory (VRAM).
End Rem
Function UnloadRenderTexture(target:RRenderTexture2D)
	bmx_raylib_UnloadRenderTexture(target)
End Function

Rem
bbdoc: Updates GPU texture with new data.
End Rem
Function UpdateTexture(texture:RTexture2D, pixels:Byte Ptr)
	bmx_raylib_UpdateTexture(texture, pixels)
End Function

Rem
bbdoc: Updates GPU texture rectangle with new data.
End Rem
Function UpdateTextureRec(texture:RTexture2D, rec:RRectangle, pixels:Byte Ptr)
	bmx_raylib_UpdateTextureRec(texture, rec, pixels)
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

' Color/pixel related functions
Rem
bbdoc: 
End Rem
Function ColorIsEqual:Int(color1:RColor, color2:RColor)
	Return bmx_raylib_ColorIsEqual(color1, color2)
End Function

Rem
bbdoc: Color fade-in or fade-out.
about: @alpha goes from 0.0 to 1.0.
End Rem
Function Fade:RColor(color:RColor, alpha:Float)
	Return bmx_raylib_Fade(color, alpha)
End Function

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

Function ColorTint:RColor(color:RColor, tint:RColor)
	Return bmx_raylib_ColorTint(color, tint)
End Function

Function ColorBrightness:RColor(color:RColor, factor:Float)
	Return bmx_raylib_ColorBrightness(color, factor)
End Function

Function ColorContrast:RColor(color:RColor, contrast:Float)
	Return bmx_raylib_ColorContrast(color, contrast)
End Function

Function ColorAlpha:RColor(color:RColor, alpha:Float)
	Return bmx_raylib_ColorAlpha(color, alpha)
End Function

Function ColorAlphaBlend:RColor(color:RColor, src:RColor, tint:RColor)
	Return bmx_raylib_ColorAlphaBlend(color, src, tint)
End Function

Function ColorLerp:RColor(color1:RColor, color2:RColor, factor:Float)
	Return bmx_raylib_ColorLerp(color1, color2, factor)
End Function

Rem
bbdoc: Returns an #RColor from a hexadecimal value.
End Rem
Function GetColor:RColor(hexValue:Int)
	Return bmx_raylib_GetColor(hexValue)
End Function

Function GetPixelColor:RColor(src:Byte Ptr, format:Int)
	Return bmx_raylib_GetPixelColor(src, format)
End Function

Function SetPixelColor(src:Byte Ptr, color:RColor, format:Int)
	bmx_raylib_SetPixelColor(src, color, format)
End Function

Rem
bbdoc: Gets pixel data size in bytes (image or texture).
End Rem
Function GetPixelDataSize:Int(width:Int, height:Int, format:Int)
	Return bmx_raylib_GetPixelDataSize(width, height, format)
End Function

' Font loading/unloading functions
Rem
bbdoc: Gets the default Font.
End Rem
Function GetFontDefault:RFont()
	Return bmx_raylib_GetFontDefault()
End Function

Rem
bbdoc: Loads font from file into GPU memory (VRAM).
End Rem
Function LoadFont:RFont(filename:String)
	Return bmx_raylib_LoadFont(filename)
End Function

Rem
bbdoc: Loads font from file with extended parameters.
End Rem
Function LoadFontEx:RFont(filename:String, FontSize:Int, fontChars:Int Ptr, charsCount:Int)
	Return bmx_raylib_LoadFontEx(filename, FontSize, fontChars, charsCount)
End Function

Rem
bbdoc: Loads font from Image (XNA style).
End Rem
Function LoadFontFromImage:RFont(image:RImage, key:RColor, firstChar:Int)
	Return bmx_raylib_LoadFontFromImage(image, key, firstChar)
End Function

Function LoadFontFromMemory:RFont(fileType:String, data:Byte Ptr, dataSize:Int, fontSize:Int, codepoints:Int Ptr, codepointCount:Int)
	Local f:Byte Ptr = fileType.ToUTF8String()
	Local font:RFont = bmx_raylib_LoadFontFromMemory(f, data, dataSize, fontSize, codepoints, codepointCount)
	MemFree(f)
	Return font
End Function

Function IsFontValid:Int(font:RFont)
	Return bmx_raylib_IsFontValid(font)
End Function

Rem
bbdoc: Loads font data for further use.
End Rem
Function LoadFontData:RGlyphInfo Ptr(filename:String, FontSize:Int, fontChars:Int Ptr, charsCount:Int, fontType:Int)
	Return bmx_raylib_LoadFontData(filename, FontSize, fontChars, charsCount, fontType)
End Function

Rem
bbdoc: Generates image font atlas using chars info.
End Rem
Function GenImageFontAtlas:RImage(chars:RGlyphInfo Ptr, recs:RRectangle Ptr Ptr, charsCount:Int, FontSize:Int, padding:Int, packMethod:Int)
	Return bmx_raylib_GenImageFontAtlas(chars, recs, charsCount, FontSize, padding, packMethod)
End Function

Function UnloadFontData(chars:RGlyphInfo Ptr, charsCount:Int)
	bmx_raylib_UnloadFontData(chars, charsCount)
End Function

Rem
bbdoc: Unloads Font from GPU memory (VRAM).
End Rem
Function UnloadFont(font:RFont)
	bmx_raylib_UnloadFont(font)
End Function

Rem
bbdoc: Exports font as code file, returns true on success.
End Rem
Function ExportFontAsCode:Int(font:RFont, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local res:Int = bmx_raylib_ExportFontAsCode(font, f)
	MemFree(f)
	Return res
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

Function DrawTextPro(font:RFont, txt:String, position:RVector2, origin:RVector2, rotation:Float, fontSize:Float, spacing:Float, tint:RColor)
	Local t:Byte Ptr = txt.ToUTF8String()
	bmx_raylib_DrawTextPro(font, t, position, origin, fontSize, spacing, tint)
	MemFree(t)
End Function

Rem
bbdoc: Draws one character (codepoint).
End Rem
Function DrawTextCodepoint(font:RFont, codepoint:Int, position:RVector2, scale:Float, tint:RColor)
	bmx_raylib_DrawTextCodepoint(font, codepoint, position, scale, tint)
End Function

Function DrawTextCodepoints(font:RFont, codepoints:Int Ptr, count:Int, position:RVector2, fontSize:Float, spacing:Float, tint:RColor)
	bmx_raylib_DrawTextCodepoints(font, codepoints, count, position, fontSize, spacing, tint)
End Function

' Text font info functions
Function SetTextLineSpacing(spacing:Int)
	bmx_raylib_SetTextLineSpacing(spacing)
End Function

Rem
bbdoc: Measures #String width for default font.
End Rem
Function MeasureText:Int(txt:String, FontSize:Int)
	Local t:Byte Ptr = txt.ToUTF8String()
	Local res:Int = bmx_raylib_MeasureText(t, FontSize)
	MemFree(t)
	Return res
End Function

Rem
bbdoc: Measures #String size for Font.
End Rem
Function MeasureTextEx:RVector2(font:RFont, txt:String, FontSize:Float, spacing:Float)
	Local t:Byte Ptr = txt.ToUTF8String()
	Local res:RVector2 = bmx_raylib_MeasureTextEx(font, txt, FontSize, spacing)
	MemFree(t)
	Return res
End Function

Rem
bbdoc: Gets index position for a unicode character on font.
End Rem
Function GetGlyphIndex:Int(font:RFont, codepoint:Int)
	Return bmx_raylib_GetGlyphIndex(font, codepoint)
End Function

Rem
bbdoc: Gets glyph font info data for a codepoint (unicode character), fallback to '?' if not found.
End Rem
Function GetGlyphInfo:RGlyphInfo(font:RFont, codepoint:Int)
	Return bmx_raylib_GetGlyphInfo(font, codepoint)
End Function

Rem
bbdoc: Gets glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found.
End Rem
Function GetGlyphAtlasRec:RRectangle(font:RFont, codepoint:Int)
	Return bmx_raylib_GetGlyphAtlasRec(font, codepoint)
End Function

' Text codepoints management functions (unicode characters)
Function LoadUTF8:Byte Ptr(codepoints:Int Ptr, length:Int)
	Return bmx_raylib_LoadUTF8(codepoints, length)
End Function

Function UnloadUTF8(utf8:Byte Ptr)
	bmx_raylib_UnloadUTF8(utf8)
End Function

Function LoadCodepoints:Byte Ptr(text:String, count:Int Var)
	Local t:Byte Ptr = text.ToUTF8String()
	Local res:Byte Ptr = bmx_raylib_LoadCodepoints(t, count)
	MemFree(t)
	Return res
End Function

Function UnloadCodepoints(codepoints:Byte Ptr)
	bmx_raylib_UnloadCodepoints(codepoints)
End Function

' There are equivalent built-in String methods for these
' GetCodepointCount(const char *text);                          // Get total number of codepoints in a UTF-8 encoded string
' GetCodepoint(const char *text, int *codepointSize);           // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
' GetCodepointNext(const char *text, int *codepointSize);       // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
' GetCodepointPrevious(const char *text, int *codepointSize);   // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
' CodepointToUTF8(int codepoint, int *utf8Size);


' Basic geometric 3D shapes drawing functions
Rem
bbdoc: Draws a line in 3D world space.
End Rem
Function DrawLine3D(startPos:RVector3, endPos:RVector3, color:RColor)
	bmx_raylib_DrawLine3D(startPos, endPos, color)
End Function

Rem
bbdoc: Draws a point in 3D space, actually a small line.
End Rem
Function DrawPoint3D(position:RVector3, color:RColor)
	bmx_raylib_DrawPoint3D(position, color)
End Function

Rem
bbdoc: Draws a circle in 3D world space.
End Rem
Function DrawCircle3D(center:RVector3, radius:Float, rotationAxis:RVector3, rotationAngle:Float, color:RColor)
	bmx_raylib_DrawCircle3D(center, radius, rotationAxis, rotationAngle, color)
End Function

Rem
bbdoc: Draws a color-filled triangle (vertex in counter-clockwise order!)
End Rem
Function DrawTriangle3D(v1:RVector3, v2:RVector3, v3:RVector3, color:RColor)
	bmx_raylib_DrawTriangle3D(v1, v2, v3, color)
End Function

Rem
bbdoc: Draw a triangle strip defined by points
End Rem
Function DrawTriangleStrip3D(points:RVector3 Ptr, pointsCount:Int, color:RColor)
	bmx_raylib_DrawTriangleStrip3D(points, pointsCount, color)
End Function

Rem
bbdoc: Draws a cube.
End Rem
Function DrawCube(position:RVector3, width:Float, height:Float, length:Float, color:RColor)
	bmx_raylib_DrawCube(position, width, height, length, color)
End Function

Rem
bbdoc: Draws a cube (Vector version).
End Rem
Function DrawCubeV(position:RVector3, size:RVector3, color:RColor)
	bmx_raylib_DrawCubeV(position, size, color)
End Function

Rem
bbdoc: Draws cube wires.
End Rem
Function DrawCubeWires(position:RVector3, width:Float, height:Float, length:Float, color:RColor)
	bmx_raylib_DrawCubeWires(position, width, height, length, color)
End Function

Rem
bbdoc: Draws cube wires (Vector version).
End Rem
Function DrawCubeWiresV(position:RVector3, size:RVector3, color:RColor)
	bmx_raylib_DrawCubeWiresV(position, size, color)
End Function

Rem
bbdoc: Draws a sphere.
End Rem
Function DrawSphere(centerPos:RVector3, radius:Float, color:RColor)
	bmx_raylib_DrawSphere(centerPos, radius, color)
End Function

Rem
bbdoc: Draws a sphere with extended parameters.
End Rem
Function DrawSphereEx(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)
	bmx_raylib_DrawSphereEx(centerPos, radius, rings, slices, color)
End Function

Rem
bbdoc: Draws sphere wires.
End Rem
Function DrawSphereWires(centerPos:RVector3, radius:Float, rings:Int, slices:Int, color:RColor)
	bmx_raylib_DrawSphereWires(centerPos, radius, rings, slices, color)
End Function

Rem
bbdoc: Draws a cylinder/cone.
End Rem
Function DrawCylinder(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)
	bmx_raylib_DrawCylinder(position, radiusTop, radiusBottom, height, slices, color)
End Function

Rem
bbdoc: Draws a cylinder with base at @startPos and top at @endPos.
End Rem
Function DrawCylinderEx(startPos:RVector3, endPos:RVector3, startRadius:Float, endRadius:Float, sides:Int, color:RColor)
	bmx_raylib_DrawCylinderEx(startPos, endPos, startRadius, endRadius, sides, color)
End Function

Rem
bbdoc: Draws a cylinder/cone wires.
End Rem
Function DrawCylinderWires(position:RVector3, radiusTop:Float, radiusBottom:Float, height:Float, slices:Int, color:RColor)
	bmx_raylib_DrawCylinderWires(position, radiusTop, radiusBottom, height, slices, color)
End Function

Rem
bbdoc: Draws a cylinder wires with base at @startPos and top at @endPos.
End Rem
Function DrawCylinderWiresEx(startPos:RVector3, endPos:RVector3, startRadius:Float, endRadius:Float, sides:Int, color:RColor)
	bmx_raylib_DrawCylinderWiresEx(startPos, endPos, startRadius, endRadius, sides, color)
End Function

Rem
bbdoc: Draws a capsule with the center of its sphere caps at @startPos and @endPos.
End Rem
Function DrawCapsule(startPos:RVector3, endPos:RVector3, radius:Float, slices:Int, rings:Int, color:RColor)
	bmx_raylib_DrawCapsule(startPos, endPos, radius, slices, rings, color)
End Function

Rem
bbdoc: Draws capsule wireframe with the center of its sphere caps at @startPos and @endPos.
End Rem
Function DrawCapsuleWires(startPos:RVector3, endPos:RVector3, radius:Float, slices:Int, rings:Int, color:RColor)
	bmx_raylib_DrawCapsuleWires(startPos, endPos, radius, slices, rings, color)
End Function

Rem
bbdoc: Draws a plane XZ.
End Rem
Function DrawPlane(centerPos:RVector3, size:RVector2, color:RColor)
	bmx_raylib_DrawPlane(centerPos, size, color)
End Function

Rem
bbdoc: Draws a ray line.
End Rem
Function DrawRay(ray:RRay, color:RColor)
	bmx_raylib_DrawRay(ray, color)
End Function

Rem
bbdoc: Draws a grid (centered at (0, 0, 0)).
End Rem
Function DrawGrid(slices:Int, spacing:Float)
	bmx_raylib_DrawGrid(slices, spacing)
End Function

' Model management functions
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
bbdoc: Check if a model is valid (loaded in GPU, VAO/VBOs)
End Rem
Function IsModelValid:Int(model:RModel)
	Return bmx_raylib_IsModelValid(model)
End Function

Rem
bbdoc: Unloads model from memory (RAM and/or VRAM)
End Rem
Function UnloadModel(model:RModel)
	bmx_raylib_UnloadModel(model)
End Function

Rem
bbdoc: Compute model bounding box limits (considers all meshes)
End Rem
Function GetModelBoundingBox:RBoundingBox(model:RModel)
	Return bmx_raylib_GetModelBoundingBox(model)
End Function

' Model drawing functions
Rem
bbdoc: Draws a model (with texture if set).
End Rem
Function DrawModel(model:RModel, position:RVector3, scale:Float, tint:RColor)
	bmx_raylib_DrawModel(model, position, scale, tint)
End Function

Rem
bbdoc: Draws a model with extended parameters.
End Rem
Function DrawModelEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)
	bmx_raylib_DrawModelEx(model, position, rotationAxis, rotationAngle, scale, tint)
End Function

Rem
bbdoc: Draws a model wires (with texture if set).
End Rem
Function DrawModelWires(model:RModel, position:RVector3, scale:Float, tint:RColor)
	bmx_raylib_DrawModelWires(model, position, scale, tint)
End Function

Rem
bbdoc: Draws a model wires (with texture if set) with extended parameters.
End Rem
Function DrawModelWiresEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)
	bmx_raylib_DrawModelWiresEx(model, position, rotationAxis, rotationAngle, scale, tint)
End Function

Function DrawModelPoints(model:RModel, position:RVector3, scale:Float, tint:RColor)
	bmx_raylib_DrawModelPoints(model, position, scale, tint)
End Function

Function DrawModelPointsEx(model:RModel, position:RVector3, rotationAxis:RVector3, rotationAngle:Float, scale:RVector3, tint:RColor)
	bmx_raylib_DrawModelPointsEx(model, position, rotationAxis, rotationAngle, scale, tint)
End Function

Rem
bbdoc: Draws a bounding box (wires).
End Rem
Function DrawBoundingBox(box:RBoundingBox, color:RColor)
	bmx_raylib_DrawBoundingBox(box, color)
End Function

Rem
bbdoc: Draws a billboard texture.
End Rem
Function DrawBillboard(camera:RCamera, texture:RTexture2D, position:RVector3, scale:Float, tint:RColor)
	bmx_raylib_DrawBillboard(camera, texture, position, scale, tint)
End Function

Rem
bbdoc: Draws a billboard texture defined by sourceRec.
End Rem
Function DrawBillboardRec(camera:RCamera, texture:RTexture2D, source:RRectangle, position:RVector3, size:RVector2, tint:RColor)
	bmx_raylib_DrawBillboardRec(camera, texture, source, position, size, tint)
End Function

Rem
bbdoc: Draws a billboard texture defined by source and rotation.
End Rem
Function DrawBillboardPro(camera:RCamera, texture:RTexture2D, source:RRectangle, position:RVector3, up:RVector3, size:RVector2, origin:RVector2, rotation:Float, tint:RColor)
	bmx_raylib_DrawBillboardPro(camera, texture, source, position, up, size, origin, rotation, tint)
End Function

' Mesh management functions

Function UploadMesh(mesh:RMesh Var, dynamic:Int)
	bmx_raylib_UploadMesh(mesh, dynamic)
End Function

Function UpdateMeshBuffer(mesh:RMesh, index:Int, data:Byte Ptr, dataSize:Int, offset:Int)
	bmx_raylib_UpdateMeshBuffer(mesh, index, data, dataSize, offset)
End Function

Rem
bbdoc: Unloads mesh from memory (RAM and/or VRAM).
End Rem
Function UnloadMesh(mesh:RMesh)
	bmx_raylib_UnloadMesh(mesh)
End Function

Function DrawMesh(mesh:RMesh, material:RMaterial, transform:RMatrix)
	bmx_raylib_DrawMesh(mesh, material, transform)
End Function

Function DrawMeshInstanced(mesh:RMesh, material:RMaterial, transforms:RMatrix Ptr, instances:Int)
	bmx_raylib_DrawMeshInstanced(mesh, material, transforms, instances)
End Function

Rem
bbdoc: Computes mesh bounding box limits.
End Rem
Function GetMeshBoundingBox:RBoundingBox(mesh:RMesh)
	Return bmx_raylib_GetMeshBoundingBox(mesh)
End Function

Rem
bbdoc: Computes mesh tangents.
End Rem
Function GenMeshTangents(mesh:RMesh Var)
	bmx_raylib_GenMeshTangents(mesh)
End Function

Rem
bbdoc: Exports mesh data to file.
End Rem
Function ExportMesh(mesh:RMesh, filename:String)
	bmx_raylib_ExportMesh(mesh, filename)
End Function

Function ExportMeshAsCode(mesh:RMesh, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportMeshAsCode(mesh, f)
	MemFree(f)
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

' Material loading/unloading functions
Rem
bbdoc: Loads materials from model file.
End Rem
Function LoadMaterials:RMaterial Ptr(filename:String, materialCount:Int Var)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local materials:RMaterial Ptr = bmx_raylib_LoadMaterials(f, materialCount)
	MemFree(f)
	Return materials
End Function

Rem
bbdoc: Loads default material (Supports: DIFFUSE, SPECULAR, NORMAL maps).
End Rem
Function LoadMaterialDefault:RMaterial()
	Return bmx_raylib_LoadMaterialDefault()
End Function

Function IsMaterialValid:Int(material:RMaterial)
	Return bmx_raylib_IsMaterialValid(material)
End Function

Rem
bbdoc: Unloads material from GPU memory (VRAM).
End Rem
Function UnloadMaterial(material:RMaterial)
	bmx_raylib_UnloadMaterial(material:RMaterial)
End Function

Rem
bbdoc: Sets texture for a material map type (MAP_DIFFUSE, MAP_SPECULAR...).
End Rem
Function SetMaterialTexture(material:RMaterial Var, mapType:Int, texture:RTexture2D)
	bmx_raylib_SetMaterialTexture(material, mapType, texture)
End Function

Rem
bbdoc: Sets material for a mesh.
End Rem
Function SetModelMeshMaterial(model:RModel Var, meshId:Int, materialId:Int)
	bmx_raylib_SetModelMeshMaterial(model, meshId, materialId)
End Function

' Model animations loading/unloading functions
Rem
bbdoc: Loads model animations from file.
End Rem
Function LoadModelAnimations:RModelAnimation Ptr(filename:String, animsCount:Int Var)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local animations:RModelAnimation Ptr = bmx_raylib_LoadModelAnimations(f, animsCount)
	MemFree(f)
	Return animations
End Function

Rem
bbdoc: Updates model animation pose.
End Rem
Function UpdateModelAnimation(model:RModel, anim:RModelAnimation, frame:Int)
	bmx_raylib_UpdateModelAnimation(model, anim, frame)
End Function

Function UpdateModelAnimationBones(model:RModel, anim:RModelAnimation, frame:Int)
	bmx_raylib_UpdateModelAnimationBones(model, anim, frame)
End Function

Rem
bbdoc: Unloads animation data.
End Rem
Function UnloadModelAnimation(anim:RModelAnimation)
	bmx_raylib_UnloadModelAnimation(anim)
End Function

Function UnloadModelAnimations(animations:RModelAnimation Ptr, animCount:Int)
	bmx_raylib_UnloadModelAnimations(animations, animCount)
End Function

Rem
bbdoc: Checks model animation skeleton match.
End Rem
Function IsModelAnimationValid:Int(model:RModel, anim:RModelAnimation)
	Return bmx_raylib_IsModelAnimationValid(model, anim)
End Function

' Collision detection functions
Rem
bbdoc: Detects collision between two spheres.
End Rem
Function CheckCollisionSpheres:Int(center1:RVector3, radius1:Float, center2:RVector3, radius2:Float)
	Return bmx_raylib_CheckCollisionSpheres(center1, radius1, center2, radius2)
End Function

Rem
bbdoc: Detects collision between two bounding boxes.
End Rem
Function CheckCollisionBoxes:Int(box1:RBoundingBox, box2:RBoundingBox)
	Return bmx_raylib_CheckCollisionBoxes(box1, box2)
End Function

Rem
bbdoc: Detects collision between box and sphere.
End Rem
Function CheckCollisionBoxSphere:Int(box:RBoundingBox, center:RVector3, radius:Float)
	Return bmx_raylib_CheckCollisionBoxSphere(box, center, radius)
End Function

Function GetRayCollisionSphere:RRayCollision(ray:RRay, center:RVector3, radius:Float)
	Return bmx_raylib_GetRayCollisionSphere(ray, center, radius)
End Function

Function GetRayCollisionBox:RRayCollision(ray:RRay, box:RBoundingBox)
	Return bmx_raylib_GetRayCollisionBox(ray, box)
End Function

Function GetRayCollisionMesh:RRayCollision(ray:RRay, mesh:RMesh, transform:RMatrix)
	Return bmx_raylib_GetRayCollisionMesh(ray, mesh, transform)
End Function

Function GetRayCollisionTriangle:RRayCollision(ray:RRay, p1:RVector3, p2:RVector3, p3:RVector3)
	Return bmx_raylib_GetRayCollisionTriangle(ray, p1, p2, p3)
End Function

Function GetRayCollisionQuad:RRayCollision(ray:RRay, p1:RVector3, p2:RVector3, p3:RVector3, p4:RVector3)
	Return bmx_raylib_GetRayCollisionQuad(ray, p1, p2, p3, p4)
End Function

Rem
bbdoc: Checks if a file has been dropped into window.
End Rem
Function IsFileDropped:Int()
	Return bmx_raylib_IsFileDropped()
End Function

Rem
bbdoc: Gets dropped files names.
End Rem
Function GetDroppedFiles:String[]()
	Return bmx_raylib_LoadDroppedFiles()
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
