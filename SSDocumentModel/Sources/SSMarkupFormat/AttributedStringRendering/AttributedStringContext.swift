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
    private var currentBlockIndex: [Int] = []
    private var currentTypesettingEnvironment: AttributeEnvironment.TypesetEnvironment?
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
//        if let currentTypesettingEnvironment = currentTypesettingEnvironment {
//            currentBlock.addAttributes(currentTypesettingEnvironment.systemAttributeDictionary, range: currentBlock.range)
//            return
//        }
        let attributes = currentTypesettingEnvironment?.systemAttributeDictionary
            ?? environment.systemAttributeDictionary(forEnvironment: .typesetting)
        let range: NSRange
        if let currentBlockIndex = currentBlockIndex.last {
            range = NSRange.init(
                location: currentBlockIndex,
                length: currentBlock.length - currentBlockIndex
            )
        } else {
            range = currentBlock.range
        }
        currentBlock.addAttributes(attributes, range: range)
//        currentBlock.addAttributes(attributes, range: currentBlock.range)
    }
    internal consuming func finalize(environment: AttributeEnvironment) -> NSAttributedString {
        buffer.append(currentBlock)
        return buffer
    }
    internal mutating func beginNewBlock(environment: AttributeEnvironment) {
        currentBlockIndex.append(currentBlock.length)
//        environment.setCurrentTypesettingEnvironment(context: &self)
    }
    internal mutating func endCurrentBlock(environment: AttributeEnvironment) {
        if !self.currentBlock.string.isEmpty {
            applyTypesettingEnvironment(environment: environment)
            buffer.append(currentBlock)
            currentBlock = NSMutableAttributedString()
        }
        let _ = currentBlockIndex.removeLast()
//        environment.setCurrentTypesettingEnvironment(context: &self)
    }
    internal mutating func setCurrentTypesettingEnvironment(
        _ currentTypesettingEnvironment: AttributeEnvironment.TypesetEnvironment
    ) {
        self.currentTypesettingEnvironment = currentTypesettingEnvironment
    }
    internal mutating func clearCurrentTypesettingEnvironment() {
        self.currentTypesettingEnvironment = nil
    }
}
