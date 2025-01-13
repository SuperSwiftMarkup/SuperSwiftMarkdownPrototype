//
//  SSMarkdownParser.parse.swift
//  
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation
import Markdown

extension SSMarkdownParser {
    public static func parse(source: String) -> [ SSBlock ] {
        let parseOptions = ParseOptions.init()
        let document = Document.init(parsing: source, source: nil, options: parseOptions)
        let nodes = document.children.map { SSBlock.try(from: $0)! }
        return nodes
    }
}

//fileprivate extension SSMarkdownAST {
//    static func `try`(from element: Markdown.Markup) -> SSMarkdownAST? {
//        if let blockMarkup = element as? Markdown.BlockMarkup {
//            return SSBlock.try(from: blockMarkup).map(SSMarkdownAST.block)
//        }
//        if let inlineMarkup = element as? Markdown.InlineMarkup {
//            return SSInline.try(from: inlineMarkup).map(SSMarkdownAST.inline)
//        }
//        fatalError("TODO - WHEN DOES THIS HAPPEN?")
//    }
//}

// MARK: - BLOCK -

fileprivate extension SSBlock {
    static func `try`(from element: Markdown.Markup) -> SSBlock? {
        if let blockMarkup = element as? Markdown.BlockMarkup {
            return SSBlock.try(from: blockMarkup)
        }
        return nil
    }
    static func `try`(from element: Markdown.BlockMarkup) -> SSBlock? {
        switch element {
        case let element as Markdown.BlockQuote: return SSBlock.BlockQuoteNode.try(from: element).map { $0.block }
        case let element as Markdown.OrderedList: return SSBlock.OrderedListNode.try(from: element).map { $0.block }
        case let element as Markdown.UnorderedList: return SSBlock.UnorderedListNode.try(from: element).map { $0.block }
        case let element as Markdown.Table: return SSBlock.TableNode.try(from: element).map { $0.block }
        case let element as Markdown.Paragraph: return SSBlock.ParagraphNode.try(from: element).map { $0.block }
        case let element as Markdown.Heading: return SSBlock.HeadingNode.try(from: element).map { $0.block }
        case let element as Markdown.HTMLBlock: return SSBlock.HTMLBlockNode.try(from: element).map { $0.block }
        case let element as Markdown.ThematicBreak: return SSBlock.ThematicBreakNode.try(from: element).map { $0.block }
        case let element as Markdown.CodeBlock: return SSBlock.CodeBlockNode.try(from: element).map { $0.block }
        // TODO: IS THIS POSSIBLE?
        case _ as Markdown.ListItem: fatalError("TODO - WHEN DOES THIS HAPPEN?")
        // TODO: NO MATCH - IS THIS POSSIBLE?
        default: fatalError("TODO - WHEN DOES THIS HAPPEN?")
        }
    }
}

// MARK: - ALL BLOCK NODES -

fileprivate extension SSBlock.BlockQuoteNode {
    static func `try`(from element: Markdown.BlockQuote) -> SSBlock.BlockQuoteNode? {
        let children = element.blockChildren.map { SSBlock.try(from: $0)! }.finalize(as: Array.self)
        return SSBlock.BlockQuoteNode.init(children: children)
    }
}
fileprivate extension SSBlock.OrderedListNode {
    static func `try`(from element: Markdown.OrderedList) -> SSBlock.OrderedListNode? {
        let items = element.listItems.map { SSBlock.ListItemNode.try(from: $0)! }.finalize(as: Array.self)
        return SSBlock.OrderedListNode(items: items)
    }
}
fileprivate extension SSBlock.UnorderedListNode {
    static func `try`(from element: Markdown.UnorderedList) -> SSBlock.UnorderedListNode? {
        let items = element.listItems.map { SSBlock.ListItemNode.try(from: $0)! }.finalize(as: Array.self)
        return SSBlock.UnorderedListNode(items: items)
    }
}
fileprivate extension SSBlock.TableNode {
    static func `try`(from element: Markdown.Table) -> SSBlock.TableNode? {
        let head = SSBlock.TableNode.Head.try(from: element.head)!
        let alignments = element.columnAlignments.map { entry in
            entry.map { alignment in
                switch alignment {
                case .center: return SSBlock.TableNode.ColumnAlignment.center
                case .left: return SSBlock.TableNode.ColumnAlignment.left
                case .right: return SSBlock.TableNode.ColumnAlignment.right
                }
            }
        }
        let body = SSBlock.TableNode.Body.try(from: element.body)!
        return SSBlock.TableNode.init(head: head, alignments: alignments, body: body)
    }
}
fileprivate extension SSBlock.ParagraphNode {
    static func `try`(from element: Markdown.Paragraph) -> SSBlock.ParagraphNode? {
        let children = element.inlineChildren.map { SSInline.try(from: $0)! }.finalize(as: Array.self)
        return SSBlock.ParagraphNode.init(children: children)
    }
}
fileprivate extension SSBlock.HeadingNode {
    static func `try`(from element: Markdown.Heading) -> SSBlock.HeadingNode? {
        let level: SSBlock.HeadingNode.Level
        switch element.level {
        case 1: level = .h1
        case 2: level = .h2
        case 3: level = .h3
        case 4: level = .h4
        case 5: level = .h5
        case 6: level = .h6
        default: fatalError("TODO - WHEN DOES THIS HAPPEN?")
        }
        let children = element.inlineChildren.map({ SSInline.try(from: $0)! }).finalize(as: Array.self)
        return SSBlock.HeadingNode.init(level: level, children: children)
    }
}
fileprivate extension SSBlock.HTMLBlockNode {
    static func `try`(from element: Markdown.HTMLBlock) -> SSBlock.HTMLBlockNode? {
        return SSBlock.HTMLBlockNode.init(rawHTML: element.rawHTML)
    }
}
fileprivate extension SSBlock.ThematicBreakNode {
    static func `try`(from element: Markdown.ThematicBreak) -> SSBlock.ThematicBreakNode? {
        return SSBlock.ThematicBreakNode.init()
    }
}
fileprivate extension SSBlock.CodeBlockNode {
    static func `try`(from element: Markdown.CodeBlock) -> SSBlock.CodeBlockNode? {
        return SSBlock.CodeBlockNode.init(code: element.code)
    }
}

fileprivate extension SSBlock.ListItemNode {
    static func `try`(from element: Markdown.ListItem) -> SSBlock.ListItemNode? {
        let children = element.blockChildren.map { SSBlock.try(from: $0)! }.finalize(as: Array.self)
        let checkbox = element.checkbox.map {
            switch $0 {
            case .checked: return SSBlock.ListItemNode.Checkbox.checked
            case .unchecked: return SSBlock.ListItemNode.Checkbox.unchecked
            }
        }
        return SSBlock.ListItemNode.init(checkbox: checkbox, children: children)
    }
}

fileprivate extension SSBlock.TableNode.Head {
    static func `try`(from element: Markdown.Table.Head) -> SSBlock.TableNode.Head? {
        let cells = element.cells.map { SSBlock.TableNode.Cell.try(from: $0)! }.finalize(as: Array.self)
        let row = SSBlock.TableNode.Row.init(cells: cells)
        return SSBlock.TableNode.Head.init(row: row)
    }
}
fileprivate extension SSBlock.TableNode.Body {
    static func `try`(from element: Markdown.Table.Body) -> SSBlock.TableNode.Body? {
        let rows = element.rows.map { SSBlock.TableNode.Row.try(from: $0)! }.finalize(as: Array.self)
        return SSBlock.TableNode.Body.init(rows: rows)
    }
}
fileprivate extension SSBlock.TableNode.Row {
    static func `try`(from element: Markdown.Table.Row) -> SSBlock.TableNode.Row? {
        let cells = element.cells.map { SSBlock.TableNode.Cell.try(from: $0)! }.finalize(as: Array.self)
        return SSBlock.TableNode.Row.init(cells: cells)
    }
}
fileprivate extension SSBlock.TableNode.Cell {
    static func `try`(from element: Markdown.Table.Cell) -> SSBlock.TableNode.Cell? {
        let children = element.inlineChildren.map { SSInline.try(from: $0)! }.finalize(as: Array.self)
        return SSBlock.TableNode.Cell.init(children: children)
    }
}

// MARK: - INLINE -

fileprivate extension SSInline {
    static func `try`(from element: Markdown.InlineMarkup) -> SSInline? {
        switch element {
        case let element as Markdown.Emphasis: return SSInline.EmphasisNode.try(from: element).map { $0.inline }
        case let element as Markdown.Image: return SSInline.ImageLinkNode.try(from: element).map { $0.inline }
        case let element as Markdown.Link: return SSInline.LinkNode.try(from: element).map { $0.inline }
        case let element as Markdown.Strikethrough: return SSInline.StrikethroughNode.try(from: element).map { $0.inline }
        case let element as Markdown.Strong: return SSInline.StrongNode.try(from: element).map { $0.inline }
        case let element as Markdown.InlineCode: return SSInline.InlineCodeNode.try(from: element).map { $0.inline }
        case let element as Markdown.InlineHTML: return SSInline.InlineHTMLNode.try(from: element).map { $0.inline }
        case let element as Markdown.LineBreak: return SSInline.LineBreakNode.try(from: element).map { $0.inline }
        case let element as Markdown.SoftBreak: return SSInline.SoftBreakNode.try(from: element).map { $0.inline }
        case let element as Markdown.SymbolLink: return SSInline.SymbolLinkNode.try(from: element).map { $0.inline }
        case let element as Markdown.Text: return SSInline.TextNode.try(from: element).map { $0.inline }
        // TODO: NO MATCH - IS THIS POSSIBLE?
        default: fatalError("TODO - WHEN DOES THIS HAPPEN?")
        }
    }
}

fileprivate extension SSInline.EmphasisNode {
    static func `try`(from element: Markdown.Emphasis) -> SSInline.EmphasisNode? {
        let children = element.inlineChildren.map { SSInline.try(from: $0)! }.finalize(as: Array.self)
        return SSInline.EmphasisNode(children: children)
    }
}
fileprivate extension SSInline.ImageLinkNode {
    static func `try`(from element: Markdown.Image) -> SSInline.ImageLinkNode? {
        let children = element.inlineChildren.map { SSInline.try(from: $0)! }.finalize(as: Array.self)
        return SSInline.ImageLinkNode.init(display: children, source: element.source, title: element.title)
    }
}
fileprivate extension SSInline.LinkNode {
    static func `try`(from element: Markdown.Link) -> SSInline.LinkNode? {
        let children = element.inlineChildren.map { SSInline.try(from: $0)! }.finalize(as: Array.self)
        return SSInline.LinkNode.init(display: children, destination: element.destination, title: element.title)
    }
}
fileprivate extension SSInline.StrikethroughNode {
    static func `try`(from element: Markdown.Strikethrough) -> SSInline.StrikethroughNode? {
        let children = element.inlineChildren.map { SSInline.try(from: $0)! }.finalize(as: Array.self)
        return SSInline.StrikethroughNode(children: children)
    }
}
fileprivate extension SSInline.StrongNode {
    static func `try`(from element: Markdown.Strong) -> SSInline.StrongNode? {
        let children = element.inlineChildren.map { SSInline.try(from: $0)! }.finalize(as: Array.self)
        return SSInline.StrongNode(children: children)
    }
}
fileprivate extension SSInline.InlineCodeNode {
    static func `try`(from element: Markdown.InlineCode) -> SSInline.InlineCodeNode? {
        return SSInline.InlineCodeNode.init(value: element.code)
    }
}
fileprivate extension SSInline.InlineHTMLNode {
    static func `try`(from element: Markdown.InlineHTML) -> SSInline.InlineHTMLNode? {
        return SSInline.InlineHTMLNode.init(value: element.rawHTML)
    }
}
fileprivate extension SSInline.LineBreakNode {
    static func `try`(from element: Markdown.LineBreak) -> SSInline.LineBreakNode? {
        return SSInline.LineBreakNode.init()
    }
}
fileprivate extension SSInline.SoftBreakNode {
    static func `try`(from element: Markdown.SoftBreak) -> SSInline.SoftBreakNode? {
        return SSInline.SoftBreakNode.init()
    }
}
fileprivate extension SSInline.SymbolLinkNode {
    static func `try`(from element: Markdown.SymbolLink) -> SSInline.SymbolLinkNode? {
        return SSInline.SymbolLinkNode.init(destination: element.destination)
    }
}
fileprivate extension SSInline.TextNode {
    static func `try`(from element: Markdown.Text) -> SSInline.TextNode? {
        return SSInline.TextNode.init(string: element.string)
    }
}
