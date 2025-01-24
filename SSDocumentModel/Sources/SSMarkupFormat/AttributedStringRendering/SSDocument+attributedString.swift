//
//  SSDocument+attributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation

extension SSDocument {
    public func compileAttributedString() -> NSAttributedString {
        var context = DocumentContext()
        let environment = AttributeEnvironment.default
        for block in self.blocks {
            block.attributedString(context: &context, environment: environment)
            context.endBlock(
                lineBreak: .hardLineBreak,
                environment: environment,
                typesetBlock: false
            )
        }
        return context.finalize(environment: environment)
    }
}
