//
//  DocumentView+viewport.swift
//  
//
//  Created by Colbyn Wadman on 1/14/25.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

extension DocumentView: NSTextViewportLayoutControllerDelegate {
    func viewportBounds(for textViewportLayoutController: NSTextViewportLayoutController) -> CGRect {
//        if let enclosingScrollView = enclosingScrollView {
//            return enclosingScrollView.contentView.documentRect
//        }
        let overdrawRect = preparedContentRect
        let visibleRect = self.visibleRect
        var minY: CGFloat = 0
        var maxY: CGFloat = 0
        if overdrawRect.intersects(visibleRect) {
            // Use preparedContentRect for vertical overdraw and ensure visibleRect is included at the minimum,
            // the width is always bounds width for proper line wrapping.
            minY = min(overdrawRect.minY, max(visibleRect.minY, 0))
            maxY = max(overdrawRect.maxY, visibleRect.maxY)
        } else {
            // We use visible rect directly if preparedContentRect does not intersect.
            // This can happen if overdraw has not caught up with scrolling yet, such as before the first layout.
            minY = visibleRect.minY
            maxY = visibleRect.maxY
        }
        return CGRect(x: bounds.minX, y: minY, width: bounds.width, height: maxY - minY)
    }
    
    func textViewportLayoutControllerWillLayout(_ controller: NSTextViewportLayoutController) {
        contentLayer.sublayers = nil
        CATransaction.begin()
    }
    func textViewportLayoutController(
        _ controller: NSTextViewportLayoutController,
        configureRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment
    ) {
        assert(textLayoutFragment.textElement!.childElements.isEmpty)
        let (layer, layerIsNew) = findOrCreateLayer(textLayoutFragment)
        if !layerIsNew {
            let oldPosition = layer.position
            let oldBounds = layer.bounds
            layer.updateGeometry()
            if oldBounds != layer.bounds {
                layer.setNeedsDisplay()
            }
            if oldPosition != layer.position {
                animate(layer, from: oldPosition, to: layer.position)
            }
        }
        if layer.showLayerFrames != showLayerFrames {
            layer.showLayerFrames = showLayerFrames
            layer.setNeedsDisplay()
        }
        
        contentLayer.addSublayer(layer)
    }
    
    func textViewportLayoutControllerDidLayout(_ controller: NSTextViewportLayoutController) {
        CATransaction.commit()
        updateSelectionHighlights()
        updateContentSizeIfNeeded()
        adjustViewportOffsetIfNeeded()
        postLayoutDebug()
    }
    
    private func findOrCreateLayer(_ textLayoutFragment: NSTextLayoutFragment) -> (TextLayoutFragmentLayer, Bool) {
        if let layer = fragmentLayerMap.object(forKey: textLayoutFragment) as? TextLayoutFragmentLayer {
            return (layer, false)
        } else {
            let layer = TextLayoutFragmentLayer(layoutFragment: textLayoutFragment, padding: padding)
            layer.parent = self
            fragmentLayerMap.setObject(layer, forKey: textLayoutFragment)
            return (layer, true)
        }
    }
    
    private func forAllLayers(function: @escaping (TextLayoutFragmentLayer) -> ()) {
        for object in fragmentLayerMap.objectEnumerator()?.allObjects ?? [] {
            if let layer = object as? TextLayoutFragmentLayer {
                function(layer)
            }
        }
    }
    
    private func animate(_ layer: CALayer, from source: CGPoint, to destination: CGPoint) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = source
        animation.toValue = destination
        animation.duration = slowAnimations ? 2.0 : 0.3
        layer.add(animation, forKey: nil)
    }
}
