# Current Development

This project began as a simple proof of concept prototype, and now that the core rendering functionality has been proven viable I've since begun working on a fresh rewrite which you can checkout [over here]( https://github.com/SuperSwiftMarkup/SuperSwiftMarkup ).

The code herein will remain as is to be used as a reference while building out the new libraries.  

# A Better Markdown UI — WIP POC

When it comes to rich text display, interaction and editing, platform specific APIs often fall short—especially for things that are not expressible in terms of paragraphs, such as tables and fenced code blocks. (Less so for lists and blockquotes but there is still a semantic mismatch.) While workarounds exists, the results are often subpar and for some use cases there are no good solutions.

The goal is to build better iOS & macOS rich text views from the ground up that overcome the limitations of platform-specific text views, starting with the markdown format.

The overarching directive:
- First class (cross platform) support for all markdown container blocks and leaf blocks, with uniform behavior concerning text selection and selection-based navigation.
- First class (cross platform) support for multiple cursors/selections.
- Default support for everything under "Meeting the expectations of iOS and macOS users" (see [Appendix](#Appendix)).

Additionally:
- Horizontally scrollable fragments (on a per-fragment basis) as an alternative to text wrapping, supporting tables and fenced code blocks that cannot fit within the available space.

## Motivation

Imagine you need to display markdown in your app.  

You can build a pretty decent Markdown renderer in SwiftUI.

But imagine that you also need to support text selection.  

Good luck.

---

### The Problem
1. Text views on Apple platforms do not support text selection across multiple views.
2. One possible workaround is to render markdown in web views that can accommodate text selection but they have their own problems: 
    - Embedded browsers are a black box from the perspective of the enclosing view tree, they work best when there is only a single instance that can monopolize the enclosing view space among other things.   
    - Combining multiple web views is problematic. In one of my projects I was able to get vertically stacked web views to layout (somewhat) nicely when wrapped in a native scroll view but it was not reliable. 

If you also need **editable rich text** things are even more problematic.

### Why Build Something New?

After struggling with hacks and workarounds, it became clear that the root problem lies in the platform limitations. The only long-term solution is to build a new framework for Markdown rendering and interaction—one that any iOS or macOS app can adopt. This project aims to solve this problem once and for all, delivering a modern, flexible solution for Markdown-based text views.

---

# Current Development Preview

## Screenshots (as of 2025-1-24 at 9:30 PM)

If it hasn’t already been mentioned the current focus is read only rendering
with text selection and general navigation—what users would expect from a text
editor in read only mode.  

![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-1.png)
![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-2.png)
![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-3.png)
![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-4.png)
![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-5.png)
![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-6.png)
![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-7.png)
![blockquote preview 2 dark mode](screenshots/2025-1-24-night/screenshot-8.png)

### Supports Freakin Markdown Tables!

![blockquote preview 2 dark mode](screenshots/2025-1-27/tables-preview.png)

**With full text selection support:**
![blockquote preview 2 dark mode](screenshots/2025-1-27/tables-selection-preview.png)

**Some other simple examples:** 
![blockquote preview 2 dark mode](screenshots/2025-1-27/tables-preview-basic-1-light-mode.png)
![blockquote preview 2 dark mode](screenshots/2025-1-27/tables-preview-basic-1-dark-mode.png)

You can build a full spreadsheet application in terms of the low level markdown rendering engine that renders text in a more optimal manner based on what’s visible in the viewport with multi cursor/selection support. All that’s really missing is per-table horizontal scrolling support (for very long tables that can’t fit within their view dimensions) based on something like `CAScrollLayer` which may be available in a closed source commercial-only version.

----

**Debug Mode:**
![debug view light mode](screenshots/2025-1-23/debug-view-light-mode.png)

Typographic boundaries are denoted by the dotted borders as shown in the above.
Blue outlines denote primary lines while the trailing wrapped lines are denoted
by dotted red borders. The centered red dots at the left margin denote the actual
layout fragments in the view. 

**Text Selection:**
![text selection dark mode](screenshots/2025-1-23/text-selection-dark-mode.png)

**Multiple text selections are supported but (as of 2025-1-23) everything is still in heavy development:**
![text selection multi cursor light mode](screenshots/2025-1-23/text-selection-multi-cursor-light-mode.png)


---

# Appendix

## Meeting the expectations of iOS and macOS users

The goal is to provide a rich and intuitive text selection experience that meets the expectations of iOS and macOS users. This includes a comprehensive set of features that enhance usability and productivity as outlined in the following.

### Basic Text Selection
- **Tap and Hold**: Select a word by tapping and holding on it.
- **Drag Handles**: Adjust the selection by dragging the handles that appear at the start and end of the selected text.

### Double-Tap and Triple-Tap
- **Double-Tap**: Select a word.
- **Triple-Tap**: Select a paragraph.
- **Quadruple-Tap**: Select the entire text (in some applications).

### Context Menu
- **Cut, Copy, Paste**: Standard text manipulation options.
- **Replace**: Suggest replacements for the selected text.
- **Look Up**: Provide definitions, synonyms, and other relevant information.
- **Share**: Share the selected text via various apps and services.
- **Translate**: Translate the selected text into another language.
- **Speak**: Read the selected text aloud.

### Smart Selection
- **Intelligent Selection**: Automatically selects meaningful chunks of text, such as addresses, phone numbers, and dates.
- **Data Detectors**: Recognize and act on specific types of data (e.g., create a calendar event from a selected date).

### Spell and Grammar Checking

- **Automatic Correction**: Suggest and apply corrections for spelling and grammar errors.
- **Underline Errors**: Highlight spelling and grammar errors with underlines.
- **Suggestions**: Provide suggestions for correcting errors.

But in a context specific manner—by default—that ignores text in HTML tags, LaTeX math commands, inline code, code blocks (except for comments when syntax highlighting is available), etc.

### Voice Control
- **Voice Commands**: Use voice commands to select, edit, and manipulate text.
- **Dictation**: Convert spoken words into text.

### Accessibility Features
- **VoiceOver**: Read selected text aloud for visually impaired users.
- **Switch Control**: Use adaptive switches to select and manipulate text.
- **Text to Speech**: Convert selected text to speech.

### Multilingual Support
- **Language Detection**: Automatically detect and switch keyboards based on the language of the selected text.
- **Input Methods**: Support for various input methods and keyboards for different languages.

### Advanced Text Manipulation
- **Find and Replace**: Search for text and replace it with another string.
- **Text Transformation**: Convert text to uppercase, lowercase, or capitalize each word.
- **Text Wrapping**: Control how text wraps within a container.

### Clipboard Management
- **Multiple Clipboard Items**: Manage multiple copied items.
- **Clipboard History**: Access a history of copied items.

### Drag and Drop
- **Text Dragging**: Drag selected text to another location within the same app or to another app.
- **Drop Targets**: Drop selected text into compatible drop targets.

### Platform-Specific Features

#### iOS
- **QuickType Keyboard**: Predictive text and autocorrect.
- **Shortcuts**: Text replacement and keyboard shortcuts.

#### macOS
- **Services Menu**: Additional text services.
- **Dictation and Speech**: Enhanced dictation and text-to-speech features.


### Additionally

#### Text Annotation
- **Highlight**: Highlight selected text with different colors.
- **Comments**: Add comments or notes to selected text.

#### Code Block Syntax Highlighting 

- Automatic lazy loading of syntax highlighting code when available. 
- Additional smart spell checking support for comments within code blocks.
