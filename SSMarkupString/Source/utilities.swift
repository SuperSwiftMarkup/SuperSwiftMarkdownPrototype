//
//  utilities.swift
//
//
//  Created by Colbyn Wadman on 1/20/25.
//

import Foundation

public struct SSRatio {
    private let numerator: UInt
    private let denominator: UInt
    internal init(numerator: UInt, denominator: UInt) {
        self.numerator = numerator
        self.denominator = denominator
    }
    public static let whole: SSRatio = .init(numerator: 1, denominator: 1)
    public static let half: SSRatio = .init(numerator: 1, denominator: 2)
    internal var asDecimal: Double { Double(numerator) / Double(denominator) }
}

