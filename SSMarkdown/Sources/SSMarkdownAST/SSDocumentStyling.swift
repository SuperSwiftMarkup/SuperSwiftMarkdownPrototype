//
//  SSDocumentStyling.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

public final class SSDocumentStyling {
    let block: Block
    let inline: Inline
    let deemphasizedSyntaxColor: XColor = XColor.lightGray
    let prominentSyntaxColor: XColor = XColor.darkGray
    
    public init(
        block: Block,
        inline: Inline
    ) {
        self.block = block
        self.inline = inline
    }
    public struct BlockSpecificAttributes {
        let font: Font
        let foregroundColor: XColor?
        let showSyntax: Bool
        public init(font: Font, foregroundColor: XColor?, showSyntax: Bool) {
            self.font = font
            self.foregroundColor = foregroundColor
            self.showSyntax = showSyntax
        }
    }
}

extension SSDocumentStyling {
    public static var `default`: SSDocumentStyling {
        let showSyntax = false
        let foregroundColor: XColor? = XColor.textColor
        let codeForegroundColor: XColor? = XColor.black
        let blockCodeBackgroundColor: XColor? = nil
        let inlineCodeBackgroundColor: XColor? = XColor.lightGray.withAlphaComponent(0.2)
        let defaultFont = SSDocumentStyling.Font(size: 16, weight: .regular, design: .default)
        return SSDocumentStyling(
            block: .init(
                blockQuote: .init(font: defaultFont, foregroundColor: foregroundColor, showSyntax: showSyntax),
                orderedList: .init(font: defaultFont, foregroundColor: foregroundColor, showSyntax: showSyntax),
                unorderedList: .init(font: defaultFont, foregroundColor: foregroundColor, showSyntax: showSyntax),
                listItem: .init(font: defaultFont, foregroundColor: foregroundColor, showSyntax: showSyntax),
                table: .init(font: defaultFont, foregroundColor: foregroundColor, showSyntax: showSyntax),
                paragraph: .init(font: defaultFont, foregroundColor: foregroundColor, showSyntax: showSyntax),
                heading: .init(
                    h1: .init(
                        font: .init(size: 20, weight: .black, design: .default),
                        foregroundColor: foregroundColor,
                        showSyntax: true
                    ),
                    h2: .init(
                        font: .init(size: 18, weight: .heavy, design: .default),
                        foregroundColor: foregroundColor,
                        showSyntax: true
                    ),
                    h3: .init(
                        font: .init(size: 16, weight: .bold, design: .default),
                        foregroundColor: foregroundColor,
                        showSyntax: true
                    ),
                    h4: .init(
                        font: .init(size: 14, weight: .semibold, design: .default),
                        foregroundColor: foregroundColor,
                        showSyntax: true
                    ),
                    h5: .init(
                        font: .init(size: 12, weight: .medium, design: .default),
                        foregroundColor: foregroundColor,
                        showSyntax: true
                    ),
                    h6: .init(
                        font: .init(size: 10, weight: .regular, design: .default),
                        foregroundColor: foregroundColor,
                        showSyntax: true
                    )
                ),
                hTMLBlock: .init(
                    font: .init(size: defaultFont.size, weight: .light, design: .monospaced),
                    foregroundColor: codeForegroundColor,
                    backgroundColor: blockCodeBackgroundColor,
                    showSyntax: showSyntax
                ),
                thematicBreak: .init(font: defaultFont, foregroundColor: foregroundColor, showSyntax: showSyntax),
                codeBlock: .init(
                    font: Font(size: 14, weight: .regular, design: .monospaced),
                    foregroundColor: XColor.darkGray,
                    backgroundColor: blockCodeBackgroundColor,
                    showSyntax: true
                )
            ),
            inline: .init(
                emphasis: .init(
                    font: .init(size: 18, weight: .bold, design: .default),
                    foregroundColor: nil,
                    showSyntax: false
                ),
                imageLink: .init(
                    font: .init(size: 16, weight: .regular, design: .default),
                    foregroundColor: nil,
                    showSyntax: false
                ),
                link: .init(
                    font: .init(size: 16, weight: .regular, design: .default),
                    foregroundColor: nil,
                    showSyntax: false
                ),
                strikethrough: .init(
                    font: .init(size: 16, weight: .medium, design: .default),
                    foregroundColor: nil,
                    showSyntax: false
                ),
                strong: .init(
                    font: .init(size: 16, weight: .bold, design: .default),
                    foregroundColor: nil,
                    showSyntax: false
                ),
                inlineCode: .init(
                    font: .init(size: 16, weight: .light, design: .monospaced),
                    foregroundColor: codeForegroundColor,
                    backgroundColor: inlineCodeBackgroundColor,
                    showSyntax: false
                ),
                inlineHTML: .init(
                    font: .init(size: 16, weight: .regular, design: .monospaced),
                    foregroundColor: codeForegroundColor,
                    backgroundColor: inlineCodeBackgroundColor,
                    showSyntax: false
                ),
                lineBreak: .init(
                    value: "\n"
                ),
                softBreak: .init(
                    value: "\n"
                ),
                symbolLink: .init(
                    font: .init(size: 16, weight: .regular, design: .default),
                    foregroundColor: nil,
                    backgroundColor: inlineCodeBackgroundColor,
                    showSyntax: false
                ),
                text: .init(
                    font: .init(size: 16, weight: .regular, design: .default),
                    foregroundColor: nil,
                    showSyntax: false
                )
            )
        )
    }
}

