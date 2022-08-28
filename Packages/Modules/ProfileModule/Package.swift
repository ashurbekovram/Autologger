// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProfileModule",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ProfileModule",
            targets: ["ProfileModule"]
        ),
    ],
    dependencies: [
        .package(name: "Models", path: "../Common/Models"),
        .package(name: "ProfileService", path: "../Services/ProfileService"),
        .package(name: "UIComponents", path: "../Common/UIComponents"),
    ],
    targets: [
        .target(
            name: "ProfileModule",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "ProfileServiceInterface", package: "ProfileService"),
                .product(name: "UIComponents", package: "UIComponents"),
            ]
        ),
    ]
)
