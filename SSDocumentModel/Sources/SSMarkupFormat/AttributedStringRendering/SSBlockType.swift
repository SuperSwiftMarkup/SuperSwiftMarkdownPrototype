// Created by Colbyn Wadman on 2025-1-23 (ISO 8601)
//
// All SuperSwiftMarkup source code and other software material (unless
// explicitly stated otherwise) is available under a dual licensing model.
//
// Users may choose to use such under either:
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions
// of either the AGPLv3 or the commercial license, depending on the license you
// select.
//
// https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md

import Foundation
import SSDMUtilities

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

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

public struct SSTableRowMetadata {
    public let beginTableRow: Bool
    public let middleTableRow: Bool
    public let endTableRow: Bool
    public let columnLocations: [ CGFloat ]
    public let endsWithEmptyColumn: Bool
    public let tabStopPadding: CGFloat
    public let headIndent: CGFloat
    public let terminalColumnPosition: CGFloat
    internal init(
        beginTableRow: Bool,
        middleTableRow: Bool,
        endTableRow: Bool,
        columnLocations: [ CGFloat ],
        endsWithEmptyColumn: Bool,
        tabStopPadding: CGFloat,
        headIndent: CGFloat,
        terminalColumnPosition: CGFloat
    ) {
        self.beginTableRow = beginTableRow
        self.middleTableRow = middleTableRow
        self.endTableRow = endTableRow
        self.columnLocations = columnLocations
        self.endsWithEmptyColumn = endsWithEmptyColumn
        self.tabStopPadding = tabStopPadding
        self.headIndent = headIndent
        self.terminalColumnPosition = terminalColumnPosition
    }
}

extension NSAttributedString.Key {
    static let blockScopes: NSAttributedString.Key = .init("SSBlockType.blockScopes")
    static let tableCellSpan: NSAttributedString.Key = .init("SSBlockType.tableCellSpan")
    static let tableRowSpan: NSAttributedString.Key = .init("SSBlockType.tableRowSpan")
    static let tableRowMetadata: NSAttributedString.Key = .init("SSTableRowMetadata.tableRowMetadata")
}

extension NSMutableAttributedString {
    internal func annotate(blockScopes: [SSBlockType]) {
        addAttribute(.blockScopes, value: blockScopes, range: self.range)
    }
    internal func markTableCellSpan(isEven: Bool) {
        addAttribute(.tableCellSpan, value: isEven, range: self.range)
    }
    internal func markTableRowSpan(isEven: Bool) {
        addAttribute(.tableRowSpan, value: isEven, range: self.range)
    }
    internal func markTableRowMetadata(tableRowMetadata: SSTableRowMetadata) {
        addAttribute(.tableRowMetadata, value: tableRowMetadata, range: self.range)
    }
}

extension NSAttributedString {
    public typealias SSBlockTypeArray = [ SSBlockType ]
    public func lookupBlockScopes() -> [SSBlockType]? {
        if let attribute = self.attribute(.blockScopes, at: 0, effectiveRange: nil) {
            if let value = attribute as? SSBlockTypeArray {
                return value
            }
        }
        return nil
    }
}

extension NSTextLineFragment {
    public func forEachTableSpanTypes(function: @escaping (Bool, NSRange, CGRect) -> ()) {
        attributedString.enumerateAttribute(.tableCellSpan, in: characterRange, options: []) { value, range, stop in
            guard let value = value as? Bool else { return }
            let start = self.locationForCharacter(at: range.location)
            let end = self.locationForCharacter(at: range.location + range.length)
            let rect = CGRect.from(point1: start, point2: end)
            function(value, range, rect)
        }
    }
    public func enumerateTableSpanTypes(function: @escaping (Bool, NSRange, (CGPoint, CGPoint)) -> ()) {
        attributedString.enumerateAttribute(.tableCellSpan, in: characterRange, options: []) { value, range, stop in
            guard let value = value as? Bool else { return }
            let start = self.locationForCharacter(at: range.lowerBound)
            let end = self.locationForCharacter(at: range.upperBound)
            function(value, range, (start, end))
        }
    }
    public func enumerateTableRowMetadata(function: @escaping (SSTableRowMetadata, NSRange, (CGPoint, CGPoint)) -> ()) {
        attributedString.enumerateAttribute(.tableRowMetadata, in: characterRange, options: []) { value, range, stop in
            guard let value = value as? SSTableRowMetadata else { return }
            let start = self.locationForCharacter(at: range.lowerBound)
            let end = self.locationForCharacter(at: range.upperBound)
            function(value, range, (start, end))
        }
    }
}

extension CGRect {
    fileprivate static func from(point1: CGPoint, point2: CGPoint) -> CGRect {
        let origin = CGPoint(x: min(point1.x, point2.x), y: min(point1.y, point2.y)) // Find top-left corner
        let size = CGSize(width: abs(point1.x - point2.x), height: abs(point1.y - point2.y)) // Calculate width and height
        return CGRect(origin: origin, size: size) // Create the CGRect
    }
}
