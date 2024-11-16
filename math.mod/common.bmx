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

	Function bmx_raymath_Clamp:Float(value:Float, minimum:Float, maximum:Float)="Clamp"
	Function bmx_raymath_Lerp:Float(s:Float, e:Float, amount:Float)="Lerp"
	Function bmx_raymath_Normalize:Float(value:Float, s:Float, e:Float)="Normalize"
	Function bmx_raymath_Remap:Float(value:Float, inputStart:Float, inputEnd:Float, outputStart:Float, outputEnd:Float)="Remap"
	Function bmx_raymath_Wrap:Float(value:Float, minimum:Float, maximum:Float)="Wrap"
	Function bmx_raymath_FloatEquals:Int(x:Float, y:Float)="FloatEquals"
	Function bmx_raymath_Vector2Zero:RVector2()="Vector2Zero"
	Function bmx_raymath_Vector2One:RVector2()="Vector2One"
	Function bmx_raymath_Vector2Add:RVector2(v1:RVector2, v2:RVector2)="Vector2Add"
	Function bmx_raymath_Vector2AddValue:RVector2(v:RVector2, add:Float)="Vector2AddValue"
	Function bmx_raymath_Vector2Subtract:RVector2(v1:RVector2, v2:RVector2)="Vector2Subtract"
	Function bmx_raymath_Vector2SubtractValue:RVector2(v:RVector2, sub:Float)="Vector2SubtractValue"
	Function bmx_raymath_Vector2Length:Float(v:RVector2)="Vector2Length"
	Function bmx_raymath_Vector2LengthSqr:Float(v:RVector2)="Vector2LengthSqr"
	Function bmx_raymath_Vector2DotProduct:Float(v1:RVector2, v2:RVector2)="Vector2DotProduct"
	Function bmx_raymath_Vector2Distance:Float(v1:RVector2, v2:RVector2)="Vector2Distance"
	Function bmx_raymath_Vector2DistanceSqr:Float(v1:RVector2, v2:RVector2)="Vector2DistanceSqr"
	Function bmx_raymath_Vector2Angle:Float(v1:RVector2, v2:RVector2)="Vector2Angle"
	Function bmx_raymath_Vector2LineAngle:Float(v1:RVector2, v2:RVector2)="Vector2LineAngle"
	Function bmx_raymath_Vector2Scale:RVector2(v:RVector2, scale:Float)="Vector2Scale"
	Function bmx_raymath_Vector2MultiplyV:RVector2(v1:RVector2, v2:RVector2)="Vector2MultiplyV"
	Function bmx_raymath_Vector2Negate:RVector2(v:RVector2)="Vector2Negate"
	Function bmx_raymath_Vector2Divide:RVector2(v:RVector2, div:Float)="Vector2Divide"
	' Function bmx_raymath_Vector2DivideV:RVector2(v1:RVector2, v2:RVector2)="Vector2DivideV"
	Function bmx_raymath_Vector2Normalize:RVector2(v:RVector2)="Vector2Normalize"
	Function bmx_raymath_Vector2Transform:RVector2(v:RVector2, mat:RMatrix)="Vector2Transform"
	Function bmx_raymath_Vector2Lerp:RVector2(v1:RVector2, v2:RVector2, amount:Float)="Vector2Lerp"
	Function bmx_raymath_Vector2Reflect:RVector2(v:RVector2, normal:RVector2)="Vector2Reflect"
	Function bmx_raymath_Vector2Min:RVector2(v1:RVector2, v2:RVector2)="Vector2Min"
	Function bmx_raymath_Vector2Max:RVector2(v1:RVector2, v2:RVector2)="Vector2Max"
	Function bmx_raymath_Vector2Rotate:RVector2(v:RVector2, degs:Float)="Vector2Rotate"
	Function bmx_raymath_Vector2MoveTowards:RVector2(v:RVector2, target:RVector2, maxDistance:Float)="Vector2MoveTowards"
	Function bmx_raymath_Vector2Invert:RVector2(v:RVector2)="Vector2Invert"
	Function bmx_raymath_Vector2Clamp:RVector2(v:RVector2, minimum:RVector2, maximum:RVector2)="Vector2Clamp"
	Function bmx_raymath_Vector2ClampValue:RVector2(v:RVector2, minimum:Float, maximum:Float)="Vector2ClampValue"
	Function bmx_raymath_Vector2Equals:Int(v1:RVector2, v2:RVector2)="Vector2Equals"
	Function bmx_raymath_Vector2Refract:RVector2(v:RVector2, n:RVector2, r:Float)="Vector2Refract"

	Function bmx_raymath_Vector3Zero:RVector3()="Vector3Zero"
	Function bmx_raymath_Vector3One:RVector3()="Vector3One"
	Function bmx_raymath_Vector3Add:RVector3(v1:RVector3, v2:RVector3)="Vector3Add"
	Function bmx_raymath_Vector3Subtract:RVector3(v1:RVector3, v2:RVector3)="Vector3Subtract"
	Function bmx_raymath_Vector3Scale:RVector3(v:RVector3, scalar:Float)="Vector3Scale"
	Function bmx_raymath_Vector3Multiply:RVector3(v1:RVector3, v2:RVector3)="Vector3Multiply"
	Function bmx_raymath_Vector3CrossProduct:RVector3(v1:RVector3, v2:RVector3)="Vector3CrossProduct"
	Function bmx_raymath_Vector3Perpendicular:RVector3(v:RVector3)="Vector3Perpendicular"
	Function bmx_raymath_Vector3Length:Float(v:RVector3)="Vector3Length"
	Function bmx_raymath_Vector3DotProduct:Float(v1:RVector3, v2:RVector3)="Vector3DotProduct"
	Function bmx_raymath_Vector3Distance:Float(v1:RVector3, v2:RVector3)="Vector3Distance"
	Function bmx_raymath_Vector3Negate:RVector3(v:RVector3)="Vector3Negate"
	Function bmx_raymath_Vector3Divide:RVector3(v:RVector3, div:Float)="Vector3Divide"
	Function bmx_raymath_Vector3DivideV:RVector3(v1:RVector3, v2:RVector3)="Vector3DivideV"
	Function bmx_raymath_Vector3Normalize:RVector3(v:RVector3)="Vector3Normalize"
	Function bmx_raymath_Vector3OrthoNormalize(v1:RVector3 Var, v2:RVector3 Var)="Vector3OrthoNormalize"
	Function bmx_raymath_Vector3Transform:RVector3(v:RVector3, mat:RMatrix)="Vector3Transform"
	Function bmx_raymath_Vector3RotateByQuaternion:RVector3(v:RVector3, q:RQuaternion)="Vector3RotateByQuaternion"
	Function bmx_raymath_Vector3Lerp:RVector3(v1:RVector3, v2:RVector3, amount:Float)="Vector3Lerp"
	Function bmx_raymath_Vector3Reflect:RVector3(v:RVector3, normal:RVector3)="Vector3Reflect"
	Function bmx_raymath_Vector3Min:RVector3(v1:RVector3, v2:RVector3)="Vector3Min"
	Function bmx_raymath_Vector3Max:RVector3(v1:RVector3, v2:RVector3)="Vector3Max"
	Function bmx_raymath_Vector3Barycenter:RVector3(p:RVector3, a:RVector3, b:RVector3, c:RVector3)="Vector3Barycenter"
	Function bmx_raymath_Vector3ToFloatV:RVector3(v:RVector3)="Vector3ToFloatV"

	Function bmx_raymath_MatrixDeterminant:Float(mat:RMatrix)="MatrixDeterminant"
	Function bmx_raymath_MatrixTrace:Float(mat:RMatrix)="MatrixTrace"
	Function bmx_raymath_MatrixTranspose:RMatrix(mat:RMatrix)="MatrixTranspose"
	Function bmx_raymath_MatrixInvert:RMatrix(mat:RMatrix)="MatrixInvert"
	Function bmx_raymath_MatrixNormalize:RMatrix(mat:RMatrix)="MatrixNormalize"
	Function bmx_raymath_MatrixIdentity:RMatrix()="MatrixIdentity"
	Function bmx_raymath_MatrixAdd:RMatrix(Left:RMatrix, Right:RMatrix)="MatrixAdd"
	Function bmx_raymath_MatrixSubtract:RMatrix(Left:RMatrix, Right:RMatrix)="MatrixSubtract"
	Function bmx_raymath_MatrixTranslate:RMatrix(x:Float, y:Float, z:Float)="MatrixTranslate"
	Function bmx_raymath_MatrixRotate:RMatrix(axis:RVector3, angle:Float)="MatrixRotate"
	Function bmx_raymath_MatrixRotateXYZ:RMatrix(ang:RVector3)="MatrixRotateXYZ"
	Function bmx_raymath_MatrixRotateX:RMatrix(angle:Float)="MatrixRotateX"
	Function bmx_raymath_MatrixRotateY:RMatrix(angle:Float)="MatrixRotateY"
	Function bmx_raymath_MatrixRotateZ:RMatrix(angle:Float)="MatrixRotateZ"
	Function bmx_raymath_MatrixScale:RMatrix(x:Float, y:Float, z:Float)="MatrixScale"
	Function bmx_raymath_MatrixMultiply:RMatrix(Left:RMatrix, Right:RMatrix)="MatrixMultiply"
	Function bmx_raymath_MatrixFrustum:RMatrix(Left:Double, Right:Double, bottom:Double, top:Double, near:Double, far:Double)="MatrixFrustum"
	Function bmx_raymath_MatrixPerspective:RMatrix(fovy:Double, aspect:Double, near:Double, far:Double)="MatrixPerspective"
	Function bmx_raymath_MatrixOrtho:RMatrix(Left:Double, Right:Double, bottom:Double, top:Double, near:Double, far:Double)="MatrixOrtho"
	Function bmx_raymath_MatrixLookAt:RMatrix(eye:RVector3, target:RVector3, up:RVector3)="MatrixLookAt"
	Function bmx_raymath_MatrixToFloatV:RMatrix(mat:RMatrix)="MatrixToFloatV"

	Function bmx_raymath_QuaternionIdentity:RQuaternion()="QuaternionIdentity"
	Function bmx_raymath_QuaternionLength:Float(q:RQuaternion)="QuaternionLength"
	Function bmx_raymath_QuaternionNormalize:RQuaternion(q:RQuaternion)="QuaternionNormalize"
	Function bmx_raymath_QuaternionInvert:RQuaternion(q:RQuaternion)="QuaternionInvert"
	Function bmx_raymath_QuaternionMultiply:RQuaternion(q1:RQuaternion, q2:RQuaternion)="QuaternionMultiply"
	Function bmx_raymath_QuaternionLerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)="QuaternionLerp"
	Function bmx_raymath_QuaternionNlerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)="QuaternionNlerp"
	Function bmx_raymath_QuaternionSlerp:RQuaternion(q1:RQuaternion, q2:RQuaternion, amount:Float)="QuaternionSlerp"
	Function bmx_raymath_QuaternionFromVector3ToVector3:RQuaternion(vfrom:RVector3, vto:RVector3)="QuaternionFromVector3ToVector3"
	Function bmx_raymath_QuaternionFromMatrix:RQuaternion(mat:RMatrix)="QuaternionFromMatrix"
	Function bmx_raymath_QuaternionToMatrix:RMatrix(q:RQuaternion)="QuaternionToMatrix"
	Function bmx_raymath_QuaternionFromAxisAngle:RQuaternion(axis:RVector3, angle:Float)="QuaternionFromAxisAngle"
	Function bmx_raymath_QuaternionToAxisAngle(q:RQuaternion, outAxis:RVector3 Var, outAngle:Float Var)="QuaternionToAxisAngle"
	Function bmx_raymath_QuaternionFromEuler:RQuaternion(roll:Float, pitch:Float, yaw:Float)="QuaternionFromEuler"
	Function bmx_raymath_QuaternionToEuler:RVector3(q:RQuaternion)="QuaternionToEuler"
	Function bmx_raymath_QuaternionTransform:RQuaternion(q:RQuaternion, mat:RMatrix)="QuaternionTransform"

End Extern
