// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ProgressHUD",
    platforms: [
      .iOS(.v13)
    ],
    products: [
        .library(
            name: "ProgressHUD",
            targets: ["ProgressHUD"]),
    ],
    targets: [
        .target(
            name: "ProgressHUD",
            dependencies: []),
    ]
)
