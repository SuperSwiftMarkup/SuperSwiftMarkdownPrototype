//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/16/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

public struct SSStyleEnvironment {
    public let font: SSDocumentStyling.Font?
    public let lineIndent: CGFloat?
    public let extraWrapLineIndent: CGFloat?
    public let emphasis: Bool?
    public let stringEmphasis: Bool?
    public let strikethrough: Bool?
    public let foregroundColor: XColor?
    public let scopes: [ Scope ]
    public static let `default`: SSStyleEnvironment = SSStyleEnvironment.init(
        font: nil,
        lineIndent: nil,
        extraWrapLineIndent: nil,
        emphasis: nil,
        stringEmphasis: nil,
        strikethrough: nil,
        foregroundColor: nil,
        scopes: []
    )
}

extension SSStyleEnvironment {
    public func mapFont(`default`: SSDocumentStyling.Font?, transform: @escaping (SSDocumentStyling.Font) -> SSDocumentStyling.Font) -> Self {
        Self.init(
            font: (font ?? `default`).map(transform),
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withFont(_ font: SSDocumentStyling.Font?) -> Self {
        Self.init(
            font: font ?? self.font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withFont(ifUndefined font: SSDocumentStyling.Font?) -> Self {
        Self.init(
            font: self.font ?? font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withLineIndent(_ lineIndent: CGFloat?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent ?? self.lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withLineIndent(ifUndefined lineIndent: CGFloat?) -> Self {
        Self.init(
            font: font,
            lineIndent: self.lineIndent ?? lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func mapLineIndent(`default`: CGFloat?, transform: @escaping (CGFloat) -> CGFloat) -> Self {
        Self.init(
            font: font,
            lineIndent: (lineIndent ?? `default`).map(transform),
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withExtraWrapLineIndent(_ extraWrapLineIndent: CGFloat?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent ?? self.extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func mapExtraWrapLineIndent(`default`: CGFloat?, transform: @escaping (CGFloat) -> CGFloat) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            extraWrapLineIndent: (self.extraWrapLineIndent ?? `default`).map(transform),
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withEmphasis(_ emphasis: Bool?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis ?? self.emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withStringEmphasis(_ stringEmphasis: Bool?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough ?? self.stringEmphasis,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withStrikethrough(_ strikethrough: Bool?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough ?? self.strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes
        )
    }
    public func withScope(_ scope: Scope) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor,
            scopes: scopes.with(append: scope)
        )
    }
    public func withForegroundColor(_ foregroundColor: XColor?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            extraWrapLineIndent: extraWrapLineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough,
            foregroundColor: foregroundColor ?? self.foregroundColor,
            scopes: scopes
        )
    }
}

extension SSStyleEnvironment {
    public enum Scope: Equatable {
        case block(Block)
        case inline(Inline)
    }
}

extension SSStyleEnvironment.Scope {
    public enum Block: Equatable {
        case blockQuote
        case orderedList
        case unorderedList
        case listItem
        case table
        case heading(SSBlock.HeadingNode.Level)
        case paragraph
        case htmlBlock
        case thematicBreak
        case codeBlock
    }
    public enum Inline: Equatable {
        case emphasis
        case imageLink
        case link
        case strikethrough
        case strong
        case inlineCode
        case inlineHTML
        case lineBreak
        case softBreak
        case symbolLink
        case text
    }
}

extension SSStyleEnvironment.Scope {
    public var isInline: Bool {
        switch self {
        case .inline(_): return true
        case .block(_): return false
        }
    }
    public var isBlock: Bool {
        switch self {
        case .block(_): return true
        case .inline(_): return false
        }
    }
}

extension SSStyleEnvironment {
    public func containsScope(block blockScope: Scope.Block) -> Bool {
        for scope in self.scopes {
            if scope == .block(blockScope) {
                return true
            }
        }
        return false
    }
}

extension SSStyleEnvironment {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        var attributes: NSAttributedString.AttributeMap = [:]
        let paragraphStyle = NSMutableParagraphStyle()
        var setParagraphStyle = false
        if var font = font {
            if let emphasis = emphasis, emphasis == true {
                font = font.withWeight(font.weight.increment)
            }
            if let stringEmphasis = stringEmphasis, stringEmphasis == true {
                font = font.withWeight(font.weight.increment)
            }
            attributes[.font] = font.systemFont
        }
        if let foregroundColor = foregroundColor {
            attributes[.foregroundColor] = foregroundColor
        }
        if let lineIndent = lineIndent {
            paragraphStyle.firstLineHeadIndent = lineIndent
            if let extraWrapLineIndent = extraWrapLineIndent {
                paragraphStyle.headIndent = lineIndent + extraWrapLineIndent
            } else {
                paragraphStyle.headIndent = lineIndent
            }
            setParagraphStyle = true
        } else if let extraWrapLineIndent = extraWrapLineIndent {
            paragraphStyle.headIndent = extraWrapLineIndent
            setParagraphStyle = true
        }
        if setParagraphStyle {
            attributes[.paragraphStyle] = paragraphStyle
        }
        return attributes
    }
    internal var inlineLevelSystemAttributes: NSAttributedString.AttributeMap {
        var attributes: NSAttributedString.AttributeMap = [:]
        if var font = font {
            if let emphasis = emphasis, emphasis == true {
                font = font.withWeight(font.weight.increment)
            }
            if let stringEmphasis = stringEmphasis, stringEmphasis == true {
                font = font.withWeight(font.weight.increment)
            }
            attributes[.font] = font.systemFont
        }
        if let foregroundColor = foregroundColor {
            attributes[.foregroundColor] = foregroundColor
        }
        return attributes
    }
    internal var blockLevelSystemAttributes: NSAttributedString.AttributeMap {
        var attributes: NSAttributedString.AttributeMap = [:]
        let paragraphStyle = NSMutableParagraphStyle()
        var setParagraphStyle = false
        if let lineIndent = lineIndent {
            paragraphStyle.firstLineHeadIndent = lineIndent
            // - -
            if let extraWrapLineIndent = extraWrapLineIndent {
                paragraphStyle.headIndent = lineIndent + extraWrapLineIndent
            } else {
                paragraphStyle.headIndent = lineIndent
            }
            // - -
            setParagraphStyle = true
        } else if let extraWrapLineIndent = extraWrapLineIndent {
            paragraphStyle.headIndent = extraWrapLineIndent
            setParagraphStyle = true
        }
        if setParagraphStyle {
            attributes[.paragraphStyle] = paragraphStyle
        }
        
        return attributes
    }
}

extension SSStyleEnvironment {
    public var disableTrailingBlockNewline: Bool {
        self.containsScope(block: .listItem)
    }
}
