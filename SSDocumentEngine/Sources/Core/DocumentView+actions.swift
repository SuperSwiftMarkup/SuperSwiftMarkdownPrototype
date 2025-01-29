// Created by Colbyn Wadman on 2025-1-14 (ISO 8601)
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

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

import SSDocumentAction

fileprivate typealias DocumentKeyBinding = SSDocumentAction.KeyBinding
fileprivate typealias DocumentShortcut = SSDocumentAction

fileprivate let VERBOSE_DEBUG_MODE: Bool = false

extension DocumentView {
    internal func handleAction(action: SSDocumentAction) {
        switch action {
        case .forward: return _forward()
        case .backward: return _backward()
        case .up: return _up()
        case .down: return _down()
        case .enter: return _enter()
        case .delete: return _delete()
        case .bold: return _bold()
        case .italic: return _italic()
        case .addWebLink: return _addWebLink()
        case .underline: return _underline()
        case .showHideFontsWindow: return _showHideFontsWindow()
        case .selectDesktopFolder: return _selectDesktopFolder()
        case .showHideDefinition: return _showHideDefinition()
        case .showSpellingAndGrammar: return _showSpellingAndGrammar()
        case .findMisspelledWords: return _findMisspelledWords()
        case .deleteWordLeft: return _deleteWordLeft()
        case .deleteCharacterLeft: return _deleteCharacterLeft()
        case .deleteCharacterRight: return _deleteCharacterRight()
        case .forwardDelete: return _forwardDelete()
        case .deleteToEndOfLine: return _deleteToEndOfLine()
        case .pageUp: return _pageUp()
        case .pageDown: return _pageDown()
        case .home: return _home()
        case .end: return _end()
        case .moveToBeginningOfDocument: return _moveToBeginningOfDocument()
        case .moveToEndOfDocument: return _moveToEndOfDocument()
        case .moveToBeginningOfLine: return _moveToBeginningOfLine()
        case .moveToEndOfLine: return _moveToEndOfLine()
        case .moveToBeginningOfPreviousWord: return _moveToBeginningOfPreviousWord()
        case .moveToEndOfNextWord: return _moveToEndOfNextWord()
        case .selectToBeginningOfDocument: return _selectToBeginningOfDocument()
        case .selectToEndOfDocument: return _selectToEndOfDocument()
        case .selectToBeginningOfLine: return _selectToBeginningOfLine()
        case .selectToEndOfLine: return _selectToEndOfLine()
        case .extendSelectionUp: return _extendSelectionUp()
        case .extendSelectionDown: return _extendSelectionDown()
        case .extendSelectionLeft: return _extendSelectionLeft()
        case .extendSelectionRight: return _extendSelectionRight()
        case .extendSelectionToBeginningOfParagraph: return _extendSelectionToBeginningOfParagraph()
        case .extendSelectionToEndOfParagraph: return _extendSelectionToEndOfParagraph()
        case .extendSelectionToBeginningOfWord: return _extendSelectionToBeginningOfWord()
        case .extendSelectionToEndOfWord: return _extendSelectionToEndOfWord()
        case .moveToBeginningOfLineOrParagraph: return _moveToBeginningOfLineOrParagraph()
        case .moveToEndOfLineOrParagraph: return _moveToEndOfLineOrParagraph()
        case .moveForwardOneCharacter: return _moveForwardOneCharacter()
        case .moveBackwardOneCharacter: return _moveBackwardOneCharacter()
        case .centerCursor: return _centerCursor()
        case .moveUpOneLine: return _moveUpOneLine()
        case .moveDownOneLine: return _moveDownOneLine()
        case .insertNewLine: return _insertNewLine()
        case .swapCharacters: return _swapCharacters()
        case .leftAlign: return _leftAlign()
        case .rightAlign: return _rightAlign()
        case .centerAlign: return _centerAlign()
        case .goToSearchField: return _goToSearchField()
        case .showHideToolbar: return _showHideToolbar()
        case .copyStyle: return _copyStyle()
        case .pasteStyle: return _pasteStyle()
        case .pasteAndMatchStyle: return _pasteAndMatchStyle()
        case .showHideInspectorWindow: return _showHideInspectorWindow()
        case .pageSetup: return _pageSetup()
        case .saveAs: return _saveAs()
        case .decreaseSize: return _decreaseSize()
        case .increaseSize: return _increaseSize()
        case .openHelpMenu: return _openHelpMenu()
        case .undo: return _undo()
        case .redo: return _redo()
        case .cut: return _cut()
        case .copy: return _copy()
        case .paste: return _paste()
        case .selectAll: return _selectAll()
        case .find: return _find()
        case .findNext: return _findNext()
        case .findPrevious: return _findPrevious()
        case .replace: return _replace()
        case .replaceAll: return _replaceAll()
        case .replaceAndFindNext: return _replaceAndFindNext()
        case .jumpToSelection: return _jumpToSelection()
        case .centerSelectionInWindow: return _centerSelectionInWindow()
        case .save: return _save()
        case .print: return _print()
        case .closeWindow: return _closeWindow()
        case .minimizeWindow: return _minimizeWindow()
        case .zoomWindow: return _zoomWindow()
        case .open: return _open()
        case .newDocument: return _newDocument()
        case .quitApplication: return _quitApplication()
        case .hideApplication: return _hideApplication()
        case .hideOthers: return _hideOthers()
        case .showAllWindows: return _showAllWindows()
        case .switchToNextTab: return _switchToNextTab()
        case .switchToPreviousTab: return _switchToPreviousTab()
        case .moveFocusToNextWindow: return _moveFocusToNextWindow()
        case .moveFocusToMenuBar: return _moveFocusToMenuBar()
        case .moveFocusToDock: return _moveFocusToDock()
        case .moveFocusToToolbar: return _moveFocusToToolbar()
        case .moveFocusToFloatingWindow: return _moveFocusToFloatingWindow()
        case .takeScreenshot: return _takeScreenshot()
        case .takeScreenshotOfWindow: return _takeScreenshotOfWindow()
        case .takeScreenshotOfEntireScreen: return _takeScreenshotOfEntireScreen()
        case .openSpotlight: return _openSpotlight()
        case .openFinder: return _openFinder()
        case .openMissionControl: return _openMissionControl()
        case .openApplicationWindows: return _openApplicationWindows()
        case .showDesktop: return _showDesktop()
        case .showDashboard: return _showDashboard()
        case .openNotificationCenter: return _openNotificationCenter()
        case .openLaunchpad: return _openLaunchpad()
        case .openSystemPreferences: return _openSystemPreferences()
        case .openDictionary: return _openDictionary()
        case .openCalculator: return _openCalculator()
        case .openCharacterViewer: return _openCharacterViewer()
        case .openEmojiAndSymbols: return _openEmojiAndSymbols()
        case .openKeyboardViewer: return _openKeyboardViewer()
        }
    }
}

// MARK: - INTERNAL -

extension DocumentView {
    fileprivate func _forward() {
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .right,
                destination: .character,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }
    fileprivate func _backward() {
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .left,
                destination: .character,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }
    fileprivate func _up() {
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .up,
                destination: .character,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: .up)
    }
    fileprivate func _down() {
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .down,
                destination: .character,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: .down)
    }
    fileprivate func _enter() {
        if VERBOSE_DEBUG_MODE {
            print("TODO: ENTER")
        }
    }
    fileprivate func _delete() {
        if VERBOSE_DEBUG_MODE {
            print("TODO: DELETE")
        }
    }
}



extension DocumentView {
    // MARK: - Text Formatting

    /// Boldface the selected text, or turn boldfacing on or off.
    /// Default: Command-B
    fileprivate func _bold() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (bold):", DocumentKeyBinding.bold.shortcut.display, "\(DocumentKeyBinding.bold.hotKey.display)")
        }
    }

    /// Italicize the selected text, or turn italics on or off.
    /// Default: Command-I
    fileprivate func _italic() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (italic):", DocumentKeyBinding.italic.shortcut.display, "\(DocumentKeyBinding.italic.hotKey.display)")
        }
    }

    /// Add a web link.
    /// Default: Command-K
    fileprivate func _addWebLink() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (addWebLink):", DocumentKeyBinding.addWebLink.shortcut.display, "\(DocumentKeyBinding.addWebLink.hotKey.display)")
        }
    }

    /// Underline the selected text, or turn underlining on or off.
    /// Default: Command-U
    fileprivate func _underline() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (underline):", DocumentKeyBinding.underline.shortcut.display, "\(DocumentKeyBinding.underline.hotKey.display)")
        }
    }

    /// Show or hide the Fonts window.
    /// Default: Command-T
    fileprivate func _showHideFontsWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showHideFontsWindow):", DocumentKeyBinding.showHideFontsWindow.shortcut.display, "\(DocumentKeyBinding.showHideFontsWindow.hotKey.display)")
        }
    }

    // MARK: - File and Folder Operations

    /// Select the Desktop folder from within an Open dialog or Save dialog.
    /// Default: Command-D
    fileprivate func _selectDesktopFolder() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (selectDesktopFolder):", DocumentKeyBinding.selectDesktopFolder.shortcut.display, "\(DocumentKeyBinding.selectDesktopFolder.hotKey.display)")
        }
    }

    /// Show or hide the definition of the selected word.
    /// Default: Control-Command-D
    fileprivate func _showHideDefinition() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showHideDefinition):", DocumentKeyBinding.showHideDefinition.shortcut.display, "\(DocumentKeyBinding.showHideDefinition.hotKey.display)")
        }
    }

    /// Display the Spelling and Grammar window.
    /// Default: Shift-Command-Colon
    fileprivate func _showSpellingAndGrammar() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showSpellingAndGrammar):", DocumentKeyBinding.showSpellingAndGrammar.shortcut.display, "\(DocumentKeyBinding.showSpellingAndGrammar.hotKey.display)")
        }
    }

    /// Find misspelled words in the document.
    /// Default: Command-Semicolon
    fileprivate func _findMisspelledWords() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (findMisspelledWords):", DocumentKeyBinding.findMisspelledWords.shortcut.display, "\(DocumentKeyBinding.findMisspelledWords.hotKey.display)")
        }
    }

    // MARK: - Text Editing

    /// Delete the word to the left of the insertion point.
    /// Default: Option-Delete
    fileprivate func _deleteWordLeft() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (deleteWordLeft):", DocumentKeyBinding.deleteWordLeft.shortcut.display, "\(DocumentKeyBinding.deleteWordLeft.hotKey.display)")
        }
    }

    /// Delete the character to the left of the insertion point. Or use Delete.
    /// Default: Control-H
    fileprivate func _deleteCharacterLeft() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (deleteCharacterLeft):", DocumentKeyBinding.deleteCharacterLeft.shortcut.display, "\(DocumentKeyBinding.deleteCharacterLeft.hotKey.display)")
        }
    }

    /// Delete the character to the right of the insertion point. Or use Fn-Delete.
    /// Default: Control-D
    fileprivate func _deleteCharacterRight() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (deleteCharacterRight):", DocumentKeyBinding.deleteCharacterRight.shortcut.display, "\(DocumentKeyBinding.deleteCharacterRight.hotKey.display)")
        }
    }

    /// Forward delete on keyboards that don't have a Forward Delete key. Or use Control-D.
    /// Default: Fn-Delete
    fileprivate func _forwardDelete() {
        if VERBOSE_DEBUG_MODE {
            print("TODO: FORWARD-DELETE")
        }
    }

    /// Delete the text between the insertion point and the end of the line or paragraph.
    /// Default: Control-K
    fileprivate func _deleteToEndOfLine() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (deleteToEndOfLine):", DocumentKeyBinding.deleteToEndOfLine.shortcut.display, "\(DocumentKeyBinding.deleteToEndOfLine.hotKey.display)")
        }
    }

    // MARK: - Navigation

    /// Scroll up one page.
    /// Default: Fn–Up Arrow
    fileprivate func _pageUp() {
        if VERBOSE_DEBUG_MODE {
            print("TODO: PAGE-UP")
        }
    }

    /// Scroll down one page.
    /// Default: Fn–Down Arrow
    fileprivate func _pageDown() {
        if VERBOSE_DEBUG_MODE {
            print("TODO: PAGE-DOWN")
        }
    }

    /// Scroll to the beginning of a document.
    /// Default: Fn–Left Arrow
    fileprivate func _home() {
        if VERBOSE_DEBUG_MODE {
            print("TODO: HOME")
        }
    }

    /// Scroll to the end of a document.
    /// Default: Fn–Right Arrow
    fileprivate func _end() {
        if VERBOSE_DEBUG_MODE {
            print("TODO: END")
        }
    }

    /// Move the insertion point to the beginning of the document.
    /// Default: Command–Up Arrow
    fileprivate func _moveToBeginningOfDocument() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (moveToBeginningOfDocument):", DocumentKeyBinding.moveToBeginningOfDocument.shortcut.display, "\(DocumentKeyBinding.moveToBeginningOfDocument.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .up,
                destination: .document,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: .up)
    }

    /// Move the insertion point to the end of the document.
    /// Default: Command–Down Arrow
    fileprivate func _moveToEndOfDocument() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (moveToEndOfDocument):", DocumentKeyBinding.moveToEndOfDocument.shortcut.display, "\(DocumentKeyBinding.moveToEndOfDocument.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .down,
                destination: .document,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: .down)
    }

    /// Move the insertion point to the beginning of the current line.
    /// Default: Command–Left Arrow
    fileprivate func _moveToBeginningOfLine() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (moveToBeginningOfLine):", DocumentKeyBinding.moveToBeginningOfLine.shortcut.display, "\(DocumentKeyBinding.moveToBeginningOfLine.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .left,
                destination: .line,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Move the insertion point to the end of the current line.
    /// Default: Command–Right Arrow
    fileprivate func _moveToEndOfLine() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (moveToEndOfLine):", DocumentKeyBinding.moveToEndOfLine.shortcut.display, "\(DocumentKeyBinding.moveToEndOfLine.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .right,
                destination: .line,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Move the insertion point to the beginning of the previous word.
    /// Default: Option–Left Arrow
    fileprivate func _moveToBeginningOfPreviousWord() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveToBeginningOfPreviousWord):", DocumentKeyBinding.moveToBeginningOfPreviousWord.shortcut.display, "\(DocumentKeyBinding.moveToBeginningOfPreviousWord.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .left,
                destination: .word,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Move the insertion point to the end of the next word.
    /// Default: Option–Right Arrow
    fileprivate func _moveToEndOfNextWord() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveToEndOfNextWord):", DocumentKeyBinding.moveToEndOfNextWord.shortcut.display, "\(DocumentKeyBinding.moveToEndOfNextWord.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .right,
                destination: .word,
                extending: false,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    // MARK: - Text Selection

    /// Select the text between the insertion point and the beginning of the document.
    /// Default: Shift–Command–Up Arrow
    fileprivate func _selectToBeginningOfDocument() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (selectToBeginningOfDocument):", DocumentKeyBinding.selectToBeginningOfDocument.shortcut.display, "\(DocumentKeyBinding.selectToBeginningOfDocument.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .up,
                destination: .document,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: .up)
    }

    /// Select the text between the insertion point and the end of the document.
    /// Default: Shift–Command–Down Arrow
    fileprivate func _selectToEndOfDocument() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (selectToEndOfDocument):", DocumentKeyBinding.selectToEndOfDocument.shortcut.display, "\(DocumentKeyBinding.selectToEndOfDocument.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .down,
                destination: .document,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: .down)
    }

    /// Select the text between the insertion point and the beginning of the current line.
    /// Default: Shift–Command–Left Arrow
    fileprivate func _selectToBeginningOfLine() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (selectToBeginningOfLine):", DocumentKeyBinding.selectToBeginningOfLine.shortcut.display, "\(DocumentKeyBinding.selectToBeginningOfLine.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .left,
                destination: .line,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Select the text between the insertion point and the end of the current line.
    /// Default: Shift–Command–Right Arrow
    fileprivate func _selectToEndOfLine() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (selectToEndOfLine):", DocumentKeyBinding.selectToEndOfLine.shortcut.display, "\(DocumentKeyBinding.selectToEndOfLine.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .right,
                destination: .line,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Extend text selection to the nearest character at the same horizontal location on the line above.
    /// Default: Shift–Up Arrow
    fileprivate func _extendSelectionUp() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionUp):", DocumentKeyBinding.extendSelectionUp.shortcut.display, "\(DocumentKeyBinding.extendSelectionUp.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .up,
                destination: .character,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: .up)
    }

    /// Extend text selection to the nearest character at the same horizontal location on the line below.
    /// Default: Shift–Down Arrow
    fileprivate func _extendSelectionDown() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionDown):", DocumentKeyBinding.extendSelectionDown.shortcut.display, "\(DocumentKeyBinding.extendSelectionDown.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .down,
                destination: .character,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: .down)
    }

    /// Extend text selection one character to the left.
    /// Default: Shift–Left Arrow
    fileprivate func _extendSelectionLeft() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionLeft):", DocumentKeyBinding.extendSelectionLeft.shortcut.display, "\(DocumentKeyBinding.extendSelectionLeft.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .left,
                destination: .character,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Extend text selection one character to the right.
    /// Default: Shift–Right Arrow
    fileprivate func _extendSelectionRight() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionRight):", DocumentKeyBinding.extendSelectionRight.shortcut.display, "\(DocumentKeyBinding.extendSelectionRight.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .right,
                destination: .character,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Extend text selection to the beginning of the current paragraph, then to the beginning of the following paragraph if pressed again.
    /// Default: Option–Shift–Up Arrow
    fileprivate func _extendSelectionToBeginningOfParagraph() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionToBeginningOfParagraph):", DocumentKeyBinding.extendSelectionToBeginningOfParagraph.shortcut.display, "\(DocumentKeyBinding.extendSelectionToBeginningOfParagraph.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .left,
                destination: .paragraph,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Extend text selection to the end of the current paragraph, then to the end of the following paragraph if pressed again.
    /// Default: Option–Shift–Down Arrow
    fileprivate func _extendSelectionToEndOfParagraph() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionToEndOfParagraph):", DocumentKeyBinding.extendSelectionToEndOfParagraph.shortcut.display, "\(DocumentKeyBinding.extendSelectionToEndOfParagraph.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .right,
                destination: .paragraph,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Extend text selection to the beginning of the current word, then to the beginning of the following word if pressed again.
    /// Default: Option–Shift–Left Arrow
    fileprivate func _extendSelectionToBeginningOfWord() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionToBeginningOfWord):", DocumentKeyBinding.extendSelectionToBeginningOfWord.shortcut.display, "\(DocumentKeyBinding.extendSelectionToBeginningOfWord.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .left,
                destination: .word,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    /// Extend text selection to the end of the current word, then to the end of the following word if pressed again.
    /// Default: Option–Shift–Right Arrow
    fileprivate func _extendSelectionToEndOfWord() {
        if VERBOSE_DEBUG_MODE {
            print("RUN (extendSelectionToEndOfWord):", DocumentKeyBinding.extendSelectionToEndOfWord.shortcut.display, "\(DocumentKeyBinding.extendSelectionToEndOfWord.hotKey.display)")
        }
        let textSelectionNavigation = textLayoutManager!.textSelectionNavigation
        textLayoutManager!.textSelections = textLayoutManager!.textSelections.compactMap {
            textSelectionNavigation.destinationSelection(
                for: $0,
                direction: .right,
                destination: .word,
                extending: true,
                confined: false
            )
        }
        updateLayout(direction: nil)
    }

    // MARK: - Cursor Movement

    /// Move to the beginning of the line or paragraph.
    /// Default: Control-A
    fileprivate func _moveToBeginningOfLineOrParagraph() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveToBeginningOfLineOrParagraph):", DocumentKeyBinding.moveToBeginningOfLineOrParagraph.shortcut.display, "\(DocumentKeyBinding.moveToBeginningOfLineOrParagraph.hotKey.display)")
        }
    }

    /// Move to the end of a line or paragraph.
    /// Default: Control-E
    fileprivate func _moveToEndOfLineOrParagraph() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveToEndOfLineOrParagraph):", DocumentKeyBinding.moveToEndOfLineOrParagraph.shortcut.display, "\(DocumentKeyBinding.moveToEndOfLineOrParagraph.hotKey.display)")
        }
    }

    /// Move one character forward.
    /// Default: Control-F
    fileprivate func _moveForwardOneCharacter() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveForwardOneCharacter):", DocumentKeyBinding.moveForwardOneCharacter.shortcut.display, "\(DocumentKeyBinding.moveForwardOneCharacter.hotKey.display)")
        }
    }

    /// Move one character backward.
    /// Default: Control-B
    fileprivate func _moveBackwardOneCharacter() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveBackwardOneCharacter):", DocumentKeyBinding.moveBackwardOneCharacter.shortcut.display, "\(DocumentKeyBinding.moveBackwardOneCharacter.hotKey.display)")
        }
    }

    /// Center the cursor or selection in the visible area.
    /// Default: Control-L
    fileprivate func _centerCursor() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (centerCursor):", DocumentKeyBinding.centerCursor.shortcut.display, "\(DocumentKeyBinding.centerCursor.hotKey.display)")
        }
    }

    /// Move up one line.
    /// Default: Control-P
    fileprivate func _moveUpOneLine() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveUpOneLine):", DocumentKeyBinding.moveUpOneLine.shortcut.display, "\(DocumentKeyBinding.moveUpOneLine.hotKey.display)")
        }
    }

    /// Move down one line.
    /// Default: Control-N
    fileprivate func _moveDownOneLine() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveDownOneLine):", DocumentKeyBinding.moveDownOneLine.shortcut.display, "\(DocumentKeyBinding.moveDownOneLine.hotKey.display)")
        }
    }

    /// Insert a new line after the insertion point.
    /// Default: Control-O
    fileprivate func _insertNewLine() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (insertNewLine):", DocumentKeyBinding.insertNewLine.shortcut.display, "\(DocumentKeyBinding.insertNewLine.hotKey.display)")
        }
    }

    /// Swap the character behind the insertion point with the character in front of the insertion point.
    /// Default: Control-T
    fileprivate func _swapCharacters() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (swapCharacters):", DocumentKeyBinding.swapCharacters.shortcut.display, "\(DocumentKeyBinding.swapCharacters.hotKey.display)")
        }
    }

    // MARK: - Text Alignment

    /// Left align.
    /// Default: Command–Left Curly Bracket
    fileprivate func _leftAlign() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (leftAlign):", DocumentKeyBinding.leftAlign.shortcut.display, "\(DocumentKeyBinding.leftAlign.hotKey.display)")
        }
    }

    /// Right align.
    /// Default: Command–Right Curly Bracket
    fileprivate func _rightAlign() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (rightAlign):", DocumentKeyBinding.rightAlign.shortcut.display, "\(DocumentKeyBinding.rightAlign.hotKey.display)")
        }
    }

    /// Center align.
    /// Default: Shift–Command–Vertical bar
    fileprivate func _centerAlign() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (centerAlign):", DocumentKeyBinding.centerAlign.shortcut.display, "\(DocumentKeyBinding.centerAlign.hotKey.display)")
        }
    }

    // MARK: - Search and Toolbar

    /// Go to the search field.
    /// Default: Option-Command-F
    fileprivate func _goToSearchField() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (goToSearchField):", DocumentKeyBinding.goToSearchField.shortcut.display, "\(DocumentKeyBinding.goToSearchField.hotKey.display)")
        }
    }

    /// Show or hide a toolbar in the app.
    /// Default: Option-Command-T
    fileprivate func _showHideToolbar() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showHideToolbar):", DocumentKeyBinding.showHideToolbar.shortcut.display, "\(DocumentKeyBinding.showHideToolbar.hotKey.display)")
        }
    }

    // MARK: - Style Operations

    /// Copy Style: Copy the formatting settings of the selected item to the Clipboard.
    /// Default: Option-Command-C
    fileprivate func _copyStyle() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (copyStyle):", DocumentKeyBinding.copyStyle.shortcut.display, "\(DocumentKeyBinding.copyStyle.hotKey.display)")
        }
    }

    /// Paste Style: Apply the copied style to the selected item.
    /// Default: Option-Command-V
    fileprivate func _pasteStyle() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (pasteStyle):", DocumentKeyBinding.pasteStyle.shortcut.display, "\(DocumentKeyBinding.pasteStyle.hotKey.display)")
        }
    }

    /// Paste and Match Style: Apply the style of the surrounding content to the item pasted within that content.
    /// Default: Option-Shift-Command-V
    fileprivate func _pasteAndMatchStyle() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (pasteAndMatchStyle):", DocumentKeyBinding.pasteAndMatchStyle.shortcut.display, "\(DocumentKeyBinding.pasteAndMatchStyle.hotKey.display)")
        }
    }

    // MARK: - Inspector and Page Setup

    /// Show or hide the inspector window.
    /// Default: Option-Command-I
    fileprivate func _showHideInspectorWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showHideInspectorWindow):", DocumentKeyBinding.showHideInspectorWindow.shortcut.display, "\(DocumentKeyBinding.showHideInspectorWindow.hotKey.display)")
        }
    }

    /// Page setup: Display a window for selecting document settings.
    /// Default: Shift-Command-P
    fileprivate func _pageSetup() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (pageSetup):", DocumentKeyBinding.pageSetup.shortcut.display, "\(DocumentKeyBinding.pageSetup.hotKey.display)")
        }
    }

    /// Display the Save As dialog, or duplicate the current document.
    /// Default: Shift-Command-S
    fileprivate func _saveAs() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (saveAs):", DocumentKeyBinding.saveAs.shortcut.display, "\(DocumentKeyBinding.saveAs.hotKey.display)")
        }
    }

    // MARK: - Text Size

    /// Decrease the size of the selected item.
    /// Default: Shift–Command–Minus sign
    fileprivate func _decreaseSize() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (decreaseSize):", DocumentKeyBinding.decreaseSize.shortcut.display, "\(DocumentKeyBinding.decreaseSize.hotKey.display)")
        }
    }

    /// Increase the size of the selected item. Command–Equal sign (=) performs the same function.
    /// Default: Shift–Command–Plus sign
    fileprivate func _increaseSize() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (increaseSize):", DocumentKeyBinding.increaseSize.shortcut.display, "\(DocumentKeyBinding.increaseSize.hotKey.display)")
        }
    }

    // MARK: - Help Menu

    /// Open the Help menu.
    /// Default: Shift–Command–Question mark
    fileprivate func _openHelpMenu() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openHelpMenu):", DocumentKeyBinding.openHelpMenu.shortcut.display, "\(DocumentKeyBinding.openHelpMenu.hotKey.display)")
        }
    }

    // MARK: - Standard Edit Operations

    /// Undo the last action.
    /// Default: Command-Z
    fileprivate func _undo() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (undo):", DocumentKeyBinding.undo.shortcut.display, "\(DocumentKeyBinding.undo.hotKey.display)")
        }
    }

    /// Redo the last undone action.
    /// Default: Shift-Command-Z
    fileprivate func _redo() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (redo):", DocumentKeyBinding.redo.shortcut.display, "\(DocumentKeyBinding.redo.hotKey.display)")
        }
    }

    /// Cut the selected text and copy it to the clipboard.
    /// Default: Command-X
    fileprivate func _cut() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (cut):", DocumentKeyBinding.cut.shortcut.display, "\(DocumentKeyBinding.cut.hotKey.display)")
        }
    }

    /// Copy the selected text to the clipboard.
    /// Default: Command-C
    fileprivate func _copy() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (copy):", DocumentKeyBinding.copy.shortcut.display, "\(DocumentKeyBinding.copy.hotKey.display)")
        }
    }

    /// Paste the text from the clipboard.
    /// Default: Command-V
    fileprivate func _paste() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (paste):", DocumentKeyBinding.paste.shortcut.display, "\(DocumentKeyBinding.paste.hotKey.display)")
        }
    }

    /// Select all text.
    /// Default: Command-A
    fileprivate func _selectAll() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (selectAll):", DocumentKeyBinding.selectAll.shortcut.display, "\(DocumentKeyBinding.selectAll.hotKey.display)")
        }
    }

    // MARK: - Find and Replace

    /// Open the Find dialog.
    /// Default: Command-F
    fileprivate func _find() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (find):", DocumentKeyBinding.find.shortcut.display, "\(DocumentKeyBinding.find.hotKey.display)")
        }
    }

    /// Find the next occurrence of the search term.
    /// Default: Command-G
    fileprivate func _findNext() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (findNext):", DocumentKeyBinding.findNext.shortcut.display, "\(DocumentKeyBinding.findNext.hotKey.display)")
        }
    }

    /// Find the previous occurrence of the search term.
    /// Default: Shift-Command-G
    fileprivate func _findPrevious() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (findPrevious):", DocumentKeyBinding.findPrevious.shortcut.display, "\(DocumentKeyBinding.findPrevious.hotKey.display)")
        }
    }

    /// Open the Replace dialog.
    /// Default: Option-Command-F
    fileprivate func _replace() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (replace):", DocumentKeyBinding.replace.shortcut.display, "\(DocumentKeyBinding.replace.hotKey.display)")
        }
    }

    /// Replace all occurrences of the search term.
    /// Default: Option-Command-G
    fileprivate func _replaceAll() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (replaceAll):", DocumentKeyBinding.replaceAll.shortcut.display, "\(DocumentKeyBinding.replaceAll.hotKey.display)")
        }
    }

    /// Replace the current occurrence and find the next one.
    /// Default: Option-Command-E
    fileprivate func _replaceAndFindNext() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (replaceAndFindNext):", DocumentKeyBinding.replaceAndFindNext.shortcut.display, "\(DocumentKeyBinding.replaceAndFindNext.hotKey.display)")
        }
    }

    /// Jump to the selection.
    /// Default: Command-J
    fileprivate func _jumpToSelection() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (jumpToSelection):", DocumentKeyBinding.jumpToSelection.shortcut.display, "\(DocumentKeyBinding.jumpToSelection.hotKey.display)")
        }
    }

    /// Center the selection in the window.
    /// Default: Command-L
    fileprivate func _centerSelectionInWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (centerSelectionInWindow):", DocumentKeyBinding.centerSelectionInWindow.shortcut.display, "\(DocumentKeyBinding.centerSelectionInWindow.hotKey.display)")
        }
    }

    // MARK: - File Operations

    /// Save the current document.
    /// Default: Command-S
    fileprivate func _save() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (save):", DocumentKeyBinding.save.shortcut.display, "\(DocumentKeyBinding.save.hotKey.display)")
        }
    }

    /// Print the current document.
    /// Default: Command-P
    fileprivate func _print() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (print):", DocumentKeyBinding.print.shortcut.display, "\(DocumentKeyBinding.print.hotKey.display)")
        }
    }

    /// Close the current window.
    /// Default: Command-W
    fileprivate func _closeWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (closeWindow):", DocumentKeyBinding.closeWindow.shortcut.display, "\(DocumentKeyBinding.closeWindow.hotKey.display)")
        }
    }

    /// Minimize the current window.
    /// Default: Command-M
    fileprivate func _minimizeWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (minimizeWindow):", DocumentKeyBinding.minimizeWindow.shortcut.display, "\(DocumentKeyBinding.minimizeWindow.hotKey.display)")
        }
    }

    /// Zoom the current window.
    /// Default: Option-Command-Equals Sign
    fileprivate func _zoomWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (zoomWindow):", DocumentKeyBinding.zoomWindow.shortcut.display, "\(DocumentKeyBinding.zoomWindow.hotKey.display)")
        }
    }

    /// Open a file.
    /// Default: Command-O
    fileprivate func _open() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (open):", DocumentKeyBinding.open.shortcut.display, "\(DocumentKeyBinding.open.hotKey.display)")
        }
    }

    /// Create a new document.
    /// Default: Command-N
    fileprivate func _newDocument() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (newDocument):", DocumentKeyBinding.newDocument.shortcut.display, "\(DocumentKeyBinding.newDocument.hotKey.display)")
        }
    }

    /// Quit the current application.
    /// Default: Command-Q
    fileprivate func _quitApplication() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (quitApplication):", DocumentKeyBinding.quitApplication.shortcut.display, "\(DocumentKeyBinding.quitApplication.hotKey.display)")
        }
    }

    /// Hide the current application.
    /// Default: Command-H
    fileprivate func _hideApplication() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (hideApplication):", DocumentKeyBinding.hideApplication.shortcut.display, "\(DocumentKeyBinding.hideApplication.hotKey.display)")
        }
    }

    /// Hide all other applications.
    /// Default: Option-Command-H
    fileprivate func _hideOthers() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (hideOthers):", DocumentKeyBinding.hideOthers.shortcut.display, "\(DocumentKeyBinding.hideOthers.hotKey.display)")
        }
    }

    /// Show all windows of the current application.
    /// Default: Command-Option-M
    fileprivate func _showAllWindows() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showAllWindows):", DocumentKeyBinding.showAllWindows.shortcut.display, "\(DocumentKeyBinding.showAllWindows.hotKey.display)")
        }
    }

    // MARK: - Tab Navigation

    /// Switch to the next tab.
    /// Default: Control-Tab
    fileprivate func _switchToNextTab() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (switchToNextTab):", DocumentKeyBinding.switchToNextTab.shortcut.display, "\(DocumentKeyBinding.switchToNextTab.hotKey.display)")
        }
    }

    /// Switch to the previous tab.
    /// Default: Shift-Control-Tab
    fileprivate func _switchToPreviousTab() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (switchToPreviousTab):", DocumentKeyBinding.switchToPreviousTab.shortcut.display, "\(DocumentKeyBinding.switchToPreviousTab.hotKey.display)")
        }
    }

    // MARK: - Focus Navigation

    /// Move focus to the next window.
    /// Default: Command-`
    fileprivate func _moveFocusToNextWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveFocusToNextWindow):", DocumentKeyBinding.moveFocusToNextWindow.shortcut.display, "\(DocumentKeyBinding.moveFocusToNextWindow.hotKey.display)")
        }
    }

    /// Move focus to the menu bar.
    /// Default: Control-F2
    fileprivate func _moveFocusToMenuBar() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveFocusToMenuBar):", DocumentKeyBinding.moveFocusToMenuBar.shortcut.display, "\(DocumentKeyBinding.moveFocusToMenuBar.hotKey.display)")
        }
    }

    /// Move focus to the Dock.
    /// Default: Control-F3
    fileprivate func _moveFocusToDock() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveFocusToDock):", DocumentKeyBinding.moveFocusToDock.shortcut.display, "\(DocumentKeyBinding.moveFocusToDock.hotKey.display)")
        }
    }

    /// Move focus to the toolbar.
    /// Default: Control-F5
    fileprivate func _moveFocusToToolbar() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveFocusToToolbar):", DocumentKeyBinding.moveFocusToToolbar.shortcut.display, "\(DocumentKeyBinding.moveFocusToToolbar.hotKey.display)")
        }
    }

    /// Move focus to the floating window.
    /// Default: Control-F6
    fileprivate func _moveFocusToFloatingWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (moveFocusToFloatingWindow):", DocumentKeyBinding.moveFocusToFloatingWindow.shortcut.display, "\(DocumentKeyBinding.moveFocusToFloatingWindow.hotKey.display)")
        }
    }

    // MARK: - Screenshots

    /// Take a screenshot of a selected area.
    /// Default: Shift-Command-4
    fileprivate func _takeScreenshot() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (takeScreenshot):", DocumentKeyBinding.takeScreenshot.shortcut.display, "\(DocumentKeyBinding.takeScreenshot.hotKey.display)")
        }
    }

    /// Take a screenshot of a window.
    /// Default: Shift-Command-4, then Space
    fileprivate func _takeScreenshotOfWindow() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (takeScreenshotOfWindow):", DocumentKeyBinding.takeScreenshotOfWindow.shortcut.display, "\(DocumentKeyBinding.takeScreenshotOfWindow.hotKey.display)")
        }
    }

    /// Take a screenshot of the entire screen.
    /// Default: Shift-Command-3
    fileprivate func _takeScreenshotOfEntireScreen() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (takeScreenshotOfEntireScreen):", DocumentKeyBinding.takeScreenshotOfEntireScreen.shortcut.display, "\(DocumentKeyBinding.takeScreenshotOfEntireScreen.hotKey.display)")
        }
    }

    // MARK: - System Operations

    /// Open Spotlight search.
    /// Default: Command-Space
    fileprivate func _openSpotlight() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openSpotlight):", DocumentKeyBinding.openSpotlight.shortcut.display, "\(DocumentKeyBinding.openSpotlight.hotKey.display)")
        }
    }

    /// Open Finder search.
    /// Default: Option-Command-Space
    fileprivate func _openFinder() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openFinder):", DocumentKeyBinding.openFinder.shortcut.display, "\(DocumentKeyBinding.openFinder.hotKey.display)")
        }
    }

    /// Open Mission Control.
    /// Default: Control-Up Arrow
    fileprivate func _openMissionControl() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openMissionControl):", DocumentKeyBinding.openMissionControl.shortcut.display, "\(DocumentKeyBinding.openMissionControl.hotKey.display)")
        }
    }

    /// Show all windows of the current application.
    /// Default: Control-Down Arrow
    fileprivate func _openApplicationWindows() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openApplicationWindows):", DocumentKeyBinding.openApplicationWindows.shortcut.display, "\(DocumentKeyBinding.openApplicationWindows.hotKey.display)")
        }
    }

    /// Show the Desktop.
    /// Default: F11
    fileprivate func _showDesktop() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showDesktop):", DocumentKeyBinding.showDesktop.shortcut.display, "\(DocumentKeyBinding.showDesktop.hotKey.display)")
        }
    }

    /// Show the Dashboard.
    /// Default: F12
    fileprivate func _showDashboard() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (showDashboard):", DocumentKeyBinding.showDashboard.shortcut.display, "\(DocumentKeyBinding.showDashboard.hotKey.display)")
        }
    }

    /// Open Notification Center.
    /// Default: Option-Command-5
    fileprivate func _openNotificationCenter() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openNotificationCenter):", DocumentKeyBinding.openNotificationCenter.shortcut.display, "\(DocumentKeyBinding.openNotificationCenter.hotKey.display)")
        }
    }

    /// Open Launchpad.
    /// Default: F4
    fileprivate func _openLaunchpad() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openLaunchpad):", DocumentKeyBinding.openLaunchpad.shortcut.display, "\(DocumentKeyBinding.openLaunchpad.hotKey.display)")
        }
    }

    /// Open System Preferences.
    /// Default: Command-Comma
    fileprivate func _openSystemPreferences() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openSystemPreferences):", DocumentKeyBinding.openSystemPreferences.shortcut.display, "\(DocumentKeyBinding.openSystemPreferences.hotKey.display)")
        }
    }

    /// Open Dictionary.
    /// Default: Command-Control-D
    fileprivate func _openDictionary() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openDictionary):", DocumentKeyBinding.openDictionary.shortcut.display, "\(DocumentKeyBinding.openDictionary.hotKey.display)")
        }
    }

    /// Open Calculator.
    /// Default: Command-Control-C
    fileprivate func _openCalculator() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openCalculator):", DocumentKeyBinding.openCalculator.shortcut.display, "\(DocumentKeyBinding.openCalculator.hotKey.display)")
        }
    }

    /// Open Character Viewer.
    /// Default: Control-Command-Space
    fileprivate func _openCharacterViewer() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openCharacterViewer):", DocumentKeyBinding.openCharacterViewer.shortcut.display, "\(DocumentKeyBinding.openCharacterViewer.hotKey.display)")
        }
    }

    /// Open Emoji & Symbols.
    /// Default: Control-Command-Space
    fileprivate func _openEmojiAndSymbols() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openEmojiAndSymbols):", DocumentKeyBinding.openEmojiAndSymbols.shortcut.display, "\(DocumentKeyBinding.openEmojiAndSymbols.hotKey.display)")
        }
    }

    /// Open Keyboard Viewer.
    /// Default: Command-Control-K
    fileprivate func _openKeyboardViewer() {
        if VERBOSE_DEBUG_MODE {
            print("TODO (openKeyboardViewer):", DocumentKeyBinding.openKeyboardViewer.shortcut.display, "\(DocumentKeyBinding.openKeyboardViewer.hotKey.display)")
        }
    }
}

fileprivate extension DocumentView {
    func updateLayout(direction: FocusSelectionRequest.ScrollDirection?) {
        if let direction = direction {
            focusSelectionRequest = .scrollTo(direction)
        }
        needsLayout = true
//        layer?.setNeedsLayout()
    }
}
