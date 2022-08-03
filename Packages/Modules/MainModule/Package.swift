// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainModule",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MainModule",
            targets: ["MainModule"]
        ),
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "ProfileService", path: "../Services/ProfileService"),
        .package(name: "UIComponents", path: "../Common/UIComponents"),
        .package(name: "UserAutosService", path: "../Services/UserAutosService"),
    ],
    targets: [
        .target(
            name: "MainModule",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "ProfileServiceInterface", package: "ProfileService"),
                .product(name: "UserAutosService", package: "UserAutosService"),
                .product(name: "UIComponents", package: "UIComponents"),
            ]
        ),
        .testTarget(
            name: "MainModuleTests",
            dependencies: ["MainModule"]
        ),
    ]
)
