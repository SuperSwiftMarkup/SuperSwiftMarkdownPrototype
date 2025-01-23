//
//  SSMarkdownKey.swift
//
//
//  Created by Colbyn Wadman on 1/17/25.
//

import Foundation

extension NSAttributedString.Key {
    public static var markdownBlockType: NSAttributedString.Key {
        return NSAttributedString.Key("SSMarkdownKey.markdownBlock")
    }
}

public struct SSMarkdownKey {
    public enum BlockType: String, CaseIterable {
        case blockQuote = "BlockQuote"
        case orderedList = "OrderedList"
        case unorderedList = "UnorderedList"
        case table = "Table"
        case heading = "Heading"
        case paragraph = "Paragraph"
        case htmlBlock = "HtmlBlock"
        case thematicBreak = "ThematicBreak"
        case codeBlock = "CodeBlock"
    }
    public struct BlockStructure {}
}

