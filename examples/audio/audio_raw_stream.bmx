SuperStrict

Framework Ray.Lib
Import Ray.Audio
Import BRL.Math

Const MAX_SAMPLES:Int = 512
Const MAX_SAMPLES_PER_UPDATE:Int = 4096

' Initialization
'--------------------------------------------------------------------------------------
Const screenWidth:Int = 800
Const screenHeight:Int = 450

InitWindow(screenWidth, screenHeight, "raylib [audio] example - raw audio streaming")

InitAudioDevice()              ' Initialize audio device

' Init raw audio stream (sample rate: 22050, sample size: 16bit-short, channels: 1-mono)
Local stream:RAudioStream = InitAudioStream(22050, 16, 1)

' Buffer for the single cycle waveform we are synthesizing
Local data:Short Ptr = MemAlloc(2 * MAX_SAMPLES)

' Frame buffer, describing the waveform when repeated over the course of a frame
Local writeBuf:Short Ptr = MemAlloc(2 * MAX_SAMPLES_PER_UPDATE)

PlayAudioStream(stream)        ' Start processing stream buffer (no data loaded currently)

' Position read in to determine next frequency
Local mousePosition:RVector2 = New RVector2(-100.0, -100.0)

' Cycles per second (hz)
Local frequency:Float = 440.0

' Previous value, used to test if sine needs to be rewritten, and to smoothly modulate frequency
Local oldFrequency:Float = 1.0

' Cursor to read and copy the samples of the sine wave buffer
Local readCursor:Int = 0

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
		frequency = 40.0 + mousePosition.y
	End If

	' Rewrite the sine wave.
	' Compute two cycles to allow the buffer padding, simplifying any modulation, resampling, etc.
	If frequency <> oldFrequency Then
		' Compute wavelength. Limit size in both directions.
		Local oldWavelength:Int = waveLength
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

		' Scale read cursor's position to minimize transition artifacts
		readCursor = Int(readCursor * (Float(waveLength) / oldWavelength))
		oldFrequency = frequency
	End If

	' Refill audio stream if required
	If IsAudioStreamProcessed(stream) Then
		' Synthesize a buffer that is exactly the requested size
		Local writeCursor:Int = 0

		While writeCursor < MAX_SAMPLES_PER_UPDATE
			' Start by trying to write the whole chunk at once
			Local writeLength:Int = MAX_SAMPLES_PER_UPDATE-writeCursor

			' Limit to the maximum readable size
			Local readLength:Int = waveLength-readCursor

			If writeLength > readLength Then
				writeLength = readLength
			End If

			' Write the slice
			MemCopy(writeBuf + writeCursor, data + readCursor, writeLength*2)

			' Update cursors and loop audio
			readCursor = (readCursor + writeLength) Mod waveLength

			writeCursor :+ writeLength
		Wend

		' Copy finished frame to audio stream
		UpdateAudioStream(stream, writeBuf, MAX_SAMPLES_PER_UPDATE)
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
MemFree(data)                 ' Unload sine wave data
MemFree(writeBuf)             ' Unload write buffer

CloseAudioStream(stream)   ' Close raw audio stream and delete buffers from RAM
CloseAudioDevice()         ' Close audio device (music streaming is automatically stopped)

CloseWindow()              ' Close window and OpenGL context
'--------------------------------------------------------------------------------------
