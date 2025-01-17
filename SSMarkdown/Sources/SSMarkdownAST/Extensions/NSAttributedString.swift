//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

extension Sequence where Element == NSAttributedString {
    internal func join(
        leading: NSAttributedString? = nil,
        contentStyling: [NSAttributedString.Key : Any]? = nil,
        trailing: NSAttributedString? = nil
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
        result.endEditing()
        return result
    }
}

extension NSAttributedString {
    internal typealias AttributeMap = [ NSAttributedString.Key : Any ]
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
}

extension NSMutableAttributedString {
    internal func between(open: NSAttributedString, close: NSAttributedString) -> NSMutableAttributedString {
        self.beginEditing()
        self.insert(open, at: 0)
        self.append(close)
        self.endEditing()
        return self
    }
}
