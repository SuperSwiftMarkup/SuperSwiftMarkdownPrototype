//
//  Extensions/Array.swift
//
//
//  Created by Colbyn Wadman on 1/16/25.
//

import Foundation

extension Array {
    public func with(append newElement: Element) -> Self {
        var copy = self
        copy.append(newElement)
        return copy
    }
    public func with<S: Sequence>(extend sequence: S) -> Self where S.Element == Element {
        var copy = self
        copy.append(contentsOf: sequence)
        return copy
    }
}
