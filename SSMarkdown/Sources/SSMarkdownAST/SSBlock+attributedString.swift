//
//  SSBlock+attributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/14/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

extension SSBlock {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .blockContainer(let x): return x.attributedString(styling: styling, environment: environment)
        case .inlineContainer(let x): return x.attributedString(styling: styling, environment: environment)
        case .leaf(let x): return x.attributedString(styling: styling, environment: environment)
        }
    }
}

// MARK: - CONTAINER BLOCKS -

extension SSBlock.BlockContainerBlock {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .blockQuote(let x): return x.attributedString(styling: styling, environment: environment)
        case .orderedList(let x): return x.attributedString(styling: styling, environment: environment)
        case .unorderedList(let x): return x.attributedString(styling: styling, environment: environment)
        case .table(let x): return x.attributedString(styling: styling, environment: environment)
        }
    }
}
extension SSBlock.BlockQuoteNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.blockQuote
        let environment = environment
            .withScope(.block(.blockQuote))
//            .mapLineIndent(default: 0, transform: { $0 + 20 })
            .withFont(ifUndefined: nodeStyling.font)
        return children
            .map { $0.attributedString(styling: styling, environment: environment) }
            .join(
                leading: nil,
                contentStyling: nil,
                trailing: environment.disableTrailingBlockNewline ? nil : NSAttributedString.newline
            )
    }
}

// MARK: - LIST NODES -

extension SSBlock.OrderedListNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.orderedList
        let environment = environment
            .withScope(.block(.orderedList))
            .withFont(ifUndefined: nodeStyling.font)
//            .mapLineIndent(default: 0, transform: { $0 + 10 })
//            .withLineIndent(ifUndefined: 0)
//            .withExtraWrapLineIndent(12)
//        if environment.containsScope(block: .listItem) {
//            environment = environment.mapLineIndent(default: 0, transform: { $0 + 20 })
//        }
        return self.items
            .enumerated()
            .map { (ix, item) in
                item.attributedString(styling: styling, environment: environment, listType: .ordered(count: ix + 1))
            }
            .join(
                separatedBy: NSAttributedString.newline,
                endWith: environment.disableTrailingBlockNewline ? nil : NSAttributedString.newline
            )
    }
}
extension SSBlock.UnorderedListNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.unorderedList
        let environment = environment
            .withScope(.block(.unorderedList))
            .withFont(ifUndefined: nodeStyling.font)
//            .mapLineIndent(default: 0, transform: { $0 + 10 })
//            .withLineIndent(ifUndefined: 0)
//            .withExtraWrapLineIndent(12)
//        if environment.containsScope(block: .listItem) {
//            environment = environment.mapLineIndent(default: 0, transform: { $0 + 20 })
//        }
        return self.items
            .map {
                $0.attributedString(styling: styling, environment: environment, listType: .unordered)
            }
            .join(
                separatedBy: NSAttributedString.newline,
                endWith: environment.disableTrailingBlockNewline ? nil : NSAttributedString.newline
            )
    }
}

extension SSBlock.ListItemNode {
    public func attributedString(
        styling: SSDocumentStyling,
        environment: SSStyleEnvironment,
        listType: ListItemType
    ) -> NSAttributedString {
        // MARK: HEADER
        let beginTokenAttributes = environment
            .mapExtraWrapLineIndent(default: 0, transform: { $0 + 30 })
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced).withWeight(.light) })
            .withForegroundColor(styling.prominentSyntaxColor)
            .systemAttributes
        let beginTokenString = [ .some(listType.displayString), self.checkbox?.displayString ]
            .compactMap { $0 }
            .joined(separator: " ")
            .with(append: " ")
            .intoAttributedString(attributes: beginTokenAttributes)
        // MARK: CHILDREN
//        let fontSize = environment.font?.size ?? styling.block.listItem.font.size
//        let headerStringFontLength = CGFloat(beginTokenString.length) * fontSize
        let environment = environment
            .withScope(.block(.listItem))
            .mapFont(default: styling.block.listItem.font, transform: { $0.withDesign(.monospaced) })
            .mapLineIndent(default: 0) { $0 + 30 }
//            .mapExtraWrapLineIndent(default: 0, transform: { $0 + 30 })
//            .mapLineIndent(default: 0) { $0 + headerStringFontLength }
//            .mapExtraWrapLineIndent(default: 0, transform: { $0 + headerStringFontLength })
//            .mapExtraWrapLineIndent(default: 0) { $0 + headerStringFontLength }
        return self.children
            .enumerated()
            .map { (index, child) in
                if index == 0 {
                    child.attributedString(styling: styling, environment: environment)
                } else {
                    child.attributedString(styling: styling, environment: environment)
                }
            }
//            .join(leading: beginTokenString, contentStyling: nil, trailing: nil)
            .join(
                startWith: beginTokenString,
                separatedBy: NSAttributedString.newline,
                endWith: environment.disableTrailingBlockNewline ? nil : NSAttributedString.newline
            )
    }
}
extension SSBlock.ListItemNode.Checkbox {
    internal var displayString: String {
        switch self {
        case .checked: return "[x]"
        case .unchecked: return "[ ]"
        }
    }
}
extension SSBlock.ListItemNode.ListItemType {
    internal var displayString: String {
        switch self {
        case .ordered(let count): return "\(count)."
        case .unordered: return "-"
        }
    }
}

// MARK: - TABLE NODES -

extension SSBlock.TableNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
//        let environment = environment.withScope(.block(.table))
        return NSAttributedString.init(string: "<<TODO>>", attributes: [:])
            .with(append: NSAttributedString.newline)
    }
}
extension SSBlock.TableNode.Head {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.Body {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.Row {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.Cell {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.ColumnAlignment {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}

// MARK: - INLINE CONTAINER BLOCKS -

extension SSBlock.InlineContainerBlock {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .heading(let x): return x.attributedString(styling: styling, environment: environment)
        case .paragraph(let x): return x.attributedString(styling: styling, environment: environment)
        }
    }
}
extension SSBlock.ParagraphNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        var environment = environment
            .withFont(styling.block.paragraph.font)
            .withScope(.block(.paragraph))
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
//            .mapExtraWrapLineIndent(default: 0, transform: { $0 + 20 })
//        if environment.containsScope(block: .listItem) {
//            environment = environment
//                .mapLineIndent(default: 0, transform: { $0 + 30 })
//                .mapExtraWrapLineIndent(default: 0, transform: { $0 + 30 })
//        }
        return self.children
            .map { $0.attributedString(styling: styling, environment: environment) }
            .join(
                leading: nil,
                contentStyling: nil,
                trailing: environment.disableTrailingBlockNewline ? nil : NSAttributedString.newline,
                finalizeWith: {
                    let _ = $0
                    $0.add(attributes: environment.blockLevelSystemAttributes)
                }
            )
    }
}
extension SSBlock.HeadingNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.heading.styling(for: self.level)
        let font = nodeStyling.font
        let beginToken = self.level
            .attributedString(styling: styling, environment: environment)
            .with(append: NSAttributedString(string: " "))
//        let beginTokenFontLength = CGFloat(beginToken.length) * font.size
        let environment = environment
            .withScope(.block(.heading(self.level)))
            .withFont(font)
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
//            .mapLineIndent(default: 0, transform: { $0 + 20 })
            .mapExtraWrapLineIndent(default: 0, transform: { $0 + 20 + CGFloat(5 * self.level.asUInt8) })
//            .mapLineIndent(default: 0, transform: { $0 +  })
        return self.children
            .map { $0.attributedString(styling: styling, environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? beginToken : nil,
                contentStyling: nil,
                trailing: environment.disableTrailingBlockNewline ? nil : NSAttributedString.newline,
                finalizeWith: {
                    let _ = $0
                    $0.add(attributes: environment.blockLevelSystemAttributes)
                }
            )
    }
}
extension SSBlock.HeadingNode.Level {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.heading.styling(for: self)
        let environment = environment
        let systemAttributes = environment
            .withForegroundColor(styling.deemphasizedSyntaxColor)
            .mapFont(default: nodeStyling.font) { $0.withDesign(.monospaced).withWeight(.thin) }
            .inlineLevelSystemAttributes
        switch self {
        case .h1: return .init(string: "#", attributes: systemAttributes)
        case .h2: return .init(string: "##", attributes: systemAttributes)
        case .h3: return .init(string: "###", attributes: systemAttributes)
        case .h4: return .init(string: "####", attributes: systemAttributes)
        case .h5: return .init(string: "#####", attributes: systemAttributes)
        case .h6: return .init(string: "######", attributes: systemAttributes)
        }
    }
    internal var displayString: String {
        switch self {
        case .h1: return "#"
        case .h2: return "##"
        case .h3: return "###"
        case .h4: return "####"
        case .h5: return "#####"
        case .h6: return "######"
        }
    }
}

// MARK: - LEAF BLOCKS -

extension SSBlock.LeafBlock {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .htmlBlock(let x): return x.attributedString(styling: styling, environment: environment)
        case .thematicBreak(let x): return x.attributedString(styling: styling, environment: environment)
        case .codeBlock(let x): return x.attributedString(styling: styling, environment: environment)
        }
    }
}
extension SSBlock.HTMLBlockNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.hTMLBlock
        let environment = environment
            .withScope(.block(.htmlBlock))
            .withFont(ifUndefined: nodeStyling.font)
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
        let systemAttributes = environment.systemAttributes
        return NSAttributedString( string: rawHTML, attributes: systemAttributes )
            .with(append: NSAttributedString.newline)
    }
}
extension SSBlock.ThematicBreakNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.thematicBreak
        let environment = environment
            .withScope(.block(.thematicBreak))
            .withFont(ifUndefined: nodeStyling.font)
        let systemAttributes = environment.systemAttributes
        let divider = NSMutableAttributedString(
            string: "---",
            attributes: systemAttributes
        )
        return divider.with(append: NSAttributedString.newline)
    }
}
extension SSBlock.CodeBlockNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.codeBlock
        let environment = environment
            .withScope(.block(.codeBlock))
            .mapLineIndent(default: 0, transform: { $0 + 20 })
            .mapFont(default: nodeStyling.font) { $0.withDesign(.monospaced) }
        let systemAttributes = environment
            .withForegroundColor(nodeStyling.foregroundColor)
            .systemAttributes
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(styling.deemphasizedSyntaxColor)
            .systemAttributes
        let token = NSAttributedString(string: "```\n", attributes: syntaxSystemAttributes)
        let code = NSAttributedString(string: code, attributes: systemAttributes)
        return nodeStyling.showSyntax
            ? code
                .wrap(open: token, close: token)
            : code
                .with(append: NSAttributedString.newline)
    }
}


