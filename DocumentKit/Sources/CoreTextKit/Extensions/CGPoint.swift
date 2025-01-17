//
//  CGPoint.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/2/25.
//

import CoreGraphics

extension CGPoint {
    /// Adjusts the `x` coordinate by subtracting a specified offset.
    ///
    /// - Parameter offset: The value to subtract from the `x` coordinate.
    /// - Returns: A new `CGPoint` with the adjusted `x` coordinate.
    @inlinable internal func subtractingX(by offset: CGFloat) -> CGPoint {
        return CGPoint(x: self.x - offset, y: self.y)
    }

    /// Adjusts the `y` coordinate by subtracting a specified offset.
    ///
    /// - Parameter offset: The value to subtract from the `y` coordinate.
    /// - Returns: A new `CGPoint` with the adjusted `y` coordinate.
    @inlinable internal func subtractingY(by offset: CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y - offset)
    }

    /// Translates the point by adding a specified vector to its coordinates.
    ///
    /// - Parameter vector: The vector to add to the point's coordinates.
    /// - Returns: A new `CGPoint` with the translated coordinates.
    @inlinable internal func translating(by vector: CGVector) -> CGPoint {
        return CGPoint(x: self.x + vector.dx, y: self.y + vector.dy)
    }

    /// Calculates the Euclidean distance between the current point and another point.
    ///
    /// - Parameter point: The other point to which the distance is calculated.
    /// - Returns: The distance between the two points.
    @inlinable internal func distance(to point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        return sqrt(dx * dx + dy * dy)
    }

    /// Calculates the midpoint between two points.
    ///
    /// - Parameters:
    ///   - point1: The first point.
    ///   - point2: The second point.
    /// - Returns: The midpoint between the two points.
    @inlinable static internal func midpoint(between point1: CGPoint, and point2: CGPoint) -> CGPoint {
        let midX = (point1.x + point2.x) / 2
        let midY = (point1.y + point2.y) / 2
        return CGPoint(x: midX, y: midY)
    }

    /// Scales the point by multiplying its coordinates by a specified factor.
    ///
    /// - Parameter factor: The factor by which to scale the point's coordinates.
    /// - Returns: A new `CGPoint` with the scaled coordinates.
    @inlinable internal func scaling(by factor: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * factor, y: self.y * factor)
    }

    /// Rotates the point around the origin by a specified angle (in radians).
    ///
    /// - Parameter angle: The angle (in radians) by which to rotate the point.
    /// - Returns: A new `CGPoint` with the rotated coordinates.
    @inlinable internal func rotating(by angle: CGFloat) -> CGPoint {
        let cosAngle = cos(angle)
        let sinAngle = sin(angle)
        let newX = self.x * cosAngle - self.y * sinAngle
        let newY = self.x * sinAngle + self.y * cosAngle
        return CGPoint(x: newX, y: newY)
    }
}
