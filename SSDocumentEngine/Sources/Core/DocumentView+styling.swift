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

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

import SSDMUtilities

extension DocumentView {
    override func viewDidChangeEffectiveAppearance() {
        super.viewDidChangeEffectiveAppearance()
        effectiveAppearance.performAsCurrentDrawingAppearance { [weak self] in
            guard let self else { return }
            updateColorScheme()
        }
    }
}

extension DocumentView {
    fileprivate func updateColorScheme() {
        let currentColorScheme = SSColorSchemeMode.detectColorScheme(view: self)
        if appliedColorScheme != currentColorScheme {
            redraw(newColorScheme: currentColorScheme)
        }
    }
    fileprivate func redraw(newColorScheme: SSColorSchemeMode) {
        switch newColorScheme {
        case .light:
            layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
        case .dark:
            layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
        }
        needsLayout = true
        setNeedsDisplay(bounds)
        appliedColorScheme = newColorScheme
    }
}


