// Created by Colbyn Wadman on 2025-1-21 (ISO 8601)
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

extension SSBlock {
    internal func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
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
        case .htmlBlock(let node):
            node.attributedString(context: &context, environment: environment)
        case .codeBlock(let node):
            node.attributedString(context: &context, environment: environment)
        case .thematicBreak(let node):
            node.attributedString(context: &context, environment: environment)
        }
    }
}

extension SSBlock.BlockQuoteNode {
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = environment
            .with(blockScope: .blockQuote)
//            .updateStyling {
//                $0  .with(backgroundColor: .red.with(alpha: 0.25), updateType: .preferExisting)
//            }
            .updateTypesetting {
                $0  .extend(baseIndentationLevel: .half)
            }
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
    }
}
extension SSBlock.OrderedListNode {
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
//        context.beginNewBlock(environment: environment)
        let environment = environment
            .with(blockScope: .orderedList)
//            .updateStyling {
//                $0  .with(backgroundColor: .blue.with(alpha: 0.1), updateType: .preferExisting)
//            }
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
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = environment
            .with(blockScope: .unorderedList)
//            .updateStyling {
//                $0  .with(backgroundColor: .blue.with(alpha: 0.1), updateType: .preferExisting)
//            }
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
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = environment
            .with(blockScope: .table)
//            .updateStyling {
////                $0  .mapForegroundColor { $0.inversed }
//                $0.with(colorMode: .darkModeOnly)
//            }
        var tableContext = TableContext(alignments: self.alignments, rows: [])
        head.attributedString(tableContext: &tableContext, environment: environment)
        body.attributedString(tableContext: &tableContext, environment: environment)
        context.push(tableContext: tableContext, environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment, typesetBlock: false)
    }
}
extension SSBlock.ParagraphNode {
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = environment
            .with(blockScope: .paragraph)
        var paragraphState = ParagraphState()
        for child in self.children {
            child.attributedString(context: &paragraphState, environment: environment)
        }
        context.push(paragraphState: paragraphState, environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment, typesetBlock: false)
    }
}
extension SSBlock.HeadingNode {
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = level.environment(environment: environment)
            .with(blockScope: .heading)
            .updateStyling {
                $0  .with(foregroundColor: ThemeDefaults.Colors.Block.Header.textForeground)
            }
//            .updateTypesetting {
//                $0  .clearTrailingIndentationLevel()
//            }
            .updateTypesetting {
                $0  .extend(trailingIndentationLevel: .whole)
            }
        let token = String(repeating: "#", count: Int(self.level.asUInt8))
        let tokenColor = ThemeDefaults.Colors.Block.Header.tokenForeground
        context.append(string: "\(token) ", environment: environment.updateStyling {
            $0  .with(foregroundColor: tokenColor)
                .with(fontWeight: .light)
        })
        var paragraphState = ParagraphState()
        for child in self.children {
            child.attributedString(context: &paragraphState, environment: environment)
        }
        context.push(paragraphState: paragraphState, environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment, typesetBlock: false)
    }
}
extension SSBlock.HTMLBlockNode {
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = environment
            .with(blockScope: .htmlBlock)
            .updateStyling {
                $0  .with(fontDesign: .monospaced)
                    .with(fontWeight: .light)
                    .mapFontSize { $0 * 0.8 }
                    .with(foregroundColor: ThemeDefaults.Colors.Block.htmlBlock)
            }
        context.append(string: self.value, environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment, typesetBlock: true)
    }
}
extension SSBlock.CodeBlockNode {
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = environment
            .with(blockScope: .codeBlock)
            .updateStyling {
                $0  .with(fontDesign: .monospaced)
                    .with(fontWeight: .light)
                    .mapFontSize { $0 * 0.8 }
                    .with(foregroundColor: ThemeDefaults.Colors.Block.codeBlock)
            }
//            .updateTypesetting {
//                $0  .extend(baseIndentationLevel: .half)
//                    .extend(trailingIndentationLevel: .whole)
//            }
//            .updateTypesetting { env in
//                env.modifyLineIndentSettings { indent in
//                    AttributeEnvironment.TypesetEnvironment.LineIndentSetting(
//                        baseIndentationLevels: indent.baseIndentationLevels.with(extend: indent.trailingIndentationLevels),
//                        trailingIndentationLevels: indent.baseIndentationLevels.with(extend: indent.trailingIndentationLevels)
//                    )
//                }
//            }
        context.append(string: "```", environment: environment)
        context.append(lineBreak: .hardLineBreak, environment: environment)
        context.append(string: value, environment: environment)
        context.append(string: "```", environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment, typesetBlock: true, typesetRange: [])
    }
}
extension SSBlock.ThematicBreakNode {
    fileprivate func attributedString(context: inout DocumentContext, environment: AttributeEnvironment) {
        let environment = environment
            .with(blockScope: .thematicBreak)
            .updateStyling {
                $0.with(fontDesign: .monospaced)
            }
        context.append(string: "---", environment: environment)
        context.endBlock(lineBreak: .hardLineBreak, environment: environment, typesetBlock: true)
    }
}

//fileprivate let codeOrMarkupForegroundColor: SSColorMap = SSColorMap(singleton: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))

// MARK: - INTERNAL HELPERS -

extension SSBlock.ListItemNode {
    fileprivate func attributedString(
        context: inout DocumentContext,
        environment: AttributeEnvironment,
        itemType: SSBlock.ListItemNode.ListItemType
    ) {
        let environment = environment
            .with(blockScope: .listItem)
//            .with(blockScope: .thematicBreak)
//            .updateTypesetting {
//                $0  .extend(baseIndentationLevel: .half)
//            }
        for (index, child) in self.children.enumerated() {
            let isFirst = index == 0
            let isLast = index + 1 == self.children.count
            let environment = environment
                .updateTypesetting(ifTrue: isFirst) {
                    $0  .extend(trailingIndentationLevel: .half)
//                        .extend(baseIndentationLevel: .half)
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
        context: inout DocumentContext,
        environment: AttributeEnvironment,
        itemType: SSBlock.ListItemNode.ListItemType
    ) {
        let beginTokenForegroundColor = SSColorMap( light: #colorLiteral(red: 0.4953680852, green: 0.4953680852, blue: 0.4953680852, alpha: 1), dark: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) )
        let deemphasizedTokenForegroundColor = SSColorMap( light: #colorLiteral(red: 0.4953680852, green: 0.4953680852, blue: 0.4953680852, alpha: 1), dark: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) )
        let checkedForegroundColor = SSColorMap( light: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), dark: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1) )
        let uncheckedForegroundColor = SSColorMap( light: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), dark: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) )
        let targetForegroundColor: SSColorMap?
        switch self.checkbox {
        case .checked: targetForegroundColor = checkedForegroundColor
        case .unchecked: targetForegroundColor = uncheckedForegroundColor
        default: targetForegroundColor = nil
        }
        let beginTokenEnvironment = environment
            .updateStyling {
                $0  .with(foregroundColor: beginTokenForegroundColor)
            }
        let deemphasizedTokenEnvironment = environment
            .updateStyling {
                $0  .with(foregroundColor: deemphasizedTokenForegroundColor)
            }
        let taskListEnvironment = environment
            .updateStyling {
                $0  .with(foregroundColor: targetForegroundColor)
                    .mapFontSize { $0 * 1.25 }
            }
//        let checkedBox = "☑"
        let checkCircle = "✓⃝⃝"
//        let checkCircle = "✔️⃝⃝"
//        let uncheckedBox = "☐"
//        let uncheckedCircle = "❍"
//        let uncheckedCircle = "◯"
//        let uncheckedCircle = "○"
        let uncheckedCircle = " ⃝⃝"
        let unchecked = uncheckedCircle
        let checked = checkCircle
        let space = "\u{2008}"
        let bullet = "•"
        let dash = "—"
        let unorderedListItem = bullet
        switch (itemType, self.checkbox) {
        case (.ordered(let count), .some(.unchecked)):
            context.append(string: "\(count)․\(space)", environment: beginTokenEnvironment)
            context.append(string: "\(unchecked)\(space)", environment: taskListEnvironment)
        case (.ordered(let count), .some(.checked)):
            context.append(string: "\(count)․\(space)", environment: beginTokenEnvironment)
            context.append(string: "\(checked)\(space)", environment: taskListEnvironment)
        case (.unordered, .some(.unchecked)):
            context.append(string: "\(dash)\(space)", environment: deemphasizedTokenEnvironment)
            context.append(string: "\(unchecked)\(space)", environment: taskListEnvironment)
        case (.unordered, .some(.checked)):
            context.append(string: "\(dash)\(space)", environment: deemphasizedTokenEnvironment)
            context.append(string: "\(checked)\(space)", environment: taskListEnvironment)
        case (.ordered(let count), .none):
            context.append(string: "\(count)․\(space)", environment: beginTokenEnvironment)
        case (.unordered, .none):
            context.append(string: "\(unorderedListItem)\(space)", environment: beginTokenEnvironment)
        }        
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

extension SSBlock.TableNode.Head {
    fileprivate func attributedString(tableContext: inout TableContext, environment: AttributeEnvironment) {
        let environment = environment
            .updateStyling {
                $0.mapFontWeight { $0.increment.increment }
            }
        row.attributedString(tableContext: &tableContext, environment: environment)
    }
}

extension SSBlock.TableNode.Body {
    fileprivate func attributedString(tableContext: inout TableContext, environment: AttributeEnvironment) {
        for row in rows {
            row.attributedString(tableContext: &tableContext, environment: environment)
        }
    }
}

extension SSBlock.TableNode.Row {
    fileprivate func attributedString(tableContext: inout TableContext, environment: AttributeEnvironment) {
        let cells = self.cells
            .map { TableContext.Cell(attributedString: $0.attributedString(environment: environment)) }
//            .with(append: TableContext.Cell(attributedString: NSAttributedString()))
        tableContext.append(row: .init(cells: cells))
    }
}

extension SSBlock.TableNode.Cell {
    fileprivate func attributedString(environment: AttributeEnvironment) -> NSAttributedString {
        var context = ParagraphState()
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
        return context.untypedFinalize(lineBreakSeparator: environment.styledSpace)
    }
}
