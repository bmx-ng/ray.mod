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
bbdoc: 
End Rem
Module Ray.Math

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


Function Clamp:Float(value:Float, minimum:Float, maximum:Float)
	Return bmx_raymath_Clamp(value, minimum, maximum)
End Function

Function Lerp:Float(s:Float, e:Float, amount:Float)
	Return bmx_raymath_Lerp(s, e, amount)
End Function

Function Vector2Zero:RVector2()
	Return bmx_raymath_Vector2Zero()
End Function

Function Vector2One:RVector2()
	Return bmx_raymath_Vector2One()
End Function

Function Vector2Add:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Add(v1, v2)
End Function

Function Vector2Subtract:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Subtract(v1, v2)
End Function

Function Vector2Length:Float(v:RVector2)
	Return bmx_raymath_Vector2Length(v)
End Function

Function Vector2DotProduct:Float(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2DotProduct(v1, v2)
End Function

Function Vector2Distance:Float(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Distance(v1, v2)
End Function

Function Vector2Angle:Float(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Angle(v1, v2)
End Function

Function Vector2Scale:RVector2(v:RVector2, scale:Float)
	Return bmx_raymath_Vector2Scale(v, scale)
End Function

Function Vector2MultiplyV:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2MultiplyV(v1, v2)
End Function

Function Vector2Negate:RVector2(v:RVector2)
	Return bmx_raymath_Vector2Negate(v)
End Function

Function Vector2Divide:RVector2(v:RVector2, div:Float)
	Return bmx_raymath_Vector2Divide(v, div)
End Function

Function Vector2DivideV:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2DivideV(v1, v2)
End Function

Function Vector2Normalize:RVector2(v:RVector2)
	Return bmx_raymath_Vector2Normalize(v)
End Function

Function Vector2Lerp:RVector2(v1:RVector2, v2:RVector2, amount:Float)
	Return bmx_raymath_Vector2Lerp(v1, v2, amount)
End Function


Function Vector3Zero:RVector3()
	Return bmx_raymath_Vector3Zero()
End Function

Function Vector3One:RVector3()
	Return bmx_raymath_Vector3One()
End Function

Function Vector3Add:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Add(v1, v2)
End Function

Function Vector3Subtract:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Subtract(v1, v2)
End Function

Function Vector3Scale:RVector3(v:RVector3, scalar:Float)
	Return bmx_raymath_Vector3Scale(v, scalar)
End Function

Function Vector3Multiply:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Multiply(v1, v2)
End Function

Function Vector3CrossProduct:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3CrossProduct(v1, v2)
End Function

Function Vector3Perpendicular:RVector3(v:RVector3)
	Return bmx_raymath_Vector3Perpendicular(v)
End Function

Function Vector3Length:Float(v:RVector3)
	Return bmx_raymath_Vector3Length(v)
End Function

Function Vector3DotProduct:Float(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3DotProduct(v1, v2)
End Function

Function Vector3Distance:Float(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Distance(v1, v2)
End Function

Function Vector3Negate:RVector3(v:RVector3)
	Return bmx_raymath_Vector3Negate(v)
End Function

Function Vector3Divide:RVector3(v:RVector3, div:Float)
	Return bmx_raymath_Vector3Divide(v, div)
End Function

Function Vector3DivideV:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3DivideV(v1, v2)
End Function

Function Vector3Normalize:RVector3(v:RVector3)
	Return bmx_raymath_Vector3Normalize(v)
End Function

Function Vector3OrthoNormalize(v1:RVector3 Var, v2:RVector3 Var)
	bmx_raymath_Vector3OrthoNormalize(v1, v2)
End Function

Function Vector3Transform:RVector3(v:RVector3, mat:RMatrix)
	Return bmx_raymath_Vector3Transform(v, mat)
End Function

Function Vector3RotateByQuaternion:RVector3(v:RVector3, q:RQuaternion)
	Return bmx_raymath_Vector3RotateByQuaternion(v, q)
End Function

Function Vector3Lerp:RVector3(v1:RVector3, v2:RVector3, amount:Float)
	Return bmx_raymath_Vector3Lerp(v1, v2, amount)
End Function

Function Vector3Reflect:RVector3(v:RVector3, normal:RVector3)
	Return bmx_raymath_Vector3Reflect(v, normal)
End Function

Function Vector3Min:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Min(v1, v2)
End Function

Function Vector3Max:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Max(v1, v2)
End Function

Function Vector3Barycenter:RVector3(p:RVector3, a:RVector3, b:RVector3, c:RVector3)
	Return bmx_raymath_Vector3Barycenter(p, a, b, c)
End Function

Function Vector3ToFloatV:RVector3(v:RVector3)
	Return bmx_raymath_Vector3ToFloatV(v)
End Function


Function MatrixDeterminant:Float(mat:RMatrix)
	Return bmx_raymath_MatrixDeterminant(mat)
End Function

Function MatrixTrace:Float(mat:RMatrix)
	Return bmx_raymath_MatrixTrace(mat)
End Function

Function MatrixTranspose:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixTranspose(mat)
End Function

Function MatrixInvert:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixInvert(mat)
End Function

Function MatrixNormalize:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixNormalize(mat)
End Function

Function MatrixIdentity:RMatrix()
	Return bmx_raymath_MatrixIdentity()
End Function

Function MatrixAdd:RMatrix(Left:RMatrix, Right:RMatrix)
	Return bmx_raymath_MatrixAdd(Left, Right)
End Function

Function MatrixSubtract:RMatrix(Left:RMatrix, Right:RMatrix)
	Return bmx_raymath_MatrixSubtract(Left, Right)
End Function

Function MatrixTranslate:RMatrix(x:Float, y:Float, z:Float)
	Return bmx_raymath_MatrixTranslate(x, y, z)
End Function

Function MatrixRotate:RMatrix(axis:RVector3, angle:Float)
	Return bmx_raymath_MatrixRotate(axis, angle)
End Function

Function MatrixRotateXYZ:RMatrix(ang:RVector3)
	Return bmx_raymath_MatrixRotateXYZ(ang)
End Function

Function MatrixRotateX:RMatrix(angle:Float)
	Return bmx_raymath_MatrixRotateX(angle)
End Function

Function MatrixRotateY:RMatrix(angle:Float)
	Return bmx_raymath_MatrixRotateY(angle)
End Function

Function MatrixRotateZ:RMatrix(angle:Float)
	Return bmx_raymath_MatrixRotateZ(angle)
End Function

Function MatrixScale:RMatrix(x:Float, y:Float, z:Float)
	Return bmx_raymath_MatrixScale(x, y, z)
End Function

Function MatrixMultiply:RMatrix(Left:RMatrix, Right:RMatrix)
	Return bmx_raymath_MatrixMultiply(Left, Right)
End Function

Function MatrixFrustum:RMatrix(Left:Double, Right:Double, bottom:Double, top:Double, near:Double, far:Double)
	Return bmx_raymath_MatrixFrustum(Left, Right, bottom, top, near, far)
End Function

Function MatrixPerspective:RMatrix(fovy:Double, aspect:Double, near:Double, far:Double)
	Return bmx_raymath_MatrixPerspective(fovy, aspect, near, far)
End Function

Function MatrixOrtho:RMatrix(Left:Double, Right:Double, bottom:Double, top:Double, near:Double, far:Double)
	Return bmx_raymath_MatrixOrtho(Left, Right, bottom, top, near, far)
End Function

Function MatrixLookAt:RMatrix(eye:RVector3, target:RVector3, up:RVector3)
	Return bmx_raymath_MatrixLookAt(eye, target, up)
End Function

Function MatrixToFloatV:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixToFloatV(mat)
End Function


Function QuaternionIdentity:RQuaternion()
	Return bmx_raymath_QuaternionIdentity()
End Function

Function QuaternionLength:Float(q:RQuaternion)
	Return bmx_raymath_QuaternionLength(q)
End Function

Function QuaternionNormalize:RQuaternion(q:RQuaternion)
	Return bmx_raymath_QuaternionNormalize(q)
End Function

Function QuaternionInvert:RQuaternion(q:RQuaternion)
	Return bmx_raymath_QuaternionInvert(q)
End Function

Function QuaternionMultiply:RQuaternion(q1:RQuaternion, q2:RQuaternion)
	Return bmx_raymath_QuaternionMultiply(q1, q2)
End Function

Function QuaternionLerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)
	Return bmx_raymath_QuaternionLerp(q1, q2, amount)
End Function

Function QuaternionNlerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)
	Return bmx_raymath_QuaternionNlerp(q1, q2, amount)
End Function

Function QuaternionSlerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)
	Return bmx_raymath_QuaternionSlerp(q1, q2, amount)
End Function

Function QuaternionFromVector3ToVector3:RQuaternion(vfrom:RVector3, vto:RVector3)
	Return bmx_raymath_QuaternionFromVector3ToVector3(vfrom, vto)
End Function

Function QuaternionFromMatrix:RQuaternion(mat:RMatrix)
	Return bmx_raymath_QuaternionFromMatrix(mat)
End Function

Function QuaternionToMatrix:RMatrix(q:RQuaternion)
	Return bmx_raymath_QuaternionToMatrix(q)
End Function

Function QuaternionFromAxisAngle:RQuaternion(axis:RVector3, angle:Float)
	Return bmx_raymath_QuaternionFromAxisAngle(axis, angle)
End Function

Function QuaternionToAxisAngle(q:RQuaternion, outAxis:RVector3 Var, outAngle:Float Var)
	bmx_raymath_QuaternionToAxisAngle(q, outAxis, outAngle)
End Function

Function QuaternionFromEuler:RQuaternion(roll:Float, pitch:Float, yaw:Float)
	Return bmx_raymath_QuaternionFromEuler(roll, pitch, yaw)
End Function

Function QuaternionToEuler:RVector3(q:RQuaternion)
	Return bmx_raymath_QuaternionToEuler(q)
End Function

Function QuaternionTransform:RQuaternion(q:RQuaternion, mat:RMatrix)
	Return bmx_raymath_QuaternionTransform(q, mat)
End Function
