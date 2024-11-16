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
	Function bmx_raylib_InitAudioDevice()="InitAudioDevice"
	Function bmx_raylib_CloseAudioDevice()="CloseAudioDevice"
	Function bmx_raylib_IsAudioDeviceReady:Int()="IsAudioDeviceReady"
	Function bmx_raylib_SetMasterVolume(volume:Float)="SetMasterVolume"
	Function bmx_raylib_GetMasterVolume:Float()="GetMasterVolume"

	Function bmx_raylib_LoadWave:RWave(fileName:Byte Ptr)="LoadWave"
	Function bmx_raylib_LoadWaveFromMemory:RWave(fileType:Byte Ptr, data:Byte Ptr, dataSize:Int)="LoadWaveFromMemory"
	Function bmx_raylib_IsWaveValid:Int(wave:RWave)="IsWaveValid"
	Function bmx_raylib_LoadSound:RSound(fileName:Byte Ptr)="LoadSound"
	Function bmx_raylib_LoadSoundFromWave:RSound(wave:RWave)="LoadSoundFromWave"
	Function bmx_raylib_LoadSoundAlias:RSound(source:RSound)="LoadSoundAlias"
	Function bmx_raylib_IsSoundValid:Int(sound:RSound)="IsSoundValid"
	Function bmx_raylib_UpdateSound(sound:RSound, data:Byte Ptr, samplesCount:Int)="UpdateSound"
	Function bmx_raylib_UnloadWave(wave:RWave)="UnloadWave"
	Function bmx_raylib_UnloadSound(sound:RSound)="UnloadSound"
	Function bmx_raylib_UnloadSoundAlias(sound:RSound)="UnloadSoundAlias"
	Function bmx_raylib_ExportWave(wave:RWave, fileName:Byte Ptr)="ExportWave"
	Function bmx_raylib_ExportWaveAsCode(wave:RWave, fileName:Byte Ptr)="ExportWaveAsCode"

	Function bmx_raylib_PlaySound(sound:RSound)
	Function bmx_raylib_StopSound(sound:RSound)="StopSound"
	Function bmx_raylib_PauseSound(sound:RSound)="PauseSound"
	Function bmx_raylib_ResumeSound(sound:RSound)="ResumeSound"
	Function bmx_raylib_IsSoundPlaying:Int(sound:RSound)="IsSoundPlaying"
	Function bmx_raylib_SetSoundVolume(sound:RSound, volume:Float)="SetSoundVolume"
	Function bmx_raylib_SetSoundPitch(sound:RSound, pitch:Float)="SetSoundPitch"
	Function bmx_raylib_SetSoundPan(sound:RSound, pan:Float)="SetSoundPan"
	Function bmx_raylib_WaveCopy:RWave(wave:RWave)="WaveCopy"
	Function bmx_raylib_WaveCrop(wave:RWave Var, initSample:Int, finalSample:Int)="WaveCrop"
	Function bmx_raylib_WaveFormat(wave:RWave Var, sampleRate:Int, sampleSize:Int, channels:Int)="WaveFormat"
	Function bmx_raylib_LoadWaveSamples:Float Ptr(wave:RWave)="LoadWaveSamples"
	FUnction bmx_raylib_UnloadWaveSamples(samples:Float Ptr)="UnloadWaveSamples"

	Function bmx_raylib_LoadMusicStream:RMusic(fileName:Byte Ptr)="LoadMusicStream"
	Function bmx_raylib_LoadMusicStreamFromMemory:RMusic(fileType:Byte Ptr, data:Byte Ptr, dataSize:Int)="LoadMusicStreamFromMemory"
	Function bmx_raylib_IsMusicValid:Int(music:RMusic)="IsMusicValid"
	Function bmx_raylib_UnloadMusicStream(music:RMusic)="UnloadMusicStream"
	Function bmx_raylib_PlayMusicStream(music:RMusic)="PlayMusicStream"
	Function bmx_raylib_IsMusicStreamPlaying:Int(music:RMusic)="IsMusicStreamPlaying"
	Function bmx_raylib_UpdateMusicStream(music:RMusic)="UpdateMusicStream"
	Function bmx_raylib_StopMusicStream(music:RMusic)="StopMusicStream"
	Function bmx_raylib_PauseMusicStream(music:RMusic)="PauseMusicStream"
	Function bmx_raylib_ResumeMusicStream(music:RMusic)="ResumeMusicStream"
	Function bmx_raylib_SeekMusicStream(music:RMusic, position:Float)="SeekMusicStream"
	Function bmx_raylib_SetMusicVolume(music:RMusic, volume:Float)="SetMusicVolume"
	Function bmx_raylib_SetMusicPitch(music:RMusic, pitch:Float)="SetMusicPitch"
	Function bmx_raylib_SetMusicPan(music:RMusic, pan:Float)="SetMusicPan"
	Function bmx_raylib_GetMusicTimeLength:Float(music:RMusic)="GetMusicTimeLength"
	Function bmx_raylib_GetMusicTimePlayed:Float(music:RMusic)="GetMusicTimePlayed"

	Function bmx_raylib_LoadAudioStream:RAudioStream(sampleRate:UInt, sampleSize:UInt, channels:UInt)="LoadAudioStream"
	Function bmx_raylib_IsAudioStreamValid:Int(stream:RAudioStream)="IsAudioStreamValid"
	Function bmx_raylib_UnloadAudioStream(stream:RAudioStream)="UnloadAudioStream"
	Function bmx_raylib_UpdateAudioStream(stream:RAudioStream, data:Byte Ptr, samplesCount:Int)="UpdateAudioStream"
	Function bmx_raylib_IsAudioStreamProcessed:Int(stream:RAudioStream)="IsAudioStreamProcessed"
	Function bmx_raylib_PlayAudioStream(stream:RAudioStream)="PlayAudioStream"
	Function bmx_raylib_PauseAudioStream(stream:RAudioStream)="PauseAudioStream"
	Function bmx_raylib_ResumeAudioStream(stream:RAudioStream)="ResumeAudioStream"
	Function bmx_raylib_IsAudioStreamPlaying:Int(stream:RAudioStream)="IsAudioStreamPlaying"
	Function bmx_raylib_StopAudioStream(stream:RAudioStream)="StopAudioStream"
	Function bmx_raylib_SetAudioStreamVolume(stream:RAudioStream, volume:Float)="SetAudioStreamVolume"
	Function bmx_raylib_SetAudioStreamPitch(stream:RAudioStream, pitch:Float)="SetAudioStreamPitch"
	Function bmx_raylib_SetAudioStreamPan(stream:RAudioStream, pan:Float)="SetAudioStreamPan"
	Function bmx_raylib_SetAudioStreamBufferSizeDefault(size:Int)="SetAudioStreamBufferSizeDefault"

End Extern

Struct RWave
	Field frameCount:UInt
	Field sampleRate:UInt
	Field sampleSize:UInt
	Field channels:UInt
	Field data:Byte Ptr
End Struct

Struct RAudioStream
	Field buffer:Byte Ptr
	Field processor:Byte Ptr

	Field sampleRate:UInt
	Field sampleSize:UInt
	Field channels:UInt
End Struct

Struct RSound
	Field stream:RAudioStream
	Field frameCount:UInt
End Struct

Struct RMusic
	Field stream:RAudioStream
	Field frameCount:UInt
	Field looping:Int
	
	Field ctxType:Int
	Field ctxData:Byte Ptr
End Struct
