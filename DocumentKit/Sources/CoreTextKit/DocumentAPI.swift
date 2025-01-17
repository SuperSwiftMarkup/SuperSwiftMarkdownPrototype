//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/14/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

import SwiftUI

public struct DocumentAPI {}

public struct DocumentDisplayView: View {
    public init() {}
    public var body: some View {
        DocumentViewControllerRepresentable()
    }
}

// MARK: - INTERNAL -

internal struct DocumentViewControllerRepresentable: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> DocumentViewController {
        DocumentViewController()
    }
    
    func updateNSViewController(_ nsViewController: DocumentViewController, context: Context) {}
    
    typealias NSViewControllerType = DocumentViewController
}
