//
//  SSDocumentStyling+Block.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

extension SSDocumentStyling {
    public struct Block {
        let blockQuote: BlockQuote
        let orderedList: OrderedList
        let unorderedList: UnorderedList
        let listItem: ListItem
        let table: Table
        let paragraph: Paragraph
        let heading: Heading
        let hTMLBlock: HTMLBlock
        let thematicBreak: ThematicBreak
        let codeBlock: CodeBlock
    }
}

extension SSDocumentStyling.Block {
    public struct BlockQuote {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct OrderedList {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct UnorderedList {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct ListItem {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct Table {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct Paragraph {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct Heading {
        let h1: Level
        let h2: Level
        let h3: Level
        let h4: Level
        let h5: Level
        let h6: Level
        public struct Level {
            let font: SSDocumentStyling.Font
            let foregroundColor: XColor?
            let showSyntax: Bool
        }
    }
    public struct HTMLBlock {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct ThematicBreak {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
    public struct CodeBlock {
        let font: SSDocumentStyling.Font
        let foregroundColor: XColor?
        let showSyntax: Bool
    }
}

extension SSDocumentStyling.Block.BlockQuote {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.OrderedList {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.UnorderedList {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.ListItem {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.Table {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.Paragraph {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.Heading {
    internal func styling(for level: SSBlock.HeadingNode.Level) -> SSDocumentStyling.Block.Heading.Level {
        switch level {
        case .h1: return self.h1
        case .h2: return self.h2
        case .h3: return self.h3
        case .h4: return self.h4
        case .h5: return self.h5
        case .h6: return self.h6
        }
    }
    internal func systemAttributes(for level: SSBlock.HeadingNode.Level) -> NSAttributedString.AttributeMap {
        self.styling(for: level).systemAttributes
    }
}
extension SSDocumentStyling.Block.Heading.Level {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.HTMLBlock {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.ThematicBreak {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
extension SSDocumentStyling.Block.CodeBlock {
    internal var systemAttributes: NSAttributedString.AttributeMap {
        return [ .font: self.font.systemFont ]
    }
}
