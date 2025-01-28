//
//  ThemeDefaults.swift
//
//
//  Created by Colbyn Wadman on 1/23/25.
//
// LICENSE file: https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md
//
// The code herein is distributed under a dual licensing model. Users may choose to use such under either:
//
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions of either the AGPLv3 or the commercial license, depending on the license you select.

import Foundation
import SSDMUtilities

internal struct ThemeDefaults {}

extension ThemeDefaults {
    public struct Colors {
        public static let textDefault: SSColorMap = .default
        public static let codeBlock: SSColorMap = .default
        public static let markup: SSColorMap = .default
    }
}

extension ThemeDefaults.Colors {
    public static let defaultTextForegroundColor: SSColorMap = SSColorMap.textColor
    public struct Block {
        fileprivate static let codeOrMarkup: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), dark: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        public static let blockQuote: SSColorMap = Self.codeOrMarkup
//        public static let orderedList: SSColorMap = .default
//        public static let unorderedList: SSColorMap = .default
//        public static let table: SSColorMap = .default
//        public static let paragraph: SSColorMap = .default
//        public static let heading: SSColorMap = .default
        public static let htmlBlock: SSColorMap = Self.codeOrMarkup
        public static let codeBlock: SSColorMap = Self.codeOrMarkup
//        public static let thematicBreak: SSColorMap = .default
//        public static let listItem: SSColorMap = .default
    }
    public struct Inline {
//        fileprivate static let codeOrMarkup: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), dark: #colorLiteral(red: 0.4068704177, green: 0.4915856192, blue: 0.6508389174, alpha: 1))
//        public static let emphasis: SSColorMap = .default
//        public static let imageLink: SSColorMap = .default
//        public static let link: SSColorMap = .default
//        public static let strikethrough: SSColorMap = .default
//        public static let strong: SSColorMap = .default
        public static let inlineCodeTextForeground: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), dark: #colorLiteral(red: 0.2763588325, green: 0.2962728927, blue: 0.3337086742, alpha: 1))
        public static let inlineCodeTokenForeground: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), dark: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).with(alpha: 0.9)
        public static let inlineCodeBackground: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.8967235978, green: 0.8967235978, blue: 0.8967235978, alpha: 1), dark: #colorLiteral(red: 0.3068073281, green: 0.3135197746, blue: 0.3261382803, alpha: 1)).with(alpha: 0.5)
        public static let inlineHTML: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), dark: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//        public static let lineBreak: SSColorMap = .default
//        public static let softBreak: SSColorMap = .default
//        public static let symbolLink: SSColorMap = .default
        public static let text: SSColorMap = .textColor
    }
}

extension ThemeDefaults.Colors.Block {
    public struct Header {
        public static let tokenForeground: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), dark: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        public static let textForeground: SSColorMap = SSColorMap(light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), dark: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
}
