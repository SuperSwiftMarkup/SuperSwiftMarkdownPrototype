//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation
import SwiftPrettyTree

extension SSInline: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .container(let x): return x.asPrettyTree
        case .leaf(let x): return x.asPrettyTree
        }
    }
}
extension SSInline.Container: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .emphasis(let x): return x.asPrettyTree
        case .imageLink(let x): return x.asPrettyTree
        case .link(let x): return x.asPrettyTree
        case .strikethrough(let x): return x.asPrettyTree
        case .strong(let x): return x.asPrettyTree
        }
    }
}
extension SSInline.EmphasisNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = children.map { $0.asPrettyTree }
        return .init(label: "EmphasisNode", children: children)
    }
}
extension SSInline.ImageLinkNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let display = self.display.map { $0.asPrettyTree }
        let source = self.source?.asPrettyTree ?? PrettyTree(value: "nil")
        let title = self.title?.asPrettyTree ?? PrettyTree(value: "nil")
        return .init(label: "ImageLinkNode", children: [
            .init(key: "display", value: display),
            .init(key: "source", value: source),
            .init(key: "title", value: title),
        ])
    }
}
extension SSInline.LinkNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let display = self.display.map { $0.asPrettyTree }
        let source = self.destination?.asPrettyTree ?? PrettyTree(value: "nil")
        let title = self.title?.asPrettyTree ?? PrettyTree(value: "nil")
        return .init(label: "LinkNode", children: [
            .init(key: "display", value: display),
            .init(key: "source", value: source),
            .init(key: "title", value: title),
        ])
    }
}
extension SSInline.StrikethroughNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = children.map { $0.asPrettyTree }
        return .init(label: "StrikethroughNode", children: children)
    }
}
extension SSInline.StrongNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = children.map { $0.asPrettyTree }
        return .init(label: "StrongNode", children: children)
    }
}
extension SSInline.Leaf: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .inlineCode(let x): return x.asPrettyTree
        case .inlineHTML(let x): return x.asPrettyTree
        case .lineBreak(let x): return x.asPrettyTree
        case .softBreak(let x): return x.asPrettyTree
        case .symbolLink(let x): return x.asPrettyTree
        case .text(let x): return x.asPrettyTree
        }
    }
}
extension SSInline.InlineCodeNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(key: "InlineCodeNode", value: value)
    }
}
extension SSInline.InlineHTMLNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(key: "InlineHTMLNode", value: value)
    }
}
extension SSInline.LineBreakNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(value: "LineBreakNode")
    }
}
extension SSInline.SoftBreakNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(value: "SoftBreakNode")
    }
}
extension SSInline.SymbolLinkNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(key: "SymbolLinkNode", value: destination ?? "nil")
    }
}
extension SSInline.TextNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(string: self.value)
    }
}


