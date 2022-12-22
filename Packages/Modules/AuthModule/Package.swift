// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthModule",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AuthModule",
            targets: ["AuthModule"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AuthModule",
            dependencies: []
        ),
    ]
)
