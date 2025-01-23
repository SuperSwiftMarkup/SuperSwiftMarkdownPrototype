//
//  File.swift
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

internal class TextLayoutFragmentLayer: CALayer {
    var parent: DocumentView?
    var layoutFragment: NSTextLayoutFragment!
    var padding: CGFloat
    var showLayerFrames: Bool = false
    
    let strokeWidth: CGFloat = 2
    private var isThematicBreakNode: Bool {
        if let paragraphElement = layoutFragment.textElement as? NSTextParagraph {
            let isHRTag = paragraphElement.attributedString.string == "---\n"
            if isHRTag {
                return true
            }
        }
        return false
    }
    
    override class func defaultAction(forKey: String) -> CAAction? {
        // Suppress default opacity animations.
        return NSNull()
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
    func updateGeometry() {
        setGeometryToFullWidth()
//        setGeometryToRenderingSurfaceBounds()
    }
    func setGeometryToFullWidth() {
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
//        bounds = bounds.union(layoutFragment.layoutFragmentFrame.mapOrigin(apply: { _ in  .zero}))
        anchorPoint = CGPoint(x: -bounds.origin.x / bounds.size.width, y: -bounds.origin.y / bounds.size.height)
        position = layoutFragment.layoutFragmentFrame.origin.mapX(apply: { _ in 0 })
        if #unavailable(iOS 17, macOS 14) {
            bounds.origin = bounds.origin.mapX(apply: { $0 + position.x })
        }
    }
    func setGeometryToRenderingSurfaceBounds() {
        if isThematicBreakNode {
            return updateGeometryHRTag()
        }
        
        bounds = layoutFragment.renderingSurfaceBounds
        
        if showLayerFrames {
            var typographicBounds = layoutFragment.layoutFragmentFrame
            typographicBounds.origin = .zero
            bounds = bounds.union(typographicBounds)
        }
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
    // Full width; will eventually draw an divider graphic
    func updateGeometryHRTag() {
        bounds = layoutFragment.renderingSurfaceBounds
        bounds = CGRect(
            origin: bounds.origin,
            size: .init(width: max(bounds.width, parent?.bounds.width ?? 0), height: bounds.height)
        )
        if showLayerFrames {
            var typographicBounds = layoutFragment.layoutFragmentFrame
            typographicBounds.origin = .zero
            bounds = bounds.union(typographicBounds)
        }
        bounds = CGRect(
            origin: .init( x: min(-5, bounds.minX), y: bounds.minY ),
            size: .init( width: max(10, bounds.width), height: bounds.height )
        )
        // The (0, 0) point in layer space should be the anchor point.
        anchorPoint = CGPoint(x: -bounds.origin.x / bounds.size.width, y: -bounds.origin.y / bounds.size.height)
        position = layoutFragment.layoutFragmentFrame.origin
        var newBounds = bounds

        // On macOS 14 and iOS 17, NSTextLayoutFragment.renderingSurfaceBounds is properly relative to the NSTextLayoutFragment's
        // interior coordinate system, and so this sample no longer needs the inconsistent x origin adjustment.
        if #unavailable(iOS 17, macOS 14) {
            newBounds.origin.x += position.x
        }
        bounds = newBounds
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
    
    private func drawContent(context: CGContext) {
        if isThematicBreakNode {
            context.saveGState()
            context.setFillColor(NSColor.green.withAlphaComponent(0.8).cgColor)
            let rect = CGRect(
                origin: .init(
                    x: bounds.origin.x,
                    y: (bounds.height * 0.5) - 1
                ),
                size: .init(
                    width: bounds.width,
                    height: 2
                )
            )
            context.fill([rect])
            context.restoreGState()
        }
//        layoutFragment.draw(at: .zero, in: context)
        layoutFragment.draw(
            at: .init(
                x: layoutFragment.layoutFragmentFrame.origin.x + padding,
                y: 0
            ),
            in: context
        )
    }
    private func drawBackgroundDebug(context: CGContext) {
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
        
        // LINE FRAGMENTS DEBUG
        context.saveGState()
//        context.translateBy(x: padding, y: 0)
        for (index, line) in self.layoutFragment.textLineFragments.enumerated() {
//            let isEven = index % 2 == 0
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
    private func drawForegroundDebug(context: CGContext) {
        context.saveGState()
//        let isBlockQuote = (layoutFragment.textElement as? NSTextParagraph)?.attributedString.isOfType(markdownBlockType: .blockQuote) == true
//        if isBlockQuote {
//            context.setFillColor(NSColor.green.withAlphaComponent(0.8).cgColor)
//        } else {
//            context.setFillColor(NSColor.red.withAlphaComponent(0.8).cgColor)
//        }
        context.setFillColor(NSColor.red.withAlphaComponent(0.8).cgColor)
        let circle = CGPath.init(
            ellipseIn: CGRect(x: 0, y: (bounds.maxY*0.5) - 3, width: 6, height: 6),
            transform: nil
        )
        context.addPath(circle)
        context.fillPath()
        context.restoreGState()

//        // LAYOUT FRAMES DEBUG
//        if showLayerFrames {
//            context.saveGState()
//            let inset = 0.5 * strokeWidth
//            // Draw rendering surface bounds.
//            context.setLineWidth(1)
//            context.setStrokeColor(renderingSurfaceBoundsStrokeColor.withAlphaComponent(0.8).cgColor)
//            context.setLineDash(phase: 0, lengths: []) // Solid line.
//            context.stroke(layoutFragment.renderingSurfaceBounds.insetBy(dx: inset, dy: inset))
//            
//            // Draw typographic bounds.
//            context.setStrokeColor(typographicBoundsStrokeColor.withAlphaComponent(0.8).cgColor)
//            context.setLineDash(phase: 0, lengths: [strokeWidth, strokeWidth]) // Square dashes.
//            var typographicBounds = layoutFragment.layoutFragmentFrame
//            typographicBounds.origin = .zero
//            context.stroke(typographicBounds.insetBy(dx: inset, dy: inset))
//            context.restoreGState()
//        }
    }
    
    var renderingSurfaceBoundsStrokeColor: NSColor { return .systemOrange }
    var typographicBoundsStrokeColor: NSColor { return .systemIndigo }
}


