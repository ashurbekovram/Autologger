// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VPICService",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "VPICService",
            targets: ["VPICService"]
        ),
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "NetworkManager", path: "../Managers/NetworkManager")
    ],
    targets: [
        .target(
            name: "VPICService",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "NetworkManager", package: "NetworkManager")
            ]
        ),
        .testTarget(
            name: "VPICServiceTests",
            dependencies: ["VPICService"]
        ),
    ]
)
