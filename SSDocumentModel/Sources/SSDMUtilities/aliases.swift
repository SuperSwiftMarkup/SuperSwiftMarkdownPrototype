//
//  aliases.swift
//  
//
//  Created by Colbyn Wadman on 1/21/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
public typealias XFont = NSFont
public typealias XFontDescriptor = NSFontDescriptor
public typealias XColor = NSColor
#elseif os(iOS) || os(visionOS)
import UIKit
public typealias XFont = UIFont
public typealias XFontDescriptor = UIFontDescriptor
public typealias XColor = UIColor
#endif

public typealias XUnderlineStyle = NSUnderlineStyle
public typealias XMutableParagraphStyle = NSMutableParagraphStyle
public typealias XTextTab = NSTextTab
public typealias XTextAlignment = NSTextAlignment
