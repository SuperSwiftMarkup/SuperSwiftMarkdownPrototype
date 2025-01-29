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

public extension SSDocumentAction.KeyBinding {
    static let bold: Self = Self(
        modifiers: [.command],
        primaryKey: .b,
        target: .bold
    )

    static let italic: Self = Self(
        modifiers: [.command],
        primaryKey: .i,
        target: .italic
    )

    static let addWebLink: Self = Self(
        modifiers: [.command],
        primaryKey: .k,
        target: .addWebLink
    )

    static let underline: Self = Self(
        modifiers: [.command],
        primaryKey: .u,
        target: .underline
    )

    static let showHideFontsWindow: Self = Self(
        modifiers: [.command],
        primaryKey: .t,
        target: .showHideFontsWindow
    )

    static let selectDesktopFolder: Self = Self(
        modifiers: [.command],
        primaryKey: .d,
        target: .selectDesktopFolder
    )

    static let showHideDefinition: Self = Self(
        modifiers: [.control, .command],
        primaryKey: .d,
        target: .showHideDefinition
    )

    static let showSpellingAndGrammar: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .colon,
        target: .showSpellingAndGrammar
    )

    static let findMisspelledWords: Self = Self(
        modifiers: [.command],
        primaryKey: .semicolon,
        target: .findMisspelledWords
    )

    static let deleteWordLeft: Self = Self(
        modifiers: [.option],
        primaryKey: .delete,
        target: .deleteWordLeft
    )

    static let deleteCharacterLeft: Self = Self(
        modifiers: [.control],
        primaryKey: .h,
        target: .deleteCharacterLeft
    )

    static let deleteCharacterRight: Self = Self(
        modifiers: [.control],
        primaryKey: .d,
        target: .deleteCharacterRight
    )

//    static let forwardDelete: Self = Self(
//        modifiers: [.fn],
//        primaryKey: .delete,
//        target: .forwardDelete
//    )

    static let deleteToEndOfLine: Self = Self(
        modifiers: [.control],
        primaryKey: .k,
        target: .deleteToEndOfLine
    )

//    static let pageUp: Self = Self(
//        modifiers: [.fn],
//        primaryKey: .up,
//        target: .pageUp
//    )
//
//    static let pageDown: Self = Self(
//        modifiers: [.fn],
//        primaryKey: .down,
//        target: .pageDown
//    )
//
//    static let home: Self = Self(
//        modifiers: [.fn],
//        primaryKey: .left,
//        target: .home
//    )
//
//    static let end: Self = Self(
//        modifiers: [.fn],
//        primaryKey: .right,
//        target: .end
//    )

    static let moveToBeginningOfDocument: Self = Self(
        modifiers: [.command],
        primaryKey: .up,
        target: .moveToBeginningOfDocument
    )

    static let moveToEndOfDocument: Self = Self(
        modifiers: [.command],
        primaryKey: .down,
        target: .moveToEndOfDocument
    )

    static let moveToBeginningOfLine: Self = Self(
        modifiers: [.command],
        primaryKey: .left,
        target: .moveToBeginningOfLine
    )

    static let moveToEndOfLine: Self = Self(
        modifiers: [.command],
        primaryKey: .right,
        target: .moveToEndOfLine
    )

    static let moveToBeginningOfPreviousWord: Self = Self(
        modifiers: [.option],
        primaryKey: .left,
        target: .moveToBeginningOfPreviousWord
    )

    static let moveToEndOfNextWord: Self = Self(
        modifiers: [.option],
        primaryKey: .right,
        target: .moveToEndOfNextWord
    )

    static let selectToBeginningOfDocument: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .up,
        target: .selectToBeginningOfDocument
    )

    static let selectToEndOfDocument: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .down,
        target: .selectToEndOfDocument
    )

    static let selectToBeginningOfLine: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .left,
        target: .selectToBeginningOfLine
    )

    static let selectToEndOfLine: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .right,
        target: .selectToEndOfLine
    )

    static let extendSelectionUp: Self = Self(
        modifiers: [.shift],
        primaryKey: .up,
        target: .extendSelectionUp
    )

    static let extendSelectionDown: Self = Self(
        modifiers: [.shift],
        primaryKey: .down,
        target: .extendSelectionDown
    )

    static let extendSelectionLeft: Self = Self(
        modifiers: [.shift],
        primaryKey: .left,
        target: .extendSelectionLeft
    )

    static let extendSelectionRight: Self = Self(
        modifiers: [.shift],
        primaryKey: .right,
        target: .extendSelectionRight
    )

    static let extendSelectionToBeginningOfParagraph: Self = Self(
        modifiers: [.option, .shift],
        primaryKey: .up,
        target: .extendSelectionToBeginningOfParagraph
    )

    static let extendSelectionToEndOfParagraph: Self = Self(
        modifiers: [.option, .shift],
        primaryKey: .down,
        target: .extendSelectionToEndOfParagraph
    )

    static let extendSelectionToBeginningOfWord: Self = Self(
        modifiers: [.option, .shift],
        primaryKey: .left,
        target: .extendSelectionToBeginningOfWord
    )

    static let extendSelectionToEndOfWord: Self = Self(
        modifiers: [.option, .shift],
        primaryKey: .right,
        target: .extendSelectionToEndOfWord
    )

    static let moveToBeginningOfLineOrParagraph: Self = Self(
        modifiers: [.control],
        primaryKey: .a,
        target: .moveToBeginningOfLineOrParagraph
    )

    static let moveToEndOfLineOrParagraph: Self = Self(
        modifiers: [.control],
        primaryKey: .e,
        target: .moveToEndOfLineOrParagraph
    )

    static let moveForwardOneCharacter: Self = Self(
        modifiers: [.control],
        primaryKey: .f,
        target: .moveForwardOneCharacter
    )

    static let moveBackwardOneCharacter: Self = Self(
        modifiers: [.control],
        primaryKey: .b,
        target: .moveBackwardOneCharacter
    )

    static let centerCursor: Self = Self(
        modifiers: [.control],
        primaryKey: .l,
        target: .centerCursor
    )

    static let moveUpOneLine: Self = Self(
        modifiers: [.control],
        primaryKey: .p,
        target: .moveUpOneLine
    )

    static let moveDownOneLine: Self = Self(
        modifiers: [.control],
        primaryKey: .n,
        target: .moveDownOneLine
    )

    static let insertNewLine: Self = Self(
        modifiers: [.control],
        primaryKey: .o,
        target: .insertNewLine
    )

    static let swapCharacters: Self = Self(
        modifiers: [.control],
        primaryKey: .t,
        target: .swapCharacters
    )

    static let leftAlign: Self = Self(
        modifiers: [.command],
        primaryKey: .leftBrace,
        target: .leftAlign
    )

    static let rightAlign: Self = Self(
        modifiers: [.command],
        primaryKey: .rightBrace,
        target: .rightAlign
    )

    static let centerAlign: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .pipe,
        target: .centerAlign
    )

    static let goToSearchField: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .f,
        target: .goToSearchField
    )

    static let showHideToolbar: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .t,
        target: .showHideToolbar
    )

    static let copyStyle: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .c,
        target: .copyStyle
    )

    static let pasteStyle: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .v,
        target: .pasteStyle
    )

    static let pasteAndMatchStyle: Self = Self(
        modifiers: [.option, .shift, .command],
        primaryKey: .v,
        target: .pasteAndMatchStyle
    )

    static let showHideInspectorWindow: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .i,
        target: .showHideInspectorWindow
    )

    static let pageSetup: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .p,
        target: .pageSetup
    )

    static let saveAs: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .s,
        target: .saveAs
    )

    static let decreaseSize: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .minus,
        target: .decreaseSize
    )

    static let increaseSize: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .plus,
        target: .increaseSize
    )

    static let openHelpMenu: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .questionMark,
        target: .openHelpMenu
    )

    static let undo: Self = Self(
        modifiers: [.command],
        primaryKey: .z,
        target: .undo
    )

    static let redo: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .z,
        target: .redo
    )

    static let cut: Self = Self(
        modifiers: [.command],
        primaryKey: .x,
        target: .cut
    )

    static let copy: Self = Self(
        modifiers: [.command],
        primaryKey: .c,
        target: .copy
    )

    static let paste: Self = Self(
        modifiers: [.command],
        primaryKey: .v,
        target: .paste
    )

    static let selectAll: Self = Self(
        modifiers: [.command],
        primaryKey: .a,
        target: .selectAll
    )

    static let find: Self = Self(
        modifiers: [.command],
        primaryKey: .f,
        target: .find
    )

    static let findNext: Self = Self(
        modifiers: [.command],
        primaryKey: .g,
        target: .findNext
    )

    static let findPrevious: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .g,
        target: .findPrevious
    )

    static let replace: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .f,
        target: .replace
    )

    static let replaceAll: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .g,
        target: .replaceAll
    )

    static let replaceAndFindNext: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .e,
        target: .replaceAndFindNext
    )

    static let jumpToSelection: Self = Self(
        modifiers: [.command],
        primaryKey: .j,
        target: .jumpToSelection
    )

    static let centerSelectionInWindow: Self = Self(
        modifiers: [.command],
        primaryKey: .l,
        target: .centerSelectionInWindow
    )

    static let save: Self = Self(
        modifiers: [.command],
        primaryKey: .s,
        target: .save
    )

    static let print: Self = Self(
        modifiers: [.command],
        primaryKey: .p,
        target: .print
    )

    static let closeWindow: Self = Self(
        modifiers: [.command],
        primaryKey: .w,
        target: .closeWindow
    )

    static let minimizeWindow: Self = Self(
        modifiers: [.command],
        primaryKey: .m,
        target: .minimizeWindow
    )

    static let zoomWindow: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .equal,
        target: .zoomWindow
    )

    static let open: Self = Self(
        modifiers: [.command],
        primaryKey: .o,
        target: .open
    )

    static let newDocument: Self = Self(
        modifiers: [.command],
        primaryKey: .n,
        target: .newDocument
    )

    static let quitApplication: Self = Self(
        modifiers: [.command],
        primaryKey: .q,
        target: .quitApplication
    )

    static let hideApplication: Self = Self(
        modifiers: [.command],
        primaryKey: .h,
        target: .hideApplication
    )

    static let hideOthers: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .h,
        target: .hideOthers
    )

    static let showAllWindows: Self = Self(
        modifiers: [.command, .option],
        primaryKey: .m,
        target: .showAllWindows
    )

    static let switchToNextTab: Self = Self(
        modifiers: [.control],
        primaryKey: .tab,
        target: .switchToNextTab
    )

    static let switchToPreviousTab: Self = Self(
        modifiers: [.shift, .control],
        primaryKey: .tab,
        target: .switchToPreviousTab
    )

    static let moveFocusToNextWindow: Self = Self(
        modifiers: [.command],
        primaryKey: .backtick,
        target: .moveFocusToNextWindow
    )

    static let moveFocusToMenuBar: Self = Self(
        modifiers: [.control],
        primaryKey: .f2,
        target: .moveFocusToMenuBar
    )

    static let moveFocusToDock: Self = Self(
        modifiers: [.control],
        primaryKey: .f3,
        target: .moveFocusToDock
    )

    static let moveFocusToToolbar: Self = Self(
        modifiers: [.control],
        primaryKey: .f5,
        target: .moveFocusToToolbar
    )

    static let moveFocusToFloatingWindow: Self = Self(
        modifiers: [.control],
        primaryKey: .f6,
        target: .moveFocusToFloatingWindow
    )

    static let takeScreenshot: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .four,
        target: .takeScreenshot
    )

    static let takeScreenshotOfWindow: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .four,
        target: .takeScreenshotOfWindow
    )

    static let takeScreenshotOfEntireScreen: Self = Self(
        modifiers: [.shift, .command],
        primaryKey: .three,
        target: .takeScreenshotOfEntireScreen
    )

    static let openSpotlight: Self = Self(
        modifiers: [.command],
        primaryKey: .space,
        target: .openSpotlight
    )

    static let openFinder: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .space,
        target: .openFinder
    )

    static let openMissionControl: Self = Self(
        modifiers: [.control],
        primaryKey: .up,
        target: .openMissionControl
    )

    static let openApplicationWindows: Self = Self(
        modifiers: [.control],
        primaryKey: .down,
        target: .openApplicationWindows
    )

    static let showDesktop: Self = Self(
        modifiers: [],
        primaryKey: .f11,
        target: .showDesktop
    )

    static let showDashboard: Self = Self(
        modifiers: [],
        primaryKey: .f12,
        target: .showDashboard
    )

    static let openNotificationCenter: Self = Self(
        modifiers: [.option, .command],
        primaryKey: .five,
        target: .openNotificationCenter
    )

    static let openLaunchpad: Self = Self(
        modifiers: [],
        primaryKey: .f4,
        target: .openLaunchpad
    )

    static let openSystemPreferences: Self = Self(
        modifiers: [.command],
        primaryKey: .comma,
        target: .openSystemPreferences
    )

    static let openDictionary: Self = Self(
        modifiers: [.command, .control],
        primaryKey: .d,
        target: .openDictionary
    )

    static let openCalculator: Self = Self(
        modifiers: [.command, .control],
        primaryKey: .c,
        target: .openCalculator
    )

    static let openCharacterViewer: Self = Self(
        modifiers: [.control, .command],
        primaryKey: .space,
        target: .openCharacterViewer
    )

    static let openEmojiAndSymbols: Self = Self(
        modifiers: [.control, .command],
        primaryKey: .space,
        target: .openEmojiAndSymbols
    )

    static let openKeyboardViewer: Self = Self(
        modifiers: [.command, .control],
        primaryKey: .k,
        target: .openKeyboardViewer
    )
}

extension SSDocumentAction.KeyBinding {
    public static let allActions: [Self] = [
        .bold,
        .italic,
        .addWebLink,
        .underline,
        .showHideFontsWindow,
        .selectDesktopFolder,
        .showHideDefinition,
        .showSpellingAndGrammar,
        .findMisspelledWords,
        .deleteWordLeft,
        .deleteCharacterLeft,
        .deleteCharacterRight,
//        .forwardDelete,
        .deleteToEndOfLine,
//        .pageUp,
//        .pageDown,
//        .home,
//        .end,
        .moveToBeginningOfDocument,
        .moveToEndOfDocument,
        .moveToBeginningOfLine,
        .moveToEndOfLine,
        .moveToBeginningOfPreviousWord,
        .moveToEndOfNextWord,
        .selectToBeginningOfDocument,
        .selectToEndOfDocument,
        .selectToBeginningOfLine,
        .selectToEndOfLine,
        .extendSelectionUp,
        .extendSelectionDown,
        .extendSelectionLeft,
        .extendSelectionRight,
        .extendSelectionToBeginningOfParagraph,
        .extendSelectionToEndOfParagraph,
        .extendSelectionToBeginningOfWord,
        .extendSelectionToEndOfWord,
        .moveToBeginningOfLineOrParagraph,
        .moveToEndOfLineOrParagraph,
        .moveForwardOneCharacter,
        .moveBackwardOneCharacter,
        .centerCursor,
        .moveUpOneLine,
        .moveDownOneLine,
        .insertNewLine,
        .swapCharacters,
        .leftAlign,
        .rightAlign,
        .centerAlign,
        .goToSearchField,
        .showHideToolbar,
        .copyStyle,
        .pasteStyle,
        .pasteAndMatchStyle,
        .showHideInspectorWindow,
        .pageSetup,
        .saveAs,
        .decreaseSize,
        .increaseSize,
        .openHelpMenu,
        .undo,
        .redo,
        .cut,
        .copy,
        .paste,
        .selectAll,
        .find,
        .findNext,
        .findPrevious,
        .replace,
        .replaceAll,
        .replaceAndFindNext,
        .jumpToSelection,
        .centerSelectionInWindow,
        .save,
        .print,
        .closeWindow,
        .minimizeWindow,
        .zoomWindow,
        .open,
        .newDocument,
        .quitApplication,
        .hideApplication,
        .hideOthers,
        .showAllWindows,
        .switchToNextTab,
        .switchToPreviousTab,
        .moveFocusToNextWindow,
        .moveFocusToMenuBar,
        .moveFocusToDock,
        .moveFocusToToolbar,
        .moveFocusToFloatingWindow,
        .takeScreenshot,
        .takeScreenshotOfWindow,
        .takeScreenshotOfEntireScreen,
        .openSpotlight,
        .openFinder,
        .openMissionControl,
        .openApplicationWindows,
        .showDesktop,
        .showDashboard,
        .openNotificationCenter,
        .openLaunchpad,
        .openSystemPreferences,
        .openDictionary,
        .openCalculator,
        .openCharacterViewer,
        .openEmojiAndSymbols,
        .openKeyboardViewer,
    ]
}
