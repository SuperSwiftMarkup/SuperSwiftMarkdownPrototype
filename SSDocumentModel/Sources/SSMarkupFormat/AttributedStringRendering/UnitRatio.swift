//
//  UnitRatio.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation

internal struct UnitRatio {
    private let numerator: UInt
    private let denominator: UInt
    internal init(numerator: UInt, denominator: UInt) {
        self.numerator = numerator
        self.denominator = denominator
    }
    internal var asDecimal: Double { Double(numerator) / Double(denominator) }
}

extension UnitRatio {
    public static let double: UnitRatio = .init(numerator: 2, denominator: 1)
    public static let whole: UnitRatio = .init(numerator: 1, denominator: 1)
    public static let half: UnitRatio = .init(numerator: 1, denominator: 2)
    public static let quarter: UnitRatio = .init(numerator: 1, denominator: 4)
    public static let eighth: UnitRatio = .init(numerator: 1, denominator: 8)
}
