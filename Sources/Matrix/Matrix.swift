//
//  Matrix.swift
//
//
//  Created by David Reed on 2/19/24.
//

import Foundation

public struct Mat4: Equatable {
    public var x: Vec4
    public var y: Vec4
    public var z: Vec4
    public var w: Vec4

    public static var identity: Mat4 {
        [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ]
    }

    public static var zero: Mat4 {
        [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0]
        ]
    }

    public init(row0 x: Vec4 = [1, 0, 0, 0], row1 y: Vec4 = [0, 1, 0, 0], row2 z: Vec4 = [0, 0, 1, 0], row3 w: Vec4 = [0, 0, 0, 1]) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public subscript(index: Int) -> Vec4 {
        get {
            switch(index) {
            case 0: return x
            case 1: return y
            case 2: return z
            case 3: return w
            default: preconditionFailure("Mat4 index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            case 3: w = newValue
            default: preconditionFailure("Mat4 index out of range")
            }
        }
    }

    public static func *(m: Mat4, v: Vec4) -> Vec4 {
        let x = m[0][0] * v[0] + m[0][1] * v[1] + m[0][2] * v[2] + m[0][3] * v[3]
        let y = m[1][0] * v[0] + m[1][1] * v[1] + m[1][2] * v[2] + m[1][3] * v[3]
        let z = m[2][0] * v[0] + m[2][1] * v[1] + m[2][2] * v[2] + m[2][3] * v[3]
        let w = m[3][0] * v[0] + m[3][1] * v[1] + m[3][2] * v[2] + m[3][3] * v[3]
        return [x, y, z, w]
    }

    public static func *(m: Mat4, v: Vec3) -> Vec4 {
        let x = m[0][0] * v[0] + m[0][1] * v[1] + m[0][2] * v[2] + m[0][3]
        let y = m[1][0] * v[0] + m[1][1] * v[1] + m[1][2] * v[2] + m[1][3]
        let z = m[2][0] * v[0] + m[2][1] * v[1] + m[2][2] * v[2] + m[2][3]
        let w = m[3][0] * v[0] + m[3][1] * v[1] + m[3][2] * v[2] + m[3][3]
        return [x, y, z, w]
    }

    public static func *(lhs: Mat4, rhs: Mat4) -> Mat4 {
        let col0: Vec4 = [rhs[0][0], rhs[1][0], rhs[2][0], rhs[3][0]]
        let col1: Vec4 = [rhs[0][1], rhs[1][1], rhs[2][1], rhs[3][1]]
        let col2: Vec4 = [rhs[0][2], rhs[1][2], rhs[2][2], rhs[3][2]]
        let col3: Vec4 = [rhs[0][3], rhs[1][3], rhs[2][3], rhs[3][3]]

        let row0: Vec4 = [ lhs[0].dot(col0), lhs[0].dot(col1), lhs[0].dot(col2), lhs[0].dot(col3) ]
        let row1: Vec4 = [ lhs[1].dot(col0), lhs[1].dot(col1), lhs[1].dot(col2), lhs[1].dot(col3) ]
        let row2: Vec4 = [ lhs[2].dot(col0), lhs[2].dot(col1), lhs[2].dot(col2), lhs[2].dot(col3) ]
        let row3: Vec4 = [ lhs[3].dot(col0), lhs[3].dot(col1), lhs[3].dot(col2), lhs[3].dot(col3) ]
        return [row0, row1, row2, row3]
    }

    public static func *=(lhs: inout Mat4, rhs: Mat4) {
        lhs = lhs * rhs
    }

    /// 3D scale matrix
    /// - Parameters:
    ///   - sx: x scale factor
    ///   - sy: y scale factor
    ///   - sz: z scale factor
    /// - Returns: Mat4 scale matrix
    public static func scale(sx: Double, sy: Double, sz: Double) -> Mat4 {
        [
            [sx, 0, 0, 0],
            [0, sy, 0, 0],
            [0, 0, sz, 0],
            [0, 0, 0, 1]
        ]
    }
    
    /// 3D translate matrix
    /// - Parameters:
    ///   - tx: x translate
    ///   - ty: y translate
    ///   - tz: z translate
    /// - Returns: Mat4 translate matrix
    public static func translate(tx: Double, ty: Double, tz: Double) -> Mat4 {
        [
            [1, 0, 0, tx],
            [0, 1, 0, ty],
            [0, 0, 1, tz],
            [0, 0, 0, 1]
        ]
    }
    
    /// 3D rotation about x axis
    /// - Parameter radians: rotation angle in radians
    /// - Returns: Mat4 rotation about x axis
    public static func rotateX(radians: Double) -> Mat4 {
        let c = cos(radians)
        let s = sin(radians)
        return [
            [1, 0, 0, 0],
            [0, c, -s, 0],
            [0, s, c, 0],
            [0, 0, 0, 1]
        ]
    }

    /// 3D rotation about x axis
    /// - Parameter degrees: rotation angle in degrees
    /// - Returns: Mat4 rotation about x axis
    public static func rotateX(degrees: Double) -> Mat4 {
        rotateX(radians: degrees * Double.pi / 180.0)
    }

    /// 3D rotation about x axis
    /// - Parameter radians: rotation angle in radians
    /// - Returns: Mat4 rotation about x axis
    public static func rotateY(radians: Double) -> Mat4 {
        let c = cos(radians)
        let s = sin(radians)
        return [
            [c, 0, s, 0],
            [0, 1, 0, 0],
            [-s, 0, c, 0],
            [0, 0, 0, 1]
        ]
    }

    /// 3D rotation about y axis
    /// - Parameter degrees: rotation angle in degrees
    /// - Returns: Mat4 rotation about y axis
    public static func rotateY(degrees: Double) -> Mat4 {
        rotateY(radians: degrees * Double.pi / 180.0)
    }

    /// 3D rotation about z axis
    /// - Parameter radians: rotation angle in radians
    /// - Returns: Mat4 rotation about z axis
    public static func rotateZ(radians: Double) -> Mat4 {
        let c = cos(radians)
        let s = sin(radians)
        return [
            [c, -s, 0, 0],
            [s, c, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ]
    }

    /// 3D rotation about z axis
    /// - Parameter degrees: rotation angle in degrees
    /// - Returns: Mat4 rotation about z axis
    public static func rotateZ(degrees: Double) -> Mat4 {
        rotateZ(radians: degrees * Double.pi / 180.0)
    }

    public static func lookAt(eye: Vec3, coi: Vec3, up: Vec3 = [0, 1, 0]) -> Mat4 {
        // reverse subtraction to match OpenGL
        let w = (eye - coi).normalized()
        let u = up.cross(w).normalized()
        let v = w.cross(u).normalized()
        let r: Mat4 = [
            [u.x, u.y, u.z, 0],
            [v.x, v.y, v.z, 0],
            [w.x, w.y, w.z, 0],
            [0, 0, 0, 1]
        ]
        return r * translate(tx: -eye.x, ty: -eye.y, tz: -eye.z)
    }
    
    /// OpenGL perspective projection matrix
    /// - Parameters:
    ///   - fieldOfViewY: vertical field of view in degrees
    ///   - aspectRatio: width to height aspect ratio of display window
    ///   - zNear: near Z clipping plane
    ///   - zFar: far Z clipping plane
    /// - Returns: OpenGL perspective matrix for the parameters
    public static func perspectiveProjection(fieldOfViewY: Double, aspectRatio: Double, zNear: Double, zFar: Double) -> Mat4 {
        let top = tan(0.5 * fieldOfViewY * Double.pi / 180.0) * zNear
        let right = top * aspectRatio
        let denom = zFar - zNear
        return [
            [ zNear / right, 0, 0, 0],
            [ 0, zNear / top, 0, 0],
            [0, 0, -(zFar + zNear) / denom, -2.0 * zFar * zNear / denom],
            [0, 0, -1, 0]
        ]
    }
}

extension Mat4: CustomStringConvertible {
    public var description: String {
        """
        [ \(x)
          \(y)
          \(z)
          \(w) ]
        """
    }
}

extension Mat4: ExpressibleByArrayLiteral {
    /// init from an array of 4 Vec4 so can initialize with 4 array of 4 Double
    /// - Parameter elements: 4 Vec4 for rows of Mat4
    public init(arrayLiteral elements: Vec4...) {
        guard elements.count == 4 else { preconditionFailure("Mat4 must have 4 Vec4 elements") }
        self.init(row0: elements[0], row1: elements[1], row2: elements[2], row3: elements[3])
    }
}
