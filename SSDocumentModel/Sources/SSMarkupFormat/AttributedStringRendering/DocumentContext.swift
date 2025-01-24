//
//  AttributedStringContext.swift
//
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation
import SSDMUtilities

internal struct DocumentContext: ~Copyable {
    private let buffer: NSMutableAttributedString = NSMutableAttributedString()
    private var currentBlock: NSMutableAttributedString = NSMutableAttributedString()
//    private var currentBlockIndex: [Int] = []
//    private var currentTypesettingEnvironment: AttributeEnvironment.TypesetEnvironment?
}

extension DocumentContext {
    internal mutating func append(string: String, environment: AttributeEnvironment) {
        let attributes = environment.systemAttributeDictionary(forEnvironment: .styling)
        let segment = NSAttributedString(string: string, attributes: attributes)
        currentBlock.append(segment)
    }
    internal mutating func append(lineBreak: LineBreakType, environment: AttributeEnvironment) {
        let isEmpty = self.currentBlock.string.isEmpty
        switch lineBreak {
        case .softLineBreak:
            append(string: "\n", environment: environment)
        case .hardLineBreak:
            append(string: "\n", environment: environment)
        case .paragraphBreak:
            append(string: "\n\n", environment: environment)
        }
    }
    internal mutating func push(
        paragraphState: consuming ParagraphState,
        environment: AttributeEnvironment,
        endingLineBreak: LineBreakType?
    ) {
        currentBlock = paragraphState.finalize(environment: environment, preceeding: currentBlock)
    }
    private mutating func applyTypesettingEnvironment(environment: AttributeEnvironment) {
        let attributes = environment.systemAttributeDictionary(forEnvironment: .typesetting)
        currentBlock.range(options: .ignoreWhitespaceAtBothEnds).map {
            currentBlock.addAttributes(attributes, range: $0)
        }
    }
    internal mutating func endBlock(lineBreak: LineBreakType?, environment: AttributeEnvironment, typesetBlock: Bool) {
        if let lineBreak = lineBreak {
            append(lineBreak: lineBreak, environment: environment)
        }
        if typesetBlock {
            applyTypesettingEnvironment(environment: environment)
        }
        if !currentBlock.string.isEmpty {
            currentBlock.annotate(blockScopes: environment.blockScopes)
            buffer.append(currentBlock)
        }
        currentBlock = NSMutableAttributedString()
    }
    internal consuming func finalize(environment: AttributeEnvironment) -> NSAttributedString {
        applyTypesettingEnvironment(environment: environment)
        buffer.append(currentBlock)
        return buffer
    }
}
