//
//  DocumentKeyBinding.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/3/25.
//

import Foundation

extension ShortcutAction {
    public struct KeyBinding: Codable, Equatable, Hashable {
        public let hotKey: ShortcutAction.HotKeyDefinition
        public let shortcut: ShortcutAction
        public init(hotKey: ShortcutAction.HotKeyDefinition, shortcut: ShortcutAction) {
            self.hotKey = hotKey
            self.shortcut = shortcut
        }
        public init(
            modifiers: Set<ShortcutAction.HotKeyDefinition.ModifierKey>,
            primaryKey: ShortcutAction.HotKeyDefinition.PrimaryKey,
            target: ShortcutAction
        ) {
            self.hotKey = .init(modifiers: modifiers, primaryKey: primaryKey)
            self.shortcut = target
        }
    }
}

