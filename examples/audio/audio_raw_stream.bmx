SuperStrict

Framework Ray.Lib
Import Ray.Audio
Import BRL.Math

Const MAX_SAMPLES:Int = 512
Const MAX_SAMPLES_PER_UPDATE:Int = 4096

' Cycles per second (hz)
Global frequency:Float = 440.0

' Audio frequency, for smoothing
Global audioFrequency:Float = 440.0

' Previous value, used to test if sine needs to be rewritten, and to smoothly modulate frequency
Local oldFrequency:Float = 1.0

' Index for audio rendering
Global sineIdx:Float = 0.0

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [audio] example - raw audio streaming")

InitAudioDevice()              ' Initialize audio device

SetAudioStreamBufferSizeDefault(MAX_SAMPLES_PER_UPDATE)

' Init raw audio stream (sample rate: 44100, sample size: 16bit-short, channels: 1-mono)
Local stream:RAudioStream = LoadAudioStream(44100, 16, 1)

SetAudioStreamCallback(stream, AudioInputCallback)

' Buffer for the single cycle waveform we are synthesizing
Local data:Short Ptr = RMemAlloc(2 * MAX_SAMPLES)

' Frame buffer, describing the waveform when repeated over the course of a frame
Local writeBuf:Short Ptr = RMemAlloc(2 * MAX_SAMPLES_PER_UPDATE)

PlayAudioStream(stream)        ' Start processing stream buffer (no data loaded currently)

' Position read in to determine next frequency
Local mousePosition:RVector2 = New RVector2(-100.0, -100.0)

' Computed size in samples of the sine wave
Local waveLength:Int = 1

Local position:RVector2

SetTargetFPS(30)               ' Set our game to run at 30 frames-per-second
'--------------------------------------------------------------------------------------

' Main game loop
While Not WindowShouldClose()    ' Detect window close button or ESC key
	' Update
	'----------------------------------------------------------------------------------

	' Sample mouse input.
	mousePosition = GetMousePosition()

	If IsMouseButtonDown(MOUSE_LEFT_BUTTON) Then
		Local fp:Float = mousePosition.y
		frequency = 40.0 + fp

		Local pan:Float = (mousePosition.x / Float(screenWidth))
		SetAudioStreamPan(stream, pan)
	End If

	' Rewrite the sine wave.
	' Compute two cycles to allow the buffer padding, simplifying any modulation, resampling, etc.
	If frequency <> oldFrequency Then
		' Compute wavelength. Limit size in both directions.

		waveLength = Int(22050 / frequency)
		If waveLength > MAX_SAMPLES/2 Then
			waveLength = MAX_SAMPLES/2
		End If
		If waveLength < 1 Then
			waveLength = 1
		End If

		' Write sine wave.
		For Local i:Int = 0 Until waveLength*2
			data[i] = Sin(((2*Pi*Float(i)/waveLength)) * 57.2958)*32000
		Next

		' Make sure the rest of the line is flat
		For Local i:Int = waveLength*2 Until MAX_SAMPLES
			data[i] = 0
		Next
		
		oldFrequency = frequency
	End If

	'----------------------------------------------------------------------------------

	' Draw
	'----------------------------------------------------------------------------------
	BeginDrawing()

		ClearBackground(RAYWHITE)

		DrawText("sine frequency: " + Int(frequency), GetScreenWidth() - 220, 10, 20, RED)
		DrawText("click mouse button to change frequency", 10, 10, 20, DARKGRAY)

		' Draw the current buffer state proportionate to the screen
		For Local i:Int = 0 Until screenWidth
			position.x = i
			position.y = 250 + 50*data[i*MAX_SAMPLES/screenWidth]/32000

			DrawPixelV(position, RED)
		Next

	EndDrawing()
	'----------------------------------------------------------------------------------
Wend

' De-Initialization
'--------------------------------------------------------------------------------------
RMemFree(data)                 ' Unload sine wave data
RMemFree(writeBuf)             ' Unload write buffer

UnloadAudioStream(stream)   ' Close raw audio stream and delete buffers from RAM
CloseAudioDevice()         ' Close audio device (music streaming is automatically stopped)

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------

Function AudioInputCallback(buffer:Byte Ptr, frames:UInt)
	audioFrequency = frequency + (audioFrequency - frequency)*0.95
	
	Local incr:Float = audioFrequency/44100.0
	Local d:Short Ptr = buffer
	
	For Local i:UInt = 0 Until frames
		d[i] = Short(32000.0*Sin(2 * Pi * sineIdx))
		sineIdx :+ incr
		If sineIdx > 1.0 Then
			sineIdx :- 1.0
		End IF
	Next
End Function
