//
//  SSDocument+attributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
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
