// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProfileService",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ProfileService",
            targets: ["ProfileService"]
        ),
        .library(
            name: "ProfileServiceInterface",
            targets: ["ProfileServiceInterface"]
        )
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "NetworkManager", path: "../Managers/NetworkManager"),
        .package(name: "Extensions", path: "../Common/Extensions"),
    ],
    targets: [
        .target(
            name: "ProfileService",
            dependencies: [
                "ProfileServiceInterface",
                .product(name: "Models", package: "Models"),
                .product(name: "NetworkManagerInterface", package: "NetworkManager"),
            ]
        ),
        .target(
            name: "ProfileServiceInterface",
            dependencies: [
                .product(name: "Models", package: "Models"),
            ]
        ),
        .testTarget(
            name: "ProfileServiceTests",
            dependencies: [
                "ProfileService",
                .product(name: "TestExtensions", package: "Extensions")
            ]
        ),
    ]
)
