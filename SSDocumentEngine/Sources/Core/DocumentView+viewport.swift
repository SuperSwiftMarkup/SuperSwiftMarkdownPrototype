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

extension DocumentView: NSTextViewportLayoutControllerDelegate {
    /// The current viewport, typically the view visible bounds with overdraw.
    func viewportBounds(for textViewportLayoutController: NSTextViewportLayoutController) -> CGRect {
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
    /// Called when textViewportLayoutController is about to layout.
    /// Layout information on textViewportLayoutController is up-to-date at the point of this call.
    func textViewportLayoutControllerWillLayout(_ controller: NSTextViewportLayoutController) {
        contentLayer.sublayers = nil
        CATransaction.begin()
    }
    /// Called when textViewportLayoutController is about to layout.
    /// Layout information on textViewportLayoutController is up-to-date at the point of this call.
    func textViewportLayoutControllerDidLayout(_ controller: NSTextViewportLayoutController) {
        CATransaction.commit()
        updateSelectionHighlights()
        updateContentSizeIfNeeded()
        adjustViewportOffsetIfNeeded()
    }
    /// Called when textViewportLayoutController lays out a given textLayoutFragment.
    /// The delegate should arrange to present the text layout fragment in the UI, e.g. a sublayer/subview.
    /// Layout information such as viewportBounds on textViewportLayoutController is not up-to-date at the point of this call.
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
//        if layer.showLayerFrames != showLayerFrames {
//            layer.showLayerFrames = showLayerFrames
//            layer.setNeedsDisplay()
//        }
        
        contentLayer.addSublayer(layer)
    }
}

// MARK: - INTERNAL HELPERS -

extension DocumentView {
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
