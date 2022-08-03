// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MakesService",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MakesService",
            targets: ["MakesService"]
        ),
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "NetworkManager", path: "../Managers/NetworkManager"),
    ],
    targets: [
        .target(
            name: "MakesService",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "NetworkManagerInterface", package: "NetworkManager"),
            ]
        ),
        .testTarget(
            name: "MakesServiceTests",
            dependencies: ["MakesService"]
        ),
    ]
)
