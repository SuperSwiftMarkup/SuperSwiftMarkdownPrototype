//
//  aliases.swift
//
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
public typealias XFont = NSFont
public typealias XColor = NSColor
#elseif os(iOS) || os(visionOS)
import UIKit
public typealias XFont = UIFont
public typealias XColor = UIColor
#endif
