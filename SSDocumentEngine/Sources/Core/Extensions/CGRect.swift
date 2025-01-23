//
//  CGRect.swift
//  SuperTextDisplay
//
//  Created by Colbyn Wadman on 1/2/25.
//

import CoreGraphics

#if os(macOS) && !targetEnvironment(macCatalyst)
import struct AppKit.NSEdgeInsets
#elseif os(iOS) || os(visionOS)
import struct UIKit.UIEdgeInsets
#endif

extension CGRect {
    internal func replacing(width: CGFloat) -> CGRect {
        CGRect(origin: origin, size: CGSize(width: width, height: size.height))
    }
    func inset(by edgeInsets: EdgeInsets) -> CGRect {
        var result = self
        result.origin.x += edgeInsets.left
        result.origin.y += edgeInsets.top
        result.size.width -= edgeInsets.left + edgeInsets.right
        result.size.height -= edgeInsets.top + edgeInsets.bottom
        return result
    }
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
    typealias EdgeInsets = NSEdgeInsets
#else
    typealias EdgeInsets = UIEdgeInsets
#endif
}

extension CGRect {
    internal func mapOrigin(apply: @escaping (CGPoint) -> CGPoint) -> CGRect {
        CGRect(origin: apply(self.origin), size: self.size)
    }
    internal func mapSize(apply: @escaping (CGSize) -> CGSize) -> CGRect {
        CGRect(origin: self.origin, size: apply(self.size))
    }
    internal func mapWidth(apply: @escaping (CGFloat) -> CGFloat) -> CGRect {
        CGRect(origin: self.origin, size: .init(width: apply(self.size.width), height: self.size.height))
    }
}
