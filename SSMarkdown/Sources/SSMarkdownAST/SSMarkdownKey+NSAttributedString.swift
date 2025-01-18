//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/17/25.
//

import Foundation

internal extension NSAttributedString {
    func annotate(markdownBlockType type: SSMarkdownKey.BlockType) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        copy.addAttribute(.markdownBlockType, value: type, range: range)
        return copy
    }
}

public extension NSAttributedString {
    func isOfType(markdownBlockType targetType: SSMarkdownKey.BlockType) -> Bool {
        var options: Set<SSMarkdownKey.BlockType> = []
        self.enumerateAttribute(.markdownBlockType, in: range, options: []) { value, range, _ in
            if let value = value as? SSMarkdownKey.BlockType {
                options.insert(value)
            }
            if let value = value as? String, let target = SSMarkdownKey.BlockType.init(rawValue: value) {
                options.insert(target)
            }
        }
        return options.contains(targetType)
    }
}
