//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation
import SSMarkdownAST
import SwiftPrettyTree

for source in allSourceSamples {
    for result in SSMarkdownParser.parse(source: source) {
        let formatOptions = PrettyTree.FormatterOptions.default.with(compactMode: true)
        print(result.asPrettyTree.format(options: formatOptions))
    }
}
