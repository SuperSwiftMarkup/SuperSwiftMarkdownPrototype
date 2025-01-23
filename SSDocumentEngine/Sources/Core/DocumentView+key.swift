//
//  DocumentView+key.swift
//
//
//  Created by Colbyn Wadman on 1/14/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

import SSDocumentAction

extension DocumentView {
    override func keyDown(with event: NSEvent) {
        if let hotKey = ShortcutAction.HotKeyDefinition.from(event: event) {
            for binding in ShortcutAction.KeyBinding.allActions {
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
