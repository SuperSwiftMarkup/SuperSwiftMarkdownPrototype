// Created by Colbyn Wadman on 2025-1-26 (ISO 8601)
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

internal struct TableContext: ~Copyable {
    private let alignments: [ SSBlock.TableNode.ColumnAlignment? ]
    private var rows: [ Row ]
    private let tabStopPadding: CGFloat = 30.0
    private let wholeIndent: CGFloat = 30.0
    internal init(alignments: [ SSBlock.TableNode.ColumnAlignment? ], rows: [Row]) {
        self.alignments = alignments
        self.rows = rows
    }
    internal final class Row {
        let cells: [ Cell ]
        init(cells: [Cell]) {
            self.cells = cells
        }
    }
    internal final class Cell {
        let attributedString: NSAttributedString
        init(attributedString: NSAttributedString) {
            self.attributedString = attributedString
        }
    }
    fileprivate final class ColumnMetadata {
        var maxLength: CGFloat?
    }
    fileprivate final class RowMetadata {
        var maxHeight: CGFloat?
    }
}

extension TableContext {
    internal mutating func append(row: TableContext.Row) {
        self.rows.append(row)
    }
}

extension TableContext {
    internal consuming func finalize(environment: AttributeEnvironment) -> NSMutableAttributedString {
        var allColumnMetadata: Dictionary<Int, ColumnMetadata> = [:]
        var allRowsMetadata: Dictionary<Int, RowMetadata> = [:]
        // - COMPUTE COLUMN METADATA -
        for (rowIndex, row) in rows.enumerated() {
            let rowMetadata = RowMetadata()
            for (columnIndex, cell) in row.cells.enumerated() {
                let columnMetadata: ColumnMetadata
                if let existing = allColumnMetadata[columnIndex] {
                    columnMetadata = existing
                } else {
                    columnMetadata = ColumnMetadata()
                    allColumnMetadata[columnIndex] = columnMetadata
                }
                let cellSize = cell.attributedString.size()
                columnMetadata.maxLength = max(cellSize.width, columnMetadata.maxLength ?? 0)
                rowMetadata.maxHeight = max(cellSize.height, rowMetadata.maxHeight ?? 0)
            }
            allRowsMetadata[rowIndex] = rowMetadata
        }
        let computePrecedingColumnLength: (Int) -> (CGFloat) = { upToIndex in
            var summary: CGFloat = wholeIndent
            for index in 0...upToIndex {
                summary += (allColumnMetadata[index]!).maxLength ?? 0
                summary += tabStopPadding
            }
            return summary
        }
        let computeTotalColumnLength: (Int) -> (CGFloat) = { upToIndex in
            var summary: CGFloat = wholeIndent
            let range = 0...upToIndex
            for index in range {
                summary += (allColumnMetadata[index]!).maxLength ?? 0
                if range.upperBound != index {
                    summary += tabStopPadding
                }
            }
            return summary
        }
        // - TYPESET -
        let tableOutput = NSMutableAttributedString()
        for (rowIndex, row) in self.rows.enumerated() {
            let isFistRow = rowIndex == 0
            let isLastRow = rowIndex + 1 == self.rows.count
            let isMiddleRow = !isFistRow || !isLastRow
            let rowOutput = NSMutableAttributedString()
            var textTabs: [ XTextTab ] = []
            for (columnIndex, cell) in row.cells.enumerated() {
                let isLastCell = columnIndex + 1 == row.cells.count
                let cellOutput = NSMutableAttributedString(attributedString: cell.attributedString)
                if !isLastCell {
                    cellOutput.append(NSAttributedString(string: "\t"))
                    let columnLocation = computePrecedingColumnLength(columnIndex)
                    let textAlignment: XTextAlignment
                    if alignments.count <= columnIndex + 1 {
                        switch alignments[columnIndex] {
                        case .left: textAlignment = .left
                        case .center: textAlignment = .center
                        case .right: textAlignment = .right
                        case .none: textAlignment = .left
                        }
                    } else {
                        textAlignment = .left
                    }
                    textTabs.append(XTextTab(
                        textAlignment: textAlignment,
                        location: columnLocation,
                        options: [:]
                    ))
                }
                cellOutput.markTableCellSpan(isEven: columnIndex % 2 == 0)
                rowOutput.append(cellOutput)
            }
            let paragraphStyle = XMutableParagraphStyle()
            let rowMeta = allRowsMetadata[rowIndex]!
            paragraphStyle.lineBreakMode = .byClipping
            paragraphStyle.tabStops = textTabs
            paragraphStyle.firstLineHeadIndent = wholeIndent
            paragraphStyle.headIndent = wholeIndent
            let _ = ensureProperLineSpacing(environment: environment, paragraphStyle: paragraphStyle, rowMeta: rowMeta)
            rowOutput.addAttribute(.paragraphStyle, value: paragraphStyle, range: rowOutput.range)
            rowOutput.markTableRowMetadata(tableRowMetadata: SSTableRowMetadata(
                beginTableRow: isFistRow,
                middleTableRow: isMiddleRow,
                endTableRow: isLastRow,
                columnLocations: textTabs.map { $0.location },
                endsWithEmptyColumn: false,
                tabStopPadding: tabStopPadding,
                headIndent: wholeIndent,
                terminalColumnPosition: computeTotalColumnLength(row.cells.count - 1)
            ))
//            if let baselineOffset = baselineOffset {
//                rowOutput.addAttribute(.baselineOffset, value: baselineOffset, range: rowOutput.range)
//            }
            tableOutput.append(rowOutput)
            if !isLastRow {
                tableOutput.append(environment.styledNewline)
            }
        }
        // - DONE -
        return tableOutput
    }
}


import CoreGraphics

fileprivate func ensureProperLineSpacing(
    environment: AttributeEnvironment,
    paragraphStyle: XMutableParagraphStyle,
    rowMeta: TableContext.RowMetadata
) -> CGFloat? {
    // Get the font from the first attribute in the attributed string
//    let fullRange = NSRange(location: 0, length: attributedString.length)
//    let font = attributedString.attribute(.font, at: 0, effectiveRange: nil) as? XFont ?? XFont.systemFont(ofSize: 12)
//    let font = environment.mapSystemFont(function: { $0 })
    
    paragraphStyle.paragraphSpacingBefore = max(4, paragraphStyle.paragraphSpacingBefore)
    paragraphStyle.paragraphSpacing = max(4, paragraphStyle.paragraphSpacing)
    
//    let upper = font.ascender
//    let lower = abs(font.descender)
    
//    return upper + lower
    
//    paragraphStyle.paragraphSpacingBefore = upper
//    paragraphStyle.paragraphSpacing = lower
//    paragraphStyle.lineSpacing
//    let totalHeight = (font.ascender - abs(font.descender)) + font.leading
//    let totalHeight = (font.ascender - font.descender) + font.leading
//    paragraphStyle.maximumLineHeight = totalHeight
    
//    paragraphStyle.lineHeightMultiple = 2.0
//    paragraphStyle.minimumLineHeight = totalHeight
    
//    return max(font.xHeight, font.capHeight)
    
    
//    // Extract font metrics
//    let lineHeight = font.capHeight  // Total line height
//    let ascent = font.ascender       // Distance from baseline to the top
//    let descent = font.descender     // Distance from baseline to the bottom (negative value in UIKit)
//    let leading = font.leading       // Additional space between lines (typically zero for many modern fonts)
    
//    // Calculate extra space needed to prevent clipping
//    let extraSpace = abs(descent) + leading
//    return abs(font.descender) + font.leading
    return nil
}

// Apply the calculated line spacing to an attributed string
//fileprivate func applyLineSpacing(to attributedString: NSMutableAttributedString) {
//    let paragraphStyle = XMutableParagraphStyle()
//    paragraphStyle.lineSpacing = calculateLineSpacing(for: attributedString)
//    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
//}

//// Example usage
//let text = "Example text with descenders like g, j, and y."
//let attributedString = NSMutableAttributedString(string: text, attributes: [
//    .font: UIFont.systemFont(ofSize: 18),
//    .backgroundColor: UIColor.yellow
//])
//
//applyLineSpacing(to: attributedString)
//
