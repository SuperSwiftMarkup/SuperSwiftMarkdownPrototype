//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation
#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

public final class SSDocumentStorage: NSTextContentStorage {
//    private var document: SSDocument?
    private var paragraphStore: ParagraphStore?
    var _textStorage: NSTextStorage? = DocumentTextStorage()
    
//    override public func enumerateTextElements(
//        from textLocation: (any NSTextLocation)?,
//        options: NSTextContentManager.EnumerationOptions = [],
//        using block: (NSTextElement) -> Bool
//    ) -> (any NSTextLocation)? {
//        super.enumerateTextElements(from: textLocation, options: options) { elem in
//            let elem = elem as! NSTextParagraph
//            print("ELEEM", elem.debugDescription)
//            return block(elem)
//        }
//    }
    
//    override public var documentRange: NSTextRange {
//        if let paragraphStore = self.paragraphStore {
//            return paragraphStore.documentTextRange
//        }
////        if let nodes = self.document?.nodes {
////            return NSTextRange.init(location: Index.init(0), end: Index.init(nodes.count))!
////        }
//        return NSTextRange.init(location: Index.init(0))
////        return NSTextRange.init(location: Index.init(0), end: Index.init(document!.nodes.count))!
////        return self.paragraphStore!.documentTextRange
//        
////        let documentTextRange = self.paragraphStore!.documentTextRange
////        return documentTextRange
//    }
    override public func replaceContents(in range: NSTextRange, with textElements: [NSTextElement]?) {
        fatalError("TODO: WHEN IS THIS CALLED?")
    }
}

//extension SSDocumentStorage {
//    override public func enumerateTextElements(
//        from textLocation: (any NSTextLocation)?,
//        options: NSTextContentManager.EnumerationOptions = [],
//        using block: (NSTextElement) -> Bool
//    ) -> (any NSTextLocation)? {
////        let textLocation_ = textLocation.debugDescription
////        print("textLocation_", textLocation_)
////        let totalLength = self.attributedString!.length
//        let reverse = options.contains(.reverse)
//        let forward = !reverse
//        // - -
//        let textLocation = textLocation.map ({ $0 as! SSDocumentIndex }) ?? Index(0)
//        let index = textLocation.value
//        if index == 0 && reverse {
//            print(
//                "SSDocumentStorage.enumerateTextElements",
//                "location:\(index)",
//                "[\(forward ? "forward" : "backward")]",
//                separator: "\t"
//            )
//            return nil
//        }
//        // - -
////        let sequence: Array<ParagraphStore.ParagraphEntry>.SubSequence
////        let entryIndex = paragraphStore!.findParagraphBlockIndex(charIndex: index)!
//        // - -
//        guard let paragraphStore = self.paragraphStore else { return nil }
//        
//        let sequence = paragraphStore.elementsFrom(charIndex: index, reverse: reverse)
//        if sequence.isEmpty {
//            print(
//                "SSDocumentStorage.enumerateTextElements",
//                "location:\(index)",
//                "[\(forward ? "forward" : "backward")]",
//                "sequence:\(sequence.count)",
//                separator: "\t"
//            )
//        }
//        else if sequence.count == 1 {
//            print(
//                "SSDocumentStorage.enumerateTextElements",
//                "location:\(index)",
//                "[\(forward ? "forward" : "backward")]",
//                "sequence:\(sequence.count)",
//                separator: "\t"
//            )
//        } else {
//            print(
//                "SSDocumentStorage.enumerateTextElements",
//                "location:\(index)",
//                "[\(forward ? "forward" : "backward")]",
//                "sequence:\(sequence.count)",
//                separator: "\t"
//            )
//        }
//        
//        var last: ParagraphStore.ParagraphEntry? = nil
//        var terminate = false
//        if reverse {
////            fatalError("TODO")
//            for entry in sequence.reversed() {
//                if terminate {
//                    last = entry
//                    break
//                }
//                let systemTextParagraph = entry.systemTextParagraph
//                systemTextParagraph.textContentManager = self
//                let result = Continuation(fromBool: block(systemTextParagraph))
//                last = entry
//                if case .break = result {
//                    terminate = true
//                }
//            }
//        } else {
//            for entry in sequence {
//                if terminate {
//                    last = entry
//                    break
//                }
//                let systemTextParagraph = entry.systemTextParagraph
//                systemTextParagraph.textContentManager = self
//                let result = Continuation(fromBool: block(systemTextParagraph))
//                last = entry
//                if case .break = result {
//                    terminate = true
//                }
//            }
//        }
////        return reverse ? (last?.startingTextLocation) : (last?.endingTextLocation)
//        return reverse ? (last?.endingTextLocation) : (last?.startingTextLocation)
////        return last?.startingTextLocation
////        return nil
//    }
//}

extension SSDocumentStorage {
    public func read(from url: URL) throws {
        let document = try SSDocument.read(from: url)
        self.paragraphStore = ParagraphStore(fromDocument: document, textContentManager: self)
    }
    public func setDocument(document: SSDocument) {
        self.paragraphStore = ParagraphStore(fromDocument: document, textContentManager: self)
    }
//    override public var textStorage: NSTextStorage? {
//        get { _textStorage }
//        set { }
//    }
}

public final class SSDocumentIndex: NSObject, Comparable {
    internal let value: Int
    internal init(_ value: Int) {
        self.value = value
    }
    public static func < (lhs: SSDocumentIndex, rhs: SSDocumentIndex) -> Bool {
        lhs.value < rhs.value
    }
    public static func > (lhs: SSDocumentIndex, rhs: SSDocumentIndex) -> Bool {
        lhs.value > rhs.value
    }
    public static func == (lhs: SSDocumentIndex, rhs: SSDocumentIndex) -> Bool {
        lhs.value == rhs.value
    }
    public override var debugDescription: String { "SSDocumentIndex(\(value))" }
    public override var description: String { self.value.description }
}

extension SSDocumentIndex: NSTextLocation {
    public func compare(_ other: any NSTextLocation) -> ComparisonResult {
        let otherOption: (any NSTextLocation)? = other
        if otherOption == nil {
            print("Index.compare: given some nil value")
//            return ComparisonResult.init(rawValue: 10)!
//            fatalError("TODO: WHAT TO DO? nil")
            return .orderedDescending
        }
        guard let other = other as? SSDocumentIndex else {
            fatalError("TODO: WHAT TO DO? \(other.debugDescription!)")
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
        fatalError("TODO: WHAT TO DO?")
    }
}

fileprivate struct ParagraphStore {
    public let paragraphs: [ ParagraphEntry ]
    public let range: NSRange
    public init(fromDocument document: SSDocument, textContentManager: NSTextContentManager) {
        let entries = document.nodes.map { $0.attributedString(styling: .default, environment: .default) }
        var paragraphs: [ ParagraphEntry ] = []
        var indexOffset: Int = 0
        for entry in entries {
            let start = indexOffset
            let end = indexOffset + entry.length
            let textParagraph = NSTextParagraph(attributedString: entry)
            textParagraph.textContentManager = textContentManager
//            let textRange = start == indexOffset + entry.length
//                ? NSTextRange.init(location: SSDocumentIndex(start))
//                : NSTextRange(location: SSDocumentIndex(start), end: SSDocumentIndex(end))!
//            let textRange = NSTextRange.init(location: SSDocumentIndex(start))
            let textRange = NSTextRange.init(location: SSDocumentIndex(end))
//            let textRange = NSTextRange.init(
//                location: SSDocumentIndex(start),
//                end: SSDocumentIndex(end)
//            )!
            textParagraph.elementRange = textRange
            paragraphs.append(.init(start: start, end: end, content: entry, textParagraph: textParagraph))
            indexOffset = end
        }
        self.paragraphs = paragraphs
        self.range = NSRange(location: 0, length: indexOffset)
    }
    public struct ParagraphEntry {
        let start: Int
        let end: Int
        let content: NSAttributedString
        let textParagraph: NSTextParagraph
    }
}

extension ParagraphStore {
    func elementsFrom(charIndex: Int, reverse: Bool) -> [ParagraphEntry] {
        var results: [ParagraphEntry] = []
        for paragraph in self.paragraphs {
            if reverse {
                if paragraph.start <= charIndex {
                    results.append(paragraph)
                }
            } else {
                if paragraph.start >= charIndex {
                    results.append(paragraph)
                }
            }
//            if charIndex <= paragraph.start {
//                results.append(paragraph)
//            }
//            if paragraph.start >= charIndex {
//                results.append(paragraph)
//            }
        }
        if reverse {
            return results
        } else {
            return results
        }
    }
    func findParagraphBlockIndex(charIndex: Int) -> [ParagraphEntry].Index? {
        for (entryIndex, entry) in self.paragraphs.enumerated() {
            if entry.range.contains(charIndex) {
                return entryIndex
            }
        }
        return nil
    }
    var documentTextRange: NSTextRange {
//        if self.paragraphs.isEmpty {
//            return NSTextRange.init(location: SSDocumentIndex(0), end: SSDocumentIndex(0))!
//        }
//        if self.paragraphs.count == 1 {
//            return NSTextRange(
//                location: self.paragraphs.first!.startingTextLocation,
//                end: self.paragraphs.first!.endingTextLocation
//            )!
//        }
//        return NSTextRange(location: SSDocumentIndex(self.range.upperBound))
        return NSTextRange(
            location: SSDocumentIndex(0),
            end: SSDocumentIndex(self.paragraphs.last!.end)
        )!
    }
}

extension ParagraphStore.ParagraphEntry {
    var systemTextParagraph: NSTextParagraph {
//        let element = NSTextParagraph(attributedString: self.content)
////        let range = NSTextRange(location: SSDocumentIndex(self.start), end: SSDocumentIndex(self.end))!
////        let range = self.fullTextRange
//        let range = NSTextRange(location: SSDocumentIndex(self.start))
//        element.elementRange = range
//        return element
        return self.textParagraph
    }
    var range: NSRange {
        NSRange(location: start, length: end)
    }
    var startingTextLocation: SSDocumentIndex {
        SSDocumentIndex.init(self.start)
    }
    var endingTextLocation: SSDocumentIndex {
        SSDocumentIndex.init(self.end)
    }
    var fullTextRange: NSTextRange {
        NSTextRange.init(
            location: SSDocumentIndex(self.start),
            end: SSDocumentIndex(self.end)
        )!
    }
    var beginTextRange: NSTextRange {
        NSTextRange.init(location: SSDocumentIndex(self.start))
    }
}

fileprivate enum Continuation {
    case `continue`
    case `break`
    init(fromBool shouldContinue: Bool) {
        if shouldContinue {
            self = .continue
        } else {
            self = .break
        }
    }
}

public final class DocumentTextStorage: NSTextStorage {
    override public var string: String {
        get { _attributedString.string }
        set { fatalError("WHEN IS THIS CALLED?") }
    }
//    private var _string: String = ""
    private var _attributedString: NSMutableAttributedString = NSMutableAttributedString()
    public static func new(document: SSDocument) -> DocumentTextStorage {
        let textStorage = DocumentTextStorage()
//        textStorage.setAttributedString(document.attributedString(styling: .default))
        textStorage._attributedString = NSMutableAttributedString(attributedString: document.attributedString(styling: .default))
        return textStorage
    }
//    override public func setAttributedString(_ attrString: NSAttributedString) {
////        super.setAttributedString(attrString)
//        self._attributedString = NSMutableAttributedString(attributedString: attrString)
//    }
    override public func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedString.Key : Any] {
        _attributedString.attributes(at: location, effectiveRange: range)
//        let style = NSMutableParagraphStyle()
//        return [.font: XFont.systemFont(ofSize: 18), .paragraphStyle: style]
    }
//    override public func replaceCharacters(in range: NSRange, with str: String) {
//        super.replaceCharacters(in: range, with: str)
//    }
    override public var paragraphs: [NSTextStorage] {
        get { fatalError("WHEN IS THIS CALLED?") }
        set { fatalError("WHEN IS THIS CALLED?") }
    }
    override public var attributeRuns: [NSTextStorage] {
        get { fatalError("WHEN IS THIS CALLED?") }
        set { fatalError("WHEN IS THIS CALLED?") }
    }
    override public var words: [NSTextStorage] {
        get { fatalError("WHEN IS THIS CALLED?") }
        set { fatalError("WHEN IS THIS CALLED?") }
    }
    override public var characters: [NSTextStorage] {
        get { fatalError("WHEN IS THIS CALLED?") }
        set { fatalError("WHEN IS THIS CALLED?") }
    }
}
