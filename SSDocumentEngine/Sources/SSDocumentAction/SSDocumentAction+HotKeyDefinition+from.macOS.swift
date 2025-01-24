//
//  DocumentHotKey.from.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/3/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit

fileprivate enum KeyCode: UInt16 {
    case f1 = 122
    case f2 = 120
    case f3 = 99
    case f4 = 118
    case f5 = 96
    case f6 = 97
    case f7 = 98
    case f8 = 100
    case f9 = 101
    case f10 = 109
    case f11 = 103
    case f12 = 111
    case leftArrow = 123
    case rightArrow = 124
    case upArrow = 126
    case downArrow = 125
    case home = 115
    case end = 119
    case pageUp = 116
    case pageDown = 121
    case delete = 51
    case escape = 53
    case returnKey = 36
    case tab = 48
}

extension SSDocumentAction.HotKeyDefinition.PrimaryKey {
    internal static func from(event: NSEvent) -> Self? {
        // MARK: - DISPLAY KEYS -
        switch event.characters {
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
        if let keyCode = KeyCode(rawValue: event.keyCode) {
            switch keyCode {
            case .f1: return .f1
            case .f2: return .f2
            case .f3: return .f3
            case .f4: return .f4
            case .f5: return .f5
            case .f6: return .f6
            case .f7: return .f7
            case .f8: return .f8
            case .f9: return .f9
            case .f10: return .f10
            case .f11: return .f11
            case .f12: return .f12
            case .leftArrow: return .left
            case .rightArrow: return .right
            case .upArrow: return .up
            case .downArrow: return .down
            case .home: return .home
            case .end: return .end
            case .pageUp: return .pageUp
            case .pageDown: return .pageDown
            case .delete: return .delete
            case .escape: return .escape
            case .returnKey: return .return
            case .tab: return .tab
            }
        }

        return nil
    }
}

extension SSDocumentAction.HotKeyDefinition.ModifierKey {
    public static func from(event: NSEvent) -> Set<Self> {
        var results: Set<Self> = []
        if event.modifierFlags.contains(.capsLock) {
            results.insert(.capsLock)
        }
        if event.modifierFlags.contains(.shift) {
            results.insert(.shift)
        }
        if event.modifierFlags.contains(.control) {
            results.insert(.control)
        }
        if event.modifierFlags.contains(.option) {
            results.insert(.option)
        }
        if event.modifierFlags.contains(.command) {
            results.insert(.command)
        }
        return results
    }
}

extension SSDocumentAction.HotKeyDefinition {
    public static func from(event: NSEvent) -> Self? {
        let modifiers = ModifierKey.from(event: event)
        guard let primaryKey = PrimaryKey.from(event: event) else { return nil }
        return Self.init(modifiers: modifiers, primaryKey: primaryKey)
    }
}



#endif
