// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VehiclesService",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "VehiclesService",
            targets: ["VehiclesService"]
        ),
        .library(
            name: "VehiclesServiceInterface",
            targets: ["VehiclesServiceInterface"]
        ),
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "NetworkManager", path: "../Managers/NetworkManager"),
    ],
    targets: [
        .target(
            name: "VehiclesService",
            dependencies: [
                "VehiclesServiceInterface",
                .product(name: "Models", package: "Models"),
                .product(name: "NetworkManagerInterface", package: "NetworkManager"),
            ]
        ),
        .target(
            name: "VehiclesServiceInterface",
            dependencies: [
                .product(name: "Models", package: "Models"),
            ]
        ),
    ]
)
