//
//  TextLayoutFragmentLayer.swift
//
//
//  Created by Colbyn Wadman on 1/14/25.
//
// LICENSE file: https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md
//
// The code herein is distributed under a dual licensing model. Users may choose to use such under either:
//
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions of either the AGPLv3 or the commercial license, depending on the license you select.

import CoreGraphics

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

import SSDMUtilities
import SSDocumentModel

fileprivate let FULL_DEBUG_MODE: Bool? = false
fileprivate let DEBUG_MODE_SHOW_LAYER_BOUNDS: Bool? = false
fileprivate let DEBUG_MODE_SHOW_LINE_FRAGMENT_BOUNDS: Bool? = false
fileprivate let DEBUG_MODE_SHOW_LAYER_FRAMES: Bool? = false

internal class TextLayoutFragmentLayer: CALayer {
    var parent: DocumentView?
    var layoutFragment: NSTextLayoutFragment!
    var padding: CGFloat
//    var showLayerFrames: Bool = false
    
    let strokeWidth: CGFloat = 2
    
    override class func defaultAction(forKey: String) -> CAAction? {
        // Suppress default opacity animations.
        return NSNull()
    }
    
    init(layoutFragment: NSTextLayoutFragment, padding: CGFloat) {
        self.layoutFragment = layoutFragment
        self.padding = padding
        super.init()
        masksToBounds = false
        contentsScale = 2
        updateGeometry()
        setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in context: CGContext) {
        drawBackgroundDebug(context: context)
        drawContent(context: context)
        drawForegroundDebug(context: context)
    }
    
    private var renderingSurfaceBoundsStrokeColor: NSColor { return .systemOrange }
    private var typographicBoundsStrokeColor: NSColor { return .systemIndigo }
    
    internal func updateGeometry() {
        setGeometryToFullWidth()
//        setGeometryToRenderingSurfaceBounds()
    }
}

// MARK: - INTERNAL HELPERS -

extension TextLayoutFragmentLayer {
    private func drawContent(context: CGContext) {
        var scopeDrawInfo = ScopeDrawInfo()
        let scopes = (layoutFragment.textElement as! NSTextParagraph).attributedString.lookupBlockScopes()
        for scope in scopes ?? [] {
            drawScopeBackground(context: context, scope: scope, scopeDrawInfo: &scopeDrawInfo)
        }
//        let drawLeadingBorder = scopeDrawInfo.indentLevels.first { $0.drawGraphic == true } != nil
//        if drawLeadingBorder {
//            let offsetX = layoutFragment.layoutFragmentFrame.origin.x + padding
////            guard level.drawGraphic else {
////                continue
////            }
//            let fillColor = SSColorMap( light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1971158593), dark: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) )
//            let beginX = -8 + offsetX
//            let frame = CGRect(
//                origin: .init(
//                    x: beginX,
//                    y: self.bounds.origin.y
//                ),
//                size: .init(width: 3, height: self.bounds.height)
//            )
//            context.saveGState()
//            context.setFillColor(fillColor.adaptiveColor.cgColor)
//            context.fill([frame])
//            context.restoreGState()
//        }
        renderScopeDrawInfo(context: context, scopeDrawInfo: scopeDrawInfo)
        if !scopeDrawInfo.skipDrawLayoutFragment {
            layoutFragment.draw(
                at: .init(
                    x: layoutFragment.layoutFragmentFrame.origin.x + padding,
                    y: 0
                ),
                in: context
            )
        }
    }
    private func drawScopeBackground(context: CGContext, scope: SSBlockType, scopeDrawInfo: inout ScopeDrawInfo) {
        switch scope {
        case .blockQuote:
            scopeDrawInfo.indentLevels.append(.init(drawGraphic: true))
//            scopeDrawInfo.drawFrameBackground = true
        case .orderedList:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: false))
            ()
        case .unorderedList:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: false))
            ()
        case .table:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: true))
            scopeDrawInfo.drawFrameBackground = .tableBlockLine
            ()
        case .paragraph: ()
        case .heading: ()
        case .htmlBlock:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: true))
            scopeDrawInfo.drawFrameBackground = .codeBlockLine
        case .codeBlock:
            scopeDrawInfo.drawFrameBackground = .codeBlockLine
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: true))
        case .thematicBreak:
            drawThematicBreak(context: context)
            scopeDrawInfo.skipDrawLayoutFragment = true
        case .listItem: ()
        }
    }
    private func renderScopeDrawInfo(context: CGContext, scopeDrawInfo: borrowing ScopeDrawInfo) {
        switch scopeDrawInfo.drawFrameBackground {
        case .codeBlockLine:
            let fillColor = SSColorMap( light: #colorLiteral(red: 0.9677360897, green: 0.9677360897, blue: 0.9677360897, alpha: 0.9970813141), dark: #colorLiteral(red: 0.1407243465, green: 0.147121262, blue: 0.1621632409, alpha: 1) )
            context.saveGState()
            context.setFillColor(fillColor.adaptiveColor.cgColor)
            context.fill([bounds])
            context.restoreGState()
        case .tableBlockLine:
//            let fillColor = SSColorMap( light: #colorLiteral(red: 0.9403009777, green: 0.9475113668, blue: 0.9643356081, alpha: 1), dark: #colorLiteral(red: 0.1407243465, green: 0.147121262, blue: 0.1621632409, alpha: 1) )
//            let fillColor = SSColorMap( light: #colorLiteral(red: 0.9826271663, green: 0.9826271663, blue: 0.9826271663, alpha: 1), dark: #colorLiteral(red: 0.1407243465, green: 0.147121262, blue: 0.1621632409, alpha: 1) )
            let fillColor = SSColorMap( light: #colorLiteral(red: 0.9826271663, green: 0.9826271663, blue: 0.9826271663, alpha: 1), dark: #colorLiteral(red: 0.137793652, green: 0.1394267114, blue: 0.1432667565, alpha: 1) )
            context.saveGState()
            context.setFillColor(fillColor.adaptiveColor.cgColor)
            let frame = layoutFragment.layoutFragmentFrame
                .mapOrigin {
                    .init(
                        x: min($0.x + self.padding, 0),
                        y: 0
                    )
                }
                .mapSize {
                    .init(
                        width: max($0.width, self.bounds.width),
                        height: $0.height
                    )
                }
            context.fill([frame])
            for line in self.layoutFragment.textLineFragments {
                line.enumerateTableRowMetadata { meta, range, span in
                    let (start, end) = span
                    let _ = end
//                    let borderColor = SSColorMap( light: #colorLiteral(red: 0.7966698894, green: 0.7966698894, blue: 0.7966698894, alpha: 1), dark: #colorLiteral(red: 0.3496662196, green: 0.3496662196, blue: 0.3496662196, alpha: 1) )
                    let borderColor = SSColorMap( light: #colorLiteral(red: 0.7966698894, green: 0.7966698894, blue: 0.7966698894, alpha: 1), dark: #colorLiteral(red: 0.2526755988, green: 0.2674100212, blue: 0.3017903399, alpha: 1) )
                    let drawTopLine: () -> () = {
                        let path = CGMutablePath()
                        path.move(to: .zero)
                        path.addLine(to: .init(x: self.bounds.width, y: 0))
                        context.addPath(path)
                        context.setLineWidth(1.0)
                        context.setStrokeColor(borderColor.adaptiveColor.cgColor)
                        context.strokePath()
                    }
                    let drawBottomLine: () -> () = {
                        let path = CGMutablePath()
                        let yPos = self.bounds.height
                        path.move(to: .init(x: 0, y: yPos))
                        path.addLine(to: .init(x: self.bounds.width, y: yPos))
                        context.addPath(path)
                        context.setLineWidth(1.0)
                        context.setStrokeColor(borderColor.adaptiveColor.cgColor)
                        context.strokePath()
                    }
                    let drawVerticalRowStartLine: () -> () = {
                        let borderWidth: CGFloat = 1
                        let path = CGMutablePath()
                        let startX = ((self.layoutFragment.layoutFragmentFrame.minX + self.bounds.minX)/2)+(meta.tabStopPadding*0.25)
                        let posX = startX + self.padding + (borderWidth/2)
                        path.move(to: .init(x: posX, y: 0))
                        path.addLine(to: .init(x: posX, y: self.bounds.height))
                        context.addPath(path)
                        context.setLineWidth(borderWidth)
                        context.setStrokeColor(borderColor.adaptiveColor.cgColor)
                        context.strokePath()
                    }
                    let drawVerticalRowEndLine: () -> () = {
                        let borderWidth: CGFloat = 1
                        let path = CGMutablePath()
//                        let startX = self.layoutFragment.layoutFragmentFrame.maxX+(meta.tabStopPadding*0.25)
                        let startX = meta.terminalColumnPosition + ( meta.tabStopPadding * 0.75 )
                        let posX = startX + self.padding + (borderWidth/2)
                        path.move(to: .init(x: posX, y: 0))
                        path.addLine(to: .init(x: posX, y: self.bounds.height))
                        context.addPath(path)
                        context.setLineWidth(borderWidth)
                        context.setStrokeColor(borderColor.adaptiveColor.cgColor)
                        context.strokePath()
                    }
                    let drawVerticalRowTabStopLine: (CGFloat) -> () = { tabPos in
                        let borderWidth: CGFloat = 0.75
                        let path = CGMutablePath()
                        let posX = start.x + self.padding + tabPos + (borderWidth/2)
                        path.move(to: .init(x: posX, y: 0))
                        path.addLine(to: .init(x: posX, y: self.bounds.height))
                        context.addPath(path)
                        context.setLineWidth(borderWidth)
                        context.setStrokeColor(borderColor.adaptiveColor.cgColor)
                        context.strokePath()
                    }
                    drawVerticalRowStartLine()
                    if !meta.endsWithEmptyColumn {
                        drawVerticalRowEndLine()
                    }
                    for columnLocation in meta.columnLocations {
//                        drawVerticalRowTabStopLine(columnLocation - (meta.tabStopPadding*0.25))
                        let columnLocation = columnLocation - (meta.tabStopPadding*0.25)
                        drawVerticalRowTabStopLine(columnLocation)
                    }
                    if meta.beginTableRow && meta.endTableRow {
                        drawTopLine()
                        drawBottomLine()
                    } else if meta.beginTableRow {
                        drawTopLine()
                        drawBottomLine()
                    } else if meta.endTableRow {
                        drawBottomLine()
                    } else {
                        assert(meta.middleTableRow)
                        drawBottomLine()
                    }
                }
            }
            context.restoreGState()
        case .none: ()
        }
        for (index, _) in scopeDrawInfo.indentLevels.enumerated() {
            let offsetX = CGFloat(index * 20)
            let fillColor = SSColorMap( light: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.7528616209), dark: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.7517339533) )
            let beginX = 15 + offsetX
            let frame = CGRect(
                origin: .init(
                    x: beginX,
                    y: self.bounds.origin.y
                ),
                size: .init(width: 5, height: self.bounds.height)
            )
            context.saveGState()
            context.setFillColor(fillColor.adaptiveColor.cgColor)
            context.fill([frame])
            context.restoreGState()
        }
    }
//    private func drawTableRowBackground(meta: SSTableRowMetadata) {
//        if meta.beginTableRow && meta.endTableRow {
//            
//        } else if meta.beginTableRow {
//            
//        } else if meta.endTableRow {
//            
//        } else {
//            assert(meta.middleTableRow)
//        }
//    }
    private func drawThematicBreak(context: CGContext) {
        let foregroundColor = SSColorMap( light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.7552321862), dark: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) )
        context.saveGState()
        context.setFillColor(foregroundColor.adaptiveColor.cgColor)
        let rect = CGRect(
            origin: .init(
                x: bounds.origin.x + padding,
                y: (bounds.height * 0.5) - 1
            ),
            size: .init(
                width: bounds.width - (padding * 2),
                height: 2
            )
        )
        context.fill([rect])
        context.restoreGState()
    }
}

fileprivate struct ScopeDrawInfo {
    var skipDrawLayoutFragment: Bool = false
    var drawFrameBackground: FrameBackgroundType? = nil
    var indentLevels: [ IndentLevel ] = []
    struct IndentLevel {
        var drawGraphic: Bool
    }
    enum FrameBackgroundType {
        case codeBlockLine
        case tableBlockLine
    }
}

extension TextLayoutFragmentLayer {
    private func setGeometryToFullWidth() {
        bounds = CGRect(
            origin: CGPoint(
                x: 0,
                y: layoutFragment.renderingSurfaceBounds.origin.y
            ),
            size: CGSize(
                width: max(layoutFragment.renderingSurfaceBounds.width, parent?.bounds.width ?? 0),
                height: layoutFragment.renderingSurfaceBounds.height
            )
        )
        // The (0, 0) point in layer space should be the anchor point.
        anchorPoint = CGPoint(x: -bounds.origin.x / bounds.size.width, y: -bounds.origin.y / bounds.size.height)
        position = layoutFragment.layoutFragmentFrame.origin.mapX(apply: { _ in 0 })
        // On macOS 14 and iOS 17, NSTextLayoutFragment.renderingSurfaceBounds is properly relative to the NSTextLayoutFragment's
        // interior coordinate system, and so this sample no longer needs the inconsistent x origin adjustment.
        if #unavailable(iOS 17, macOS 14) {
            bounds.origin = bounds.origin.mapX(apply: { $0 + position.x })
        }
    }
    private func setGeometryToRenderingSurfaceBounds() {
        bounds = layoutFragment.renderingSurfaceBounds
//        if showLayerFrames {
//            var typographicBounds = layoutFragment.layoutFragmentFrame
//            typographicBounds.origin = .zero
//            bounds = bounds.union(typographicBounds)
//        }
        bounds = CGRect(
            origin: .init( x: min(-5, bounds.minX), y: bounds.minY ),
            size: .init(
                width: max(10, bounds.width + 20), // ADD 20 PTS TO bounds.width - FIXES CLIPED MONOSPACE TEXT AT END OF LINE
                height: bounds.height
            )
        )
        // The (0, 0) point in layer space should be the anchor point.
        anchorPoint = CGPoint(x: -bounds.origin.x / bounds.size.width, y: -bounds.origin.y / bounds.size.height)
        position = layoutFragment.layoutFragmentFrame.origin

        // On macOS 14 and iOS 17, NSTextLayoutFragment.renderingSurfaceBounds is properly relative to the NSTextLayoutFragment's
        // interior coordinate system, and so this sample no longer needs the inconsistent x origin adjustment.
        if #unavailable(iOS 17, macOS 14) {
            bounds.origin = bounds.origin.mapX(apply: { $0 + position.x })
        }
    }
//    func updateGeometry() {
//        bounds = layoutFragment.renderingSurfaceBounds
//        if showLayerFrames {
//            var typographicBounds = layoutFragment.layoutFragmentFrame
//            typographicBounds.origin = .zero
//            bounds = bounds.union(typographicBounds)
//        }
//        bounds = CGRect(
//            origin: .init( x: min(-5, bounds.minX), y: bounds.minY ),
//            size: .init( width: max(10, bounds.width), height: bounds.height )
//        )
//        // The (0, 0) point in layer space should be the anchor point.
//        anchorPoint = CGPoint(x: -bounds.origin.x / bounds.size.width, y: -bounds.origin.y / bounds.size.height)
//        position = layoutFragment.layoutFragmentFrame.origin
//        var newBounds = bounds
//
//        // On macOS 14 and iOS 17, NSTextLayoutFragment.renderingSurfaceBounds is properly relative to the NSTextLayoutFragment's
//        // interior coordinate system, and so this sample no longer needs the inconsistent x origin adjustment.
//        if #unavailable(iOS 17, macOS 14) {
//            newBounds.origin.x += position.x
//        }
//        bounds = newBounds
//        position.x += padding
//    }
}

// MARK: - INTERNAL: DEBUG -

extension TextLayoutFragmentLayer {
    private func drawBackgroundDebug(context: CGContext) {
        if FULL_DEBUG_MODE == true {
            let colors: [NSColor] = [
                NSColor.systemRed,
                NSColor.systemGreen,
                NSColor.systemBlue,
                NSColor.systemOrange,
                NSColor.systemYellow,
                NSColor.systemBrown,
                NSColor.systemPink,
                NSColor.systemPurple,
                NSColor.systemGray,
                NSColor.systemTeal,
                NSColor.systemIndigo,
                NSColor.systemMint,
                NSColor.systemCyan,
            ]
            context.saveGState()
            let color = colors.randomElement()!.withAlphaComponent(0.08)
            context.saveGState()
            context.setFillColor(color.cgColor)
            context.fill([ self.bounds ])
            context.restoreGState()
        }
        
        // LINE FRAGMENTS DEBUG
        if DEBUG_MODE_SHOW_LINE_FRAGMENT_BOUNDS == true {
            context.saveGState()
            for (index, line) in self.layoutFragment.textLineFragments.enumerated() {
                let strokeWidth = 1.0
                let inset = 0.5 * strokeWidth
                context.setLineWidth(strokeWidth)
                if self.bounds.width > 10 {
                    let color1 = NSColor.blue.withAlphaComponent(0.8)
                    let color2 = NSColor.systemPink.withAlphaComponent(0.8)
                    let color = index == 0 ? color1 : color2
                    let positionX = layoutFragment.layoutFragmentFrame.origin.x + line.typographicBounds.origin.x + padding
                    let region = CGRect(
                        origin: .init( x: positionX, y: line.typographicBounds.origin.y ),
                        size: line.typographicBounds.size
                    )
                    context.setStrokeColor(color.cgColor)
                    context.setLineDash(phase: 1, lengths: [ strokeWidth, strokeWidth ])
                    context.stroke(
                        region.insetBy(dx: inset, dy: inset)
                    )
                }
            }
            context.restoreGState()
        }
    }
    private func drawForegroundDebug(context: CGContext) {
        if FULL_DEBUG_MODE == true {
            context.saveGState()
            context.setFillColor(NSColor.red.withAlphaComponent(0.8).cgColor)
            let circle = CGPath.init(
                ellipseIn: CGRect(x: 0, y: (bounds.maxY*0.5) - 3, width: 6, height: 6),
                transform: nil
            )
            context.addPath(circle)
            context.fillPath()
            context.restoreGState()
        }

        // LAYOUT FRAMES DEBUG
        if DEBUG_MODE_SHOW_LAYER_FRAMES == true {
            context.saveGState()
            let shiftX = layoutFragment.layoutFragmentFrame.origin.x + padding
            let inset = 0.5 * strokeWidth
            // Draw rendering surface bounds.
            context.setLineWidth(1)
            context.setStrokeColor(renderingSurfaceBoundsStrokeColor.withAlphaComponent(0.8).cgColor)
            context.setLineDash(phase: 0, lengths: []) // Solid line.
            context.stroke(
                layoutFragment
                    .renderingSurfaceBounds
                    .mapOrigin { $0.mapX { $0 + shiftX } }
                    .insetBy(dx: inset, dy: inset)
            )
            
            // Draw typographic bounds.
            context.setStrokeColor(typographicBoundsStrokeColor.withAlphaComponent(0.8).cgColor)
            context.setLineDash(phase: 0, lengths: [strokeWidth, strokeWidth]) // Square dashes.
            let typographicBounds = layoutFragment.layoutFragmentFrame
                .mapOrigin {
                    .init(
                        x: $0.x,
                        y: 0
                    )
                }
            context.stroke(typographicBounds.insetBy(dx: inset, dy: inset))
            context.restoreGState()
        }
    }
}

//fileprivate extension NSTextLayoutFragment {
//    func enumerateRenderingAttributes(of key: NSAttributedString.Key, forEach: @escaping () -> ()) {
//        
//    }
//}
