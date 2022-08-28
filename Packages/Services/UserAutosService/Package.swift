// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserAutosService",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "UserAutosService",
            targets: ["UserAutosService"]),
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "NetworkManager", path: "../Managers/NetworkManager"),
        .package(name: "Extensions", path: "../Common/Extensions"),
    ],
    targets: [
        .target(
            name: "UserAutosService",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "NetworkManagerInterface", package: "NetworkManager"),
            ]
        ),
    ]
)
