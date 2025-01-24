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
        environment: AttributeEnvironment
    ) {
        currentBlock = paragraphState.finalize(environment: environment, initial: currentBlock)
    }
    private mutating func applyTypesettingEnvironment(
        environment: AttributeEnvironment,
        typesetRange: NSAttributedString.RangeOptions
    ) {
        let attributes = environment.systemAttributeDictionary(forEnvironment: .typesetting)
        currentBlock.range(options: typesetRange).map {
            currentBlock.addAttributes(attributes, range: $0)
        }
    }
    internal mutating func endBlock(
        lineBreak: LineBreakType?,
        environment: AttributeEnvironment,
        typesetBlock: Bool,
        typesetRange: NSAttributedString.RangeOptions? = nil
    ) {
        if let lineBreak = lineBreak {
            append(lineBreak: lineBreak, environment: environment)
        }
        if typesetBlock {
            applyTypesettingEnvironment(
                environment: environment,
                typesetRange: typesetRange ?? NSAttributedString.RangeOptions.ignoreWhitespaceAtBothEnds
            )
        }
        if !currentBlock.string.isEmpty {
            currentBlock.annotate(blockScopes: environment.blockScopes)
            buffer.append(currentBlock)
        }
        currentBlock = NSMutableAttributedString()
    }
    internal consuming func finalize(environment: AttributeEnvironment) -> NSAttributedString {
        applyTypesettingEnvironment(environment: environment, typesetRange: .ignoreWhitespaceAtBothEnds)
        buffer.append(currentBlock)
        return buffer
    }
}
