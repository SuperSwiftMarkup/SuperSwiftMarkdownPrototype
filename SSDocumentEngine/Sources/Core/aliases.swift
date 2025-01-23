//
//  aliases.swift
//
//
//  Created by Colbyn Wadman on 1/14/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
public typealias XView = NSView
public typealias XViewController = NSViewController
public typealias XFont = NSFont
#elseif os(iOS) || os(visionOS)
import UIKit
public typealias XView = UIView
public typealias XViewController = UIViewController
public typealias XFont = UIFont
#endif
