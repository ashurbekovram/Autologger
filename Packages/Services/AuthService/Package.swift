// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthService",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AuthService",
            targets: ["AuthService"]
        ),
        .library(
            name: "AuthServiceInterface",
            targets: ["AuthServiceInterface"]
        ),
    ],
    dependencies: [
        .package(name: "NetworkManager", path: "../Managers/NetworkManager"),
    ],
    targets: [
        .target(
            name: "AuthService",
            dependencies: [
                "AuthServiceInterface",
                .product(name: "NetworkManagerInterface", package: "NetworkManager")
            ]
        ),
        .target(
            name: "AuthServiceInterface",
            dependencies: []
        ),
    ]
)
