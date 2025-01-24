//
//  SSBlockType.swift
//
//
//  Created by Colbyn Wadman on 1/23/25.
//

import Foundation
import SSDMUtilities

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

extension NSAttributedString {
    public typealias SSBlockTypeArray = [ SSBlockType ]
    public func lookupBlockScopes() -> [SSBlockType]? {
//        self.enumerateAttribute(.blockScopes, in: self.range) { value, range, _ in
//            if let value = value as? SSBlockTypeArray {
//                let stringDebug = self.string.truncated(limit: 80, position: .middle).debugDescription
//                let scopesString = value.map { $0.rawValue }.joined(separator: ".")
//                print("SCOPE: \(stringDebug):", scopesString)
//            }
//        }
        if let attribute = self.attribute(.blockScopes, at: 0, effectiveRange: nil) {
            if let value = attribute as? SSBlockTypeArray {
//                let stringDebug = self.string.truncated(limit: 80, position: .middle).debugDescription
//                let scopesString = value.map { $0.rawValue }.joined(separator: ".")
//                print("SCOPE: \(stringDebug):", scopesString)
                return value
            }
        }
        return nil
    }
}
