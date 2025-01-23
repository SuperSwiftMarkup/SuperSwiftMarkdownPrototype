//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/19/25.
//

import Foundation



public enum SSStyle {
    case fontSize(CGFloat)
    case fontWeight(Weight)
    case fontDesign(Design)
    case emphasis(Emphasis)
    case foregroundColor(XColor)
    case backgroundColor(XColor)
}

//extension SSStyle {
//    public enum Property<Value> {
//        case override(Value)
//        case `default`(Value)
//        case strong
//    }
//}

extension SSStyle {
    public enum Weight {
        case black
        case heavy
        case bold
        case semibold
        case medium
        case regular
        case light
        case thin
        case ultraLight
        internal static let maximum: Weight = .black
        internal static let minimum: Weight = .ultraLight
        internal var increment: Weight {
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
        internal var decrement: Weight {
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
}

extension SSStyle {
    public enum Design {
        case `default`
        case monospaced
        case rounded
        case serif
    }
}

extension SSStyle {
    public enum Emphasis {
        case bold, italic, strong
    }
}
