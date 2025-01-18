//
//  Extensions/String.swift
//
//
//  Created by Colbyn Wadman on 1/17/25.
//

import Foundation

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
    func intoAttributedString(attributes: NSAttributedString.AttributeMap) -> NSAttributedString {
        NSAttributedString(string: self, attributes: attributes)
    }
    func intoMutableAttributedString(attributes: NSAttributedString.AttributeMap) -> NSMutableAttributedString {
        NSMutableAttributedString(string: self, attributes: attributes)
    }
    
}
