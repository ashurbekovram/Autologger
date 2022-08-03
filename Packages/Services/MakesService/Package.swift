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
        .library(
            name: "MakesServiceInterface",
            targets: ["MakesServiceInterface"]
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
                "MakesServiceInterface",
                .product(name: "Models", package: "Models"),
                .product(name: "NetworkManagerInterface", package: "NetworkManager"),
            ]
        ),
        .target(
            name: "MakesServiceInterface",
            dependencies: [
                .product(name: "Models", package: "Models"),
            ]
        ),
        .testTarget(
            name: "MakesServiceTests",
            dependencies: ["MakesService"]
        ),
    ]
)
