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
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .container(let x): return x.attributedString(styling: styling, environment: environment)
        case .leaf(let x): return x.attributedString(styling: styling, environment: environment)
        }
    }
}

// MARK: - INLINE CONTAINERS -

extension SSInline.Container {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .emphasis(let x): return x.attributedString(styling: styling, environment: environment)
        case .imageLink(let x): return x.attributedString(styling: styling, environment: environment)
        case .link(let x): return x.attributedString(styling: styling, environment: environment)
        case .strikethrough(let x): return x.attributedString(styling: styling, environment: environment)
        case .strong(let x): return x.attributedString(styling: styling, environment: environment)
        }
    }
}
extension SSInline.EmphasisNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.emphasis
        let token = NSAttributedString(string: "**", attributes: nodeStyling.systemAttributes)
        return self.children.map
        { $0.attributedString(styling: styling, environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? token : nil,
                contentStyling: nodeStyling.systemAttributes,
                trailing: nodeStyling.showSyntax ? token : nil
            )
    }
}
extension SSInline.ImageLinkNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.imageLink
        let systemAttributes = nodeStyling.systemAttributes
        let display = display.map { $0.attributedString(styling: styling, environment: environment) }.join(
            leading: nodeStyling.showSyntax ? NSAttributedString(string: "![", attributes: systemAttributes) : nil,
            contentStyling: systemAttributes,
            trailing: nodeStyling.showSyntax ? NSAttributedString(string: "]", attributes: systemAttributes) : nil
        )
        let destination = source.map { NSAttributedString(string: $0) }
        let title = title.map { NSAttributedString(string: $0) }
        let ending = [ destination, title ].compactMap { $0 }.join(
            leading: nodeStyling.showSyntax ? NSAttributedString(string: "(", attributes: systemAttributes) : nil,
            contentStyling: systemAttributes,
            trailing: nodeStyling.showSyntax ? NSAttributedString(string: ")", attributes: systemAttributes) : nil
        )
        return [display, ending].join(leading: nil, contentStyling: nil, trailing: nil)
    }
}
extension SSInline.LinkNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.link
        let systemAttributes = nodeStyling.systemAttributes
        let display = display.map { $0.attributedString(styling: styling, environment: environment) }.join(
            leading: nodeStyling.showSyntax ? NSAttributedString(string: "[", attributes: systemAttributes) : nil,
            contentStyling: systemAttributes,
            trailing: nodeStyling.showSyntax ? NSAttributedString(string: "]", attributes: systemAttributes) : nil
        )
        let destination = destination.map { NSAttributedString(string: $0) }
        let title = title.map { NSAttributedString(string: $0) }
        let ending = [ destination, title ].compactMap { $0 }.join(
            leading: nodeStyling.showSyntax ? NSAttributedString(string: "(", attributes: systemAttributes) : nil,
            contentStyling: systemAttributes,
            trailing: nodeStyling.showSyntax ? NSAttributedString(string: ")", attributes: systemAttributes) : nil
        )
        return [display, ending].join(leading: nil, contentStyling: nil, trailing: nil)
    }
}
extension SSInline.StrikethroughNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.strikethrough
        let systemAttributes = nodeStyling.systemAttributes
        let token = NSAttributedString(string: "~~", attributes: systemAttributes)
        return self.children.map
        { $0.attributedString(styling: styling, environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? token : nil,
                contentStyling: systemAttributes,
                trailing: nodeStyling.showSyntax ? token : nil
            )
    }
}
extension SSInline.StrongNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.strong
        let systemAttributes = nodeStyling.systemAttributes
        let token = NSAttributedString(string: "***", attributes: systemAttributes)
        return self.children.map
        { $0.attributedString(styling: styling, environment: environment) }
            .join(
                leading: nodeStyling.showSyntax ? token : nil,
                contentStyling: systemAttributes,
                trailing: nodeStyling.showSyntax ? token : nil
            )
    }
}

// MARK: - INLINE LEAVES -

extension SSInline.Leaf {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        switch self {
        case .inlineCode(let x): return x.attributedString(styling: styling, environment: environment)
        case .inlineHTML(let x): return x.attributedString(styling: styling, environment: environment)
        case .lineBreak(let x): return x.attributedString(styling: styling, environment: environment)
        case .softBreak(let x): return x.attributedString(styling: styling, environment: environment)
        case .symbolLink(let x): return x.attributedString(styling: styling, environment: environment)
        case .text(let x): return x.attributedString(styling: styling, environment: environment)
        }
    }
}
extension SSInline.InlineCodeNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.inlineCode
        let systemAttributes = nodeStyling.systemAttributes
        let token = NSAttributedString(string: "`", attributes: systemAttributes)
        let result = NSAttributedString(string: value, attributes: systemAttributes)
        if !nodeStyling.showSyntax {
            return result
        }
        return result.wrap(open: token, close: token)
    }
}
extension SSInline.InlineHTMLNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        return NSAttributedString(string: value, attributes: styling.inline.inlineHTML.systemAttributes)
    }
}
extension SSInline.LineBreakNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        return NSAttributedString(string: styling.inline.lineBreak.value, attributes: nil)
    }
}
extension SSInline.SoftBreakNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        return NSAttributedString(string: styling.inline.softBreak.value, attributes: nil)
    }
}
extension SSInline.SymbolLinkNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.symbolLink
        let systemAttributes = nodeStyling.systemAttributes
        let token = NSAttributedString(string: "`", attributes: systemAttributes)
        let result = NSAttributedString(string: destination ?? "", attributes: systemAttributes)
        if !nodeStyling.showSyntax {
            return result
        }
        return result.wrap(open: token, close: token)
    }
}
extension SSInline.TextNode {
    public func attributedString(styling: SSDocumentStyling, environment: SSStyleEnvironment) -> NSAttributedString {
        let nodeStyling = styling.inline.text
        return NSMutableAttributedString(string: value, attributes: nodeStyling.systemAttributes)
    }
}
