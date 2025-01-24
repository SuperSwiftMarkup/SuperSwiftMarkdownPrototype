//
//  SSInline+attributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation
import SSDMUtilities

fileprivate let FORCE_REPLACE_LINE_BREAKS_WITH_SPACE: Bool = false

extension SSInline {
    internal func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        switch self {
        case .emphasis(let node):
            node.attributedString(context: &context, environment: environment)
        case .imageLink(let node):
            node.attributedString(context: &context, environment: environment)
        case .link(let node):
            node.attributedString(context: &context, environment: environment)
        case .strikethrough(let node):
            node.attributedString(context: &context, environment: environment)
        case .strong(let node):
            node.attributedString(context: &context, environment: environment)
        case .inlineCode(let node):
            node.attributedString(context: &context, environment: environment)
        case .inlineHTML(let node):
            node.attributedString(context: &context, environment: environment)
        case .lineBreak(let node):
            node.attributedString(context: &context, environment: environment)
        case .softBreak(let node):
            node.attributedString(context: &context, environment: environment)
        case .symbolLink(let node):
            node.attributedString(context: &context, environment: environment)
        case .text(let node):
            node.attributedString(context: &context, environment: environment)
        }
    }
}

extension SSInline.EmphasisNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        let environment = environment.updateStyling { $0.with(italicTextStyle: true) }
        let token = "*"
        context.append(string: token, environment: environment)
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
        context.append(string: token, environment: environment)
    }
}
extension SSInline.ImageLinkNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        renderLink(context: &context, environment: environment, children: display, destination: source, title: title, imageMode: true)
    }
}
extension SSInline.LinkNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        renderLink(context: &context, environment: environment, children: display, destination: destination, title: title, imageMode: false)
    }
}
extension SSInline.StrikethroughNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        let tokenEnvironment = environment
            .updateStyling {
                $0  .with(fontWeight: .light)
            }
        let environment = environment
            .updateStyling {
                $0.with(strikethroughMode: true)
            }
        context.append(string: "~~", environment: tokenEnvironment)
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
        context.append(string: "~~", environment: tokenEnvironment)
    }
}
extension SSInline.StrongNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        let environment = environment.updateStyling { $0.with(boldTextStyle: true) }
        let token = "**"
        context.append(string: token, environment: environment)
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
        context.append(string: token, environment: environment)
    }
}
extension SSInline.InlineCodeNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        renderCodeVoice(context: &context, environment: environment, value: value)
    }
}
extension SSInline.InlineHTMLNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        let foregroundColor = ThemeDefaults.Colors.Inline.inlineHTML
        let environment = environment
            .updateStyling {
                $0  .with(fontDesign: .monospaced)
                    .with(fontWeight: .light)
                    .with(foregroundColor: foregroundColor)
            }
        context.append(string: value, environment: environment)
    }
}
extension SSInline.LineBreakNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        if FORCE_REPLACE_LINE_BREAKS_WITH_SPACE {
            context.append(string: " ", environment: environment)
        } else {
            context.append(lineBreak: .hardLineBreak, environment: environment)
        }
    }
}
extension SSInline.SoftBreakNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        if FORCE_REPLACE_LINE_BREAKS_WITH_SPACE {
            context.append(string: " ", environment: environment)
        } else {
            context.append(lineBreak: .softLineBreak, environment: environment)
        }
    }
}
extension SSInline.SymbolLinkNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        renderCodeVoice(context: &context, environment: environment, value: self.destination ?? "")
    }
}
extension SSInline.TextNode {
    fileprivate func attributedString(context: inout ParagraphState, environment: AttributeEnvironment) {
        context.append(string: value, environment: environment)
    }
}

// MARK: - INTERNAL HELPERS -
fileprivate func renderLink(
    context: inout ParagraphState,
    environment: AttributeEnvironment,
    children: [ SSInline ]?,
    destination: String?,
    title: String?,
    imageMode: Bool
) {
    let linkColor = SSColorMap( light: #colorLiteral(red: 0, green: 0.4035420405, blue: 1, alpha: 1), dark: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) )
    let tokenColor = SSColorMap( light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), dark: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) )
    let tokenEnvironment = environment
        .updateStyling {
            $0  .with(fontWeight: .light)
                .with(fontDesign: .rounded)
                .with(foregroundColor: tokenColor)
        }
    let linkEnvironment = environment.updateStyling {
        $0  .with(fontWeight: .light)
//            .with(fontDesign: .monospaced)
            .mapFontSize { $0 * 0.9 }
            .with(fontDesign: .default)
            .with(foregroundColor: linkColor)
            .with(fontWidth: .condensed)
    }
    let childEnvironment = environment
        .updateStyling(ifTrue: destination == nil) {
            $0  .with(foregroundColor: linkColor)
        }
    if imageMode {
        context.append(string: "!", environment: tokenEnvironment)
    }
    if let children = children {
        context.append(string: "[", environment: tokenEnvironment)
        for child in children {
            child.attributedString(context: &context, environment: childEnvironment)
        }
        context.append(string: "]", environment: tokenEnvironment)
    }
    if destination != nil || title != nil {
        context.append(string: "(", environment: tokenEnvironment)
        if let destination = destination {
            context.append(string: destination, environment: linkEnvironment)
        }
        if let title = title {
            if destination != nil {
                context.append(string: " ", environment: linkEnvironment)
            }
            context.append(string: "\"\(title)\"", environment: environment)
        }
        context.append(string: ")", environment: tokenEnvironment)
    }
}

fileprivate func renderCodeVoice(
    context: inout ParagraphState,
    environment: AttributeEnvironment,
    value: String
) {
    let tokenEnvironment = environment
        .updateStyling {
            $0  .with(fontDesign: .monospaced)
                .with(fontWeight: .light)
                .with(foregroundColor: ThemeDefaults.Colors.Inline.inlineCodeTokenForeground)
                .with(backgroundColor: ThemeDefaults.Colors.Inline.inlineCodeBackground)
        }
    let environment = environment
        .updateStyling {
            $0  .with(fontDesign: .monospaced)
                .with(fontWeight: .light)
                .with(backgroundColor: ThemeDefaults.Colors.Inline.inlineCodeTextForeground)
                .with(backgroundColor: ThemeDefaults.Colors.Inline.inlineCodeBackground)
        }
    context.append(string: "`", environment: tokenEnvironment)
    context.append(string: value, environment: environment)
    context.append(string: "`", environment: tokenEnvironment)
}
