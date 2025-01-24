//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation

extension NSAttributedString {
    public typealias AttributeDictionary = [ NSAttributedString.Key : Any ]
    public static var newline: NSAttributedString { NSAttributedString.init(string: "\n") }
    public static var doubleNewline: NSAttributedString { NSAttributedString.init(string: "\n\n") }
}

extension NSAttributedString {
    public var range: NSRange {
        NSRange(location: 0, length: self.length)
    }
    public struct RangeOptions: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public static let fullRange = Self(rawValue: 1 << 1)
        public static let ignoreLeadingWhitespace = Self(rawValue: 1 << 2)
        public static let ignoreTrailingWhitespace = Self(rawValue: 1 << 3)
        public static let ignoreWhitespaceAtBothEnds: Self = [
            Self.ignoreLeadingWhitespace,
            Self.ignoreTrailingWhitespace,
        ]
    }
    public func range(options: RangeOptions) -> NSRange? {
        if options.contains(.fullRange) {
            return self.range
        }
        let startIndex = string
            .firstIndex { !$0.isWhitespace }
            .map {
                string.distance(from: string.startIndex, to: $0)
            }
        let endIndex = string
            .lastIndex { !$0.isWhitespace }
            .map {
                return string.distance(from: $0, to: string.endIndex)
            }
        if options.contains(.ignoreLeadingWhitespace) && options.contains(.ignoreTrailingWhitespace) {
            let startIndex = startIndex ?? 0
            let endIndex = endIndex ?? length
            let length = endIndex - startIndex
            let isValid = startIndex <= endIndex
            let result = NSRange(
                location: startIndex,
                length: length
            )
            if isValid {
                return result
            }
            print(
                "[FAILURE] NSAttributedString.range(options: RangeOptions) result=\(result.debugDescription)",
                "startIndex=\(startIndex.description)",
                "endIndex=\(endIndex.description)"
            )
        }
        if options.contains(.ignoreLeadingWhitespace) {
            return NSRange(location: startIndex ?? 0, length: length - (startIndex ?? 0))
        }
        return self.range
    }
}
