//
//  ParagraphState.swift
//
//
//  Created by Colbyn Wadman on 1/23/25.
//

import Foundation

internal struct ParagraphState: ~Copyable {
    private var lines: [NSAttributedString] = []
    private var current: NSMutableAttributedString = NSMutableAttributedString()
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
        initial: NSAttributedString
    ) -> NSMutableAttributedString {
        // - -
        lines.append(current)
        current = NSMutableAttributedString()
        // - -
        let output = NSMutableAttributedString(attributedString: initial)
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
}


