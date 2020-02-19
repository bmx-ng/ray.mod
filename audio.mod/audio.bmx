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

Function InitAudioDevice()
	bmx_raylib_InitAudioDevice()
End Function

Function CloseAudioDevice()
	bmx_raylib_CloseAudioDevice()
End Function

Function IsAudioDeviceReady:Int()
	Return bmx_raylib_IsAudioDeviceReady()
End Function

Function SetMasterVolume(volume:Float)
	bmx_raylib_SetMasterVolume(volume)
End Function


' Wave/Sound loading/unloading functions
Function LoadWave:RWave(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local wave:RWave = bmx_raylib_LoadWave(f)
	MemFree(f)
	Return wave
End Function

Function LoadSound:RSound(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local sound:RSound = bmx_raylib_LoadSound(f)
	MemFree(f)
	Return sound
End Function

Function LoadSoundFromWave:RSound(wave:RWave)
	Return bmx_raylib_LoadSoundFromWave(wave)
End Function

Function UpdateSound(sound:RSound, data:Byte Ptr, samplesCount:Int)
	bmx_raylib_UpdateSound(sound, data, samplesCount)
End Function

Function UnloadWave(wave:RWave)
	bmx_raylib_UnloadWave(wave)
End Function

Function UnloadSound(sound:RSound)
	bmx_raylib_UnloadSound(sound)
End Function

Function ExportWave(wave:RWave, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportWave(wave, f)
	MemFree(f)
End Function

Function ExportWaveAsCode(wave:RWave, filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	bmx_raylib_ExportWaveAsCode(wave, f)
	MemFree(f)
End Function


' Wave/Sound management functions
Function PlaySound(sound:RSound)
	bmx_raylib_PlaySound(sound)
End Function

Function StopSound(sound:RSound)
	bmx_raylib_StopSound(sound)
End Function

Function PauseSound(sound:RSound)
	bmx_raylib_PauseSound(sound)
End Function

Function ResumeSound(sound:RSound)
	bmx_raylib_ResumeSound(sound)
End Function

Function PlaySoundMulti(sound:RSound)
	bmx_raylib_PlaySoundMulti(sound)
End Function

Function StopSoundMulti()
	bmx_raylib_StopSoundMulti()
End Function

Function GetSoundsPlaying:Int()
	Return bmx_raylib_GetSoundsPlaying()
End Function

Function IsSoundPlaying:Int(sound:RSound)
	bmx_raylib_IsSoundPlaying(sound)
End Function

Function SetSoundVolume(sound:RSound, volume:Float)
	bmx_raylib_SetSoundVolume(sound, volume)
End Function

Function SetSoundPitch(sound:RSound, pitch:Float)
	bmx_raylib_SetSoundPitch(sound, pitch)
End Function

Function WaveFormat(wave:RWave Var, sampleRate:Int, sampleSize:Int, channels:Int)
	bmx_raylib_WaveFormat(wave, sampleRate, sampleSize, channels)
End Function

Function WaveCopy:RWave(wave:RWave)
	Return bmx_raylib_WaveCopy(wave)
End Function

Function WaveCrop(wave:RWave Var, initSample:Int, finalSample:Int)
	bmx_raylib_WaveCrop(wave, initSample, finalSample)
End Function

Function GetWaveData:Float Ptr(wave:RWave)
	Return bmx_raylib_GetWaveData(wave)
End Function


Function LoadMusicStream:RMusic(filename:String)
	Local f:Byte Ptr = filename.ToUTF8String()
	Local music:RMusic = bmx_raylib_LoadMusicStream(f)
	MemFree(f)
	Return music
End Function

Function UnloadMusicStream(music:RMusic)
	bmx_raylib_UnloadMusicStream(music)
End Function

Function PlayMusicStream(music:RMusic)
	bmx_raylib_PlayMusicStream(music)
End Function

Function UpdateMusicStream(music:RMusic)
	bmx_raylib_UpdateMusicStream(music)
End Function

Function StopMusicStream(music:RMusic)
	bmx_raylib_StopMusicStream(music)
End Function

Function PauseMusicStream(music:RMusic)
	bmx_raylib_PauseMusicStream(music)
End Function

Function ResumeMusicStream(music:RMusic)
	bmx_raylib_ResumeMusicStream(music)
End Function

Function IsMusicPlaying:Int(music:RMusic)
	bmx_raylib_IsMusicPlaying(music)
End Function

Function SetMusicVolume(music:RMusic, volume:Float)
	bmx_raylib_SetMusicVolume(music, volume)
End Function

Function SetMusicPitch(music:RMusic, pitch:Float)
	bmx_raylib_SetMusicPitch(music, pitch)
End Function

Function SetMusicLoopCount(music:RMusic, count:Int)
	bmx_raylib_SetMusicLoopCount(music, count)
End Function

Function GetMusicTimeLength:Float(music:RMusic)
	Return bmx_raylib_GetMusicTimeLength(music)
End Function

Function GetMusicTimePlayed:Float(music:RMusic)
	Return bmx_raylib_GetMusicTimePlayed(music)
End Function


' AudioStream management functions
Function InitAudioStream:RAudioStream(sampleRate:UInt, sampleSize:UInt, channels:UInt)
	Return bmx_raylib_InitAudioStream(sampleRate, sampleSize, channels)
End Function

Function UpdateAudioStream(stream:RAudioStream, data:Byte Ptr, samplesCount:Int)
	bmx_raylib_UpdateAudioStream(stream, data, samplesCount)
End Function

Function CloseAudioStream(stream:RAudioStream)
	bmx_raylib_CloseAudioStream(stream)
End Function

Function IsAudioStreamProcessed:Int(stream:RAudioStream)
	Return bmx_raylib_IsAudioStreamProcessed(stream)
End Function

Function PlayAudioStream(stream:RAudioStream)
	bmx_raylib_PlayAudioStream(stream)
End Function

Function PauseAudioStream(stream:RAudioStream)
	bmx_raylib_PauseAudioStream(stream)
End Function

Function ResumeAudioStream(stream:RAudioStream)
	bmx_raylib_ResumeAudioStream(stream)
End Function

Function IsAudioStreamPlaying:Int(stream:RAudioStream)
	Return bmx_raylib_IsAudioStreamPlaying(stream)
End Function

Function StopAudioStream(stream:RAudioStream)
	bmx_raylib_StopAudioStream(stream)
End Function

Function SetAudioStreamVolume(stream:RAudioStream, volume:Float)
	bmx_raylib_SetAudioStreamVolume(stream, volume)
End Function

Function SetAudioStreamPitch(stream:RAudioStream, pitch:Float)
	bmx_raylib_SetAudioStreamPitch(stream, pitch)
End Function
