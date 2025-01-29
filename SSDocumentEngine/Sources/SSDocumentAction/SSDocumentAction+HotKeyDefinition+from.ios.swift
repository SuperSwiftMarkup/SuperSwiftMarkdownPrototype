// Created by Colbyn Wadman on 2025-1-3 (ISO 8601)
//
// All SuperSwiftMarkup source code and other software material (unless
// explicitly stated otherwise) is available under a dual licensing model.
//
// Users may choose to use such under either:
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions
// of either the AGPLv3 or the commercial license, depending on the license you
// select.
//
// https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md

import Foundation

#if os(iOS) || os(visionOS)
import UIKit

extension SSDocumentAction.HotKeyDefinition.PrimaryKey {
    internal static func from(uiKey: UIKey) -> Self? {
        // MARK: - DISPLAY KEYS -
        switch uiKey.characters {
        case "a", "A": return .a
        case "b", "B": return .b
        case "c", "C": return .c
        case "d", "D": return .d
        case "e", "E": return .e
        case "f", "F": return .f
        case "g", "G": return .g
        case "h", "H": return .h
        case "i", "I": return .i
        case "j", "J": return .j
        case "k", "K": return .k
        case "l", "L": return .l
        case "m", "M": return .m
        case "n", "N": return .n
        case "o", "O": return .o
        case "p", "P": return .p
        case "q", "Q": return .q
        case "r", "R": return .r
        case "s", "S": return .s
        case "t", "T": return .t
        case "u", "U": return .u
        case "v", "V": return .v
        case "w", "W": return .w
        case "x", "X": return .x
        case "y", "Y": return .y
        case "z", "Z": return .z
        case "0": return .zero
        case "1": return .one
        case "2": return .two
        case "3": return .three
        case "4": return .four
        case "5": return .five
        case "6": return .six
        case "7": return .seven
        case "8": return .eight
        case "9": return .nine
        case "!": return .exclamationMark
        case "@": return .atSymbol
        case "#": return .hash
        case "$": return .dollar
        case "%": return .percent
        case "^": return .caret
        case "&": return .ampersand
        case "*": return .asterisk
        case "(": return .leftParenthesis
        case ")": return .rightParenthesis
        case "-": return .minus
        case "_": return .underscore
        case "=": return .equal
        case "+": return .plus
        case "[": return .leftBracket
        case "]": return .rightBracket
        case "{": return .leftBrace
        case "}": return .rightBrace
        case "|": return .pipe
        case "\\": return .backslash
        case ";": return .semicolon
        case ":": return .colon
        case "'": return .singleQuote
        case "\"": return .doubleQuote
        case ",": return .comma
        case ".": return .period
        case "<": return .lessThan
        case ">": return .greaterThan
        case "/": return .slash
        case "?": return .questionMark
        case "`": return .backtick
        case "~": return .tilde
        case " ": return .space
        case "\t": return .tab
        case "\r": return .return
        default: ()
        }
        
        // MARK: - FUNCTION KEYS -
        if uiKey.keyCode == .keyboardF1 { return .f1 }
        if uiKey.keyCode == .keyboardF2 { return .f2 }
        if uiKey.keyCode == .keyboardF3 { return .f3 }
        if uiKey.keyCode == .keyboardF4 { return .f4 }
        if uiKey.keyCode == .keyboardF5 { return .f5 }
        if uiKey.keyCode == .keyboardF6 { return .f6 }
        if uiKey.keyCode == .keyboardF7 { return .f7 }
        if uiKey.keyCode == .keyboardF8 { return .f8 }
        if uiKey.keyCode == .keyboardF9 { return .f9 }
        if uiKey.keyCode == .keyboardF10 { return .f10 }
        if uiKey.keyCode == .keyboardF11 { return .f11 }
        if uiKey.keyCode == .keyboardF12 { return .f12 }
        
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f1 { return .f1 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f2 { return .f2 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f3 { return .f3 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f4 { return .f4 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f5 { return .f5 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f6 { return .f6 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f7 { return .f7 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f8 { return .f8 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f9 { return .f9 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f10 { return .f10 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f11 { return .f11 }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.f12 { return .f12 }
        
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow { return .left }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow { return .right }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow { return .up }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow { return .down }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputHome { return .home }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputEnd { return .end }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputPageUp { return .pageUp }
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputPageDown { return .pageDown }
        
        if uiKey.charactersIgnoringModifiers == UIKeyCommand.inputDelete { return .delete }
        
        switch uiKey.keyCode {
        case .keyboardEscape: return .escape
        case .keyboardReturn: return .return
        case .keyboardTab: return .tab
//        case .keyboardCapsLock: return .capsLock
//        case .keyboardScrollLock: return .scrollLock
//        case .keyboardPause: return .pause
//        case .keyboardPrintScreen: return .printScreen
//        case .keyboardInsert: return .insert
//        case .keyboardDeleteForward: return .delete
//        case .keyboardDeleteOrBackspace: return .deleteBackward
        default: ()
        }
        
        return nil
    }
}

extension SSDocumentAction.HotKeyDefinition.ModifierKey {
    public static func from(uiKey: UIKey) -> Set<Self> {
        var results: Set<Self> = []
        if uiKey.modifierFlags.contains(.alphaShift) {
            results.insert(.capsLock)
        }
        if uiKey.modifierFlags.contains(.shift) {
            results.insert(.shift)
        }
        if uiKey.modifierFlags.contains(.control) {
            results.insert(.control)
        }
        if uiKey.modifierFlags.contains(.alternate) {
            results.insert(.option)
        }
        if uiKey.modifierFlags.contains(.command) {
            results.insert(.command)
        }
        return results
    }
}

extension SSDocumentAction.HotKeyDefinition {
    public static func from(uiKey: UIKey) -> Self? {
        let modifiers = ModifierKey.from(uiKey: uiKey)
        guard let primaryKey = PrimaryKey.from(uiKey: uiKey) else { return nil }
        return Self.init(modifiers: modifiers, primaryKey: primaryKey)
    }
}

#endif
