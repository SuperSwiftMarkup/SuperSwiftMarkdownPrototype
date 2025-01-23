//
//  SSDocumentView.swift
//  
//
//  Created by Colbyn Wadman on 1/20/25.
//

import Foundation

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif
import SwiftUI

import Core

// MARK: - PUBLIC -

public struct SSDocumentSampleView: View {
    public init() {}
    public var body: some View {
        DocumentWrapperView()
    }
}

// MARK: - INTERNAL -

//internal struct DocumentViewControllerRepresentable: NSViewControllerRepresentable {
//    func makeNSViewController(context: Context) -> DocumentViewController {
//        DocumentViewController()
//    }
//    
//    func updateNSViewController(_ nsViewController: DocumentViewController, context: Context) {}
//    
//    typealias NSViewControllerType = DocumentViewController
//}


