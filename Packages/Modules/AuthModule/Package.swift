// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthModule",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AuthModule",
            targets: ["AuthModule"]
        ),
    ],
    dependencies: [
        .package(name: "AuthService", path: "../Services/AuthService"),
    ],
    targets: [
        .target(
            name: "AuthModule",
            dependencies: [
                .product(name: "AuthServiceInterface", package: "AuthService")
            ]
        ),
    ]
)
