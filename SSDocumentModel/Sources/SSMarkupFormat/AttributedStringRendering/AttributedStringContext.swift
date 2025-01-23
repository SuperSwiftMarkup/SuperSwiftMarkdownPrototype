//
//  AttributedStringContext.swift
//
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation
import SSDMUtilities

internal struct AttributedStringContext: ~Copyable {
    private let buffer: NSMutableAttributedString = NSMutableAttributedString()
    private var currentBlock: NSMutableAttributedString = NSMutableAttributedString()
//    private var currentBlockIndex: [Int] = []
//    private var currentTypesettingEnvironment: AttributeEnvironment.TypesetEnvironment?
}

extension AttributedStringContext {
    internal mutating func append(string: String, environment: AttributeEnvironment) {
        let attributes = environment.systemAttributeDictionary(forEnvironment: .styling)
        let segment = NSAttributedString(string: string, attributes: attributes)
        currentBlock.append(segment)
    }
    internal mutating func append(lineBreak: LineBreakType, environment: AttributeEnvironment) {
        switch lineBreak {
        case .softLineBreak:
            append(string: "\n", environment: environment)
        case .hardLineBreak:
            append(string: "\n", environment: environment)
        case .paragraphBreak:
            append(string: "\n\n", environment: environment)
        }
    }
    private mutating func applyTypesettingEnvironment(environment: AttributeEnvironment) {
        let startIndex = currentBlock.string
            .firstIndex { !$0.isWhitespace }
            .map {
                currentBlock.string.distance(from: currentBlock.string.startIndex, to: $0)
//                $0.utf16Offset(in: currentBlock.string)
            }
        let range = NSRange(location: startIndex ?? 0, length: currentBlock.length - (startIndex ?? 0))
        let attributes = environment.systemAttributeDictionary(forEnvironment: .typesetting)
        currentBlock.addAttributes(attributes, range: range)
    }
    internal mutating func endBlock(lineBreak: LineBreakType, environment: AttributeEnvironment) {
        applyTypesettingEnvironment(environment: environment)
        append(lineBreak: lineBreak, environment: environment)
        buffer.append(currentBlock)
        currentBlock = NSMutableAttributedString()
    }
    internal consuming func finalize(environment: AttributeEnvironment) -> NSAttributedString {
        buffer.append(currentBlock)
        return buffer
    }
}
