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
    public func attributedString() -> NSAttributedString {
        self.nodes
            .map {
//                print("HERE: \($0)")
                return $0.attributedString(environment: .default)
            }
//            .join(leading: nil, contentStyling: nil, trailing: nil)
            .join(separatedBy: NSAttributedString.doubleNewline)
    }
}
