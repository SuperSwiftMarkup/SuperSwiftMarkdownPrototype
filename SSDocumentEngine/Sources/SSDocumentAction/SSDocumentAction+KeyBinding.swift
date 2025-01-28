//
//  DocumentKeyBinding.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/3/25.
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

