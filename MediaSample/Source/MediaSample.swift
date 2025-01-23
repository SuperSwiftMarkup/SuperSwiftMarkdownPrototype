// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct MediaSample {
//    static func "MarkdownExample.md"
//    static func "LongSampleContent1.md"
//    static func "LongSampleContent2.md"
//    static func "LongSampleContent3.md"
//    static func "BookExample1.txt"
//    static func "BookExample2.txt"
//    static func "BookExample3.txt"
}

extension MediaSample {
    public enum SampleFile: String {
        case markdownExample = "MarkdownExample.md"
        case longSampleContent1 = "LongSampleContent1.md"
        case longSampleContent2 = "LongSampleContent2.md"
        case longSampleContent3 = "LongSampleContent3.md"
        case bookExample1 = "BookExample1.txt"
        case bookExample2 = "BookExample2.txt"
        case bookExample3 = "BookExample3.txt"
    }
}

extension MediaSample.SampleFile {
    public func read() throws -> String {
        let dotIndex = self.rawValue.firstIndex(where: { $0 == "." })!
        let beginExtensionIndex = self.rawValue.index(after: dotIndex)
        let fileName = String(self.rawValue[..<dotIndex])
        let fileExtension = String(self.rawValue[beginExtensionIndex...])
        let url = Bundle.module.url(forResource: fileName, withExtension: fileExtension)!
        return try String.init(contentsOf: url)
    }
}
