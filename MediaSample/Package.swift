// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MediaSample",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "MediaSample", targets: ["MediaSample"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "MediaSample", resources: [
            .process("MarkdownExample.md"),
            .process("LongSampleContent1.md"),
            .process("LongSampleContent2.md"),
            .process("LongSampleContent3.md"),
            .process("BookExample1.txt"),
            .process("BookExample2.txt"),
            .process("BookExample3.txt"),
        ]),
    ]
)
