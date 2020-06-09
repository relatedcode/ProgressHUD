// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ProgressHUD",
    products: [
        .library(
            name: "app",
            targets: ["app"]),
    ],
    targets: [
        .target(
            name: "app",
            dependencies: []),
    ]
)
