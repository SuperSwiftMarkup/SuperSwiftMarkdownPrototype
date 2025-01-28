//
//  DocumentView+key.swift
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

import SSDocumentAction

extension DocumentView {
    override func keyDown(with event: NSEvent) {
        if let hotKey = SSDocumentAction.HotKeyDefinition.from(event: event) {
            for binding in SSDocumentAction.KeyBinding.allActions {
                if binding.hotKey == hotKey {
                    return handleAction(action: binding.shortcut)
                }
            }
            if hotKey.primaryKey == .return { return handleAction(action: .enter) }
            if hotKey.primaryKey == .left { return handleAction(action: .backward) }
            if hotKey.primaryKey == .right { return handleAction(action: .forward) }
            if hotKey.primaryKey == .up { return handleAction(action: .up) }
            if hotKey.primaryKey == .down { return handleAction(action: .down) }
            if hotKey.primaryKey == .delete { return handleAction(action: .delete) }
            return
        }
        super.keyDown(with: event)
    }
}
