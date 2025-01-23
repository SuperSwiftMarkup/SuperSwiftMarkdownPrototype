//
//  DocumentHotKey.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/3/25.
//

import Foundation

extension ShortcutAction {
    public struct HotKeyDefinition: Codable, Equatable, Hashable {
        public let modifiers: Set<ModifierKey>
        public let primaryKey: PrimaryKey
        public init(modifiers: Set<ModifierKey>, primaryKey: PrimaryKey) {
            self.modifiers = modifiers
            self.primaryKey = primaryKey
        }
    }
}


extension ShortcutAction.HotKeyDefinition {
    // Enum for Modifier Keys
    public enum ModifierKey: Codable, Equatable, Hashable {
        case shift
        case control
        case option
        case command
        case capsLock
    }
    // Enum for Primary Keys
    public enum PrimaryKey: Codable, Equatable, Hashable {
        case a
        case b
        case c
        case d
        case e
        case f
        case g
        case h
        case i
        case j
        case k
        case l
        case m
        case n
        case o
        case p
        case q
        case r
        case s
        case t
        case u
        case v
        case w
        case x
        case y
        case z
        case zero
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case f1
        case f2
        case f3
        case f4
        case f5
        case f6
        case f7
        case f8
        case f9
        case f10
        case f11
        case f12
        case escape
        case up
        case down
        case left
        case right
        case home
        case end
        case pageUp
        case pageDown
        case delete
        case forwardDelete
        case space
        case `return`
        case tab
        case backtick
        case tilde
        case exclamationMark
        case atSymbol
        case hash
        case dollar
        case percent
        case caret
        case ampersand
        case asterisk
        case leftParenthesis
        case rightParenthesis
        case underscore
        case minus
        case plus
        case equal
        case leftBrace
        case rightBrace
        case leftBracket
        case rightBracket
        case pipe
        case backslash
        case colon
        case semicolon
        case singleQuote
        case doubleQuote
        case lessThan
        case greaterThan
        case comma
        case period
        case questionMark
        case slash
    }
}

extension ShortcutAction.HotKeyDefinition.ModifierKey {
    public var display: String {
        switch self {
        case .shift: return "⇧"
        case .control: return "⌃"
        case .option: return "⌥"
        case .command: return "⌘"
        case .capsLock: return "⇪"
        }
    }
}


extension ShortcutAction.HotKeyDefinition.PrimaryKey {
    public var display: String {
        switch self {
        case .a: return "A"
        case .b: return "B"
        case .c: return "C"
        case .d: return "D"
        case .e: return "E"
        case .f: return "F"
        case .g: return "G"
        case .h: return "H"
        case .i: return "I"
        case .j: return "J"
        case .k: return "K"
        case .l: return "L"
        case .m: return "M"
        case .n: return "N"
        case .o: return "O"
        case .p: return "P"
        case .q: return "Q"
        case .r: return "R"
        case .s: return "S"
        case .t: return "T"
        case .u: return "U"
        case .v: return "V"
        case .w: return "W"
        case .x: return "X"
        case .y: return "Y"
        case .z: return "Z"
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .f1: return "F1"
        case .f2: return "F2"
        case .f3: return "F3"
        case .f4: return "F4"
        case .f5: return "F5"
        case .f6: return "F6"
        case .f7: return "F7"
        case .f8: return "F8"
        case .f9: return "F9"
        case .f10: return "F10"
        case .f11: return "F11"
        case .f12: return "F12"
        case .escape: return "Esc"
        case .up: return "↑"
        case .down: return "↓"
        case .left: return "←"
        case .right: return "→"
        case .home: return "Home"
        case .end: return "End"
        case .pageUp: return "Page Up"
        case .pageDown: return "Page Down"
        case .delete: return "Del"
        case .forwardDelete: return "Forward Del"
        case .space: return "Space"
        case .return: return "Enter"
        case .tab: return "Tab"
        case .backtick: return "`"
        case .tilde: return "~"
        case .exclamationMark: return "!"
        case .atSymbol: return "@"
        case .hash: return "#"
        case .dollar: return "$"
        case .percent: return "%"
        case .caret: return "^"
        case .ampersand: return "&"
        case .asterisk: return "*"
        case .leftParenthesis: return "("
        case .rightParenthesis: return ")"
        case .underscore: return "_"
        case .minus: return "-"
        case .plus: return "+"
        case .equal: return "="
        case .leftBrace: return "{"
        case .rightBrace: return "}"
        case .leftBracket: return "["
        case .rightBracket: return "]"
        case .pipe: return "|"
        case .backslash: return "\\"
        case .colon: return ":"
        case .semicolon: return ";"
        case .singleQuote: return "'"
        case .doubleQuote: return "\""
        case .lessThan: return "<"
        case .greaterThan: return ">"
        case .comma: return ","
        case .period: return "."
        case .questionMark: return "?"
        case .slash: return "/"
        }
    }
}

extension ShortcutAction.HotKeyDefinition {
    public var display: String {
        let modifiersDisplay = modifiers.map { $0.display }.sorted().joined(separator: " + ")
        let primaryKeyDisplay = primaryKey.display
        return modifiersDisplay.isEmpty ? primaryKeyDisplay : "\(modifiersDisplay) + \(primaryKeyDisplay)"
    }
}
