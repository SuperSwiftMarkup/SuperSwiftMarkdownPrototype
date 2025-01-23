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
        preceeding: NSAttributedString
    ) -> NSMutableAttributedString {
        // - -
        lines.append(current)
        current = NSMutableAttributedString()
        // - -
        let output = NSMutableAttributedString(attributedString: preceeding)
        // - -
        let baseAttributes = environment.systemAttributeDictionary(forEnvironment: .typesetting)
        let postNewlineAttributes = environment
            .updateTypesetting { env in
                env.modifyLineIndentSettings {
                    AttributeEnvironment.TypesetEnvironment.LineIndentSetting(
                        baseIndentationLevels: $0.baseIndentationLevels.with(extend: $0.trailingIndentationLevels),
                        trailingIndentationLevels: []
                    )
                }
            }
            .systemAttributeDictionary(forEnvironment: .typesetting)
        // - -
        output.beginEditing()
        output.addAttributes(baseAttributes, range: output.range(options: .ignoreWhitespaceAtBothEnds))
        for (index, line) in lines.enumerated() {
            let line = NSMutableAttributedString(attributedString: line)
            let isLast = index + 1 == lines.count
            let isFirst = index == 0
            if !isFirst {
                line.addAttributes(postNewlineAttributes, range: line.range)
            }
            if !isLast {
                line.append(NSAttributedString(string: "\n"))
            }
            output.append(line)
        }
        output.endEditing()
        return output
    }
}


