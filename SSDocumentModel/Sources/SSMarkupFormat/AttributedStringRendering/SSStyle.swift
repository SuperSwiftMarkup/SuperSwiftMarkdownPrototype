//
//  SSStyle.swift
//
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation
import SSDMUtilities

public struct SSStyle {}

//extension SSStyle {
//    public enum Property<Value> {
//        case override(Value)
//        case `default`(Value)
//        case strong
//    }
//}

extension SSStyle {
    public enum FontWeight {
        case black
        case heavy
        case bold
        case semibold
        case medium
        case regular
        case light
        case thin
        case ultraLight
    }
}

extension SSStyle.FontWeight {
    internal static let maximum: SSStyle.FontWeight = .black
    internal static let minimum: SSStyle.FontWeight = .ultraLight
    internal var increment: SSStyle.FontWeight {
        switch self {
        case .black: return .black
        case .heavy: return .black
        case .bold: return .heavy
        case .semibold: return .bold
        case .medium: return .semibold
        case .regular: return .medium
        case .light: return .regular
        case .thin: return .light
        case .ultraLight: return .thin
        }
    }
    internal var decrement: SSStyle.FontWeight {
        switch self {
        case .black: return .heavy
        case .heavy: return .bold
        case .bold: return .semibold
        case .semibold: return .medium
        case .medium: return .regular
        case .regular: return .light
        case .light: return .thin
        case .thin: return .ultraLight
        case .ultraLight: return .ultraLight
        }
    }
}

extension SSStyle {
    public enum FontDesign {
        case `default`
        case monospaced
        case rounded
        case serif
    }
}

//extension SSStyle {
//    public struct Font {
//        let fontSize: CGFloat
//        let fontWeight: Weight
//        let fontDesign: Design
//        let boldTextStyle: Bool
//        let italicTextStyle: Bool
//    }
//}

extension SSStyle.FontWeight {
    internal var systemFontWeight: XFont.Weight {
        switch self {
        case .black: return XFont.Weight.black
        case .heavy: return XFont.Weight.heavy
        case .bold: return XFont.Weight.bold
        case .semibold: return XFont.Weight.semibold
        case .medium: return XFont.Weight.medium
        case .regular: return XFont.Weight.regular
        case .light: return XFont.Weight.light
        case .thin: return XFont.Weight.thin
        case .ultraLight: return XFont.Weight.ultraLight
        }
    }
}

extension SSStyle {
    public enum FontWidth {
        case compressed
        case condensed
        case expanded
        case standard
    }
}

extension SSStyle.FontWidth {
    internal var systemFontWidth: XFont.Width {
        switch self {
        case .compressed: XFont.Width.compressed
        case .condensed: XFont.Width.condensed
        case .expanded: XFont.Width.expanded
        case .standard: XFont.Width.standard
        }
    }
}
