//
//  Extensions/NSAttributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

extension Sequence where Element == NSAttributedString {
    internal func join(
        leading: NSAttributedString? = nil,
        contentStyling: [NSAttributedString.Key : Any]? = nil,
        trailing: NSAttributedString? = nil,
        finalizeWith finalize: ((NSMutableAttributedString) -> ())? = nil
    ) -> NSAttributedString {
        let result = NSMutableAttributedString.init()
        result.beginEditing()
        for element in self {
            result.append(element)
        }
        if let contentStyling = contentStyling {
            result.addAttributes(contentStyling, range: result.range)
        }
        if let leading = leading {
            result.insert(leading, at: 0)
        }
        if let trailing = trailing {
            result.append(trailing)
        }
        if let finalize = finalize {
            finalize(result)
        }
        result.endEditing()
        return result
    }
    internal func concat(withAttributes attributes: NSAttributedString.AttributeMap?) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.beginEditing()
        for element in self {
            result.append(element)
        }
        if let attributes = attributes {
            result.addAttributes(attributes, range: result.range)
        }
        result.endEditing()
        return result
    }
}


extension Collection where Element == NSAttributedString {
    internal func join(
        startWith: NSAttributedString? = nil,
        separatedBy separator: NSAttributedString,
        endWith: NSAttributedString? = nil
    ) -> NSAttributedString {
        let result = NSMutableAttributedString.init()
        result.beginEditing()
        if let startWith = startWith {
            result.append(startWith)
        }
        for (index, element) in self.enumerated() {
            let isLast = (index + 1) == self.count
            if isLast {
                result.append(element)
            } else {
                result.append(element)
                result.append(separator)
            }
        }
        if let endWith = endWith {
            result.append(endWith)
        }
        result.endEditing()
        return result
    }
    internal func join(separatedBy separator: String ) -> NSAttributedString {
        self.join(separatedBy: NSAttributedString(string: separator))
    }
}

extension NSAttributedString {
    internal typealias AttributeMap = [ NSAttributedString.Key : Any ]
    internal static var newline: NSAttributedString { NSAttributedString.init(string: "\n") }
    internal static var doubleNewline: NSAttributedString { NSAttributedString.init(string: "\n\n") }
}

extension NSAttributedString {
    internal var range: NSRange { NSRange.init(location: 0, length: length) }
    internal static func styling(
        _ map: [ NSAttributedString.Key : Any ]
    ) -> [ NSAttributedString.Key : Any ] {
        map
    }
    internal func wrap(open: NSAttributedString, close: NSAttributedString) -> NSMutableAttributedString {
        let value = NSMutableAttributedString.init(attributedString: self)
        value.beginEditing()
        value.insert(open, at: 0)
        value.append(close)
        value.endEditing()
        return value
    }
    internal func with(append trailing: NSAttributedString) -> NSAttributedString {
        let new = NSMutableAttributedString(attributedString: self)
        new.append(trailing)
        return new
    }
    internal func with(leading preceding: NSAttributedString) -> NSAttributedString {
        let new = NSMutableAttributedString(attributedString: self)
        new.insert(preceding, at: 0)
        return new
    }
    internal func with(append trailing: String) -> NSAttributedString {
        let new = NSMutableAttributedString(attributedString: self)
        new.append(NSAttributedString(string: trailing))
        return new
    }
    internal func with(attributes: [ NSAttributedString.Key : Any ]) -> NSAttributedString {
        let new = NSMutableAttributedString(attributedString: self)
        new.addAttributes(attributes, range: self.range)
        return new
    }
    internal func withAttribute(key: NSAttributedString.Key, value: Any) -> NSAttributedString {
        let new = NSMutableAttributedString(attributedString: self)
        new.addAttribute(key, value: value, range: new.range)
        return new
    }
}

extension NSMutableAttributedString {
    internal func between(open: NSAttributedString, close: NSAttributedString) -> NSMutableAttributedString {
        self.beginEditing()
        self.insert(open, at: 0)
        self.append(close)
        self.endEditing()
        return self
    }
    @discardableResult
    internal func add(attributes: NSAttributedString.AttributeMap) -> NSMutableAttributedString {
        self.addAttributes(attributes, range: range)
        return self
    }
}
