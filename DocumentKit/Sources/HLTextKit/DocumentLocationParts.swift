//
//  DocumentLocationParts.swift
//
//
//  Created by Colbyn Wadman on 1/14/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

public final class DocumentLocationParts: NSObject, NSTextLocation {
    fileprivate let elementIndex: ElementIndex
    fileprivate let displayUnitIndex: DisplayUnitIndex
    internal init(elementIndex: ElementIndex, displayUnitIndex: DisplayUnitIndex) {
        self.elementIndex = elementIndex
        self.displayUnitIndex = displayUnitIndex
    }
    public func compare(_ other: any NSTextLocation) -> ComparisonResult {
        guard let other = other as? DocumentLocationParts else {
            fatalError("TODO")
        }
        if self < other {
            return .orderedAscending
        }
        if self > other {
            return .orderedDescending
        }
        if self == other {
            return .orderedSame
        }
        assertionFailure()
        fatalError("TODO: WHAT TO DO?")
    }
}

extension DocumentLocationParts {
    public struct ElementIndex {
        fileprivate let value: Int
    }
    public struct DisplayUnitIndex {
        fileprivate let value: Int
    }
}

extension DocumentLocationParts.ElementIndex: Equatable, Comparable {
    public static func < (lhs: DocumentLocationParts.ElementIndex, rhs: DocumentLocationParts.ElementIndex) -> Bool { lhs.value < rhs.value }
    public static func > (lhs: DocumentLocationParts.ElementIndex, rhs: DocumentLocationParts.ElementIndex) -> Bool { lhs.value > rhs.value }
    public static func == (lhs: DocumentLocationParts.ElementIndex, rhs: DocumentLocationParts.ElementIndex) -> Bool { lhs.value == rhs.value }
}

extension DocumentLocationParts.DisplayUnitIndex: Equatable, Comparable {
    public static func < (lhs: DocumentLocationParts.DisplayUnitIndex, rhs: DocumentLocationParts.DisplayUnitIndex) -> Bool { lhs.value < rhs.value }
    public static func > (lhs: DocumentLocationParts.DisplayUnitIndex, rhs: DocumentLocationParts.DisplayUnitIndex) -> Bool { lhs.value > rhs.value }
    public static func == (lhs: DocumentLocationParts.DisplayUnitIndex, rhs: DocumentLocationParts.DisplayUnitIndex) -> Bool { lhs.value == rhs.value }
}

extension DocumentLocationParts: Comparable {
    private var indexRatio: IndexRatio {
        IndexRatio(sequence: elementIndex.value, subsequence: displayUnitIndex.value)
    }
    public static func < (lhs: DocumentLocationParts, rhs: DocumentLocationParts) -> Bool {
        return lhs.indexRatio < rhs.indexRatio
    }
    public static func > (lhs: DocumentLocationParts, rhs: DocumentLocationParts) -> Bool {
        return lhs.indexRatio > rhs.indexRatio
    }
    public static func == (lhs: DocumentLocationParts, rhs: DocumentLocationParts) -> Bool {
        return lhs.indexRatio == rhs.indexRatio
    }
}

fileprivate struct IndexRatio: Comparable {
    private let sequence: Int
    private let subsequence: Int
    init(sequence: Int, subsequence: Int) {
        self.sequence = sequence
        self.subsequence = subsequence
    }
    static func < (lhs: IndexRatio, rhs: IndexRatio) -> Bool {
        if lhs.sequence == rhs.sequence {
            return lhs.sequence < rhs.subsequence
        }
        return lhs.sequence < rhs.sequence
    }
    static func > (lhs: IndexRatio, rhs: IndexRatio) -> Bool {
        if lhs.sequence == rhs.sequence {
            return lhs.sequence > rhs.subsequence
        }
        return lhs.sequence > rhs.sequence
    }
    static func == (lhs: IndexRatio, rhs: IndexRatio) -> Bool {
        if lhs.sequence == rhs.sequence {
            return lhs.sequence == rhs.subsequence
        }
        return lhs.sequence == rhs.sequence
    }
}
