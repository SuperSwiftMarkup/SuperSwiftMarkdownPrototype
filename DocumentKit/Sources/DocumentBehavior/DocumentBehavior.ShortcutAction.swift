//
//  KeyCommand.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/3/25.
//

extension DocumentBehavior {
    public enum ShortcutAction: Codable, Equatable, Hashable {
        // MARK: - CORE -
        case forward
        case backward
        case up
        case down
        case enter
        case delete
        
        // MARK: - Text Formatting

        /// Boldface the selected text, or turn boldfacing on or off.
        /// Default: Command-B
        case bold

        /// Italicize the selected text, or turn italics on or off.
        /// Default: Command-I
        case italic

        /// Add a web link.
        /// Default: Command-K
        case addWebLink

        /// Underline the selected text, or turn underlining on or off.
        /// Default: Command-U
        case underline

        /// Show or hide the Fonts window.
        /// Default: Command-T
        case showHideFontsWindow

        // MARK: - File and Folder Operations

        /// Select the Desktop folder from within an Open dialog or Save dialog.
        /// Default: Command-D
        case selectDesktopFolder

        /// Show or hide the definition of the selected word.
        /// Default: Control-Command-D
        case showHideDefinition

        /// Display the Spelling and Grammar window.
        /// Default: Shift-Command-Colon
        case showSpellingAndGrammar

        /// Find misspelled words in the document.
        /// Default: Command-Semicolon
        case findMisspelledWords

        // MARK: - Text Editing

        /// Delete the word to the left of the insertion point.
        /// Default: Option-Delete
        case deleteWordLeft

        /// Delete the character to the left of the insertion point. Or use Delete.
        /// Default: Control-H
        case deleteCharacterLeft

        /// Delete the character to the right of the insertion point. Or use Fn-Delete.
        /// Default: Control-D
        case deleteCharacterRight

        /// Forward delete on keyboards that don't have a Forward Delete key. Or use Control-D.
        /// Default: Fn-Delete
        case forwardDelete

        /// Delete the text between the insertion point and the end of the line or paragraph.
        /// Default: Control-K
        case deleteToEndOfLine

        // MARK: - Navigation

        /// Scroll up one page.
        /// Default: Fn–Up Arrow
        case pageUp

        /// Scroll down one page.
        /// Default: Fn–Down Arrow
        case pageDown

        /// Scroll to the beginning of a document.
        /// Default: Fn–Left Arrow
        case home

        /// Scroll to the end of a document.
        /// Default: Fn–Right Arrow
        case end

        /// Move the insertion point to the beginning of the document.
        /// Default: Command–Up Arrow
        case moveToBeginningOfDocument

        /// Move the insertion point to the end of the document.
        /// Default: Command–Down Arrow
        case moveToEndOfDocument

        /// Move the insertion point to the beginning of the current line.
        /// Default: Command–Left Arrow
        case moveToBeginningOfLine

        /// Move the insertion point to the end of the current line.
        /// Default: Command–Right Arrow
        case moveToEndOfLine

        /// Move the insertion point to the beginning of the previous word.
        /// Default: Option–Left Arrow
        case moveToBeginningOfPreviousWord

        /// Move the insertion point to the end of the next word.
        /// Default: Option–Right Arrow
        case moveToEndOfNextWord

        // MARK: - Text Selection

        /// Select the text between the insertion point and the beginning of the document.
        /// Default: Shift–Command–Up Arrow
        case selectToBeginningOfDocument

        /// Select the text between the insertion point and the end of the document.
        /// Default: Shift–Command–Down Arrow
        case selectToEndOfDocument

        /// Select the text between the insertion point and the beginning of the current line.
        /// Default: Shift–Command–Left Arrow
        case selectToBeginningOfLine

        /// Select the text between the insertion point and the end of the current line.
        /// Default: Shift–Command–Right Arrow
        case selectToEndOfLine

        /// Extend text selection to the nearest character at the same horizontal location on the line above.
        /// Default: Shift–Up Arrow
        case extendSelectionUp

        /// Extend text selection to the nearest character at the same horizontal location on the line below.
        /// Default: Shift–Down Arrow
        case extendSelectionDown

        /// Extend text selection one character to the left.
        /// Default: Shift–Left Arrow
        case extendSelectionLeft

        /// Extend text selection one character to the right.
        /// Default: Shift–Right Arrow
        case extendSelectionRight

        /// Extend text selection to the beginning of the current paragraph, then to the beginning of the following paragraph if pressed again.
        /// Default: Option–Shift–Up Arrow
        case extendSelectionToBeginningOfParagraph

        /// Extend text selection to the end of the current paragraph, then to the end of the following paragraph if pressed again.
        /// Default: Option–Shift–Down Arrow
        case extendSelectionToEndOfParagraph

        /// Extend text selection to the beginning of the current word, then to the beginning of the following word if pressed again.
        /// Default: Option–Shift–Left Arrow
        case extendSelectionToBeginningOfWord

        /// Extend text selection to the end of the current word, then to the end of the following word if pressed again.
        /// Default: Option–Shift–Right Arrow
        case extendSelectionToEndOfWord

        // MARK: - Cursor Movement

        /// Move to the beginning of the line or paragraph.
        /// Default: Control-A
        case moveToBeginningOfLineOrParagraph

        /// Move to the end of a line or paragraph.
        /// Default: Control-E
        case moveToEndOfLineOrParagraph

        /// Move one character forward.
        /// Default: Control-F
        case moveForwardOneCharacter

        /// Move one character backward.
        /// Default: Control-B
        case moveBackwardOneCharacter

        /// Center the cursor or selection in the visible area.
        /// Default: Control-L
        case centerCursor

        /// Move up one line.
        /// Default: Control-P
        case moveUpOneLine

        /// Move down one line.
        /// Default: Control-N
        case moveDownOneLine

        /// Insert a new line after the insertion point.
        /// Default: Control-O
        case insertNewLine

        /// Swap the character behind the insertion point with the character in front of the insertion point.
        /// Default: Control-T
        case swapCharacters

        // MARK: - Text Alignment

        /// Left align.
        /// Default: Command–Left Curly Bracket
        case leftAlign

        /// Right align.
        /// Default: Command–Right Curly Bracket
        case rightAlign

        /// Center align.
        /// Default: Shift–Command–Vertical bar
        case centerAlign

        // MARK: - Search and Toolbar

        /// Go to the search field.
        /// Default: Option-Command-F
        case goToSearchField

        /// Show or hide a toolbar in the app.
        /// Default: Option-Command-T
        case showHideToolbar

        // MARK: - Style Operations

        /// Copy Style: Copy the formatting settings of the selected item to the Clipboard.
        /// Default: Option-Command-C
        case copyStyle

        /// Paste Style: Apply the copied style to the selected item.
        /// Default: Option-Command-V
        case pasteStyle

        /// Paste and Match Style: Apply the style of the surrounding content to the item pasted within that content.
        /// Default: Option-Shift-Command-V
        case pasteAndMatchStyle

        // MARK: - Inspector and Page Setup

        /// Show or hide the inspector window.
        /// Default: Option-Command-I
        case showHideInspectorWindow

        /// Page setup: Display a window for selecting document settings.
        /// Default: Shift-Command-P
        case pageSetup

        /// Display the Save As dialog, or duplicate the current document.
        /// Default: Shift-Command-S
        case saveAs

        // MARK: - Text Size

        /// Decrease the size of the selected item.
        /// Default: Shift–Command–Minus sign
        case decreaseSize

        /// Increase the size of the selected item. Command–Equal sign (=) performs the same function.
        /// Default: Shift–Command–Plus sign
        case increaseSize

        // MARK: - Help Menu

        /// Open the Help menu.
        /// Default: Shift–Command–Question mark
        case openHelpMenu

        // MARK: - Standard Edit Operations

        /// Undo the last action.
        /// Default: Command-Z
        case undo

        /// Redo the last undone action.
        /// Default: Shift-Command-Z
        case redo

        /// Cut the selected text and copy it to the clipboard.
        /// Default: Command-X
        case cut

        /// Copy the selected text to the clipboard.
        /// Default: Command-C
        case copy

        /// Paste the text from the clipboard.
        /// Default: Command-V
        case paste

        /// Select all text.
        /// Default: Command-A
        case selectAll

        // MARK: - Find and Replace

        /// Open the Find dialog.
        /// Default: Command-F
        case find

        /// Find the next occurrence of the search term.
        /// Default: Command-G
        case findNext

        /// Find the previous occurrence of the search term.
        /// Default: Shift-Command-G
        case findPrevious

        /// Open the Replace dialog.
        /// Default: Option-Command-F
        case replace

        /// Replace all occurrences of the search term.
        /// Default: Option-Command-G
        case replaceAll

        /// Replace the current occurrence and find the next one.
        /// Default: Option-Command-E
        case replaceAndFindNext

        /// Jump to the selection.
        /// Default: Command-J
        case jumpToSelection

        /// Center the selection in the window.
        /// Default: Command-L
        case centerSelectionInWindow

        // MARK: - File Operations

        /// Save the current document.
        /// Default: Command-S
        case save

        /// Print the current document.
        /// Default: Command-P
        case print

        /// Close the current window.
        /// Default: Command-W
        case closeWindow

        /// Minimize the current window.
        /// Default: Command-M
        case minimizeWindow

        /// Zoom the current window.
        /// Default: Option-Command-Equals Sign
        case zoomWindow

        /// Open a file.
        /// Default: Command-O
        case open

        /// Create a new document.
        /// Default: Command-N
        case newDocument

        /// Quit the current application.
        /// Default: Command-Q
        case quitApplication

        /// Hide the current application.
        /// Default: Command-H
        case hideApplication

        /// Hide all other applications.
        /// Default: Option-Command-H
        case hideOthers

        /// Show all windows of the current application.
        /// Default: Command-Option-M
        case showAllWindows

        // MARK: - Tab Navigation

        /// Switch to the next tab.
        /// Default: Control-Tab
        case switchToNextTab

        /// Switch to the previous tab.
        /// Default: Shift-Control-Tab
        case switchToPreviousTab

        // MARK: - Focus Navigation

        /// Move focus to the next window.
        /// Default: Command-`
        case moveFocusToNextWindow

        /// Move focus to the menu bar.
        /// Default: Control-F2
        case moveFocusToMenuBar

        /// Move focus to the Dock.
        /// Default: Control-F3
        case moveFocusToDock

        /// Move focus to the toolbar.
        /// Default: Control-F5
        case moveFocusToToolbar

        /// Move focus to the floating window.
        /// Default: Control-F6
        case moveFocusToFloatingWindow

        // MARK: - Screenshots

        /// Take a screenshot of a selected area.
        /// Default: Shift-Command-4
        case takeScreenshot

        /// Take a screenshot of a window.
        /// Default: Shift-Command-4, then Space
        case takeScreenshotOfWindow

        /// Take a screenshot of the entire screen.
        /// Default: Shift-Command-3
        case takeScreenshotOfEntireScreen

        // MARK: - System Operations

        /// Open Spotlight search.
        /// Default: Command-Space
        case openSpotlight

        /// Open Finder search.
        /// Default: Option-Command-Space
        case openFinder

        /// Open Mission Control.
        /// Default: Control-Up Arrow
        case openMissionControl

        /// Show all windows of the current application.
        /// Default: Control-Down Arrow
        case openApplicationWindows

        /// Show the Desktop.
        /// Default: F11
        case showDesktop

        /// Show the Dashboard.
        /// Default: F12
        case showDashboard

        /// Open Notification Center.
        /// Default: Option-Command-5
        case openNotificationCenter

        /// Open Launchpad.
        /// Default: F4
        case openLaunchpad

        /// Open System Preferences.
        /// Default: Command-Comma
        case openSystemPreferences

        /// Open Dictionary.
        /// Default: Command-Control-D
        case openDictionary

        /// Open Calculator.
        /// Default: Command-Control-C
        case openCalculator

        /// Open Character Viewer.
        /// Default: Control-Command-Space
        case openCharacterViewer

        /// Open Emoji & Symbols.
        /// Default: Control-Command-Space
        case openEmojiAndSymbols

        /// Open Keyboard Viewer.
        /// Default: Command-Control-K
        case openKeyboardViewer
    }
}

extension DocumentBehavior.ShortcutAction {
    public var display: String {
        switch self {
        case .forward: return "Forward"
        case .backward: return "Backward"
        case .up: return "Up"
        case .down: return "Down"
        case .enter: return "Enter"
        case .delete: return "Delete"
        case .bold: return "Bold"
        case .italic: return "Italic"
        case .addWebLink: return "Add Web Link"
        case .underline: return "Underline"
        case .showHideFontsWindow: return "Show/Hide Fonts Window"
        case .selectDesktopFolder: return "Select Desktop Folder"
        case .showHideDefinition: return "Show/Hide Definition"
        case .showSpellingAndGrammar: return "Show Spelling and Grammar"
        case .findMisspelledWords: return "Find Misspelled Words"
        case .deleteWordLeft: return "Delete Word Left"
        case .deleteCharacterLeft: return "Delete Character Left"
        case .deleteCharacterRight: return "Delete Character Right"
        case .forwardDelete: return "Forward Delete"
        case .deleteToEndOfLine: return "Delete to End of Line"
        case .pageUp: return "Page Up"
        case .pageDown: return "Page Down"
        case .home: return "Home"
        case .end: return "End"
        case .moveToBeginningOfDocument: return "Move to Beginning of Document"
        case .moveToEndOfDocument: return "Move to End of Document"
        case .moveToBeginningOfLine: return "Move to Beginning of Line"
        case .moveToEndOfLine: return "Move to End of Line"
        case .moveToBeginningOfPreviousWord: return "Move to Beginning of Previous Word"
        case .moveToEndOfNextWord: return "Move to End of Next Word"
        case .selectToBeginningOfDocument: return "Select to Beginning of Document"
        case .selectToEndOfDocument: return "Select to End of Document"
        case .selectToBeginningOfLine: return "Select to Beginning of Line"
        case .selectToEndOfLine: return "Select to End of Line"
        case .extendSelectionUp: return "Extend Selection Up"
        case .extendSelectionDown: return "Extend Selection Down"
        case .extendSelectionLeft: return "Extend Selection Left"
        case .extendSelectionRight: return "Extend Selection Right"
        case .extendSelectionToBeginningOfParagraph: return "Extend Selection to Beginning of Paragraph"
        case .extendSelectionToEndOfParagraph: return "Extend Selection to End of Paragraph"
        case .extendSelectionToBeginningOfWord: return "Extend Selection to Beginning of Word"
        case .extendSelectionToEndOfWord: return "Extend Selection to End of Word"
        case .moveToBeginningOfLineOrParagraph: return "Move to Beginning of Line or Paragraph"
        case .moveToEndOfLineOrParagraph: return "Move to End of Line or Paragraph"
        case .moveForwardOneCharacter: return "Move Forward One Character"
        case .moveBackwardOneCharacter: return "Move Backward One Character"
        case .centerCursor: return "Center Cursor"
        case .moveUpOneLine: return "Move Up One Line"
        case .moveDownOneLine: return "Move Down One Line"
        case .insertNewLine: return "Insert New Line"
        case .swapCharacters: return "Swap Characters"
        case .leftAlign: return "Left Align"
        case .rightAlign: return "Right Align"
        case .centerAlign: return "Center Align"
        case .goToSearchField: return "Go to Search Field"
        case .showHideToolbar: return "Show/Hide Toolbar"
        case .copyStyle: return "Copy Style"
        case .pasteStyle: return "Paste Style"
        case .pasteAndMatchStyle: return "Paste and Match Style"
        case .showHideInspectorWindow: return "Show/Hide Inspector Window"
        case .pageSetup: return "Page Setup"
        case .saveAs: return "Save As"
        case .decreaseSize: return "Decrease Size"
        case .increaseSize: return "Increase Size"
        case .openHelpMenu: return "Open Help Menu"
        case .undo: return "Undo"
        case .redo: return "Redo"
        case .cut: return "Cut"
        case .copy: return "Copy"
        case .paste: return "Paste"
        case .selectAll: return "Select All"
        case .find: return "Find"
        case .findNext: return "Find Next"
        case .findPrevious: return "Find Previous"
        case .replace: return "Replace"
        case .replaceAll: return "Replace All"
        case .replaceAndFindNext: return "Replace and Find Next"
        case .jumpToSelection: return "Jump to Selection"
        case .centerSelectionInWindow: return "Center Selection in Window"
        case .save: return "Save"
        case .print: return "Print"
        case .closeWindow: return "Close Window"
        case .minimizeWindow: return "Minimize Window"
        case .zoomWindow: return "Zoom Window"
        case .open: return "Open"
        case .newDocument: return "New Document"
        case .quitApplication: return "Quit Application"
        case .hideApplication: return "Hide Application"
        case .hideOthers: return "Hide Others"
        case .showAllWindows: return "Show All Windows"
        case .switchToNextTab: return "Switch to Next Tab"
        case .switchToPreviousTab: return "Switch to Previous Tab"
        case .moveFocusToNextWindow: return "Move Focus to Next Window"
        case .moveFocusToMenuBar: return "Move Focus to Menu Bar"
        case .moveFocusToDock: return "Move Focus to Dock"
        case .moveFocusToToolbar: return "Move Focus to Toolbar"
        case .moveFocusToFloatingWindow: return "Move Focus to Floating Window"
        case .takeScreenshot: return "Take Screenshot"
        case .takeScreenshotOfWindow: return "Take Screenshot of Window"
        case .takeScreenshotOfEntireScreen: return "Take Screenshot of Entire Screen"
        case .openSpotlight: return "Open Spotlight"
        case .openFinder: return "Open Finder"
        case .openMissionControl: return "Open Mission Control"
        case .openApplicationWindows: return "Open Application Windows"
        case .showDesktop: return "Show Desktop"
        case .showDashboard: return "Show Dashboard"
        case .openNotificationCenter: return "Open Notification Center"
        case .openLaunchpad: return "Open Launchpad"
        case .openSystemPreferences: return "Open System Preferences"
        case .openDictionary: return "Open Dictionary"
        case .openCalculator: return "Open Calculator"
        case .openCharacterViewer: return "Open Character Viewer"
        case .openEmojiAndSymbols: return "Open Emoji & Symbols"
        case .openKeyboardViewer: return "Open Keyboard Viewer"
        }
    }
}

