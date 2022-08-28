// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Extensions",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Extensions",
            targets: ["Extensions"]
        ),
        .library(
            name: "TestExtensions",
            targets: ["TestExtensions"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Extensions",
            dependencies: []
        ),
        .target(
            name: "TestExtensions",
            dependencies: []
        ),
    ]
)
