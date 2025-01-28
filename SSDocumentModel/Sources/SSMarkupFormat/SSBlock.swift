//
//  SSBlock.swift
//
//
//  Created by Colbyn Wadman on 1/21/25.
//
// LICENSE file: https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md
//
// The code herein is distributed under a dual licensing model. Users may choose to use such under either:
//
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions of either the AGPLv3 or the commercial license, depending on the license you select.

import Foundation

public enum SSBlock {
    case blockQuote(BlockQuoteNode)
    case orderedList(OrderedListNode)
    case unorderedList(UnorderedListNode)
    case table(TableNode)
    case paragraph(ParagraphNode)
    case heading(HeadingNode)
    case htmlBlock(HTMLBlockNode)
    case codeBlock(CodeBlockNode)
    case thematicBreak(ThematicBreakNode)
}

// MARK: - Block Container Blocks -

extension SSBlock {
    public struct BlockQuoteNode {
        public let children: [ SSBlock ]
    }
}

extension SSBlock {
    public struct OrderedListNode {
        public let items: [ ListItemNode ]
    }
    public struct UnorderedListNode {
        public let items: [ ListItemNode ]
    }
    public struct ListItemNode {
        public let checkbox: Checkbox?
        public let children: [ SSBlock ]
        public enum Checkbox: Equatable {
            case checked, unchecked
        }
        public enum ListItemType: Equatable {
            case ordered(count: Int)
            case unordered
        }
    }
}

extension SSBlock {
    public struct TableNode {
        public let head: Head
        public let alignments: [ ColumnAlignment? ]
        public let body: Body
    }
}

extension SSBlock.TableNode {
    public struct Head {
        public let row: Row
    }
    public struct Body {
        public let rows: [ Row ]
    }
    public struct Row {
        public let cells: [ Cell ]
    }
    public struct Cell {
        public let children: [ SSInline ]
    }
    public enum ColumnAlignment: Equatable {
        case center, left, right
    }
}

// MARK: - Inline Container Blocks -

extension SSBlock {
    public struct ParagraphNode {
        let children: [ SSInline ]
    }
    public struct HeadingNode {
        let level: Level
        let children: [ SSInline ]
        public enum Level: Equatable {
            case h1, h2, h3, h4, h5, h6
        }
    }
}

extension SSBlock.HeadingNode.Level {
    internal var asUInt8: UInt8 {
        switch self {
        case .h1: return 1
        case .h2: return 2
        case .h3: return 3
        case .h4: return 4
        case .h5: return 5
        case .h6: return 6
        }
    }
}

// MARK: - Leaf Blocks -

extension SSBlock {
    public struct HTMLBlockNode {
        public let value: String
    }
    public struct CodeBlockNode {
        public let value: String
    }
    public struct ThematicBreakNode {}
}

// MARK: - INTERFACE UTILITIES -

public protocol SomeBlockNode {
    var block: SSBlock { get }
}

extension SSBlock.BlockQuoteNode: SomeBlockNode {
    public var block: SSBlock { .blockQuote(self) }
}
extension SSBlock.OrderedListNode: SomeBlockNode {
    public var block: SSBlock { .orderedList(self) }
}
extension SSBlock.UnorderedListNode: SomeBlockNode {
    public var block: SSBlock { .unorderedList(self) }
}
extension SSBlock.TableNode: SomeBlockNode {
    public var block: SSBlock { .table(self) }
}
extension SSBlock.ParagraphNode: SomeBlockNode {
    public var block: SSBlock { .paragraph(self) }
}
extension SSBlock.HeadingNode: SomeBlockNode {
    public var block: SSBlock { .heading(self) }
}
extension SSBlock.HTMLBlockNode: SomeBlockNode {
    public var block: SSBlock { .htmlBlock(self) }
}
extension SSBlock.CodeBlockNode: SomeBlockNode {
    public var block: SSBlock { .codeBlock(self) }
}
extension SSBlock.ThematicBreakNode: SomeBlockNode {
    public var block: SSBlock { .thematicBreak(self) }
}
