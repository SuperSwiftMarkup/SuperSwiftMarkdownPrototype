//
//  Extensions/String.swift
//
//
//  Created by Colbyn Wadman on 3/26/24.
//
// https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md
//

import Foundation

extension String {
    public func truncate(limit: Int) -> String {
        if self.count > limit {
            let trimmed = self.prefix(limit)
            if trimmed.starts(with: "\"") {
                return "\(trimmed)\"…"
            }
            return String("\(trimmed)…")
        }
        return self
    }
}

extension String {
    public enum TruncationPosition {
        case head
        case middle
        case tail
    }
}

extension String {
    public func truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "…") -> String {
        // If the current string length is within the limit, return the string itself
        guard self.count > limit else { return self }

        // Ensure that the limit is always positive after adjusting for the leader's length
        let effectiveLimit = max(0, limit - leader.count)

        switch position {
        case .head:
            // For the head, we take the last part of the string after the leader
            let tailLength = min(effectiveLimit, self.count)
            return "\(leader)\(self.suffix(tailLength))"
        case .middle:
            // For the middle, we split the limit (adjusted for leader length) between the start and end
            let halfLimit = effectiveLimit / 2
            let headLength = halfLimit
            // Adjust the tail length in case of an odd effectiveLimit
            let tailLength = effectiveLimit - headLength
            return "\(self.prefix(headLength))\(leader)\(self.suffix(tailLength))"
        case .tail:
            // For the tail, we simply take the prefix of the string before adding the leader
            let headLength = min(effectiveLimit, self.count)
            return "\(self.prefix(headLength))\(leader)"
        }
    }
}



internal extension String {
    func with(append trailing: String) -> String {
        var copy = self
        copy.append(trailing)
        return copy
    }
    var asAttributedString: NSAttributedString {
        NSAttributedString(string: self)
    }
    var asMutableAttributedString: NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
//    func intoAttributedString(attributes: NSAttributedString.AttributeMap) -> NSAttributedString {
//        NSAttributedString(string: self, attributes: attributes)
//    }
//    func intoMutableAttributedString(attributes: NSAttributedString.AttributeMap) -> NSMutableAttributedString {
//        NSMutableAttributedString(string: self, attributes: attributes)
//    }
}

