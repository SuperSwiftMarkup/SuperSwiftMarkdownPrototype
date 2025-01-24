//
//  TextLayoutFragmentLayer.swift
//
//
//  Created by Colbyn Wadman on 1/14/25.
//

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
        if scopeDrawInfo.drawFrameBackground {
//            let fillColor = SSColorMap( light: #colorLiteral(red: 0.7986731021, green: 0.8121947767, blue: 0.8439902169, alpha: 0.9970813141), dark: #colorLiteral(red: 0.3476208146, green: 0.3476208146, blue: 0.3476208146, alpha: 0.5048139327) )
            let fillColor = SSColorMap( light: #colorLiteral(red: 0.9677360897, green: 0.9677360897, blue: 0.9677360897, alpha: 0.9970813141), dark: #colorLiteral(red: 0.3476208146, green: 0.3476208146, blue: 0.3476208146, alpha: 0.5048139327) )
            context.saveGState()
            context.setFillColor(fillColor.adaptiveColor.cgColor)
            context.fill([bounds])
            context.restoreGState()
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
        for (index, _) in scopeDrawInfo.indentLevels.enumerated() {
            let offsetX = CGFloat(index * 20)
            let fillColor = SSColorMap( light: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), dark: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) )
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
            scopeDrawInfo.drawFrameBackground = true
        case .orderedList:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: false))
            ()
        case .unorderedList:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: false))
            ()
        case .table:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: true))
            ()
        case .paragraph: ()
        case .heading: ()
        case .htmlBlock:
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: true))
            scopeDrawInfo.drawFrameBackground = true
        case .codeBlock:
            scopeDrawInfo.drawFrameBackground = true
//            scopeDrawInfo.indentLevels.append(.init(drawGraphic: true))
        case .thematicBreak:
            drawThematicBreak(context: context)
            scopeDrawInfo.skipDrawLayoutFragment = true
        case .listItem: ()
        }
    }
    private func drawThematicBreak(context: CGContext) {
        let foregroundColor = SSColorMap( light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.7552321862), dark: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) )
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
    var drawFrameBackground: Bool = false
    var indentLevels: [ IndentLevel ] = []
    struct IndentLevel {
        var drawGraphic: Bool
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
