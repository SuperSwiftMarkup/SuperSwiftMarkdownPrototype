// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSDocumentEngine",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "SSDocumentEngine", targets: ["SSDocumentEngine"]),
    ],
    dependencies: [
        .package(path: "../MediaSample"),
        .package(path: "../SSDocumentModel"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SSDocumentAction"),
        .target(name: "Core", dependencies: [
            "SSDocumentAction",
            "MediaSample",
            "SSDocumentModel",
        ]),
        .target(name: "SSDocumentEngine", dependencies: [
            "Core",
            "SSDocumentAction",
            "MediaSample",
            "SSDocumentModel",
        ]),
        .testTarget(name: "SSDocumentEngineTests", dependencies: ["SSDocumentEngine"]),
    ]
)
