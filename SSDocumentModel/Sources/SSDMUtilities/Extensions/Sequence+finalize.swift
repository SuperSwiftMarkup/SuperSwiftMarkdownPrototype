//
//  Extensions/Sequence+finalize.swift
//
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation

extension Sequence {
    public func finalize<Into: FromSequence>(as type: Into.Type) -> Into where Into.Element == Self.Element {
        return Into.init(fromSequence: self)
    }
}

public protocol FromSequence {
    init(fromSequence sequence: some Sequence<Element>)
    associatedtype Element
}

extension Array: FromSequence {
    public init(fromSequence sequence: some Sequence<Element>) {
        self.init(sequence)
    }
    public typealias Element = Self.Element
}

extension ContiguousArray: FromSequence {
    public init(fromSequence sequence: some Sequence<Element>) {
        self.init(sequence)
    }
    public typealias Element = Self.Element
}


fileprivate func example() {
    func wantsArray(array: [Int]) {
        print("given:", array.debugDescription)
    }
    func wantsContiguousArray(array: ContiguousArray<Int>) {
        print("given:", array.debugDescription)
    }
    
    let valuesIterator: IndexingIterator<Array<Int>> = [1, 2, 3, 4, 5, 6].makeIterator()
    
    // MARK: THIS DOES NOT WORK:
    // wantsArray(array: values)
    //                   ^^^^^^
    // TYPE ERROR:
    // Cannot convert value of type 'IndexingIterator<Array<Int>>' to expected argument type '[Int]'
    
    // MARK: But the following works:
    
    wantsArray(array: valuesIterator.finalize(as: Array.self)) // GOOD
    
    wantsContiguousArray(array: valuesIterator.finalize(as: ContiguousArray.self)) // GOOD
}
