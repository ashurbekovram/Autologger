// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProfileModule",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ProfileModule",
            targets: ["ProfileModule"]
        ),
    ],
    dependencies: [
        .package(name: "AuthService", path: "../Services/AuthService"),
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "ProfileService", path: "../Services/ProfileService"),
        .package(name: "UIComponents", path: "../Common/UIComponents"),
    ],
    targets: [
        .target(
            name: "ProfileModule",
            dependencies: [
                .product(name: "AuthServiceInterface", package: "AuthService"),
                .product(name: "Models", package: "Models"),
                .product(name: "ProfileServiceInterface", package: "ProfileService"),
                .product(name: "UIComponents", package: "UIComponents"),
            ]
        ),
    ]
)
