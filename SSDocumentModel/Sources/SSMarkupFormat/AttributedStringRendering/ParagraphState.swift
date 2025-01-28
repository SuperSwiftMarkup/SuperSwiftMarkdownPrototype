//
//  ParagraphState.swift
//
//
//  Created by Colbyn Wadman on 1/23/25.
//
// LICENSE file: https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md
//
// The code herein is distributed under a dual licensing model. Users may choose to use such under either:
//
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions of either the AGPLv3 or the commercial license, depending on the license you select.

import Foundation

internal struct ParagraphState: ~Copyable {
    private var lines: [NSAttributedString] = []
    private var current: NSMutableAttributedString = NSMutableAttributedString()
//    struct Configuration {
//        let singleLineMode
//    }
}

extension ParagraphState {
    internal mutating func append(string: String, environment: AttributeEnvironment) {
        let attributes = environment.systemAttributeDictionary(forEnvironment: .styling)
        self.current.append(NSAttributedString(string: string, attributes: attributes))
    }
    internal mutating func append(lineBreak: LineBreakType, environment: AttributeEnvironment) {
        lines.append(current)
        current = NSMutableAttributedString()
    }
    internal consuming func finalize(
        environment: AttributeEnvironment,
        initial: NSAttributedString?
    ) -> NSMutableAttributedString {
        // - -
        lines.append(current)
        current = NSMutableAttributedString()
        // - -
        let output: NSMutableAttributedString = initial.map { NSMutableAttributedString(attributedString: $0) } ?? NSMutableAttributedString()
        // - -
        let baseAttributes = environment
            .systemAttributeDictionary(forEnvironment: .typesetting)
        let postNewlineAttributes = environment
            .updateTypesetting { env in
                env.modifyLineIndentSettings {
                    AttributeEnvironment.TypesetEnvironment.LineIndentSetting(
                        baseIndentationLevels: $0.baseIndentationLevels.with(extend: $0.trailingIndentationLevels),
                        trailingIndentationLevels: $0.trailingIndentationLevels
                    )
                }
            }
            .systemAttributeDictionary(forEnvironment: .typesetting)
        // - -
        output.beginEditing()
        let _ = output.range(options: .ignoreWhitespaceAtBothEnds)
            .map {
                output.addAttributes(baseAttributes, range: $0)
            }!
        for (index, line) in lines.enumerated() {
            let line = NSMutableAttributedString(attributedString: line)
            let isLast = index + 1 == lines.count
            let isFirst = index == 0
            if isFirst {
                line.addAttributes(baseAttributes, range: line.range)
            }
            if !isFirst {
                line.addAttributes(postNewlineAttributes, range: line.range)
            }
            if !isLast {
                let attributes = environment.systemAttributeDictionary(forEnvironment: .styling)
                line.append(NSAttributedString(string: "\n", attributes: attributes))
            }
            output.append(line)
        }
        output.endEditing()
        return output
    }
    internal consuming func untypedFinalize(lineBreakSeparator: NSAttributedString) -> NSMutableAttributedString {
        // - -
        lines.append(current)
        current = NSMutableAttributedString()
        // - -
        let output: NSMutableAttributedString = .init()
        // - -
        output.beginEditing()
        for (index, line) in self.lines.enumerated() {
            let isLast = index + 1 == self.lines.count
            output.append(line)
            if !isLast {
                output.append(lineBreakSeparator)
            }
        }
        output.endEditing()
        // - -
        return output
    }
}


