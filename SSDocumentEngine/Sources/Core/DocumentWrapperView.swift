//
//  SSDocumentSampleView.swift
//
//
//  Created by Colbyn Wadman on 1/22/25.
//

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
