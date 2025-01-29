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

extension DocumentView {
    func updateSelectionHighlights() {
        guard textLayoutManager?.textSelections.isEmpty == false else {
            selectionLayer.sublayers = nil
            return
        }
        selectionLayer.sublayers = nil
        func process(textRange: NSTextRange) {
            textLayoutManager!.enumerateTextSegments(
                in: textRange,
                type: .selection,
                options: []
            ) { ( textSegmentRange, textSegmentFrame, baselinePosition, _ ) in
                var highlightFrame = textSegmentFrame
                highlightFrame.origin.x += padding
                if highlightFrame.size.width > 0 {
                    // SELECTION HIGHLIGHT LAYER
                    let highlightSubLayer = TextDocumentLayer()
                    highlightSubLayer.backgroundColor = selectionColor.adaptiveColor.cgColor
                    highlightSubLayer.frame = highlightFrame
                    selectionLayer.addSublayer(highlightSubLayer)
                } else {
                    // JUST THE CURSOR LAYER
                    let cursorSubLayer = TextDocumentCursorLayer()
                    cursorSubLayer.backgroundColor = caretColor.adaptiveColor.cgColor
                    cursorSubLayer.frame = highlightFrame.replacing(width: 2)
                    cursorSubLayer.setBlinkingCursorMode(enableBlinking: true)
                    selectionLayer.addSublayer(cursorSubLayer)
                }
                return true // Keep going.
            }
        }
        for textSelection in textLayoutManager!.textSelections {
            assert(textSelection.isLogical == false, "WHEN IS THIS NOT FALSE?")
            assert(textSelection.secondarySelectionLocation == nil, "WHEN IS THIS NOT NILL?")
            assert(textSelection.typingAttributes.isEmpty, "WHEN IS THIS NOT EMPTY?")
            for textRange in textSelection.textRanges {
                process(textRange: textRange)
            }
        }
    }
    
    // Live resize.
    override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()
        adjustViewportOffsetIfNeeded()
        updateContentSizeIfNeeded()
    }
    
    fileprivate var scrollView: NSScrollView? {
        guard let result = enclosingScrollView else {
            print("MISSING: enclosingScrollView")
            return nil
        }
        if result.documentView == self {
            return result
        }
        print("NOTE: NO SCROLL VIEW")
        return nil
    }
    
    func updateContentSizeIfNeeded() {
        let currentHeight = bounds.height
        var height: CGFloat = 0
        textLayoutManager!.ensureLayout(for: NSTextRange(location: textLayoutManager!.documentRange.endLocation))
        let usageBoundsForTextContainer = textLayoutManager!.usageBoundsForTextContainer
        height = max(usageBoundsForTextContainer.height, enclosingScrollView?.contentSize.height ?? 0)
//        textLayoutManager!.enumerateTextLayoutFragments(
//            from: textLayoutManager!.documentRange.endLocation,
//            options: [.reverse, .ensuresLayout]
//        ) { layoutFragment in
//            height = layoutFragment.layoutFragmentFrame.maxY
//            return false // stop
//        }
//        height = max(height, enclosingScrollView?.contentSize.height ?? 0)
        if abs(currentHeight - height) > 1e-10 {
//            let contentSize = NSSize(width: enclosingScrollView?.contentSize.width ?? bounds.width, height: height)
            let contentSize = NSSize(width: bounds.width, height: height)
            setFrameSize(contentSize)
        }
    }
    
    internal func updateTextContainerSize() {
        if let textContainer = textLayoutManager!.textContainer, textContainer.size.width != bounds.width {
            textContainer.size = NSSize(width: bounds.size.width, height: 0)
            layer?.setNeedsLayout()
        }
    }
    
    func adjustViewportOffsetIfNeeded() {
        let viewportLayoutController = textLayoutManager!.textViewportLayoutController
        guard viewportLayoutController.viewportRange != nil else { return }
        let contentOffset = scrollView!.contentView.bounds.minY
        if contentOffset < scrollView!.contentView.bounds.height &&
            viewportLayoutController.viewportRange!.location.compare(textLayoutManager!.documentRange.location) == .orderedDescending {
            // Nearing top, see if we need to adjust and make room above.
            adjustViewportOffset()
        } else if viewportLayoutController.viewportRange!.location.compare(textLayoutManager!.documentRange.location) == .orderedSame {
            // At top, see if we need to adjust and reduce space above.
            adjustViewportOffset()
        }
    }
    
    private func adjustViewportOffset() {
        let viewportLayoutController = textLayoutManager!.textViewportLayoutController
        var layoutYPoint: CGFloat = 0
        textLayoutManager!.enumerateTextLayoutFragments(
            from: viewportLayoutController.viewportRange!.location,
            options: [.reverse, .ensuresLayout]
        ) { layoutFragment in
            layoutYPoint = layoutFragment.layoutFragmentFrame.origin.y
            return true
        }
        if layoutYPoint != 0 {
            let adjustmentDelta = bounds.minY - layoutYPoint
            viewportLayoutController.adjustViewport(byVerticalOffset: adjustmentDelta)
            scroll(CGPoint(x: scrollView!.contentView.bounds.minX, y: scrollView!.contentView.bounds.minY + adjustmentDelta))
        }
    }
    
    override func viewWillMove(toSuperview newSuperview: NSView?) {
        if let clipView = scrollView?.contentView {
            NotificationCenter.default.removeObserver(self, name: NSView.boundsDidChangeNotification, object: clipView)
        }
        super.viewWillMove(toSuperview: newSuperview)
    }
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        if let clipView = scrollView?.contentView {
            boundsDidChangeObserver = NotificationCenter.default.addObserver(
                forName: NSView.boundsDidChangeNotification,
                object: clipView,
                queue: nil
            ) { [weak self] notification in
                self!.layer?.setNeedsLayout()
            }
        }
    }

    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        updateTextContainerSize()
    }
    override var intrinsicContentSize: NSSize {
        textLayoutManager!.usageBoundsForTextContainer.size
    }
    override func layout() {
        super.layout()
        if inLiveResize {
            return Throttler.throttle(0.05, identifier: "layoutViewport", option: .ensureLast) { [weak self] in
                guard let self else { return }
                self._layout()
            }
        }
        _layout()
    }
    private func _layout() {
        layoutViewport()
        if let focusSelectionRequest = focusSelectionRequest {
            switch focusSelectionRequest {
            case .scrollTo(.up):
                let targetRange = textLayoutManager!.textSelections
                    .flatMap(\.textRanges)
                    .flatMap { [ NSTextRange(location: $0.location), NSTextRange(location: $0.endLocation) ] }
                    .sorted(by: { $0.location < $1.location })
                    .first
                if let textRange = targetRange {
                    scrollToVisible(textRange, type: .standard)
                }
            case .scrollTo(.down):
                let targetRange = textLayoutManager!.textSelections
                    .flatMap(\.textRanges)
                    .flatMap { [ NSTextRange(location: $0.location), NSTextRange(location: $0.endLocation) ] }
                    .sorted(by: { $0.location < $1.location })
                    .last
                if let textRange = targetRange {
                    scrollToVisible(textRange, type: .standard)
                }
            }
        }
        focusSelectionRequest = nil
    }
    internal func layoutViewport() {
        // layoutViewport does not handle properly layout range
        // for far jump it tries to layout everything starting at location 0
        // even though viewport range is properly calculated.
        // No known workaround.
        textLayoutManager!.textViewportLayoutController.layoutViewport()
    }
    @discardableResult
    internal func scrollToVisible(_ selectionTextRange: NSTextRange, type: NSTextLayoutManager.SegmentType) -> Bool {
        guard var rect = textLayoutManager!.textSegmentFrame(in: selectionTextRange, type: type) else {
            return false
        }
        let textContainer = textLayoutManager!.textContainer!

        if rect.width.isZero {
            // add padding around the point to ensure the visibility the segment
            // since the width of the segment is 0 for a selection
            rect = rect.inset(by: .init(top: 0, left: -textContainer.lineFragmentPadding, bottom: 0, right: -textContainer.lineFragmentPadding))
        }

        // scroll to visible IN clip view (ignoring gutter view overlay)
        // adjust rect to mimick it's size to include gutter overlay
//        rect.origin.x -= gutterView?.frame.width ?? 0
//        rect.size.width += gutterView?.frame.width ?? 0
        return scrollToVisible(rect)
    }
}

fileprivate final class TextDocumentCursorLayer: CALayer {
    private var timer: Timer?
    override class func defaultAction(forKey event: String) -> CAAction? {
        // Suppress default animation of opacity when adding comment bubbles.
        return NSNull()
    }
    func setBlinkingCursorMode(enableBlinking: Bool) {
        if enableBlinking, self.timer == nil {
            isHidden = false
            timer = Timer.scheduledTimer(
                withTimeInterval: 0.75,
                repeats: true,
                block: { [weak self] _ in self?.isHidden.toggle() }
            )
        } else if !enableBlinking {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
}


// TODO: MOVE ELSEWHERE
extension NSTextLayoutManager {
    /// A text segment is both logically and visually contiguous portion of the text content inside a line fragment.
    /// Text segment is a logically and visually contiguous portion of the text content inside a line fragment that you specify with a single text range.
    /// The framework enumerates the segments visually from left to right.
    public func textSegmentFrame(
        in textRange: NSTextRange,
        type: NSTextLayoutManager.SegmentType,
        options: SegmentOptions = [.upstreamAffinity, .rangeNotRequired]
    ) -> CGRect? {
        var result: CGRect? = nil
        // .upstreamAffinity: When specified, the segment is placed based on the upstream affinity for an empty range.
        //
        // In the context of text editing, upstream affinity means that the selection is biased towards the preceding or earlier portion of the text,
        // while downstream affinity means that the selection is biased towards the following or later portion of the text. The affinity helps determine
        // the behavior of the text selection when the text is modified or manipulated.

        // FB15131180: Extra line fragment frame is not correct, that affects enumerateTextSegments as well.
        enumerateTextSegments(in: textRange, type: type, options: options) { textSegmentRange, textSegmentFrame, baselinePosition, textContainer -> Bool in
            result = result?.union(textSegmentFrame) ?? textSegmentFrame
            return true
        }
        return result
    }
}
