//
//  DocumentIndexable.swift
//
//
//  Created by Colbyn Wadman on 1/14/25.
//

import Foundation

public protocol DocumentIndexer<Element, Index> {
    associatedtype Element
    associatedtype Index
}
