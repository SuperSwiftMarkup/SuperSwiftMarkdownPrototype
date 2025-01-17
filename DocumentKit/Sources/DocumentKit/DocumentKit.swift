// The Swift Programming Language
// https://docs.swift.org/swift-book

//public protocol SSIndex: Equatable, Comparable {}

//public protocol SSRange {
//    associatedtype Index: SSIndex
//    var startIndex: Index { get }
//    var endIndex: Index { get }
//}

//public struct SSRange<Index: SSIndex> {
//    let startIndex: Index
//    let endIndex: Index
//}
//
////public protocol SSElementDisplaySize<Index> {
////    associatedtype Index: SSIndex
////}
//
//public protocol SSDocumentRange<Index> {
//    associatedtype Index: SSIndex
//    var range: SSRange<Index> { get }
//}
//
//protocol SSDocumentSegment {}
//
////public protocol SSIndexer {
////    func startIndex()
////    func endIndex()
////}
//public struct SSIndexer<Index: SSIndex> {
//    internal let index: Index
//}
//
////public struct SSDocumentEnumerator {}
//
//public protocol SSElementZipper<Element> {
//    associatedtype Element: SSDocumentRange
//    mutating func seek(to position: Element.Index)
//    mutating func forward() -> Self.Element?
//    mutating func backward() -> Self.Element?
//    var currentElement: Element? { get }
//    var firstElement: Element? { get }
//    var lastElement: Element? { get }
//}
//
//public protocol SSElementIterator<Element> {
//    associatedtype Element: SSDocumentRange
//    mutating func next() -> Self.Element?
//}
//

//public protocol SSElementIteratorProvider<Element> {
//    associatedtype ForwardIterator: SSElementIterator<Element>
//    associatedtype BackwardIterator: SSElementIterator<Element>
//    func makeForwardIterator(startingFrom startIndex: Element.Index) -> ForwardIterator
//    func makeBackwardIterator(startingFrom startIndex: Element.Index) -> BackwardIterator
//    associatedtype Element: SSDocumentRange
//}


//public protocol SSDocumentSource {}
//
//public struct SSElementArray<Element> {
//    public let sequence: [ Element ]
//    public struct ForwardIterator {}
//    public struct BackwardIterator {}
//}
//
//public protocol SSElementCursor<Element> {
//    associatedtype Element: SSDocumentRange
//}
//
//public protocol SSElementSequence {}


//public protocol SSDocumentSource: SSRange {}

//public struct SSDocumentWrapper<Block> {
//    
//}

//public final class SSIndexRef {
//    let current: Int
//    internal init(current: Int) {
//        self.current = current
//    }
//}

//public struct Layout {}

//public protocol ForwardElementIterator {}
//public final class DocumentRuntime {}

public protocol UnitCountable {
    var unitCount: UInt { get }
}

//public protocol LogicalUnit {}
//public protocol UnitIndexable {}

//public protocol ElementIndexable {
//    associatedtype ElementIndex
//}

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

public struct ElementArrayBuffer<Element>: ElementIteratorProvider {
    private var elements: [ Element ]
    public func makeForwardIterator(startingFrom startIndex: Index) -> ForwardIterator {
        ForwardIterator(index: startIndex, elements: elements)
    }
    public func makeBackwardIterator(startingFrom startIndex: Index) -> BackwardIterator {
        BackwardIterator(index: startIndex, elements: elements)
    }
    public struct Index: Equatable, Comparable {
        fileprivate let value: Int
        public static func < (lhs: ElementArrayBuffer<Element>.Index, rhs: ElementArrayBuffer<Element>.Index) -> Bool {
            lhs.value < rhs.value
        }
        public static func > (lhs: ElementArrayBuffer<Element>.Index, rhs: ElementArrayBuffer<Element>.Index) -> Bool {
            lhs.value > rhs.value
        }
        public static func == (lhs: ElementArrayBuffer<Element>.Index, rhs: ElementArrayBuffer<Element>.Index) -> Bool {
            lhs.value == rhs.value
        }
        fileprivate var uncheckedIncrement: Index {
            Index(value: value + 1)
        }
        fileprivate var uncheckedDecrement: Index {
            Index(value: value - 1)
        }
    }
    public struct ForwardIterator: ForwardElementIterator {
        private var index: Index
        private let elements: [ Element ]
        public mutating func next() -> Element? {
            guard index.value < elements.count else {
                return nil
            }
            let character = elements[index.value]
            index = index.uncheckedIncrement
            return character
        }
        fileprivate init(index: Index, elements: [Element]) {
            self.index = index
            self.elements = elements
        }
    }
    public struct BackwardIterator: BackwardElementIterator {
        private var index: Index
        private let elements: [ Element ]
        public mutating func next() -> Element? {
            guard index.value < elements.count else {
                return nil
            }
            guard index.value >= 0 else {
                return nil
            }
            let character = elements[index.value]
            index = index.uncheckedDecrement
            return character
        }
        fileprivate init(index: Index, elements: [Element]) {
            self.index = index
            self.elements = elements
        }
    }
}

