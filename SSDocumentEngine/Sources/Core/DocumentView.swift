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
    // MARK: - TextKit -
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
    
    // MARK: - INTERNAL SETUP -
    var showLayerFrames: Bool = true
    var slowAnimations: Bool = false
    
    // MARK: - TEXT RENDERING -
    var contentLayer: CALayer! = nil
    var selectionLayer: CALayer! = nil
    var fragmentLayerMap: NSMapTable<NSTextLayoutFragment, CALayer>
    var padding: CGFloat = 5.0
    
    // MARK: - COLORS & COLOR SCHEME STATE -
    var selectionColor: SSColorMap {
        SSColorMap(
            light: .systemBlue.withAlphaComponent(0.2),
            dark: .systemBlue.withAlphaComponent(0.5)
        )
    }
    var caretColor: SSColorMap {
        SSColorMap(
            light: .systemBlue,
            dark: .systemBlue
        )
    }
    var appliedColorScheme: SSColorSchemeMode? = nil
    
    // MARK: - MISCELLANEOUS -
    var boundsDidChangeObserver: Any? = nil
    
    // MARK: - INITIALIZATION & DE-INITIALIZATION -
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
    }
    
    deinit {
       if let observer = boundsDidChangeObserver {
           NotificationCenter.default.removeObserver(observer)
       }
    }
    
    // MARK: - NSResponder / VIEW STATE -
    override var acceptsFirstResponder: Bool { true }
    override var isFlipped: Bool { true }
    
    // MARK: - Responsive scrolling. -
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
    
    // MARK: - TEXT SELECTION PROPERTIES -
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

