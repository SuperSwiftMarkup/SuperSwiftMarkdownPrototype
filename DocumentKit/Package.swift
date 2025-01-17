// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DocumentKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "DocumentKit", targets: ["DocumentKit"]),
        .library(name: "CoreTextKit", targets: ["CoreTextKit"]),
        .library(name: "HLTextKit", targets: ["HLTextKit"]),
        .library(name: "DocumentBehavior", targets: ["DocumentBehavior"]),
    ],
    dependencies: [
        .package(path: "../SSMarkdown")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "DocumentKit"),
        .target(name: "HLTextKit"),
        .target(name: "DocumentBehavior"),
        .target(
            name: "CoreTextKit",
            dependencies: [
                "DocumentBehavior",
                "SSMarkdown",
            ],
            resources: [
                .process("Samples/MarkdownExample.md"),
                .process("Samples/LongSampleContent1.md"),
                .process("Samples/LongSampleContent2.md"),
                .process("Samples/LongSampleContent3.md"),
                .process("Samples/BookExample1.txt"),
                .process("Samples/BookExample2.txt"),
                .process("Samples/BookExample3.txt"),
            ]
        ),
        .testTarget(name: "DocumentKitTests", dependencies: ["DocumentKit"]),
    ]
)
