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
bbdoc: Math functions for RVector3, RMatrix and RQuaternion.
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


Rem
bbdoc: Clamps #Float value.
End Rem
Function Clamp:Float(value:Float, minimum:Float, maximum:Float)
	Return bmx_raymath_Clamp(value, minimum, maximum)
End Function

Rem
bbdoc: Calculates linear interpolation between two floats.
End Rem
Function Lerp:Float(s:Float, e:Float, amount:Float)
	Return bmx_raymath_Lerp(s, e, amount)
End Function

Rem
bbdoc: #RVector with components value 0.0.
End Rem
Function Vector2Zero:RVector2()
	Return bmx_raymath_Vector2Zero()
End Function

Rem
bbdoc: #RVector with components value 1.0.
End Rem
Function Vector2One:RVector2()
	Return bmx_raymath_Vector2One()
End Function

Rem
bbdoc: Adds two vectors `(v1 + v2)`.
End Rem
Function Vector2Add:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Add(v1, v2)
End Function

Rem
bbdoc: Subtracts two vectors `(v1 - v2)`.
End Rem
Function Vector2Subtract:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Subtract(v1, v2)
End Function

Rem
bbdoc: Calculates vector length.
End Rem
Function Vector2Length:Float(v:RVector2)
	Return bmx_raymath_Vector2Length(v)
End Function

Rem
bbdoc: Calculates two vectors dot product.
End Rem
Function Vector2DotProduct:Float(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2DotProduct(v1, v2)
End Function

Rem
bbdoc: Calculates distance between two vectors.
End Rem
Function Vector2Distance:Float(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Distance(v1, v2)
End Function

Rem
bbdoc: Calculates angle from two vectors in X-axis.
End Rem
Function Vector2Angle:Float(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2Angle(v1, v2)
End Function

Rem
bbdoc: Scales vector (multiply by value).
End Rem
Function Vector2Scale:RVector2(v:RVector2, scale:Float)
	Return bmx_raymath_Vector2Scale(v, scale)
End Function

Rem
bbdoc: Multiplies vector by vector.
End Rem
Function Vector2MultiplyV:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2MultiplyV(v1, v2)
End Function

Rem
bbdoc: Negates vector.
End Rem
Function Vector2Negate:RVector2(v:RVector2)
	Return bmx_raymath_Vector2Negate(v)
End Function

Rem
bbdoc: Divides vector by a #Float value.
End Rem
Function Vector2Divide:RVector2(v:RVector2, div:Float)
	Return bmx_raymath_Vector2Divide(v, div)
End Function

Rem
bbdoc: Divides vector by vector.
End Rem
Function Vector2DivideV:RVector2(v1:RVector2, v2:RVector2)
	Return bmx_raymath_Vector2DivideV(v1, v2)
End Function

Rem
bbdoc: Normalizes provided vector.
End Rem
Function Vector2Normalize:RVector2(v:RVector2)
	Return bmx_raymath_Vector2Normalize(v)
End Function

Rem
bbdoc: Calculates linear interpolation between two vectors.
End Rem
Function Vector2Lerp:RVector2(v1:RVector2, v2:RVector2, amount:Float)
	Return bmx_raymath_Vector2Lerp(v1, v2, amount)
End Function

Rem
bbdoc: Rotates Vector by float in Degrees.
End Rem
Function Vector2Rotate:RVector2(v:RVector2, degs:Float)
	Return bmx_raymath_Vector2Rotate(v, degs)
End Function

Rem
bbdoc: #RVector3 with components value 0.0.
End Rem
Function Vector3Zero:RVector3()
	Return bmx_raymath_Vector3Zero()
End Function

Rem
bbdoc: #RVector3 with components value 1.0.
End Rem
Function Vector3One:RVector3()
	Return bmx_raymath_Vector3One()
End Function

Rem
bbdoc: Adds two vectors.
End Rem
Function Vector3Add:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Add(v1, v2)
End Function

Rem
bbdoc: Subtracts two vectors.
End Rem
Function Vector3Subtract:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Subtract(v1, v2)
End Function

Rem
bbdoc: Multiplies vector by scalar.
End Rem
Function Vector3Scale:RVector3(v:RVector3, scalar:Float)
	Return bmx_raymath_Vector3Scale(v, scalar)
End Function

Rem
bbdoc: Multiplies vector by vector.
End Rem
Function Vector3Multiply:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Multiply(v1, v2)
End Function

Rem
bbdoc: Calculates two vectors cross product.
End Rem
Function Vector3CrossProduct:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3CrossProduct(v1, v2)
End Function

Rem
bbdoc: Calculates one vector perpendicular vector.
End Rem
Function Vector3Perpendicular:RVector3(v:RVector3)
	Return bmx_raymath_Vector3Perpendicular(v)
End Function

Rem
bbdoc: Calculates vector length.
End Rem
Function Vector3Length:Float(v:RVector3)
	Return bmx_raymath_Vector3Length(v)
End Function

Rem
bbdoc: Calculates two vectors dot product.
End Rem
Function Vector3DotProduct:Float(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3DotProduct(v1, v2)
End Function

Rem
bbdoc: Calculates distance between two vectors.
End Rem
Function Vector3Distance:Float(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Distance(v1, v2)
End Function

Rem
bbdoc: Negates provided vector (invert direction).
End Rem
Function Vector3Negate:RVector3(v:RVector3)
	Return bmx_raymath_Vector3Negate(v)
End Function

Rem
bbdoc: Divides vector by a #Float value.
End Rem
Function Vector3Divide:RVector3(v:RVector3, div:Float)
	Return bmx_raymath_Vector3Divide(v, div)
End Function

Rem
bbdoc: Divides vector by vector.
End Rem
Function Vector3DivideV:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3DivideV(v1, v2)
End Function

Rem
bbdoc: Normalizes provided vector.
End Rem
Function Vector3Normalize:RVector3(v:RVector3)
	Return bmx_raymath_Vector3Normalize(v)
End Function

Rem
bbdoc: Orthonormalizes provided vectors.
about: Makes vectors normalized and orthogonal to each other. *Gram-Schmidt* function implementation
End Rem
Function Vector3OrthoNormalize(v1:RVector3 Var, v2:RVector3 Var)
	bmx_raymath_Vector3OrthoNormalize(v1, v2)
End Function

Rem
bbdoc: Transforms a Vector3 by a given Matrix.
End Rem
Function Vector3Transform:RVector3(v:RVector3, mat:RMatrix)
	Return bmx_raymath_Vector3Transform(v, mat)
End Function

Rem
bbdoc: Transforms a vector by quaternion rotation.
End Rem
Function Vector3RotateByQuaternion:RVector3(v:RVector3, q:RQuaternion)
	Return bmx_raymath_Vector3RotateByQuaternion(v, q)
End Function

Rem
bbdoc: Calculates linear interpolation between two vectors.
End Rem
Function Vector3Lerp:RVector3(v1:RVector3, v2:RVector3, amount:Float)
	Return bmx_raymath_Vector3Lerp(v1, v2, amount)
End Function

Rem
bbdoc: Calculates reflected vector to normal.
End Rem
Function Vector3Reflect:RVector3(v:RVector3, normal:RVector3)
	Return bmx_raymath_Vector3Reflect(v, normal)
End Function

Rem
bbdoc: Returns min value for each pair of components.
End Rem
Function Vector3Min:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Min(v1, v2)
End Function

Rem
bbdoc: Returns max value for each pair of components.
End Rem
Function Vector3Max:RVector3(v1:RVector3, v2:RVector3)
	Return bmx_raymath_Vector3Max(v1, v2)
End Function

Rem
bbdoc: Computes barycenter coordinates '(u, v, w)' for point @p with respect to triangle '(a, b, c)'.
about
> NOTE: Assumes @p is on the plane of the triangle.
End Rem
Function Vector3Barycenter:RVector3(p:RVector3, a:RVector3, b:RVector3, c:RVector3)
	Return bmx_raymath_Vector3Barycenter(p, a, b, c)
End Function

Rem
bbdoc: Returns Vector3 as float array.
End Rem
Function Vector3ToFloatV:RVector3(v:RVector3)
	Return bmx_raymath_Vector3ToFloatV(v)
End Function


Rem
bbdoc: Computes matrix determinant.
End Rem
Function MatrixDeterminant:Float(mat:RMatrix)
	Return bmx_raymath_MatrixDeterminant(mat)
End Function

Rem
bbdoc: Returns the trace of the matrix (sum of the values along the diagonal).
End Rem
Function MatrixTrace:Float(mat:RMatrix)
	Return bmx_raymath_MatrixTrace(mat)
End Function

Rem
bbdoc: Transposes provided matrix.
End Rem
Function MatrixTranspose:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixTranspose(mat)
End Function

Rem
bbdoc: Inverts provided matrix.
End Rem
Function MatrixInvert:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixInvert(mat)
End Function

Rem
bbdoc: Normalizes provided matrix.
End Rem
Function MatrixNormalize:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixNormalize(mat)
End Function

Rem
bbdoc: Returns identity matrix.
End Rem
Function MatrixIdentity:RMatrix()
	Return bmx_raymath_MatrixIdentity()
End Function

Rem
bbdoc: Adds two matrices.
End Rem
Function MatrixAdd:RMatrix(Left:RMatrix, Right:RMatrix)
	Return bmx_raymath_MatrixAdd(Left, Right)
End Function

Rem
bbdoc: Subtracts two matrices (left - right).
End Rem
Function MatrixSubtract:RMatrix(Left:RMatrix, Right:RMatrix)
	Return bmx_raymath_MatrixSubtract(Left, Right)
End Function

Rem
bbdoc: Returns translation matrix.
End Rem
Function MatrixTranslate:RMatrix(x:Float, y:Float, z:Float)
	Return bmx_raymath_MatrixTranslate(x, y, z)
End Function

Rem
bbdoc: Creates rotation matrix from axis and angle.
End Rem
Function MatrixRotate:RMatrix(axis:RVector3, angle:Float)
	Return bmx_raymath_MatrixRotate(axis, angle * 0.0174533)
End Function

Rem
bbdoc: Returns xyz-rotation matrix.
End Rem
Function MatrixRotateXYZ:RMatrix(ang:RVector3)
	Return bmx_raymath_MatrixRotateXYZ(New RVector3(ang.x * 0.0174533, ang.y * 0.0174533, ang.z * 0.0174533))
End Function

Rem
bbdoc: Returns x-rotation matrix.
End Rem
Function MatrixRotateX:RMatrix(angle:Float)
	Return bmx_raymath_MatrixRotateX(angle * 0.0174533)
End Function

Rem
bbdoc: Returns y-rotation matrix.
End Rem
Function MatrixRotateY:RMatrix(angle:Float)
	Return bmx_raymath_MatrixRotateY(angle * 0.0174533)
End Function

Rem
bbdoc: Returns z-rotation matrix.
End Rem
Function MatrixRotateZ:RMatrix(angle:Float)
	Return bmx_raymath_MatrixRotateZ(angle * 0.0174533)
End Function

Rem
bbdoc: Returns scaling matrix.
End Rem
Function MatrixScale:RMatrix(x:Float, y:Float, z:Float)
	Return bmx_raymath_MatrixScale(x, y, z)
End Function

Rem
bbdoc: Returns two matrix multiplication
about: 
> NOTE: When multiplying matrices... the order matters!
End Rem
Function MatrixMultiply:RMatrix(Left:RMatrix, Right:RMatrix)
	Return bmx_raymath_MatrixMultiply(Left, Right)
End Function

Rem
bbdoc: Returns perspective projection matrix.
End Rem
Function MatrixFrustum:RMatrix(Left:Double, Right:Double, bottom:Double, top:Double, near:Double, far:Double)
	Return bmx_raymath_MatrixFrustum(Left, Right, bottom, top, near, far)
End Function

Rem
bbdoc: Returns perspective projection matrix.
End Rem
Function MatrixPerspective:RMatrix(fovy:Double, aspect:Double, near:Double, far:Double)
	Return bmx_raymath_MatrixPerspective(fovy * 0.0174533, aspect, near, far)
End Function

Rem
bbdoc: Returns orthographic projection matrix.
End Rem
Function MatrixOrtho:RMatrix(Left:Double, Right:Double, bottom:Double, top:Double, near:Double, far:Double)
	Return bmx_raymath_MatrixOrtho(Left, Right, bottom, top, near, far)
End Function

Rem
bbdoc: Returns camera look-at matrix (view matrix).
End Rem
Function MatrixLookAt:RMatrix(eye:RVector3, target:RVector3, up:RVector3)
	Return bmx_raymath_MatrixLookAt(eye, target, up)
End Function

Rem
bbdoc: Returns float array of matrix data.
End Rem
Function MatrixToFloatV:RMatrix(mat:RMatrix)
	Return bmx_raymath_MatrixToFloatV(mat)
End Function


Rem
bbdoc: Returns identity quaternion.
End Rem
Function QuaternionIdentity:RQuaternion()
	Return bmx_raymath_QuaternionIdentity()
End Function

Rem
bbdoc: Computes the length of a quaternion.
End Rem
Function QuaternionLength:Float(q:RQuaternion)
	Return bmx_raymath_QuaternionLength(q)
End Function

Rem
bbdoc: Normalizes provided quaternion.
End Rem
Function QuaternionNormalize:RQuaternion(q:RQuaternion)
	Return bmx_raymath_QuaternionNormalize(q)
End Function

Rem
bbdoc: Inverts provided quaternion.
End Rem
Function QuaternionInvert:RQuaternion(q:RQuaternion)
	Return bmx_raymath_QuaternionInvert(q)
End Function

Rem
bbdoc: Calculates two quaternion multiplication.
End Rem
Function QuaternionMultiply:RQuaternion(q1:RQuaternion, q2:RQuaternion)
	Return bmx_raymath_QuaternionMultiply(q1, q2)
End Function

Rem
bbdoc: Calculates linear interpolation between two quaternions.
End Rem
Function QuaternionLerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)
	Return bmx_raymath_QuaternionLerp(q1, q2, amount)
End Function

Rem
bbdoc: Calculates slerp-optimized interpolation between two quaternions.
End Rem
Function QuaternionNlerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)
	Return bmx_raymath_QuaternionNlerp(q1, q2, amount)
End Function

Rem
bbdoc: Calculates spherical linear interpolation between two quaternions.
End Rem
Function QuaternionSlerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)
	Return bmx_raymath_QuaternionSlerp(q1, q2, amount)
End Function

Rem
bbdoc: Calculates quaternion based on the rotation from one vector to another.
End Rem
Function QuaternionFromVector3ToVector3:RQuaternion(vfrom:RVector3, vto:RVector3)
	Return bmx_raymath_QuaternionFromVector3ToVector3(vfrom, vto)
End Function

Rem
bbdoc: Returns a quaternion for a given rotation matrix.
End Rem
Function QuaternionFromMatrix:RQuaternion(mat:RMatrix)
	Return bmx_raymath_QuaternionFromMatrix(mat)
End Function

Rem
bbdoc: Returns a matrix for a given quaternion.
End Rem
Function QuaternionToMatrix:RMatrix(q:RQuaternion)
	Return bmx_raymath_QuaternionToMatrix(q)
End Function

Rem
bbdoc: Returns rotation quaternion for an angle and axis.
End Rem
Function QuaternionFromAxisAngle:RQuaternion(axis:RVector3, angle:Float)
	Return bmx_raymath_QuaternionFromAxisAngle(axis, angle * 0.0174533)
End Function

Rem
bbdoc: Returns the rotation angle and axis for a given quaternion.
End Rem
Function QuaternionToAxisAngle(q:RQuaternion, outAxis:RVector3 Var, outAngle:Float Var)
	bmx_raymath_QuaternionToAxisAngle(q, outAxis, outAngle)
End Function

Rem
bbdoc: Returns the quaternion equivalent to Euler angles.
End Rem
Function QuaternionFromEuler:RQuaternion(roll:Float, pitch:Float, yaw:Float)
	Return bmx_raymath_QuaternionFromEuler(roll, pitch, yaw)
End Function

Rem
bbdoc: Returns the Euler angles equivalent to quaternion (roll, pitch, yaw).
End Rem
Function QuaternionToEuler:RVector3(q:RQuaternion)
	Return bmx_raymath_QuaternionToEuler(q)
End Function

Rem
bbdoc: Transforms a quaternion given a transformation matrix.
End Rem
Function QuaternionTransform:RQuaternion(q:RQuaternion, mat:RMatrix)
	Return bmx_raymath_QuaternionTransform(q, mat)
End Function
