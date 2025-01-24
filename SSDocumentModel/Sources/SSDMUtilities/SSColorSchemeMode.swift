//
//  SSColorSchemeMode.swift
//
//
//  Created by Colbyn Wadman on 1/23/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

public enum SSColorSchemeMode: Equatable {
    case light, dark
}

#if os(macOS) && !targetEnvironment(macCatalyst)
extension SSColorSchemeMode {
    fileprivate static func isDarkMode(view: NSView) -> Bool {
        view.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
    }
    public static func detectColorScheme(view: NSView) -> SSColorSchemeMode {
        if isDarkMode(view: view) {
            return .dark
        }
        return .light
    }
}
#endif

#if os(iOS) || os(visionOS)
#endif
