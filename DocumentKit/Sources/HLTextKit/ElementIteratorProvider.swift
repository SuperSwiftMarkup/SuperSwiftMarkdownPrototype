//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/14/25.
//

import Foundation

public protocol ForwardElementIterator<Element> {
    associatedtype Element
    mutating func next() -> Self.Element?
}

public protocol BackwardElementIterator<Element> {
    associatedtype Element
    mutating func next() -> Self.Element?
}

public protocol ElementIteratorProvider<Element, Index> {
    associatedtype Element
    associatedtype Index
    associatedtype ForwardIterator: ForwardElementIterator<Element>
    associatedtype BackwardIterator: BackwardElementIterator<Element>
    func makeForwardIterator(startingFrom startIndex: Index) -> ForwardIterator
    func makeBackwardIterator(startingFrom startIndex: Index) -> BackwardIterator
}
