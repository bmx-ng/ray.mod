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
bbdoc: Raylib Audio - Simple and easy-to-use audio library
End Rem
Module Ray.Audio

ModuleInfo "Version: 1.00"
ModuleInfo "License: zlib"
ModuleInfo "Copyright: Wrapper - 2020 Bruce A Henderson"
ModuleInfo "Copyright: raylib - 2013-2020 Ramon Santamaria"

ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release."


ModuleInfo "CC_OPTS: -std=c99"
ModuleInfo "CC_OPTS: -DSTATIC"
ModuleInfo "CC_OPTS: -DSUPPORT_CAMERA_SYSTEM"
ModuleInfo "CC_OPTS: -DSUPPORT_FILEFORMAT_OGG -DSUPPORT_FILEFORMAT_XM -DSUPPORT_FILEFORMAT_MOD -DSUPPORT_FILEFORMAT_FLAC -DSUPPORT_FILEFORMAT_MP3"

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

Rem
bbdoc: Initializes audio device and context.
End Rem
Function InitAudioDevice()
	bmx_raylib_InitAudioDevice()
End Function

Rem
bbdoc: Closes the audio device and context.
End Rem
Function CloseAudioDevice()
	bmx_raylib_CloseAudioDevice()
End Function

Rem
bbdoc: Checks if audio device has been initialized successfully.
End Rem
Function IsAudioDeviceReady:Int()
	Return bmx_raylib_IsAudioDeviceReady()
End Function

Rem
bbdoc: Sets master volume (listener).
End Rem
Function SetMasterVolume(volume:Float)
	bmx_raylib_SetMasterVolume(volume)
End Function


' Wave/Sound loading/unloading functions
Rem
bbdoc: Loads wave data from file.
End Rem
Function LoadWave:RWave(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local wave:RWave = bmx_raylib_LoadWave(f)
	MemFree(f)
	Return wave
End Function

Rem
bbdoc: Loads sound from file.
End Rem
Function LoadSound:RSound(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local sound:RSound = bmx_raylib_LoadSound(f)
	MemFree(f)
	Return sound
End Function

Rem
bbdoc: Loads sound from wave data.
End Rem
Function LoadSoundFromWave:RSound(wave:RWave)
	Return bmx_raylib_LoadSoundFromWave(wave)
End Function

Rem
bbdoc: Updates sound buffer with new data.
End Rem
Function UpdateSound(sound:RSound, data:Byte Ptr, samplesCount:Int)
	bmx_raylib_UpdateSound(sound, data, samplesCount)
End Function

Rem
bbdoc: Unloads wave data.
End Rem
Function UnloadWave(wave:RWave)
	bmx_raylib_UnloadWave(wave)
End Function

Rem
bbdoc: Unloads sound.
End Rem
Function UnloadSound(sound:RSound)
	bmx_raylib_UnloadSound(sound)
End Function

Rem
bbdoc: Exports wave data to file.
End Rem
Function ExportWave(wave:RWave, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportWave(wave, f)
	MemFree(f)
End Function

Rem
bbdoc: Exports wave sample data to code (.h).
End Rem
Function ExportWaveAsCode(wave:RWave, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportWaveAsCode(wave, f)
	MemFree(f)
End Function


' Wave/Sound management functions
Rem
bbdoc: Plays a sound.
End Rem
Function PlaySound(sound:RSound)
	bmx_raylib_PlaySound(sound)
End Function

Rem
bbdoc: Stops playing a sound.
End Rem
Function StopSound(sound:RSound)
	bmx_raylib_StopSound(sound)
End Function

Rem
bbdoc: Pauses a sound.
End Rem
Function PauseSound(sound:RSound)
	bmx_raylib_PauseSound(sound)
End Function

Rem
bbdoc: Resumes a paused sound.
End Rem
Function ResumeSound(sound:RSound)
	bmx_raylib_ResumeSound(sound)
End Function

Rem
bbdoc: Plays a sound (using multichannel buffer pool).
End Rem
Function PlaySoundMulti(sound:RSound)
	bmx_raylib_PlaySoundMulti(sound)
End Function

Rem
bbdoc: Stops any sound playing (using multichannel buffer pool).
End Rem
Function StopSoundMulti()
	bmx_raylib_StopSoundMulti()
End Function

Rem
bbdoc: Gets number of sounds playing in the multichannel.
End Rem
Function GetSoundsPlaying:Int()
	Return bmx_raylib_GetSoundsPlaying()
End Function

Rem
bbdoc: Checks if a sound is currently playing.
End Rem
Function IsSoundPlaying:Int(sound:RSound)
	bmx_raylib_IsSoundPlaying(sound)
End Function

Rem
bbdoc: Sets volume for a sound (1.0 is max level).
End Rem
Function SetSoundVolume(sound:RSound, volume:Float)
	bmx_raylib_SetSoundVolume(sound, volume)
End Function

Rem
bbdoc: Sets pitch for a sound (1.0 is base level).
End Rem
Function SetSoundPitch(sound:RSound, pitch:Float)
	bmx_raylib_SetSoundPitch(sound, pitch)
End Function

Rem
bbdoc: Converts wave data to desired format.
End Rem
Function WaveFormat(wave:RWave Var, sampleRate:Int, sampleSize:Int, channels:Int)
	bmx_raylib_WaveFormat(wave, sampleRate, sampleSize, channels)
End Function

Rem
bbdoc: Copies a wave to a new wave.
End Rem
Function WaveCopy:RWave(wave:RWave)
	Return bmx_raylib_WaveCopy(wave)
End Function

Rem
bbdoc: Crops a wave to defined samples range.
End Rem
Function WaveCrop(wave:RWave Var, initSample:Int, finalSample:Int)
	bmx_raylib_WaveCrop(wave, initSample, finalSample)
End Function

Rem
bbdoc: Gets samples data from wave as a floats array.
End Rem
Function GetWaveData:Float Ptr(wave:RWave)
	Return bmx_raylib_GetWaveData(wave)
End Function

' Music management functions
Rem
bbdoc: Loads music stream from file.
End Rem
Function LoadMusicStream:RMusic(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local music:RMusic = bmx_raylib_LoadMusicStream(f)
	MemFree(f)
	Return music
End Function

Rem
bbdoc: Unloads music stream.
End Rem
Function UnloadMusicStream(music:RMusic)
	bmx_raylib_UnloadMusicStream(music)
End Function

Rem
bbdoc: Starts music playing.
End Rem
Function PlayMusicStream(music:RMusic)
	bmx_raylib_PlayMusicStream(music)
End Function

Rem
bbdoc: Updates buffers for music streaming.
End Rem
Function UpdateMusicStream(music:RMusic)
	bmx_raylib_UpdateMusicStream(music)
End Function

Rem
bbdoc: Stops music playing.
End Rem
Function StopMusicStream(music:RMusic)
	bmx_raylib_StopMusicStream(music)
End Function

Rem
bbdoc: Pauses music playing.
End Rem
Function PauseMusicStream(music:RMusic)
	bmx_raylib_PauseMusicStream(music)
End Function

Rem
bbdoc: Resumes playing paused music.
End Rem
Function ResumeMusicStream(music:RMusic)
	bmx_raylib_ResumeMusicStream(music)
End Function

Rem
bbdoc: Checks if music is playing.
End Rem
Function IsMusicPlaying:Int(music:RMusic)
	bmx_raylib_IsMusicPlaying(music)
End Function

Rem
bbdoc: Sets volume for music (1.0 is max level).
End Rem
Function SetMusicVolume(music:RMusic, volume:Float)
	bmx_raylib_SetMusicVolume(music, volume)
End Function

Rem
bbdoc: Sets pitch for a music (1.0 is base level).
End Rem
Function SetMusicPitch(music:RMusic, pitch:Float)
	bmx_raylib_SetMusicPitch(music, pitch)
End Function

Rem
bbdoc: Sets music loop count (loop repeats).
End Rem
Function SetMusicLoopCount(music:RMusic, count:Int)
	bmx_raylib_SetMusicLoopCount(music, count)
End Function

Rem
bbdoc: Gets music time length (in seconds).
End Rem
Function GetMusicTimeLength:Float(music:RMusic)
	Return bmx_raylib_GetMusicTimeLength(music)
End Function

Rem
bbdoc: Gets current music time played (in seconds).
End Rem
Function GetMusicTimePlayed:Float(music:RMusic)
	Return bmx_raylib_GetMusicTimePlayed(music)
End Function


' AudioStream management functions
Rem
bbdoc: Inits audio stream (to stream raw audio pcm data).
End Rem
Function InitAudioStream:RAudioStream(sampleRate:UInt, sampleSize:UInt, channels:UInt)
	Return bmx_raylib_InitAudioStream(sampleRate, sampleSize, channels)
End Function

Rem
bbdoc: Updates audio stream buffers with data.
End Rem
Function UpdateAudioStream(stream:RAudioStream, data:Byte Ptr, samplesCount:Int)
	bmx_raylib_UpdateAudioStream(stream, data, samplesCount)
End Function

Rem
bbdoc: Closes audio stream and free memory.
End Rem
Function CloseAudioStream(stream:RAudioStream)
	bmx_raylib_CloseAudioStream(stream)
End Function

Rem
bbdoc: Checks if any audio stream buffers requires refill.
End Rem
Function IsAudioStreamProcessed:Int(stream:RAudioStream)
	Return bmx_raylib_IsAudioStreamProcessed(stream)
End Function

Rem
bbdoc: Plays audio stream.
End Rem
Function PlayAudioStream(stream:RAudioStream)
	bmx_raylib_PlayAudioStream(stream)
End Function

Rem
bbdoc: Pauses audio stream.
End Rem
Function PauseAudioStream(stream:RAudioStream)
	bmx_raylib_PauseAudioStream(stream)
End Function

Rem
bbdoc: Resumes audio stream.
End Rem
Function ResumeAudioStream(stream:RAudioStream)
	bmx_raylib_ResumeAudioStream(stream)
End Function

Rem
bbdoc: Checks if audio stream is playing.
End Rem
Function IsAudioStreamPlaying:Int(stream:RAudioStream)
	Return bmx_raylib_IsAudioStreamPlaying(stream)
End Function

Rem
bbdoc: Stops audio stream.
End Rem
Function StopAudioStream(stream:RAudioStream)
	bmx_raylib_StopAudioStream(stream)
End Function

Rem
bbdoc: Sets volume for audio stream (1.0 is max level).
End Rem
Function SetAudioStreamVolume(stream:RAudioStream, volume:Float)
	bmx_raylib_SetAudioStreamVolume(stream, volume)
End Function

Rem
bbdoc: Sets pitch for audio stream (1.0 is base level).
End Rem
Function SetAudioStreamPitch(stream:RAudioStream, pitch:Float)
	bmx_raylib_SetAudioStreamPitch(stream, pitch)
End Function

Rem
bbdoc: Sets the default buffer size for new audio streams.
End Rem
Function SetAudioStreamBufferSizeDefault(size:Int)
	bmx_raylib_SetAudioStreamBufferSizeDefault(size)
End Function
