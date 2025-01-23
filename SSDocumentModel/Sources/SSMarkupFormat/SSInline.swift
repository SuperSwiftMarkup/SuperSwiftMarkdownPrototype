//
//  SSInline.swift
//
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation

public enum SSInline {
    case emphasis(EmphasisNode)
    case imageLink(ImageLinkNode)
    case link(LinkNode)
    case strikethrough(StrikethroughNode)
    case strong(StrongNode)
    case inlineCode(InlineCodeNode)
    case inlineHTML(InlineHTMLNode)
    case lineBreak(LineBreakNode)
    case softBreak(SoftBreakNode)
    case symbolLink(SymbolLinkNode)
    case text(TextNode)
}

// MARK: - INLINE CONTAINERS -

extension SSInline {
    public struct EmphasisNode {
        public let children: [ SSInline ]
    }
    public struct ImageLinkNode {
        public let display: [ SSInline ]
        public let source: String?
        public let title: String?
    }
    public struct LinkNode {
        public let display: [ SSInline ]
        public let destination: String?
        public let title: String?
    }
    public struct StrikethroughNode {
        public let children: [ SSInline ]
    }
    public struct StrongNode {
        public let children: [ SSInline ]
    }
}

// MARK: - INLINE LEAVES -

extension SSInline {
    public struct TextNode {
        public let value: String
    }
    public struct InlineCodeNode {
        public let value: String
    }
    public struct InlineHTMLNode {
        public let value: String
    }
    public struct SymbolLinkNode {
        public let destination: String?
    }
    public struct LineBreakNode {}
    public struct SoftBreakNode {}
}

// MARK: - INTERFACE UTILITIES -

public protocol SomeInlineNode {
    var inline: SSInline { get }
}

extension SSInline.EmphasisNode: SomeInlineNode {
    public var inline: SSInline { .emphasis(self) }
}
extension SSInline.ImageLinkNode: SomeInlineNode {
    public var inline: SSInline { .imageLink(self) }
}
extension SSInline.LinkNode: SomeInlineNode {
    public var inline: SSInline { .link(self) }
}
extension SSInline.StrikethroughNode: SomeInlineNode {
    public var inline: SSInline { .strikethrough(self) }
}
extension SSInline.StrongNode: SomeInlineNode {
    public var inline: SSInline { .strong(self) }
}
extension SSInline.InlineCodeNode: SomeInlineNode {
    public var inline: SSInline { .inlineCode(self) }
}
extension SSInline.InlineHTMLNode: SomeInlineNode {
    public var inline: SSInline { .inlineHTML(self) }
}
extension SSInline.LineBreakNode: SomeInlineNode {
    public var inline: SSInline { .lineBreak(self) }
}
extension SSInline.SoftBreakNode: SomeInlineNode {
    public var inline: SSInline { .softBreak(self) }
}
extension SSInline.SymbolLinkNode: SomeInlineNode {
    public var inline: SSInline { .symbolLink(self) }
}
extension SSInline.TextNode: SomeInlineNode {
    public var inline: SSInline { .text(self) }
}
