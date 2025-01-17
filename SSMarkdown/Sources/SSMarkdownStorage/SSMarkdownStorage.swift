//
//  SSMarkdownStorage.swift
//
//
//  Created by Colbyn Wadman on 1/11/25.
//

import Foundation
import SSMarkdownAST

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

public final class SSMarkdownStorage: NSTextContentManager {}

//public final class SSCountableTextRange: NSObject, NSTextLocation {
//    public let
//    public func compare(_ location: any NSTextLocation) -> ComparisonResult {
//        <#code#>
//    }
//    
//    
//}

//fileprivate struct BlockEntry {
//    let block: SSBlock
//    let range: NSRange
//}
