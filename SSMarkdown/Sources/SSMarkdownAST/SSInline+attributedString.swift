//
//  SSInline+attributedString.swift
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


extension SSInline {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .container(let x): return x.attributedString(environment: environment)
        case .leaf(let x): return x.attributedString(environment: environment)
        }
    }
}

// MARK: - INLINE CONTAINERS -

extension SSInline.Container {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .emphasis(let x): return x.attributedString(environment: environment)
        case .imageLink(let x): return x.attributedString(environment: environment)
        case .link(let x): return x.attributedString(environment: environment)
        case .strikethrough(let x): return x.attributedString(environment: environment)
        case .strong(let x): return x.attributedString(environment: environment)
        }
    }
}
extension SSInline.EmphasisNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.emphasis
        let environment = environment
            .withScope(.inline(.emphasis))
            .withEmphasis(true)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
        let systemAttributes = environment.inlineLevelSystemAttributes
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .inlineLevelSystemAttributes
        let token = NSAttributedString(string: "**", attributes: syntaxSystemAttributes)
        return self.children
            .map { $0.attributedString(environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? token : nil,
                contentStyling: systemAttributes,
                trailing: nodeStyling.showSyntax ? token : nil
            )
    }
}
extension SSInline.ImageLinkNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.imageLink
        let environment = environment
            .withScope(.inline(.imageLink))
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .inlineLevelSystemAttributes
        let link = renderLink(
            environment: environment,
            showSyntax: nodeStyling.showSyntax,
            display: self.display,
            destination: self.source,
            title: self.title
        )
        if nodeStyling.showSyntax {
            return link.with(leading: NSAttributedString(string: "!", attributes: syntaxSystemAttributes))
        }
        return link
    }
}
extension SSInline.LinkNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.link
        let environment = environment
            .withScope(.inline(.link))
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
        return renderLink(
            environment: environment,
            showSyntax: nodeStyling.showSyntax,
            display: self.display,
            destination: self.destination,
            title: self.title
        )
    }
}
extension SSInline.StrikethroughNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.strikethrough
        let environment = environment
            .withScope(.inline(.strikethrough))
            .withStrikethrough(true)
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
        let systemAttributes = environment.inlineLevelSystemAttributes
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .inlineLevelSystemAttributes
        let token = NSAttributedString(string: "~~", attributes: syntaxSystemAttributes)
        return self.children.map
        { $0.attributedString(environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? token : nil,
                contentStyling: systemAttributes,
                trailing: nodeStyling.showSyntax ? token : nil
            )
    }
}
extension SSInline.StrongNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.strong
        let environment = environment
            .withScope(.inline(.strong))
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .withStringEmphasis(true)
        let systemAttributes = environment.inlineLevelSystemAttributes
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .inlineLevelSystemAttributes
        let token = NSAttributedString(string: "***", attributes: syntaxSystemAttributes)
        return self.children.map
        { $0.attributedString(environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? token : nil,
                contentStyling: systemAttributes,
                trailing: nodeStyling.showSyntax ? token : nil
            )
    }
}

// MARK: - INLINE LEAVES -

extension SSInline.Leaf {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .inlineCode(let x): return x.attributedString(environment: environment)
        case .inlineHTML(let x): return x.attributedString(environment: environment)
        case .lineBreak(let x): return x.attributedString(environment: environment)
        case .softBreak(let x): return x.attributedString(environment: environment)
        case .symbolLink(let x): return x.attributedString(environment: environment)
        case .text(let x): return x.attributedString(environment: environment)
        }
    }
}
extension SSInline.InlineCodeNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.inlineCode
        let environment = environment
            .withScope(.inline(.inlineCode))
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
            .withForegroundColor(nodeStyling.foregroundColor)
            .withBackgroundColor(nodeStyling.backgroundColor)
        let systemAttributes = environment.inlineLevelSystemAttributes
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .inlineLevelSystemAttributes
        let token = NSAttributedString(string: "`", attributes: syntaxSystemAttributes)
        let result = NSAttributedString(string: value, attributes: systemAttributes)
        if !nodeStyling.showSyntax {
            return result
        }
        return result.wrap(open: token, close: token)
    }
}
extension SSInline.InlineHTMLNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.inlineHTML
        let environment = environment
            .withScope(.inline(.inlineHTML))
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
            .mapFont(default: nil, transform: { $0.withDesign(.monospaced) })
            .withForegroundColor(nodeStyling.foregroundColor)
            .withBackgroundColor(nodeStyling.backgroundColor)
        let systemAttributes = environment.inlineLevelSystemAttributes
        return NSAttributedString(string: value, attributes: systemAttributes)
    }
}
extension SSInline.LineBreakNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
//        let nodeStyling = styling.inline.lineBreak
        let environment = environment
            .withScope(.inline(.lineBreak))
        let systemAttributes = environment.inlineLevelSystemAttributes
        return NSAttributedString(string: environment.documentStyling.inline.lineBreak.value, attributes: systemAttributes)
    }
}
extension SSInline.SoftBreakNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
//        let nodeStyling = styling.inline.softBreak
        let environment = environment.withScope(.inline(.softBreak))
        let systemAttributes = environment.inlineLevelSystemAttributes
        return NSAttributedString(string: environment.documentStyling.inline.softBreak.value, attributes: systemAttributes)
    }
}
extension SSInline.SymbolLinkNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.symbolLink
        let environment = environment
            .withScope(.inline(.symbolLink))
            .mergeFont(nodeStyling.font, keeping: .keepLargerSize)
        let systemAttributes = environment.inlineLevelSystemAttributes
        let syntaxSystemAttributes = environment
            .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
            .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
            .inlineLevelSystemAttributes
        let token = NSAttributedString(string: "`", attributes: syntaxSystemAttributes)
        let result = NSAttributedString(string: destination ?? "", attributes: systemAttributes)
        if !nodeStyling.showSyntax {
            return result
        }
        return result.wrap(open: token, close: token)
    }
}
extension SSInline.TextNode {
    public func attributedString(environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = environment.documentStyling.inline.text
        let environment = environment
            .withScope(.inline(.text))
            .mergeFont(nodeStyling.font, ignoring: .keepLargerSize)
        let systemAttributes = environment.inlineLevelSystemAttributes
        return NSMutableAttributedString(string: value, attributes: systemAttributes)
    }
}

fileprivate func renderLink(
    environment: SSStyleEnvironment,
    showSyntax: Bool,
    display: [ SSInline ],
    destination: String?,
    title: String?
) -> NSAttributedString {
    var systemAttributes = environment.inlineLevelSystemAttributes
    if let destination = destination {
        systemAttributes[.link] = destination
    } else {
        systemAttributes[.foregroundColor] = XColor.systemTeal
    }
    let syntaxSystemAttributes = environment
        .mapFont(default: nil) { $0.withDesign(.rounded).withWeight(.light) }
        .withForegroundColor(environment.documentStyling.deemphasizedSyntaxColor)
        .inlineLevelSystemAttributes
    let display = display.map { $0.attributedString(environment: environment) }.join(
        leading: showSyntax ? NSAttributedString(string: "[", attributes: syntaxSystemAttributes) : nil,
        contentStyling: systemAttributes,
        trailing: showSyntax ? NSAttributedString(string: "]", attributes: syntaxSystemAttributes) : nil
    )
    if !showSyntax {
        return display
    }
    let destination = destination.map { NSAttributedString(string: $0) }
    let title = title.map { NSAttributedString(string: $0) }
    let ending = [ destination, title ].compactMap { $0 }.join(
        leading: showSyntax ? NSAttributedString(string: "(", attributes: syntaxSystemAttributes) : nil,
        contentStyling: systemAttributes,
        trailing: showSyntax ? NSAttributedString(string: ")", attributes: syntaxSystemAttributes) : nil
    )
    return [display, ending].join(leading: nil, contentStyling: nil, trailing: nil)
}

internal extension SSInline {
    static func processAttributedStringSequence() {
        
    }
}
