//
//  DocumentView+layoutManager.swift
//  
//
//  Created by Colbyn Wadman on 1/14/25.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

extension DocumentView: NSTextLayoutManagerDelegate {
    func textLayoutManager(
        _ textLayoutManager: NSTextLayoutManager,
       textLayoutFragmentFor location: NSTextLocation,
       in textElement: NSTextElement
    ) -> NSTextLayoutFragment {
        return NSTextLayoutFragment(textElement: textElement, range: textElement.elementRange!)
    }
}

