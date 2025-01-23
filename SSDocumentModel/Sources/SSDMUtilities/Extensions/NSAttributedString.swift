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
    public var range: NSRange { NSRange(location: 0, length: self.length) }
    public struct RangeOptions: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public static let ignoreLeadingWhitespace = Self(rawValue: 1 << 1)
        public static let ignoreTrailingWhitespace = Self(rawValue: 1 << 2)
        public static let ignoreWhitespaceAtBothEnds: Self = [ Self.ignoreLeadingWhitespace, Self.ignoreTrailingWhitespace ]
    }
    public func range(options: RangeOptions) -> NSRange {
        let startIndex = string
            .firstIndex { !$0.isWhitespace }
            .map {
                string.distance(from: string.startIndex, to: $0)
            }
        let endIndex = string
            .lastIndex { !$0.isWhitespace }
            .map {
                string.distance(from: $0, to: string.endIndex)
            }
        if options.contains(.ignoreLeadingWhitespace) && options.contains(.ignoreTrailingWhitespace) {
            return NSRange(
                location: startIndex ?? 0,
                length: (endIndex ?? length) - (startIndex ?? 0)
            )
        }
        if options.contains(.ignoreLeadingWhitespace) {
            return NSRange(location: startIndex ?? 0, length: length - (startIndex ?? 0))
        }
        return self.range
    }
}
