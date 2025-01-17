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
        let blockQuote = NSMutableAttributedString(
            attributedString: children
                .map { $0.attributedString(styling: styling, environment: environment) }
                .join(leading: nil, contentStyling: nil, trailing: nil)
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 10
        paragraphStyle.headIndent = 10
        blockQuote.addAttribute(.paragraphStyle, value: paragraphStyle, range: blockQuote.range)
//        let result = NSTextStorage(attributedString: blockQuote)
//        return NSAttributedString.init(blockQuote, including: \FoundationAttributes.LinkAttribute.self)
        return blockQuote
    }
}
extension SSBlock.OrderedListNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.orderedList
        return self.items
            .map { $0.attributedString(styling: styling, environment: environment) }
            .enumerated()
            .map { (ix, item) in
                let ix = NSAttributedString(string: "\(ix + 1). ", attributes: nodeStyling.systemAttributes)
                return [ ix, item ].join()
            }
            .join(
                leading: nil,
                contentStyling: nil,
                trailing: nil
            )
    }
}
extension SSBlock.UnorderedListNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.unorderedList
        return self.items
            .map { $0.attributedString(styling: styling, environment: environment) }
            .map {
                let ix = NSAttributedString(string: "- ", attributes: nodeStyling.systemAttributes)
                return [ ix, $0 ].join()
            }
            .join(
                leading: nil,
                contentStyling: nil,
                trailing: nil
            )
    }
}

extension SSBlock.ListItemNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let checkbox = self.checkbox.map { $0.attributedString(styling: styling, environment: environment).with(append: " ") }
        return self.children
            .map { $0.attributedString(styling: styling, environment: environment) }
            .join(leading: checkbox)
    }
}
extension SSBlock.ListItemNode.Checkbox {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.listItem
        switch self {
        case .checked: return NSAttributedString(string: "[x]", attributes: nodeStyling.systemAttributes)
        case .unchecked: return NSAttributedString(string: "[ ]", attributes: nodeStyling.systemAttributes)
        }
    }
}

extension SSBlock.TableNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        return NSAttributedString.init(string: "<<TODO>>", attributes: [:])
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
        let paragraph = self.children
            .map { $0.attributedString(styling: styling, environment: environment) }
            .join(leading: nil, contentStyling: nil, trailing: nil)
            .with(append: "\n")
//        let mutableParagraph = NSMutableAttributedString(attributedString: paragraph)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineBreakMode = .byCharWrapping
//        mutableParagraph.addAttribute(.paragraphStyle, value: paragraphStyle, range: mutableParagraph.range)
        return paragraph
    }
}
extension SSBlock.HeadingNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let levelStyling = styling.block.heading.styling(for: self.level)
        let systemAttributes = levelStyling.systemAttributes
        let level = NSAttributedString(attributedString: self.level.attributedString(styling: styling, environment: environment)).with(append: " ")
        return self.children
            .map { $0.attributedString(styling: styling, environment: environment) }
            .join(leading: levelStyling.showSyntax ? level : nil, contentStyling: systemAttributes, trailing: nil)
            .with(append: "\n")
    }
}
extension SSBlock.HeadingNode.Level {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.heading.styling(for: self)
        let attributes = nodeStyling.systemAttributes
        switch self {
        case .h1: return .init(string: "#", attributes: attributes)
        case .h2: return .init(string: "##", attributes: attributes)
        case .h3: return .init(string: "###", attributes: attributes)
        case .h4: return .init(string: "####", attributes: attributes)
        case .h5: return .init(string: "#####", attributes: attributes)
        case .h6: return .init(string: "######", attributes: attributes)
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
        return NSAttributedString(
            string: rawHTML,
            attributes: nodeStyling.systemAttributes
        )
    }
}
extension SSBlock.ThematicBreakNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.block.thematicBreak
        let divider = NSMutableAttributedString(
            string: "---",
            attributes: nodeStyling.systemAttributes
        )
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = .right
        divider.addAttribute(.paragraphStyle, value: paragraphStyle, range: divider.range)
        return divider.with(append: "\n")
    }
}
extension SSBlock.CodeBlockNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
//        print("code", code.debugDescription)
        let nodeStyling = styling.block.codeBlock
        let token = NSAttributedString(string: "```\n", attributes: nodeStyling.systemAttributes)
        let code = NSAttributedString(string: code, attributes: nodeStyling.systemAttributes)
        let codeBlock = NSMutableAttributedString(
            attributedString: nodeStyling.showSyntax ? code.wrap(open: token, close: token) : code
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 10
        paragraphStyle.headIndent = 10
        codeBlock.addAttribute(.paragraphStyle, value: paragraphStyle, range: codeBlock.range)
        return codeBlock
//        let resultMut = NSMutableAttributedString(attributedString: result)
//        let paragraphStyle = NSParagraphStyle()
//        final.addAttribute(.paragraphStyle, value: paragraphStyle, range: final.range)
        // - -
//        let result = NSTextStorage.init(attributedString: final)
//        let sorage = CodeBlockStorage.init(attributedString: NSAttributedString())
//        sorage.beginEditing()
//        sorage.paragraphs = [ NSTextStorage.init(attributedString: result) ]
//        sorage.endEditing()
//        result.paragraphs = [ NSTextStorage(attributedString: final) ]
//        result.paragraphs
//        if result.paragraphs.count != 1 {
//            print("result.paragraphs.count", result.paragraphs.count)
//        }
//        assert(result.paragraphs.count == 1)
//        result.paragraphs = [ NSTextStorage(attributedString: final) ]
//        return sorage
    }
}


