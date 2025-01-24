//
//  DocumentView.swift
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

internal final class DocumentView: NSView {
    var textLayoutManager: NSTextLayoutManager? {
        willSet {
            if let tlm = textLayoutManager {
                tlm.delegate = nil
                tlm.textViewportLayoutController.delegate = nil
            }
        }
        didSet {
            if let tlm = textLayoutManager {
                tlm.delegate = self
                tlm.textViewportLayoutController.delegate = self
            }
            updateContentSizeIfNeeded()
            updateTextContainerSize()
            layer!.setNeedsLayout()
        }
    }
    
    var textContentStorage: NSTextContentManager?
    var documentViewController: DocumentViewController!
    
    var showLayerFrames: Bool = true
    var slowAnimations: Bool = false
    
    var contentLayer: CALayer! = nil
    var selectionLayer: CALayer! = nil
    var fragmentLayerMap: NSMapTable<NSTextLayoutFragment, CALayer>
    var padding: CGFloat = 5.0
    
    // Colors support.
    var selectionColor: NSColor {
        SSColorMap(
            light: {
                .systemBlue.withAlphaComponent(0.2)
            },
            dark: {
                .systemBlue.withAlphaComponent(0.5)
            }
        )
        .adaptiveColor
    }
    var caretColor: NSColor { .systemBlue }
    
    var boundsDidChangeObserver: Any? = nil
    
    var appliedColorScheme: SSColorSchemeMode? = nil
    
    override init(frame: CGRect) {
        print("INIT: FRAME")
        fragmentLayerMap = .weakToWeakObjects()
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        wantsLayer = true
        selectionLayer = TextDocumentLayer()
        contentLayer = TextDocumentLayer()
        layer?.addSublayer(selectionLayer)
        layer?.addSublayer(contentLayer)
        fragmentLayerMap = NSMapTable.weakToWeakObjects()
//        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [ .width, .height ]
        postsBoundsChangedNotifications = true
        postsFrameChangedNotifications = true
        _defaultStylingAttributes = [
            .paragraphStyle: NSParagraphStyle.default,
            .font: NSFont.preferredFont(forTextStyle: .body),
            .foregroundColor: NSColor.labelColor
        ]
    }
    
    deinit {
       if let observer = boundsDidChangeObserver {
           NotificationCenter.default.removeObserver(observer)
       }
    }
    
    override var isFlipped: Bool { true }
    // NSResponder
    override var acceptsFirstResponder: Bool { true }
    
    // Responsive scrolling.
    override class var isCompatibleWithResponsiveScrolling: Bool { true }
    override func prepareContent(in rect: NSRect) {
        layer!.setNeedsLayout()
        super.prepareContent(in: rect)
    }
    override func centerSelectionInVisibleArea(_ sender: Any?) {
        if !textLayoutManager!.textSelections.isEmpty {
            let viewportOffset =
            textLayoutManager!.textViewportLayoutController.relocateViewport(to: textLayoutManager!.textSelections[0].textRanges[0].location)
            scroll(CGPoint(x: 0, y: viewportOffset))
        }
    }
    
    internal var _defaultStylingAttributes: [ NSAttributedString.Key: Any ] = [:]
    internal var _stylingAttributes: [NSAttributedString.Key: Any] = [:]
//    internal var colorScheme: CoreColorScheme? = nil
    
    /// A dragging selection anchor
    ///
    /// FB11898356 - Something if wrong with textSelectionsInteractingAtPoint
    /// it expects that the dragging operation does not change anchor selections
    /// significantly. Specifically it does not play well if anchor and current
    /// location is too close to each other, therefore `mouseDraggingSelectionAnchors`
    /// keep the anchors unchanged while dragging.
    internal var pointerDraggingSelectionAnchors: [NSTextSelection]? = nil
    
    internal var focusSelectionRequest: FocusSelectionRequest? = nil {
        didSet {
            if focusSelectionRequest != nil {
                needsLayout = true
            }
        }
    }
    internal enum FocusSelectionRequest {
        case scrollTo(ScrollDirection)
        internal enum ScrollDirection {
            case up
            case down
        }
    }
}

extension DocumentView: CALayerDelegate {
    func layoutSublayers(of layer: CALayer) {
//        print("TextDocumentView.layoutSublayers")
        assert(layer == self.layer)
        textLayoutManager?.textViewportLayoutController.layoutViewport()
        updateContentSizeIfNeeded()
        updateTextContainerSize()
    }
}

internal class TextDocumentLayer: CALayer {
    override class func defaultAction(forKey event: String) -> CAAction? {
        // Suppress default animation of opacity when adding comment bubbles.
        return NSNull()
    }
}

