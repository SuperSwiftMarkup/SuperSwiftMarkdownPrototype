//
//  OptionSet.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/2/25.
//

import Foundation

extension OptionSet {
    internal func including(optional newMember: Self.Element, ifTrue condition: Bool) -> Self {
        if condition {
            var copy = self
            copy.insert(newMember)
            return copy
        }
        return self
    }
    internal func including(_ newMember: Self.Element) -> Self {
        var copy = self
        copy.insert(newMember)
        return copy
    }
//    internal func doesNotContain(other: Self) ->
}
