//
//  SSBlockType.swift
//
//
//  Created by Colbyn Wadman on 1/23/25.
//

import Foundation

public enum SSBlockType: String {
    case blockQuote = "BlockQuote"
    case orderedList = "OrderedList"
    case unorderedList = "UnorderedList"
    case table = "Table"
    case paragraph = "Paragraph"
    case heading = "Heading"
    case htmlBlock = "HTMLBlock"
    case codeBlock = "CodeBlock"
    case thematicBreak = "ThematicBreak"
    case listItem = "ListItem"
}

extension SSBlockType {}

extension NSAttributedString.Key {
    static let blockScopes: NSAttributedString.Key = .init("blockScopes")
}

extension NSMutableAttributedString {
    internal func annotate(blockScopes: [SSBlockType]) {
        addAttribute(.blockScopes, value: blockScopes, range: self.range)
    }
}
