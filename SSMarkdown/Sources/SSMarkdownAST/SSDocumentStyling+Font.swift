//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

extension SSDocumentStyling {
    public struct Font {
        let size: CGFloat
        let weight: Weight
        let design: Design
        public init(size: CGFloat, weight: Weight, design: Design) {
            self.size = size
            self.weight = weight
            self.design = design
        }
    }
}

extension SSDocumentStyling.Font {
    public func withSize(_ size: CGFloat) -> Self {
        Self.init(size: size, weight: weight, design: design)
    }
    public func withWeight(_ weight: Weight) -> Self {
        Self.init(size: size, weight: weight, design: design)
    }
    public func withDesign(_ design: Design) -> Self {
        Self.init(size: size, weight: weight, design: design)
    }
    public func mapSize(_ apply: @escaping (CGFloat) -> CGFloat) -> Self {
        Self.init(size: apply(size), weight: weight, design: design)
    }
    public enum Design {
        case `default`
        case monospaced
        case rounded
        case serif
    }
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

extension SSDocumentStyling.Font {
    internal var systemFont: XFont {
        switch self.design {
        case .default: return XFont.systemFont(ofSize: size, weight: self.weight.systemWeight)
        case .monospaced: return XFont.monospacedSystemFont(ofSize: size, weight: self.weight.systemWeight)
        case .rounded: return XFont.systemFont(ofSize: size, weight: self.weight.systemWeight)
        case .serif: return XFont.systemFont(ofSize: size, weight: self.weight.systemWeight)
        }
    }
}
extension SSDocumentStyling.Font.Weight {
    internal var systemWeight: XFont.Weight {
        switch self {
        case .black: return XFont.Weight.black
        case .bold: return XFont.Weight.bold
        case .heavy: return XFont.Weight.heavy
        case .light: return XFont.Weight.light
        case .medium: return XFont.Weight.medium
        case .regular: return XFont.Weight.regular
        case .semibold: return XFont.Weight.semibold
        case .thin: return XFont.Weight.thin
        case .ultraLight: return XFont.Weight.ultraLight
        }
    }
}

extension SSDocumentStyling.Font {
    public struct FontPropertyOptions: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public typealias RawValue = Int
        public static let size = FontPropertyOptions(rawValue: 1 << 1)
        public static let weight = FontPropertyOptions(rawValue: 1 << 2)
        public static let design = FontPropertyOptions(rawValue: 1 << 3)
        internal static let keepLargerSize = FontPropertyOptions(rawValue: 1 << 4)
    }
    public func merge(with other: Self?, keeping: FontPropertyOptions) -> SSDocumentStyling.Font {
        var size = keeping.contains(.size) ? self.size : ( other?.size ?? self.size)
        if keeping.contains(.keepLargerSize) {
            if let other = other, other.size > self.size {
                size = other.size
            }
            else if self.size > size {
                size = self.size
            }
        }
        let weight = keeping.contains(.weight) ? self.weight : ( other?.weight ?? self.weight)
        let design = keeping.contains(.design) ? self.design : ( other?.design ?? self.design)
        return SSDocumentStyling.Font(size: size, weight: weight, design: design)
    }
    public func merge(with other: Self?, ignoring: FontPropertyOptions) -> SSDocumentStyling.Font {
        var size = ignoring.contains(.size) ? ( other?.size ?? self.size) : self.size
        if ignoring.contains(.keepLargerSize) {
            if let other = other, other.size > self.size {
                size = other.size
            }
            else if self.size > size {
                size = self.size
            }
        }
        let weight = ignoring.contains(.weight) ? ( other?.weight ?? self.weight) : self.weight
        let design = ignoring.contains(.design) ? ( other?.design ?? self.design) : self.design
        return SSDocumentStyling.Font(size: size, weight: weight, design: design)
    }
}
