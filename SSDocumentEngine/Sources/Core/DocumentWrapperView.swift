//
//  SSDocumentSampleView.swift
//
//
//  Created by Colbyn Wadman on 1/22/25.
//
// LICENSE file: https://github.com/SuperSwiftMarkup/SuperSwiftMarkdownPrototype/blob/main/LICENSE.md
//
// The code herein is distributed under a dual licensing model. Users may choose to use such under either:
//
// 1. The GNU Affero General Public License v3.0 ("AGPLv3"); or
// 2. A commercial license, as specified in LICENSE file.
//
// By using any of the code, you agree to comply with the terms and conditions of either the AGPLv3 or the commercial license, depending on the license you select.

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif
import SwiftUI

// MARK: - PUBLIC -

public struct DocumentWrapperView: View {
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
