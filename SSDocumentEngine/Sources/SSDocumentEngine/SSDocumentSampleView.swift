// Created by Colbyn Wadman on 2025-1-20 (ISO 8601)
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


