//
//  SSBlock+attributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation
import SSDMUtilities

extension SSBlock {
    internal func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        switch self {
        case .blockQuote(let node):
            node.attributedString(context: &context, environment: environment)
        case .orderedList(let node):
            node.attributedString(context: &context, environment: environment)
        case .unorderedList(let node):
            node.attributedString(context: &context, environment: environment)
        case .table(let node):
            node.attributedString(context: &context, environment: environment)
        case .paragraph(let node):
            node.attributedString(context: &context, environment: environment)
        case .heading(let node):
            node.attributedString(context: &context, environment: environment)
        case .hTMLBlock(let node):
            node.attributedString(context: &context, environment: environment)
        case .codeBlock(let node):
            node.attributedString(context: &context, environment: environment)
        case .thematicBreak(let node):
            node.attributedString(context: &context, environment: environment)
        }
    }
}

extension SSBlock.BlockQuoteNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment
            .updateStyling {
                $0  .with(backgroundColor: .red.with(alpha: 0.25), updateType: .preferExisting)
            }
            .updateTypesetting {
                $0  .extend(baseIndentationLevel: .quarter)
            }
        for (index, child) in self.children.enumerated() {
            let isLast = self.children.count == index + 1
            child.attributedString(context: &context, environment: environment)
            let _ = isLast
        }
    }
}
extension SSBlock.OrderedListNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
//        context.beginNewBlock(environment: environment)
        let environment = environment
            .updateStyling {
                $0  .with(backgroundColor: .blue.with(alpha: 0.1), updateType: .preferExisting)
            }
            .updateTypesetting {
                $0  .extend(baseIndentationLevel: .quarter)
            }
        for (index, item) in self.items.enumerated() {
            let isLast = self.items.count == index + 1
            item.attributedString(
                context: &context,
                environment: environment,
                itemType: .ordered(count: index + 1)
            )
            let _ = isLast
        }
    }
}
extension SSBlock.UnorderedListNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment
            .updateStyling {
                $0  .with(backgroundColor: .blue.with(alpha: 0.1), updateType: .preferExisting)
            }
            .updateTypesetting {
                $0  .extend(baseIndentationLevel: .quarter)
            }
        for (index, item) in self.items.enumerated() {
            let isLast = self.items.count == index + 1
            item.attributedString(
                context: &context,
                environment: environment,
                itemType: .unordered
            )
            let _ = isLast
        }
    }
}
extension SSBlock.TableNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment.updateStyling {
            $0.with(fontDesign: .monospaced)
        }
        context.append(string: "<<TABLE>>", environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment)
    }
}
extension SSBlock.ParagraphNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
        context.endBlock(lineBreak: .hardLineBreak, environment: environment)
    }
}
extension SSBlock.HeadingNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = level.environment(environment: environment)
            .updateTypesetting {
                $0  .extend(trailingIndentationLevel: .whole)
            }
        let token = String(repeating: "#", count: Int(self.level.asUInt8))
        let tokenColor = SSColorMap(light: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), dark: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        context.append(string: "\(token) ", environment: environment.updateStyling {
            $0  .with(foregroundColor: tokenColor)
                .with(fontWeight: .light)
        })
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
        context.endBlock(lineBreak: .hardLineBreak, environment: environment)
    }
}
extension SSBlock.HTMLBlockNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment
            .updateStyling {
                $0  .with(fontDesign: .monospaced)
                    .mapFontSize { $0 * 0.8 }
            }
        context.append(string: self.value, environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment)
    }
}
extension SSBlock.CodeBlockNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment
            .updateStyling {
                $0  .with(fontDesign: .monospaced)
                    .mapFontSize { $0 * 0.8 }
            }
        context.append(string: "```", environment: environment)
        context.append(lineBreak: .hardLineBreak, environment: environment)
        context.append(string: value, environment: environment)
        context.append(string: "```", environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment)
    }
}
extension SSBlock.ThematicBreakNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment
            .updateStyling {
                $0.with(fontDesign: .monospaced)
            }
        context.append(string: "---", environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment)
    }
}

// MARK: - INTERNAL HELPERS -

extension SSBlock.ListItemNode {
    fileprivate func attributedString(
        context: inout AttributedStringContext,
        environment: AttributeEnvironment,
        itemType: SSBlock.ListItemNode.ListItemType
    ) {
        let environment = environment
        for (index, child) in self.children.enumerated() {
            let isFirst = index == 0
            let isLast = index + 1 == self.children.count
            let environment = environment
                .updateTypesetting(ifTrue: isFirst) {
                    $0  .extend(trailingIndentationLevel: .whole)
                }
                .updateTypesetting(ifTrue: !isFirst) {
                    $0  .extend(baseIndentationLevel: .half)
                }
            if isFirst {
                startToken(context: &context, environment: environment, itemType: itemType)
            }
            child.attributedString(context: &context, environment: environment)
            let _ = isLast
        }
    }
    fileprivate func startToken(
        context: inout AttributedStringContext,
        environment: AttributeEnvironment,
        itemType: SSBlock.ListItemNode.ListItemType
    ) {
        let checkedBox = "☑"
//        let uncheckedBox = "☐"
        let uncheckedCircle = "❍"
        let unchecked = uncheckedCircle
        let checked = checkedBox
        let space = "\u{2008}"
//        let bullet = "•"
        let dash = "—"
        let unorderedListItem = dash
        let token: String
        switch (itemType, self.checkbox) {
        case (.ordered(let count), .some(.unchecked)):
            token = "\(count)․\(space)\(unchecked)\(space)"
        case (.ordered(let count), .some(.checked)):
            token = "\(count)․\(space)\(checked)\(space)"
        case (.unordered, .some(.unchecked)):
            token = "\(dash)\(space)\(unchecked)\(space)"
        case (.unordered, .some(.checked)):
            token = "\(dash)\(space)\(checked)\(space)"
        case (.ordered(let count), .none):
            token = "\(count)․\(space)"
        case (.unordered, .none):
            token = "\(unorderedListItem)\(space)"
        }
        context.append(string: token, environment: environment)
    }
}

extension SSBlock.HeadingNode.Level {
    fileprivate func environment(environment: AttributeEnvironment) -> AttributeEnvironment {
        switch self {
        case .h1:
            return environment.updateStyling {
                $0  .with(fontSize: 26)
                    .with(fontDesign: .rounded)
                    .with(fontWeight: .bold)
            }
        case .h2:
            return environment.updateStyling {
                $0  .with(fontSize: 24)
                    .with(fontDesign: .rounded)
                    .with(fontWeight: .semibold)
            }
        case .h3:
            return environment.updateStyling {
                $0  .with(fontSize: 22)
                    .with(fontDesign: .rounded)
                    .with(fontWeight: .medium)
            }
        case .h4:
            return environment.updateStyling {
                $0  .with(fontSize: 20)
                    .with(fontDesign: .rounded)
                    .with(fontWeight: .regular)
            }
        case .h5:
            return environment.updateStyling {
                $0  .with(fontSize: 18)
                    .with(fontDesign: .rounded)
                    .with(fontWeight: .light)
            }
        case .h6:
            return environment.updateStyling {
                $0  .with(fontSize: 16)
                    .with(fontDesign: .rounded)
                    .with(fontWeight: .thin)
            }
        }
    }
}
