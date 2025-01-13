//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation

public enum SSBlock: SomeBlockNode {
    case blockContainer(BlockContainerBlock)
    case inlineContainer(InlineContainerBlock)
    case leaf(LeafBlock)
    public var block: SSBlock { self }
}

// MARK: - Block Container Blocks -
extension SSBlock {
    public enum BlockContainerBlock: SomeBlockContainerBlockNode {
        case blockQuote(BlockQuoteNode)
        case orderedList(OrderedListNode)
        case unorderedList(UnorderedListNode)
        case table(TableNode)
        public var blockContainerBlock: SSBlock.BlockContainerBlock { self }
    }
    public struct BlockQuoteNode: SomeBlockContainerBlockNode {
        public let children: [ SSBlock ]
        public var blockContainerBlock: SSBlock.BlockContainerBlock { .blockQuote(self) }
    }
    public struct OrderedListNode: SomeBlockContainerBlockNode {
        public let items: [ ListItemNode ]
        public var blockContainerBlock: SSBlock.BlockContainerBlock { .orderedList(self) }
    }
    public struct UnorderedListNode: SomeBlockContainerBlockNode {
        public let items: [ ListItemNode ]
        public var blockContainerBlock: SSBlock.BlockContainerBlock { .unorderedList(self) }
    }
    public struct TableNode: SomeBlockContainerBlockNode {
        public let head: Head
        public let alignments: [ ColumnAlignment? ]
        public let body: Body
        public var blockContainerBlock: SSBlock.BlockContainerBlock { .table(self) }
    }
}

// MARK: COMMON
extension SSBlock {
    public struct ListItemNode {
        public let checkbox: Checkbox?
        public let children: [ SSBlock ]
        public enum Checkbox: Equatable {
            case checked, unchecked
        }
    }
}

// MARK: - Inline Container Blocks -
extension SSBlock {
    public enum InlineContainerBlock: SomeInlineContainerBlockNode {
        case heading(HeadingNode)
        case paragraph(ParagraphNode)
        public var inlineContainerBlock: SSBlock.InlineContainerBlock { self }
    }
    public struct ParagraphNode: SomeInlineContainerBlockNode {
        let children: [ SSInline ]
        public var inlineContainerBlock: SSBlock.InlineContainerBlock { .paragraph(self) }
    }
    public struct HeadingNode: SomeInlineContainerBlockNode {
        let level: Level
        let children: [ SSInline ]
        public var inlineContainerBlock: SSBlock.InlineContainerBlock { .heading(self) }
    }
}

// MARK: COMMON
extension SSBlock.HeadingNode {
    public enum Level: Equatable {
        case h1, h2, h3, h4, h5, h6
    }
}

// MARK: - Leaf Blocks -
extension SSBlock {
    public enum LeafBlock: SomeLeafBlockNode {
        case htmlBlock(HTMLBlockNode)
        case thematicBreak(ThematicBreakNode)
        case codeBlock(CodeBlockNode)
        public var leafBlock: SSBlock.LeafBlock { self }
    }
    public struct HTMLBlockNode: SomeLeafBlockNode {
        public let rawHTML: String
        public var leafBlock: SSBlock.LeafBlock { .htmlBlock(self) }
    }
    public struct ThematicBreakNode: SomeLeafBlockNode {
        public var leafBlock: SSBlock.LeafBlock { .thematicBreak(self) }
    }
    public struct CodeBlockNode: SomeLeafBlockNode {
        public let code: String
        public var leafBlock: SSBlock.LeafBlock { .codeBlock(self) }
    }
}

// MARK: - INTERFACE ABSTRACTIONS -

public protocol SomeBlockNode {
    var block: SSBlock { get }
}
public protocol SomeBlockContainerBlockNode: SomeBlockNode {
    var blockContainerBlock: SSBlock.BlockContainerBlock { get }
}
public protocol SomeInlineContainerBlockNode: SomeBlockNode {
    var inlineContainerBlock: SSBlock.InlineContainerBlock { get }
}
public protocol SomeLeafBlockNode: SomeBlockNode {
    var leafBlock: SSBlock.LeafBlock { get }
}

extension SomeBlockContainerBlockNode {
    public var block: SSBlock { SSBlock.blockContainer(blockContainerBlock) }
}
extension SomeInlineContainerBlockNode {
    public var block: SSBlock { SSBlock.inlineContainer(inlineContainerBlock) }
}
extension SomeLeafBlockNode {
    public var block: SSBlock { SSBlock.leaf(leafBlock) }
}
