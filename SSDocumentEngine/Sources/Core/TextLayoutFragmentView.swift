//
//  TextLayoutFragmentView.swift
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

internal final class TextLayoutFragmentView: NSView {
    var layoutFragment: NSTextLayoutFragment {
        didSet {
            needsDisplay = true
            needsLayout = true
        }
    }

#if canImport(AppKit)
    override var isFlipped: Bool { true }
#endif

    init(layoutFragment: NSTextLayoutFragment, frame: CGRect) {
        self.layoutFragment = layoutFragment
        super.init(frame: frame)
        wantsLayer = true
        clipsToBounds = false // allow overdraw invisible characters
        needsDisplay = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ dirtyRect: CGRect) {
        guard let context = NSGraphicsContext.current?.cgContext else { return }
        context.saveGState()
        layoutFragment.draw(at: .zero, in: context)
        context.restoreGState()
    }
    override func layout() {
        super.layout()
        layoutTextAttachmentViews()
    }
    private func layoutTextAttachmentViews() {
        for provider in layoutFragment.textAttachmentViewProviders {
            print("TODO: FOUND VIEW PROVIDER")
            if let providerView = provider.view {
                let frame = layoutFragment.frameForTextAttachment(at: provider.location)
                providerView.frame.origin = frame.origin
                if providerView.superview == nil {
                    addSubview(providerView)
                }
            }
        }
    }
}


