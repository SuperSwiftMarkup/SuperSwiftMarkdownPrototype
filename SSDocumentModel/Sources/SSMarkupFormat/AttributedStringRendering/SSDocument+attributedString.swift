//
//  SSDocument+attributedString.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation

extension SSDocument {
    public func compileAttributedString() -> NSAttributedString {
        var context = AttributedStringContext()
        let environment = AttributeEnvironment.default
        for (index, block) in self.blocks.enumerated() {
            let isLast = self.blocks.count == index + 1
            block.attributedString(context: &context, environment: environment)
            context.append(lineBreak: .hardLineBreak, environment: environment)
//            context.append(lineBreak: .hardLineBreak, environment: environment)
//            if !isLast {
////                context.append(lineBreak: .paragraphBreak, environment: environment)
//                context.append(lineBreak: .hardLineBreak, environment: environment)
//            }
            let _ = isLast
        }
        return context.finalize(environment: environment)
    }
}
