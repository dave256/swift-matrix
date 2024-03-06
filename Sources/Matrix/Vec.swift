//
//  Vec.swift
//
//
//  Created by David Reed on 2/19/24.
//

import Foundation

/// Vec3 for x, y, z points and 3D vector
public struct Vec3: Equatable{
    public var x: Double
    public var y: Double
    public var z: Double

    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// [0] is x, [1]. is y, [2] is z
    public subscript(index: Int) -> Double{
        get {
            switch(index) {
            case 0: return x
            case 1: return y
            case 2: return z
            default: preconditionFailure("Vec3 index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: preconditionFailure("Vec3 index out of range")
            }
        }
    }

    public static func +(lhs: Vec3, rhs: Vec3) -> Vec3 {
        [lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z]
    }

    public static func +=(lhs: inout Vec3, rhs: Vec3) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Vec3, rhs: Vec3) -> Vec3 {
        [lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z]
    }

    public static func -=(lhs: inout Vec3, rhs: Vec3) {
        lhs = lhs - rhs
    }

    /// dot product of self and rhs
    /// - Parameter rhs: second vector
    /// - Returns: dot product of self and rhs
    public func dot(_ rhs: Vec3) -> Double {
        self.x * rhs.x + self.y * rhs.y + self.z * rhs.z
    }
    
    /// cross product of self and rhs
    /// - Parameter rhs: right operator for cross product
    /// - Returns: cross product of self and rhs
    public func cross(_ rhs: Vec3) -> Vec3 {
        let x = self.y * rhs.z - self.z * rhs.y
        let y = self.z * rhs.x - self.x * rhs.z
        let z = self.x * rhs.y - self.y * rhs.x
        return [x, y, z]
    }
    
    /// same direction, but length 1
    public mutating func normalize() {
        let length = sqrt(self.dot(self))
        self = [x / length, y / length, z / length]
    }
    
    /// return new Vec3 with same direction but length 1
    /// - Returns:  new Vec3 with same direction but length 1
    public func normalized() -> Vec3 {
        let length = sqrt(self.dot(self))
        return [x / length, y / length, z / length]
    }
}

extension Vec3: CustomStringConvertible {
    public var description: String {
        let sx = x.formatted(.number.precision(.fractionLength(3)))
        let sy = y.formatted(.number.precision(.fractionLength(3)))
        let sz = z.formatted(.number.precision(.fractionLength(3)))
        return "[\(sx), \(sy), \(sz)]"
    }
}

extension Vec3: ExpressibleByArrayLiteral {
    /// init from an array of 3 Double
    /// - Parameter elements: array of 3 Double with x, y, and z
    public init(arrayLiteral elements: Double...) {
        guard elements.count == 3 else { preconditionFailure("Vec3 must have 3 elements") }
        self.init(x: elements[0], y: elements[1], z: elements[2])
    }
}

public struct Vec4: Equatable {
    public var x: Double
    public var y: Double
    public var z: Double
    public var w: Double

    public init(x: Double, y: Double, z: Double, w: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    /// [0] is x, [1]. is y, [2] is z, [3] is w
    public subscript(index: Int) -> Double{
        get {
            switch(index) {
            case 0: return x
            case 1: return y
            case 2: return z
            case 3: return w
            default: preconditionFailure("Vec4 index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            case 3: w = newValue
            default: preconditionFailure("Vec4 index out of range")
            }
        }
    }

    public var vec3: Vec3 {
        [x / w, y / w, z / w]
    }

    public static func +(lhs: Vec4, rhs: Vec4) -> Vec4 {
        [lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w]
    }

    public static func +=(lhs: inout Vec4, rhs: Vec4) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Vec4, rhs: Vec4) -> Vec4 {
        [lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w]
    }

    public static func -=(lhs: inout Vec4, rhs: Vec4) {
        lhs = lhs - rhs
    }

    /// dot product of self and rhs
    /// - Parameter rhs: second vector
    /// - Returns: dot product of self and rhs
    public func dot(_ rhs: Vec4) -> Double {
        self.x * rhs.x + self.y * rhs.y + self.z * rhs.z + self.w * rhs.w
    }

    /// same direction, but length 1
    public mutating func normalize() {
        let length = sqrt(self.dot(self))
        self = [x / length, y / length, z / length, z / length]
    }

    /// return new Vec4 with same direction but length 1
    /// - Returns:  new Vec4 with same direction but length 1
    public func normalized() -> Vec4 {
        let length = sqrt(self.dot(self))
        return [x / length, y / length, z / length, w / length]
    }
}

/// Vec4 for x, y, z, w points and 4D vector
extension Vec4: CustomStringConvertible {
    public var description: String {
        let sx = x.formatted(.number.precision(.fractionLength(3)))
        let sy = y.formatted(.number.precision(.fractionLength(3)))
        let sz = z.formatted(.number.precision(.fractionLength(3)))
        let sw = w.formatted(.number.precision(.fractionLength(3)))
        return "[\(sx), \(sy), \(sz), \(sw)]"
    }
}

extension Vec4: ExpressibleByArrayLiteral {
    /// init from an array of 4 Double
    /// - Parameter elements: array of 4 Double with x, y,  z, and w
    public init(arrayLiteral elements: Double...) {
        guard elements.count == 4 else { preconditionFailure("Vec4 must have 4 elements") }
        self.init(x: elements[0], y: elements[1], z: elements[2], w: elements[3])
    }
}
