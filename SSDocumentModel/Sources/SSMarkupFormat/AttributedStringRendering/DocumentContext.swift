// Created by Colbyn Wadman on 2025-1-21 (ISO 8601)
//
// All SuperSwiftMarkup source code and other software material (unless
// explicitly stated otherwise) is available under a dual licensing model.
//
// Users may choose to use such under either:
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions
// of either the AGPLv3 or the commercial license, depending on the license you
// select.
//
// https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md

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
    internal mutating func push(
        tableContext: consuming TableContext,
        environment: AttributeEnvironment
    ) {
        currentBlock = tableContext.finalize(environment: environment)
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
