//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/14/25.
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

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

extension DocumentView {
    override func mouseDown(with event: NSEvent) {
//        super.mouseDown(with: event)
        let point = self.convert(event.locationInWindow, from: nil).subtractingX(by: padding)
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        let holdingShift = event.modifierFlags.contains(.shift)
        let holdingControl = event.modifierFlags.contains(.control)
        let holdingOption = event.modifierFlags.contains(.option)
        let textSelectionNavigationModifiers = NSTextSelectionNavigation.Modifier.init()
            .including(optional: .extend, ifTrue: holdingShift)
            .including(optional: .visual, ifTrue: holdingOption)
        let multilineCursorMode = holdingShift && holdingControl
        pointerDraggingSelectionAnchors = textLayoutManager!.textSelections
        if multilineCursorMode {
            textLayoutManager!.textSelections += textSelectionNavigation.textSelections(
                interactingAt: point,
                inContainerAt: textLayoutManager!.documentRange.location,
                anchors: [],
                modifiers: [],
                selecting: false,
                bounds: .zero
            )
            needsUpdateLayout(direction: nil)
        } else {
            textLayoutManager!.textSelections = textSelectionNavigation.textSelections(
                interactingAt: point,
                inContainerAt: textLayoutManager!.documentRange.location,
                anchors: holdingShift ? (pointerDraggingSelectionAnchors ?? textLayoutManager!.textSelections) : [],
                modifiers: textSelectionNavigationModifiers,
                selecting: false,
                bounds: .zero
            )
            needsUpdateLayout(direction: nil)
        }
    }
    override func mouseDragged(with event: NSEvent) {
//        super.mouseDragged(with: event)
        let point = self.convert(event.locationInWindow, from: nil).subtractingX(by: padding)
        if pointerDraggingSelectionAnchors == nil {
            pointerDraggingSelectionAnchors = textLayoutManager!.textSelections
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        let holdingOption = event.modifierFlags.contains(.option)
        let textSelectionNavigationModifiers = NSTextSelectionNavigation.Modifier.init()
            .including(.extend)
            .including(optional: .visual, ifTrue: holdingOption)
        textLayoutManager!.textSelections = textSelectionNavigation.textSelections(
            interactingAt: point,
            inContainerAt: textLayoutManager!.documentRange.location,
            anchors: pointerDraggingSelectionAnchors ?? [],
            modifiers: textSelectionNavigationModifiers,
            selecting: true,
            bounds: .zero
        )
        needsUpdateLayout(direction: nil)
    }
    override func mouseUp(with event: NSEvent) {
//        super.mouseUp(with: event)
        pointerDraggingSelectionAnchors = nil
    }
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
    }
}

fileprivate extension DocumentView {
    func needsUpdateLayout(direction: FocusSelectionRequest.ScrollDirection?) {
        if let direction = direction {
            focusSelectionRequest = .scrollTo(direction)
        }
        layer?.setNeedsLayout()
    }
}

