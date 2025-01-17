//
//  DocumentKeyBinding.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/3/25.
//

import Foundation

extension DocumentBehavior {
    public struct KeyBinding: Codable, Equatable, Hashable {
        public let hotKey: DocumentBehavior.HotKeyDefinition
        public let shortcut: DocumentBehavior.ShortcutAction
        public init(hotKey: DocumentBehavior.HotKeyDefinition, shortcut: DocumentBehavior.ShortcutAction) {
            self.hotKey = hotKey
            self.shortcut = shortcut
        }
        public init(
            modifiers: Set<DocumentBehavior.HotKeyDefinition.ModifierKey>,
            primaryKey: DocumentBehavior.HotKeyDefinition.PrimaryKey,
            target: DocumentBehavior.ShortcutAction
        ) {
            self.hotKey = .init(modifiers: modifiers, primaryKey: primaryKey)
            self.shortcut = target
        }
    }
}

