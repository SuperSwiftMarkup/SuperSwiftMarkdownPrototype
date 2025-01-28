//
//  UnitRatio.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//
// LICENSE file: https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md
//
// The code herein is distributed under a dual licensing model. Users may choose to use such under either:
//
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions of either the AGPLv3 or the commercial license, depending on the license you select.

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
