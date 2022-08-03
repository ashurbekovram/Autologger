// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkManager",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]
        ),
        .library(
            name: "NetworkManagerInterface",
            targets: ["NetworkManagerInterface"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NetworkManager",
            dependencies: ["NetworkManagerInterface"]
        ),
        .target(
            name: "NetworkManagerInterface",
            dependencies: []
        ),
        .testTarget(
            name: "NetworkManagerTests",
            dependencies: ["NetworkManager"]
        ),
    ]
)
