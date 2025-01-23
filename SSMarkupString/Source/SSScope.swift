//
//  SSScope.swift
//
//
//  Created by Colbyn Wadman on 1/19/25.
//

import Foundation

public enum SSScope: Equatable {
    case markdown(Markdown)
}

extension SSScope {
    public enum Markdown: Equatable {
        case block(Block)
    }
}

extension SSScope.Markdown {
    public enum Block: Equatable { 
        case blockQuote
        case orderedList
        case unorderedList
        case table
        case heading
        case paragraph
        case htmlBlock
        case thematicBreak
        case codeBlock
    }
}
