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
}
