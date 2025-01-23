//
//  SSInline+attributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation
import SSDMUtilities

extension SSInline {
    internal func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
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
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
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
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        context.append(string: "!", environment: environment)
        renderLink(context: &context, environment: environment, children: display, destination: source, title: title)
    }
}
extension SSInline.LinkNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        renderLink(context: &context, environment: environment, children: display, destination: destination, title: title)
    }
}
extension SSInline.StrikethroughNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment.updateStyling { $0.with(strikethroughMode: true) }
        context.append(string: "~~", environment: environment)
        for child in self.children {
            child.attributedString(context: &context, environment: environment)
        }
        context.append(string: "~~", environment: environment)
    }
}
extension SSInline.StrongNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
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
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        let environment = environment.updateStyling { $0.with(fontDesign: .monospaced) }
        context.append(string: "`", environment: environment)
        context.append(string: value, environment: environment)
        context.append(string: "`", environment: environment)
    }
}
extension SSInline.InlineHTMLNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        renderCodeVoice(context: &context, environment: environment, value: value)
    }
}
extension SSInline.LineBreakNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
//        context.append(lineBreak: .hardLineBreak, environment: environment)
        context.append(string: " ", environment: environment)
    }
}
extension SSInline.SoftBreakNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
//        context.append(lineBreak: .softLineBreak, environment: environment)
        context.append(string: " ", environment: environment)
    }
}
extension SSInline.SymbolLinkNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        renderCodeVoice(context: &context, environment: environment, value: self.destination ?? "")
    }
}
extension SSInline.TextNode {
    fileprivate func attributedString(context: inout AttributedStringContext, environment: AttributeEnvironment) {
        context.append(string: value, environment: environment)
    }
}

// MARK: - INTERNAL HELPERS -
fileprivate func renderLink(
    context: inout AttributedStringContext,
    environment: AttributeEnvironment,
    children: [ SSInline ]?,
    destination: String?,
    title: String?
) {
    let tokenEnvironment = environment.updateStyling {
        $0  .with(fontWeight: .light)
    }
    let linkEnvironment = environment.updateStyling {
        $0  .with(fontWeight: .light)
//            .with(fontDesign: .monospaced)
            .mapFontSize { $0 * 0.9 }
            .with(fontDesign: .default)
            .with(foregroundColor: SSColorMap(
                light: {#colorLiteral(red: 0, green: 0.4035420405, blue: 1, alpha: 1)},
                dark: {#colorLiteral(red: 0, green: 0.4035420405, blue: 1, alpha: 1)}
            ))
            .with(fontWidth: .condensed)
    }
    if let children = children {
        context.append(string: "[", environment: tokenEnvironment)
        for child in children {
            child.attributedString(context: &context, environment: environment)
        }
        context.append(string: "]", environment: tokenEnvironment)
    }
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

fileprivate func renderCodeVoice(
    context: inout AttributedStringContext,
    environment: AttributeEnvironment,
    value: String
) {
    context.append(string: "`", environment: environment)
    context.append(string: value, environment: environment)
    context.append(string: "`", environment: environment)
}
