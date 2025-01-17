//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

extension SSDocument {
    public func attributedString(styling: SSDocumentStyling) -> NSAttributedString {
//        let attributedString = NSMutableAttributedString.init(<#T##attrStr: AttributedString##AttributedString#>, including: <#T##KeyPath<AttributeScopes, AttributeScope.Type>#>)
        self.nodes
            .map {
//                print("HERE: \($0)")
                return $0.attributedString(styling: styling, environment: .default).with(append: "\n")
            }
            .join(leading: nil, contentStyling: nil, trailing: nil)
    }
}
