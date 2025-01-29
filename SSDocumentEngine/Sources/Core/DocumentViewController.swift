// Created by Colbyn Wadman on 2025-1-14 (ISO 8601)
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

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#elseif os(iOS) || os(visionOS)
import UIKit
#endif

import Foundation
import AppKit
//import SSMarkdownAST
import MediaSample
import SSDocumentModel

internal final class DocumentViewController: NSViewController {
    private var textContentStorage: NSTextContentStorage
    private var textLayoutManager: NSTextLayoutManager
    var commentColor: NSColor { return .white }
    private var textDocumentView: DocumentView!
    private var scrollView: NSScrollView!
    
    required init() {
        textLayoutManager = NSTextLayoutManager()
//        textLayoutManager.usesHyphenation = true
        textContentStorage = NSTextContentStorage()
//        textContentStorage.textStorage!.setAttributedString(NSAttributedString(string: "Hello World!"))
//        textContentStorage
        
//        let exampleDocumentURL = Bundle.module.url(forResource: "MarkdownExample", withExtension: "md")!
//        let exampleDocument = try! SSDocument.read(from: exampleDocumentURL)
//        let exampleDocumentAttributedString = exampleDocument.attributedString(styling: .default)
//        textContentStorage.textStorage!.setAttributedString(exampleDocumentAttributedString)
//        let textStorage = DocumentTextStorage()
//        textContentStorage.textStorage = DocumentTextStorage.new(document: exampleDocument)
//        textContentStorage.textStorage!.setAttributedString(exampleDocumentAttributedString)
//        textContentStorage
        
//        let exampleDocumentURL = Bundle.module.url(forResource: "MarkdownExample", withExtension: "md")!
//        try! textContentStorage.read(from: exampleDocumentURL)
        
        
//        textContentStorage.textStorage = NSTextStorage(string: "Hello World", attributes: [
//            .font: XFont.systemFont(ofSize: 18, weight: .regular)
//        ])
        super.init(nibName: nil, bundle: nil)
//        textContentStorage.delegate = self
        textContentStorage.addTextLayoutManager(textLayoutManager)
        textContentStorage.primaryTextLayoutManager = textLayoutManager
        let textContainer = NSTextContainer(size: NSSize(width: 200, height: 0))
        textLayoutManager.textContainer = textContainer
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DocumentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.autoresizesSubviews = true
        // - -
        let sampleDocumentSource = try! MediaSample.SampleFile.markdownExample.read()
        let sampleDocument = SSDocument.parse(source: sampleDocumentSource)
        let sampleDocumentAttributedString = sampleDocument.compileAttributedString()
        textContentStorage.textStorage!.setAttributedString(sampleDocumentAttributedString)
//        let exampleDocumentURL = Bundle.module.url(forResource: "MarkdownExample", withExtension: "md")!
//        let exampleDocumentURL = Bundle.module.url(forResource: "BookExample3", withExtension: "txt")!
//        let exampleDocumentString = try! String.init(contentsOf: exampleDocumentURL)
//        let exampleDocument = try! SSDocument.read(from: exampleDocumentURL)
//        let exampleDocumentAttributedString = exampleDocument.attributedString( styling: .default )
//        textContentStorage.attributedString = exampleDocumentAttributedString
//        try! textContentStorage.read(from: exampleDocumentURL)
        // - -
        textDocumentView = DocumentView.init(frame: view.frame)
        textDocumentView.textContentStorage = textContentStorage
        textDocumentView.textLayoutManager = textLayoutManager
        textDocumentView.updateContentSizeIfNeeded()
        textDocumentView.documentViewController = self
        // - -
        scrollView = NSScrollView.init(frame: view.frame)
        scrollView.wantsLayer = true
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
//        scrollView.drawsBackground = false
        scrollView.drawsBackground = true
        scrollView.documentView = textDocumentView
        // - -
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//extension DocumentViewController: NSTextContentManagerDelegate {}
//extension DocumentViewController: NSTextContentStorageDelegate {}

