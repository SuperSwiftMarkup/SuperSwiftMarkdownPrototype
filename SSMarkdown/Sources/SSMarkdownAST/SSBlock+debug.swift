//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation
import SwiftPrettyTree

extension SSBlock: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .blockContainer(let x): return x.asPrettyTree
        case .inlineContainer(let x): return x.asPrettyTree
        case .leaf(let x): return x.asPrettyTree
        }
    }
}

extension SSBlock.BlockContainerBlock: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .blockQuote(let x): return x.asPrettyTree
        case .orderedList(let x): return x.asPrettyTree
        case .unorderedList(let x): return x.asPrettyTree
        case .table(let x): return x.asPrettyTree
        }
    }
}
extension SSBlock.BlockQuoteNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = children.map { $0.asPrettyTree }
        return .init(label: "BlockQuoteNode", children: children)
    }
}
extension SSBlock.OrderedListNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = items.map { $0.asPrettyTree }
        return .init(label: "OrderedListNode", children: children)
    }
}
extension SSBlock.UnorderedListNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = items.map { $0.asPrettyTree }
        return .init(label: "UnorderedListNode", children: children)
    }
}
extension SSBlock.TableNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let head = head.asPrettyTree
        let alignments = alignments.map {
            switch $0 {
            case .some(let x): return x.asPrettyTree
            case .none: return PrettyTree(value: "nil")
            }
        }
        let body = body.asPrettyTree
        return .init(label: "TableNode", children: [
            .init(label: "head", children: [head]),
            .init(label: "alignments", children: alignments),
            .init(label: "body", children: [body]),
        ])
    }
}
extension SSBlock.TableNode.Head: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(key: "TableNode.Head", value: self.row)
    }
}
extension SSBlock.TableNode.Body: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let rows = self.rows.map { $0.asPrettyTree }
        return .init(label: "TableNode.Body", children: rows)
    }
}
extension SSBlock.TableNode.Row: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let cells = self.cells.map { $0.asPrettyTree }
        return .init(label: "TableNode.Row", children: cells)
    }
}
extension SSBlock.TableNode.Cell: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let contents = self.children.map { $0.asPrettyTree }
        return .init(label: "TableNode.Cell", children: contents)
    }
}
extension SSBlock.TableNode.ColumnAlignment: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .center: return PrettyTree(value: "ColumnAlignment.center")
        case .left: return PrettyTree(value: "ColumnAlignment.left")
        case .right: return PrettyTree(value: "ColumnAlignment.right")
        }
    }
}
extension SSBlock.ListItemNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = self.children.map { $0.asPrettyTree }
        let label: String
        if let checkbox = self.checkbox.map({ $0.string }) {
            label = "ListItemNode[\(checkbox)]"
        } else {
            label = "ListItemNode"
        }
//        if children.isEmpty {
//            return PrettyTree(value: label)
//        }
//        if children.count == 1, case .branch(let branch) = children.first!.asPrettyTree {
////            let label = "\(label) ▷ \(branch)"
//            return .init(label: label, children: <#T##[PrettyTree]#>)
//        }
        return PrettyTree(label: label, children: children)
    }
}
extension SSBlock.ListItemNode.Checkbox: ToPrettyTree {
    public var asPrettyTree: PrettyTree { PrettyTree(value: string) }
    public var string: String {
        switch self {
        case .checked: return "checked"
        case .unchecked: return "unchecked"
        }
    }
}
extension SSBlock.InlineContainerBlock: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .heading(let x): return x.asPrettyTree
        case .paragraph(let x): return x.asPrettyTree
        }
    }
}
extension SSBlock.ParagraphNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = children.map { $0.asPrettyTree }
        return .init(label: "ParagraphNode", children: children)
    }
}
extension SSBlock.HeadingNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        let children = children.map { $0.asPrettyTree }
        return .init(label: "HeadingNode", children: children)
    }
}
extension SSBlock.LeafBlock: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        switch self {
        case .htmlBlock(let x): return x.asPrettyTree
        case .thematicBreak(let x): return x.asPrettyTree
        case .codeBlock(let x): return x.asPrettyTree
        }
    }
}
extension SSBlock.HTMLBlockNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(key: "HTMLBlockNode", value: self.rawHTML)
    }
}
extension SSBlock.ThematicBreakNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(value: "ThematicBreakNode")
    }
}
extension SSBlock.CodeBlockNode: ToPrettyTree {
    public var asPrettyTree: PrettyTree {
        return .init(key: "CodeBlockNode", value: code)
    }
}
