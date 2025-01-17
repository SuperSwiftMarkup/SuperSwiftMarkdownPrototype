//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/16/25.
//

import Foundation

public struct SSStyleEnvironment {
    public let font: SSDocumentStyling.Font?
    public let lineIndent: CGFloat?
    public let emphasis: Bool?
    public let stringEmphasis: Bool?
    public let strikethrough: Bool?
    public static let `default`: SSStyleEnvironment = SSStyleEnvironment.init(
        font: nil,
        lineIndent: nil,
        emphasis: nil,
        stringEmphasis: nil,
        strikethrough: nil
    )
}

extension SSStyleEnvironment {
    public func withFont(_ font: SSDocumentStyling.Font?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough
        )
    }
    public func withLineIndent(_ lineIndent: CGFloat?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough
        )
    }
    public func withEmphasis(_ emphasis: Bool?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough
        )
    }
    public func withStrikethrough(_ strikethrough: Bool?) -> Self {
        Self.init(
            font: font,
            lineIndent: lineIndent,
            emphasis: emphasis,
            stringEmphasis: stringEmphasis,
            strikethrough: strikethrough
        )
    }
}

extension SSStyleEnvironment {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        fatalError("TODO")
    }
}

extension SSStyleEnvironment {
    public enum Scope {
        case block(Block)
        case inline(Inline)
    }
}

extension SSStyleEnvironment.Scope {
    public enum Block: Equatable {
        case blockQuote
        case orderedList
        case unorderedList
        case table
        case heading
        case paragraph
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
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
