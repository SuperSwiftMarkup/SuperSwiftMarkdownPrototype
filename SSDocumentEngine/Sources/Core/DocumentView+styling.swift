//
//  DocumentView+styling.swift
//  
//
//  Created by Colbyn Wadman on 1/14/25.
//

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


