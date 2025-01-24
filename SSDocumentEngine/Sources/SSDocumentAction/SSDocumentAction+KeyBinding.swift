//
//  DocumentKeyBinding.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/3/25.
//

import Foundation

extension SSDocumentAction {
    public struct KeyBinding: Codable, Equatable, Hashable {
        public let hotKey: SSDocumentAction.HotKeyDefinition
        public let shortcut: SSDocumentAction
        public init(hotKey: SSDocumentAction.HotKeyDefinition, shortcut: SSDocumentAction) {
            self.hotKey = hotKey
            self.shortcut = shortcut
        }
        public init(
            modifiers: Set<SSDocumentAction.HotKeyDefinition.ModifierKey>,
            primaryKey: SSDocumentAction.HotKeyDefinition.PrimaryKey,
            target: SSDocumentAction
        ) {
            self.hotKey = .init(modifiers: modifiers, primaryKey: primaryKey)
            self.shortcut = target
        }
    }
}

