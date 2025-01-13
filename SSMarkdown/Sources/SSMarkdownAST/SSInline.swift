//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation

public enum SSInline: SomeInlineNode {
    case container(Container)
    case leaf(Leaf)
    public var inline: SSInline { self }
}

// MARK: - INLINE CONTAINERS -
extension SSInline {
    public enum Container: SomeInlineContainerNode {
        case emphasis(EmphasisNode)
        case imageLink(ImageLinkNode)
        case link(LinkNode)
        case strikethrough(StrikethroughNode)
        case strong(StrongNode)
        public var inlineContainer: SSInline.Container { self }
    }
    public struct EmphasisNode: SomeInlineContainerNode {
        public let children: [ SSInline ]
        public var inlineContainer: Container { .emphasis(self) }
    }
    public struct ImageLinkNode: SomeInlineContainerNode {
        public let display: [ SSInline ]
        public let source: String?
        public let title: String?
        public var inlineContainer: Container { .imageLink(self) }
    }
    public struct LinkNode: SomeInlineContainerNode {
        public let display: [ SSInline ]
        public let destination: String?
        public let title: String?
        public var inlineContainer: Container { .link(self) }
    }
    public struct StrikethroughNode: SomeInlineContainerNode {
        public let children: [ SSInline ]
        public var inlineContainer: Container { .strikethrough(self) }
    }
    public struct StrongNode: SomeInlineContainerNode {
        public let children: [ SSInline ]
        public var inlineContainer: Container { .strong(self) }
    }
}

// MARK: - INLINE LEAVES -
extension SSInline {
    public enum Leaf: SomeInlineLeafNode {
        case inlineCode(InlineCodeNode)
        case inlineHTML(InlineHTMLNode)
        case lineBreak(LineBreakNode)
        case softBreak(SoftBreakNode)
        case symbolLink(SymbolLinkNode)
        case text(TextNode)
        public var inlineLeaf: SSInline.Leaf { self }
    }
    public struct InlineCodeNode: SomeInlineLeafNode {
        public let value: String
        public var inlineLeaf: SSInline.Leaf { .inlineCode(self) }
    }
    public struct InlineHTMLNode: SomeInlineLeafNode {
        public let value: String
        public var inlineLeaf: SSInline.Leaf { .inlineHTML(self) }
    }
    public struct LineBreakNode: SomeInlineLeafNode {
        public var inlineLeaf: SSInline.Leaf { .lineBreak(self) }
    }
    public struct SoftBreakNode: SomeInlineLeafNode {
        public var inlineLeaf: SSInline.Leaf { .softBreak(self) }
    }
    public struct SymbolLinkNode: SomeInlineLeafNode {
        public let destination: String?
        public var inlineLeaf: SSInline.Leaf { .symbolLink(self) }
    }
    public struct TextNode: SomeInlineLeafNode {
        public let string: String
        public var inlineLeaf: SSInline.Leaf { .text(self) }
    }
}

// MARK: - INTERFACE ABSTRACTIONS -

public protocol SomeInlineNode {
    var inline: SSInline { get }
}
public protocol SomeInlineContainerNode: SomeInlineNode {
    var inlineContainer: SSInline.Container { get }
}
public protocol SomeInlineLeafNode: SomeInlineNode {
    var inlineLeaf: SSInline.Leaf { get }
}

extension SomeInlineContainerNode {
    public var inline: SSInline { SSInline.container(inlineContainer) }
}

extension SomeInlineLeafNode {
    public var inline: SSInline { SSInline.leaf(inlineLeaf) }
}
