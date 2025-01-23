//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/18/25.
//

import Foundation

extension CGSize {
    @inlinable
    internal func mapWidth(apply: @escaping (CGFloat) -> CGFloat) -> CGSize {
        CGSize(width: apply(width), height: height)
    }
}
