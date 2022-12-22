// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EditAutoModule",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "EditAutoModule",
            targets: ["EditAutoModule"]
        ),
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "VehiclesService", path: "../Services/VehiclesService"),
        .package(name: "UIComponents", path: "../Common/UIComponents"),
        .package(name: "UserAutosService", path: "../Services/UserAutosService"),
    ],
    targets: [
        .target(
            name: "EditAutoModule",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "VehiclesServiceInterface", package: "VehiclesService"),
                .product(name: "UserAutosService", package: "UserAutosService"),
                .product(name: "UIComponents", package: "UIComponents"),
            ]
        ),
    ]
)
