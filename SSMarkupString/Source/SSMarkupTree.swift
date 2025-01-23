//
//  SSMarkupTree.swift
//
//
//  Created by Colbyn Wadman on 1/19/25.
//

import Foundation

public indirect enum SSMarkupTree {
    case displayString(DisplayString)
    case lineBreak(LineBreakType)
    case scope(SSScope, SSMarkupTree)
    case style([SSStyle], SSMarkupTree)
    case indent(BlockIndentMode, SSMarkupTree)
    case fragment([SSMarkupTree])
}

extension SSMarkupTree {
    public enum DisplayString {
        case text(String)
        case token(String)
        case preformatted(String)
    }
}

extension SSMarkupTree {
    public enum LineBreakType {
        case softLineBreak
        case hardLineBreak
        case paragraphBreak
    }
}

extension SSMarkupTree {
    public struct LayoutBlock {}
    public enum BlockIndentMode {
        case whole(ratio: SSRatio)
        case trailing(ratio: SSRatio)
    }
}
