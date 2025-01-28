//
//  DocumentView+debug.swift
//  
//
//  Created by Colbyn Wadman on 1/16/25.
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
import CoreGraphics

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

fileprivate let VERBOSE_DEBUG_MODE: Bool = false

//extension DocumentView {
//    internal func postLayoutDebug() {
//        if !VERBOSE_DEBUG_MODE {
//            return
//        }
//        self.textLayoutManager!.enumerateTextSegments(
//            in: self.textLayoutManager!.documentRange,
//            type: .standard,
//            options: []
//        ) { range, textSegmentFrame, baselinePosition, textContainer in
////            let context 
//            print("SEGMENT", range!.debugDescription, textSegmentFrame, baselinePosition)
//            return true
//        }
//        self.textLayoutManager!.enumerateTextLayoutFragments(
//            from: nil,
//            options: [.ensuresExtraLineFragment]
//        ) { fragment in
//            print(
//                "FRAGMENT:",
//                fragment.textElement!.elementRange.debugDescription,
//                fragment.layoutFragmentFrame.debugDescription
//            )
//            return true
//        }
//    }
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//        let context = NSGraphicsContext.current!.cgContext
//        context.saveGState()
//        context.setFillColor(NSColor.red.withAlphaComponent(0.5).cgColor)
////        self.textLayoutManager!.enumerateTextSegments(
////            in: self.textLayoutManager!.documentRange,
////            type: .standard,
////            options: []
////        ) { range, textSegmentFrame, baselinePosition, textContainer in
////            print("SEGMENT", range!.debugDescription, textSegmentFrame, baselinePosition)
////            let circle = CGPath.init(
////                ellipseIn: CGRect.init(
////                    origin: .init(
////                        x: textSegmentFrame.minX,
////                        y: textSegmentFrame.minY + (baselinePosition/2)
////                    ),
////                    size: .init(width: 5, height: 5)
////                ),
////                transform: nil
////            )
////            context.addPath(circle)
////            context.fillPath()
////            return true
////        }
////        self.textLayoutManager?.enumerateTextLayoutFragments(
////            from: nil,
////            options: []
////        ) { fragment in
////            let frame = fragment.layoutFragmentFrame
////            let circle = CGPath.init(
////                ellipseIn: CGRect.init(
////                    origin: .init(
////                        x: frame.minX,
////                        y: frame.minY + (((frame.maxY - frame.minY)/2) - 2)
////                    ),
////                    size: .init(width: 5, height: 5)
////                ),
////                transform: nil
////            )
////            context.addPath(circle)
////            context.fillPath()
////            
////            return true
////        }
//        context.restoreGState()
//    }
//}
