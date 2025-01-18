//
//  Extensions/Array.swift
//  
//
//  Created by Colbyn Wadman on 1/16/25.
//

import Foundation

extension Array {
    internal func with(append newElement: Element) -> Self {
        var copy = self
        copy.append(newElement)
        return copy
    }
}
