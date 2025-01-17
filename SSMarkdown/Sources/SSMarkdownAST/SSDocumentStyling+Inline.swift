//
//  SSDocumentStyling+Inline.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

extension SSDocumentStyling {
    public struct Inline {
        let emphasis: Emphasis
        let imageLink: ImageLink
        let link: Link
        let strikethrough: Strikethrough
        let strong: Strong
        let inlineCode: InlineCode
        let inlineHTML: InlineHTML
        let lineBreak: LineBreak
        let softBreak: SoftBreak
        let symbolLink: SymbolLink
        let text: Text
        public init(
            emphasis: Emphasis,
            imageLink: ImageLink,
            link: Link,
            strikethrough: Strikethrough,
            strong: Strong,
            inlineCode: InlineCode,
            inlineHTML: InlineHTML,
            lineBreak: LineBreak,
            softBreak: SoftBreak,
            symbolLink: SymbolLink,
            text: Text
        ) {
            self.emphasis = emphasis
            self.imageLink = imageLink
            self.link = link
            self.strikethrough = strikethrough
            self.strong = strong
            self.inlineCode = inlineCode
            self.inlineHTML = inlineHTML
            self.lineBreak = lineBreak
            self.softBreak = softBreak
            self.symbolLink = symbolLink
            self.text = text
        }
    }
}

extension SSDocumentStyling.Inline {
    public struct Emphasis {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct ImageLink {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct Link {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct Strikethrough {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct Strong {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct InlineCode {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct InlineHTML {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct LineBreak {
        let value: String
    }
    public struct SoftBreak {
        let value: String
    }
    public struct SymbolLink {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct Text {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
}

extension SSDocumentStyling.Inline.Emphasis {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.ImageLink {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.Link {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.Strikethrough {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.Strong {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.InlineCode {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.InlineHTML {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.LineBreak {}
extension SSDocumentStyling.Inline.SoftBreak {}
extension SSDocumentStyling.Inline.SymbolLink {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Inline.Text {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
