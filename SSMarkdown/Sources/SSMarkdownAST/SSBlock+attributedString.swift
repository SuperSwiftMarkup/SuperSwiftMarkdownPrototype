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
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .blockContainer(let x): return x.attributedString(environment: environment)
        case .inlineContainer(let x): return x.attributedString(environment: environment)
        case .leaf(let x): return x.attributedString(environment: environment)
        }
    }
}

// MARK: - CONTAINER BLOCKS -

extension SSBlock.BlockContainerBlock {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .blockQuote(let x): return x.attributedString(environment: environment)
        case .orderedList(let x): return x.attributedString(environment: environment)
        case .unorderedList(let x): return x.attributedString(environment: environment)
        case .table(let x): return x.attributedString(environment: environment)
        }
    }
}
extension SSBlock.BlockQuoteNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.blockQuote
        let environment = environment
            .withScope(.block(.blockQuote))
            .mapLineIndent(default: 0, transform: { $0 + 30 })
//            .withFont(nodeStyling.font)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
        return children
            .map { $0.attributedString(environment: environment) }
            .join( separatedBy: NSAttributedString.newline )
            .annotate(markdownBlockType: .blockQuote)
    }
}

// MARK: - LIST NODES -

extension SSBlock.OrderedListNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.orderedList
        let environment = environment
            .withScope(.block(.orderedList))
//            .withFont(nodeStyling.font)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapLineIndent(default: 0.0) { $0 + 20 }
        return self.items
            .enumerated()
            .map { (ix, item) in
                item.attributedString(environment: environment, listType: .ordered(count: ix + 1))
            }
            .join( separatedBy: NSAttributedString.newline )
            .annotate(markdownBlockType: .orderedList)
    }
}
extension SSBlock.UnorderedListNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.unorderedList
        let environment = environment
            .withScope(.block(.unorderedList))
//            .withFont(nodeStyling.font)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapLineIndent(default: 0.0) { $0 + 20 }
        return self.items
            .map {
                $0.attributedString(environment: environment, listType: .unordered)
            }
            .join( separatedBy: NSAttributedString.newline )
            .annotate(markdownBlockType: .unorderedList)
    }
}

extension SSBlock.ListItemNode {
    public func attributedString(
        environment: SSStyleEnvironment,
        listType: ListItemType
    ) -> NSAttributedString {
        // MARK: HEADER
        let beginTokenAttributes = environment
            .mapExtraWrapLineIndent(default: 0, transform: { $0 + 30 })
            .mapFont(default: nil) {
                $0  .withDesign( self.checkbox == nil ? .monospaced : .default )
                    .withWeight( self.checkbox == nil ? .light : .light )
                    .mapSize {
                        if self.checkbox != nil {
                            return $0 + 6
                        } else {
                            return $0
                        }
                    }
            }
            .withForegroundColor(environment.documentStyling.prominentSyntaxColor)
            .systemAttributes
        let beginTokenString = leadingTokenAttributedString(listType: listType)
            .intoAttributedString(attributes: beginTokenAttributes)
        // MARK: CHILDREN
        let environment = environment
            .withScope(.block(.listItem))
//            .mapFont(default: styling.block.listItem.font, transform: { $0.withDesign(.monospaced) })
            .mapLineIndent(default: 0) { $0 + 30 }
        return self.children
            .enumerated()
            .map { (index, child) in
                if index == 0 {
                    child.attributedString(environment: environment)
                } else {
                    child.attributedString(environment: environment)
                }
            }
            .join(
                startWith: beginTokenString,
                separatedBy: NSAttributedString.newline,
                endWith: environment.disableTrailingBlockNewline ? nil : NSAttributedString.newline
            )
    }
    internal func leadingTokenAttributedString(listType: ListItemType) -> String {
        let checkedBox = "☑"
        let uncheckedBox = "☐"
        let uncheckedCircle = "❍"
        let unchecked = { false }() ? uncheckedBox : uncheckedCircle
        let checked = { true }() ? checkedBox : checkedBox
        let space = "\u{2008}"
        let bullet = "•"
        let dash = "—"
        let unorderedListItem = { true }() ? dash : bullet
        switch (listType, self.checkbox) {
        case (.ordered(let count), .some(.unchecked)): return "\(count)․\(space)\(unchecked)\(space)"
        case (.ordered(let count), .some(.checked)): return "\(count)․\(space)\(checked)\(space)"
        case (.unordered, .some(.unchecked)): return "\(dash)\(space)\(unchecked)\(space)"
        case (.unordered, .some(.checked)): return "\(dash)\(space)\(checked)\(space)"
        case (.ordered(let count), .none): return "\(count)․\(space)"
        case (.unordered, .none): return "\(unorderedListItem)\(space)"
        }
    }
}
extension SSBlock.ListItemNode.Checkbox {
    internal var displayString: String {
        switch self {
        case .checked: return "[x]\u{2008}"
        case .unchecked: return "[ ]\u{2008}"
        }
    }
}
extension SSBlock.ListItemNode.ListItemType {
    internal var displayString: String {
        switch self {
        case .ordered(let count): return "\(count)․\u{2008}"
        case .unordered: return "•\u{2008}"
        }
    }
}

// MARK: - TABLE NODES -

extension SSBlock.TableNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
//        let environment = environment.withScope(.block(.table))
//        let string = NSString.init(string: "1\r2")
        return NSAttributedString.init(string: "<<TODO>>", attributes: [:])
            .annotate(markdownBlockType: .table)
    }
}
extension SSBlock.TableNode.Head {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.Body {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.Row {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.Cell {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}
extension SSBlock.TableNode.ColumnAlignment {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        fatalError("TODO")
    }
}

// MARK: - INLINE CONTAINER BLOCKS -

extension SSBlock.InlineContainerBlock {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .heading(let x): return x.attributedString(environment: environment)
        case .paragraph(let x): return x.attributedString(environment: environment)
        }
    }
}
extension SSBlock.ParagraphNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.paragraph
        let environment = environment
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .withScope(.block(.paragraph))
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
        return self.children
            .map { $0.attributedString(environment: environment) }
            .join(
                leading: nil,
                contentStyling: nil,
                trailing: nil,
                finalizeWith: {
                    let _ = $0
                    $0.add(attributes: environment.blockLevelSystemAttributes)
                }
            )
            .annotate(markdownBlockType: .paragraph)
    }
}
extension SSBlock.HeadingNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.heading.styling(for: self.level)
//        let font = nodeStyling.font
        let beginToken = self.level
            .attributedString(environment: environment)
            .with(append: NSAttributedString(string: " "))
//        let beginTokenFontLength = CGFloat(beginToken.length) * font.size
        let environment = environment
            .withScope(.block(.heading(self.level)))
//            .withFont(nodeStyling.font)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
//            .mapLineIndent(default: 0, transform: { $0 + 20 })
            .mapExtraWrapLineIndent(default: 0, transform: { $0 + 20 + CGFloat(5 * self.level.asUInt8) })
//            .mapLineIndent(default: 0, transform: { $0 +  })
        return self.children
            .map { $0.attributedString(environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? beginToken : nil,
                contentStyling: nil,
                trailing: nil,
                finalizeWith: {
                    let _ = $0
                    $0.add(attributes: environment.blockLevelSystemAttributes)
                }
            )
            .annotate(markdownBlockType: .heading)
    }
}
extension SSBlock.HeadingNode.Level {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.heading.styling(for: self)
        let environment = environment
        let systemAttributes = environment
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapFont(default: nil) { $0.withDesign(.monospaced).withWeight(.thin) }
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
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .htmlBlock(let x): return x.attributedString(environment: environment)
        case .thematicBreak(let x): return x.attributedString(environment: environment)
        case .codeBlock(let x): return x.attributedString(environment: environment)
        }
    }
}
extension SSBlock.HTMLBlockNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.hTMLBlock
        let environment = environment
            .withScope(.block(.htmlBlock))
//            .withFont(nodeStyling.font)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
            .withForegroundColor(nodeStyling.foregroundColor)
            .withBackgroundColor(nodeStyling.backgroundColor)
        let systemAttributes = environment.systemAttributes
        return NSAttributedString( string: rawHTML, attributes: systemAttributes )
            .annotate(markdownBlockType: .htmlBlock)
    }
}
extension SSBlock.ThematicBreakNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.thematicBreak
        let environment = environment
            .withScope(.block(.thematicBreak))
//            .withFont(nodeStyling.font)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
        let systemAttributes = environment.systemAttributes
        let divider = NSMutableAttributedString(
            string: "---",
            attributes: systemAttributes
        )
        return divider
            .annotate(markdownBlockType: .thematicBreak)
    }
}
extension SSBlock.CodeBlockNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.block.codeBlock
        let environment = environment
            .withScope(.block(.codeBlock))
//            .withFont(nodeStyling.font)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapLineIndent(default: 0, transform: { $0 + 10 })
            .withForegroundColor(nodeStyling.foregroundColor)
            .withBackgroundColor(nodeStyling.backgroundColor)
        let systemAttributes = environment
            .withForegroundColor(nodeStyling.foregroundColor)
            .systemAttributes
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .systemAttributes
        let openToken = NSAttributedString(string: "```\n", attributes: syntaxSystemAttributes)
        let closeToken = NSAttributedString(string: "```", attributes: syntaxSystemAttributes)
        let code = NSAttributedString(string: code, attributes: systemAttributes)
        return ( nodeStyling.showSyntax ? code.wrap(open: openToken, close: closeToken) : code )
            .annotate(markdownBlockType: .codeBlock)
    }
}


