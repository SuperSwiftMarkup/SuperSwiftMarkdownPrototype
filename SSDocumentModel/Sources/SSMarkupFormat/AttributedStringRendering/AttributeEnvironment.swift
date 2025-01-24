//
//  AttributeEnvironment.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation
import SSDMUtilities

internal final class AttributeEnvironment {
    fileprivate let styleEnvironment: StyleEnvironment
    fileprivate let typesetEnvironment: TypesetEnvironment
    internal    let blockScopes: [ SSBlockType ]
    fileprivate init(
        styleEnvironment: StyleEnvironment,
        typesetEnvironment: TypesetEnvironment,
        blockScopes: [ SSBlockType ]
    ) {
        self.styleEnvironment = styleEnvironment
        self.typesetEnvironment = typesetEnvironment
        self.blockScopes = blockScopes
    }
    internal static let `default`: AttributeEnvironment = AttributeEnvironment.init(
        styleEnvironment: .init(),
        typesetEnvironment: .init(),
        blockScopes: []
    )
    enum EnvironmentType {
        case styling
        case typesetting
    }
}

extension AttributeEnvironment {
    internal struct StyleEnvironment {
        private var fontSize: CGFloat = 16.0
        private var fontWeight: SSStyle.FontWeight = SSStyle.FontWeight.regular
        private var fontDesign: SSStyle.FontDesign = SSStyle.FontDesign.default
        private var fontWidth: SSStyle.FontWidth? = nil
        private var boldTextStyle: Bool? = nil
        private var italicTextStyle: Bool? = nil
        private var foregroundColor: SSColorMap? = nil
        private var backgroundColor: SSColorMap? = nil
        private var strikethroughMode: Bool? = nil
    }
}

extension AttributeEnvironment {
    internal struct TypesetEnvironment {
        private var baseIndentationLevels: [UnitRatio] = []
        private var trailingIndentationLevels: [UnitRatio] = []
    }
}

// MARK: - PUBLIC API -

extension AttributeEnvironment.StyleEnvironment {
    internal func with(fontSize: CGFloat?) -> Self {
        var copy = self
        copy.fontSize = fontSize ?? self.fontSize
        return copy
    }
    internal func mapFontSize(apply: @escaping (CGFloat) -> CGFloat) -> Self {
        var copy = self
        copy.fontSize = apply(self.fontSize)
        return copy
    }
    internal func with(fontWeight: SSStyle.FontWeight?) -> Self {
        var copy = self
        copy.fontWeight = fontWeight ?? self.fontWeight
        return copy
    }
    internal func with(fontDesign: SSStyle.FontDesign?) -> Self {
        var copy = self
        copy.fontDesign = fontDesign ?? self.fontDesign
        return copy
    }
    internal func with(fontWidth: SSStyle.FontWidth?) -> Self {
        var copy = self
        copy.fontWidth = fontWidth ?? self.fontWidth
        return copy
    }
    internal func with(boldTextStyle: Bool?) -> Self {
        var copy = self
        copy.boldTextStyle = boldTextStyle ?? self.boldTextStyle
        return copy
    }
    internal func with(italicTextStyle: Bool?) -> Self {
        var copy = self
        copy.italicTextStyle = italicTextStyle ?? self.italicTextStyle
        return copy
    }
    internal func with(foregroundColor: SSColorMap?) -> Self {
        var copy = self
        copy.foregroundColor = foregroundColor ?? self.foregroundColor
        return copy
    }
    internal func with(backgroundColor: SSColorMap?, updateType: UpdateType = .preferThis) -> Self {
        var copy = self
        switch updateType {
        case .preferExisting:
            copy.backgroundColor = self.backgroundColor ?? backgroundColor
        case .preferThis:
            copy.backgroundColor = backgroundColor ?? self.backgroundColor
        case .forceOverride:
            copy.backgroundColor = backgroundColor
        }
        return copy
    }
    internal func with(strikethroughMode: Bool?) -> Self {
        var copy = self
        copy.strikethroughMode = strikethroughMode ?? self.strikethroughMode
        return copy
    }
    internal enum UpdateType {
        case preferExisting
        case preferThis
        case forceOverride
    }
}

extension AttributeEnvironment.TypesetEnvironment {
    internal func extend(baseIndentationLevel: UnitRatio) -> Self {
        var copy = self
        copy.baseIndentationLevels.append(baseIndentationLevel)
        return copy
    }
    internal func extend(trailingIndentationLevel: UnitRatio) -> Self {
        var copy = self
        copy.trailingIndentationLevels.append(trailingIndentationLevel)
        return copy
    }
    internal func clearTrailingIndentationLevel() -> Self {
        var copy = self
        copy.trailingIndentationLevels.removeAll(keepingCapacity: true)
        return copy
    }
    internal func modifyLineIndentSettings(apply: @escaping (LineIndentSetting) -> LineIndentSetting) -> Self {
        var copy = self
        let currentLineIndentSetting = LineIndentSetting(
            baseIndentationLevels: baseIndentationLevels,
            trailingIndentationLevels: trailingIndentationLevels
        )
        let newLineIndentSetting = apply(currentLineIndentSetting)
        copy.baseIndentationLevels = newLineIndentSetting.baseIndentationLevels
        copy.trailingIndentationLevels  = newLineIndentSetting.trailingIndentationLevels
        return copy
    }
    internal struct LineIndentSetting {
        internal let baseIndentationLevels: [UnitRatio]
        internal let trailingIndentationLevels: [UnitRatio]
        public init(baseIndentationLevels: [UnitRatio], trailingIndentationLevels: [UnitRatio]) {
            self.baseIndentationLevels = baseIndentationLevels
            self.trailingIndentationLevels = trailingIndentationLevels
        }
    }
}

extension AttributeEnvironment {
    internal func updateStyling(_ function: @escaping (StyleEnvironment) -> StyleEnvironment) -> AttributeEnvironment {
        .init(styleEnvironment: function(styleEnvironment), typesetEnvironment: typesetEnvironment, blockScopes: blockScopes)
    }
    internal func updateTypesetting(_ function: @escaping (TypesetEnvironment) -> TypesetEnvironment) -> AttributeEnvironment {
        .init(styleEnvironment: styleEnvironment, typesetEnvironment: function(typesetEnvironment), blockScopes: blockScopes)
    }
    internal func updateStyling(ifTrue flag: Bool, apply: @escaping (StyleEnvironment) -> StyleEnvironment) -> AttributeEnvironment {
        if flag {
            return .init(styleEnvironment: apply(styleEnvironment), typesetEnvironment: typesetEnvironment, blockScopes: blockScopes)
        } else {
            return self
        }
    }
    internal func updateTypesetting(ifTrue flag: Bool, apply: @escaping (TypesetEnvironment) -> TypesetEnvironment) -> AttributeEnvironment {
        if flag {
            return .init(styleEnvironment: styleEnvironment, typesetEnvironment: apply(typesetEnvironment), blockScopes: blockScopes)
        } else {
            return self
        }
    }
//    internal func setCurrentTypesettingEnvironment(context: inout AttributedStringContext) {
//        context.setCurrentTypesettingEnvironment(self.typesetEnvironment)
//    }
}

// MARK: - TO SYSTEM ATTRIBUTE DICTIONARY -

extension AttributeEnvironment.StyleEnvironment {
    internal var systemAttributeDictionary: NSAttributedString.AttributeDictionary {
        var attributes = NSAttributedString.AttributeDictionary(minimumCapacity: 10)
        attributes[.font] = systemFont
        if let foregroundColor = foregroundColor {
            let color: XColor = foregroundColor.adaptiveColor
            attributes[.foregroundColor] = color
        } else {
            attributes[.foregroundColor] = ThemeDefaults.Colors.Block.htmlBlock.adaptiveColor
        }
        if let backgroundColor = backgroundColor {
            let color: XColor = backgroundColor.adaptiveColor
            attributes[.backgroundColor] = color
        }
        if let strikethroughMode = strikethroughMode, strikethroughMode == true {
            attributes[.strikethroughColor] = XColor.textColor
            attributes[.strikethroughStyle] = XUnderlineStyle.single.rawValue
        }
        return attributes
    }
    fileprivate var systemFont: XFont {
        var baseFont: XFont
        var fontDescriptor: XFontDescriptor
        switch self.fontDesign {
        case .default:
            baseFont = self.fontWidth.map {
                XFont.systemFont(
                    ofSize: fontSize,
                    weight: fontWeight.systemFontWeight,
                    width: $0.systemFontWidth
                )
            } ?? XFont.systemFont(ofSize: fontSize, weight: fontWeight.systemFontWeight)
            // SET
            fontDescriptor = baseFont.fontDescriptor
            fontDescriptor = fontDescriptor.withDesign(.default) ?? fontDescriptor
            // UPDATE BASE FONT & DESCRIPTOR
            baseFont = XFont(descriptor: fontDescriptor, size: fontSize) ?? baseFont
            fontDescriptor = baseFont.fontDescriptor
        case .monospaced:
            baseFont = XFont.monospacedSystemFont(ofSize: fontSize, weight: fontWeight.systemFontWeight)
            // SET
            fontDescriptor = baseFont.fontDescriptor
            fontDescriptor = fontDescriptor.withDesign(.monospaced) ?? fontDescriptor
            // UPDATE BASE FONT & DESCRIPTOR
            baseFont = XFont(descriptor: fontDescriptor, size: fontSize) ?? baseFont
            fontDescriptor = baseFont.fontDescriptor
        case .rounded:
            baseFont = self.fontWidth.map {
                XFont.systemFont(
                    ofSize: fontSize,
                    weight: fontWeight.systemFontWeight,
                    width: $0.systemFontWidth
                )
            } ?? XFont.systemFont(ofSize: fontSize, weight: fontWeight.systemFontWeight)
            // SET
            fontDescriptor = baseFont.fontDescriptor
            fontDescriptor = fontDescriptor.withDesign(.rounded) ?? fontDescriptor
            // UPDATE BASE FONT & DESCRIPTOR
            baseFont = XFont(descriptor: fontDescriptor, size: fontSize) ?? baseFont
            fontDescriptor = baseFont.fontDescriptor
        case .serif:
            baseFont = self.fontWidth.map {
                XFont.systemFont(
                    ofSize: fontSize,
                    weight: fontWeight.systemFontWeight,
                    width: $0.systemFontWidth
                )
            } ?? XFont.systemFont(ofSize: fontSize, weight: fontWeight.systemFontWeight)
            // SET
            fontDescriptor = baseFont.fontDescriptor
            fontDescriptor = fontDescriptor.withDesign(.serif) ?? fontDescriptor
            // UPDATE BASE FONT & DESCRIPTOR
            baseFont = XFont(descriptor: fontDescriptor, size: fontSize) ?? baseFont
            fontDescriptor = baseFont.fontDescriptor
        }
        if self.boldTextStyle == true {
            fontDescriptor = fontDescriptor.withSymbolicTraits(.bold)
            // UPDATE BASE FONT & DESCRIPTOR
            baseFont = XFont(descriptor: fontDescriptor, size: fontSize) ?? baseFont
            fontDescriptor = baseFont.fontDescriptor
        }
        if self.italicTextStyle == true {
            fontDescriptor = fontDescriptor.withSymbolicTraits(.italic)
            // UPDATE BASE FONT & DESCRIPTOR
            baseFont = XFont(descriptor: fontDescriptor, size: fontSize) ?? baseFont
            fontDescriptor = baseFont.fontDescriptor
        }
        return XFont(descriptor: fontDescriptor, size: fontSize) ?? baseFont
    }
}

extension AttributeEnvironment.TypesetEnvironment {
    internal var systemAttributeDictionary: NSAttributedString.AttributeDictionary {
        var attributes = NSAttributedString.AttributeDictionary(minimumCapacity: 5)
        let paragraphStyle = XMutableParagraphStyle()
        let indentationMultiple = CGFloat(40)
        var baseIndentation = 0.0
        var trailingIndentation = 0.0
        for unit in baseIndentationLevels {
            baseIndentation += unit.asDecimal * indentationMultiple
        }
        for unit in trailingIndentationLevels {
            trailingIndentation += unit.asDecimal * indentationMultiple
        }
//        paragraphStyle.lineHeightMultiple = 1
//        paragraphStyle.minimumLineHeight = 5
//        paragraphStyle.lineSpacing = 8
        paragraphStyle.paragraphSpacingBefore = 4
        paragraphStyle.paragraphSpacing = 4
        paragraphStyle.firstLineHeadIndent = baseIndentation
        paragraphStyle.headIndent = baseIndentation + trailingIndentation
        attributes[.paragraphStyle] = paragraphStyle
        return attributes
    }
}

extension AttributeEnvironment {
    internal func systemAttributeDictionary(forEnvironment environmentType: EnvironmentType) -> NSAttributedString.AttributeDictionary {
        switch environmentType {
        case .styling: return self.styleEnvironment.systemAttributeDictionary
        case .typesetting: return self.typesetEnvironment.systemAttributeDictionary
        }
    }
    internal func with(blockScope: SSBlockType) -> AttributeEnvironment {
        AttributeEnvironment(
            styleEnvironment: styleEnvironment,
            typesetEnvironment: typesetEnvironment,
            blockScopes: blockScopes.with(append: blockScope)
        )
    }
    internal func containsScope(blockType type: SSBlockType) -> Bool {
        for blockScope in self.blockScopes {
            if blockScope == type {
                return true
            }
        }
        return false
    }
}
