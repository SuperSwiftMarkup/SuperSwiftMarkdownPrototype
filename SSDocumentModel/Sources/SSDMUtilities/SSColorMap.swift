//
//  SSColorMap.swift
//
//
//  Created by Colbyn Wadman on 1/22/25.
//

import Foundation
import enum SwiftUI.ColorScheme

public struct SSColorMap: Sendable {
    public let light: XColor
    public let dark: XColor
    public init(light: XColor, dark: XColor) {
        self.light = light
        self.dark = dark
    }
    public init(light: () -> XColor, dark: () -> XColor) {
        self.light = light()
        self.dark = dark()
    }
    public init(singleton color: XColor) {
        self.light = color
        self.dark = color
    }
}

extension SSColorMap {
    public func apply(colorScheme: ColorScheme) -> XColor {
        switch colorScheme {
        case .light: return self.light
        case .dark: return self.dark
        default: return self.light
        }
    }
    public func callAsFunction(colorScheme: ColorScheme) -> XColor {
        self.apply(colorScheme: colorScheme)
    }
    public func with(light: XColor) -> Self {
        Self(light: light, dark: dark)
    }
    public func with(dark: XColor) -> Self {
        Self(light: light, dark: dark)
    }
    public func with(alpha: CGFloat) -> SSColorMap {
        SSColorMap(light: light.withAlphaComponent(alpha), dark: dark.withAlphaComponent(alpha))
    }
    public func blend(with other: SSColorMap, amount: CGFloat) -> SSColorMap {
        SSColorMap(
            light: self.light.blended(withFraction: amount, of: other.light) ?? self.light,
            dark: self.dark.blended(withFraction: amount, of: other.dark) ?? self.dark
        )
    }
}

extension SSColorMap {
    public static let textColor: Self = Self(light: XColor.textColor, dark: XColor.textColor)
    public static let red: Self = Self(light: .systemRed, dark: .systemRed)
    public static let green: Self = Self(light: .systemGreen, dark: .systemGreen)
    public static let blue: Self = Self(light: .systemBlue, dark: .systemBlue)
    public static let orange: Self = Self(light: .systemOrange, dark: .systemOrange)
    public static let yellow: Self = Self(light: .systemYellow, dark: .systemYellow)
    public static let brown: Self = Self(light: .systemBrown, dark: .systemBrown)
    public static let pink: Self = Self(light: .systemPink, dark: .systemPink)
    public static let purple: Self = Self(light: .systemPurple, dark: .systemPurple)
    public static let gray: Self = Self(light: .systemGray, dark: .systemGray)
    public static let teal: Self = Self(light: .systemTeal, dark: .systemTeal)
    public static let indigo: Self = Self(light: .systemIndigo, dark: .systemIndigo)
    public static let mint: Self = Self(light: .systemMint, dark: .systemMint)
    public static let cyan: Self = Self(light: .systemCyan, dark: .systemCyan)
    public static let clear: Self = Self(light: XColor.clear, dark: XColor.clear)
    public static let unnoticeable: Self = Self(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01), dark: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01235708773))
    public static let `default`: Self = Self(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    public static var random: Self {
        let colors = [
            red,
            green,
            blue,
            orange,
            yellow,
            brown,
            pink,
            purple,
            gray,
            teal,
            indigo,
            mint,
            cyan,
        ]
        return colors.randomElement()!
    }
}

//extension SSColorMap: View {
//    public var body: some View {
//        ColorMapView(colorMap: self)
//    }
//}

//fileprivate struct ColorMapView: View {
//    let colorMap: SSColorMap
//    @Environment(\.colorScheme) private var colorScheme: ColorScheme
//    var body: some View {
//        colorMap.apply(colorScheme: colorScheme).asSUIColor
//    }
//}

#if os(iOS)
import UIKit
extension SSColorMap {
    public var adaptiveColor: XColor {
        XColor { (traitCollection: UITraitCollection) -> XColor in
            switch traitCollection.userInterfaceStyle {
            case .dark: return self.dark
            default: return self.light
            }
        }
    }
}
#elseif os(macOS)
extension SSColorMap {
    public var adaptiveColor: XColor {
        XColor(name: nil) { (appearance) -> XColor in
            if appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua {
                // Dark mode color
                return self.dark
            } else {
                // Light mode color
                return self.light
            }
        }
    }
}
#endif
